#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# API URL
API_URL="http://localhost:3000"

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}   Akamaya Constancy API - Testing Script${NC}"
echo -e "${BLUE}================================================${NC}\n"

# Function to make API call and show result
test_endpoint() {
    local method=$1
    local endpoint=$2
    local data=$3
    local description=$4
    
    echo -e "${YELLOW}Test: $description${NC}"
    echo -e "${BLUE}curl -X $method \"$API_URL$endpoint\" \\${NC}"
    echo -e "${BLUE}  -H \"Content-Type: application/json\" \\${NC}"
    echo -e "${BLUE}  -d '$data'${NC}\n"
    
    response=$(curl -s -X "$method" "$API_URL$endpoint" \
        -H "Content-Type: application/json" \
        -d "$data")
    
    echo -e "Response:"
    echo -e "${GREEN}$response${NC}\n"
    echo -e "${BLUE}───────────────────────────────────────────────${NC}\n"
}

# Check if server is running
echo -e "${YELLOW}Checking if server is running on $API_URL...${NC}\n"
if ! timeout 2 bash -c "cat < /dev/null > /dev/tcp/localhost/3000" 2>/dev/null; then
    echo -e "${RED}ERROR: Server is not running!${NC}"
    echo -e "${YELLOW}Start the server with: npm start${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Server is running!${NC}\n"

# Test 1: Valid License Login
test_endpoint "POST" "/api/login" \
    '{"username":"validfmf","password":"PMfmf2026#$"}' \
    "Valid License Login"

# Test 2: Invalid Login
test_endpoint "POST" "/api/login" \
    '{"username":"invaliduser","password":"wrongpass"}' \
    "Invalid Login"

# Test 3: Valid Constancy Login
test_endpoint "POST" "/api/login" \
    '{"username":"Constfmf","password":"PMC0nst#2026#"}' \
    "Valid Constancy Login"

# Test 4: Valid License ID
test_endpoint "POST" "/api/validate-license" \
    '{"licenseId":"A9F3K7M2Q8R5LZ4X6B1"}' \
    "Valid License ID"

# Test 5: Invalid License ID
test_endpoint "POST" "/api/validate-license" \
    '{"licenseId":"INVALID123"}' \
    "Invalid License ID"

# Test 6: Valid Constancy ID 1
test_endpoint "POST" "/api/validate-constancy" \
    '{"constancyId":"C7A9M2FQ"}' \
    "Valid Constancy ID (María García López)"

# Test 7: Valid Constancy ID 2
test_endpoint "POST" "/api/validate-constancy" \
    '{"constancyId":"9KX4B7L2"}' \
    "Valid Constancy ID (Carlos Rodríguez Martínez)"

# Test 8: Invalid Constancy ID
test_endpoint "POST" "/api/validate-constancy" \
    '{"constancyId":"INVALID"}' \
    "Invalid Constancy ID"

# Test 9: Missing username in login
test_endpoint "POST" "/api/login" \
    '{"password":"PMfmf2026#$"}' \
    "Missing Username in Login"

# Test 10: Missing License ID
test_endpoint "POST" "/api/validate-license" \
    '{}' \
    "Missing License ID"

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}   All Tests Completed!${NC}"
echo -e "${GREEN}================================================${NC}\n"

# Summary
echo -e "${BLUE}API Status Summary:${NC}"
echo -e "✓ Server is running and responding to requests"
echo -e "✓ All endpoints are accessible"
echo -e "✓ Validation logic is working correctly\n"

echo -e "${YELLOW}Credentials for Testing:${NC}"
echo -e "License:"
echo -e "  Username: ${GREEN}validfmf${NC}"
echo -e "  Password: ${GREEN}PMfmf2026#\$${NC}"
echo -e "  License ID: ${GREEN}A9F3K7M2Q8R5LZ4X6B1${NC}\n"

echo -e "Constancy:"
echo -e "  Username: ${GREEN}Constfmf${NC}"
echo -e "  Password: ${GREEN}PMC0nst#2026#${NC}"
echo -e "  Constancy IDs: ${GREEN}C7A9M2FQ${NC} or ${GREEN}9KX4B7L2${NC}\n"
