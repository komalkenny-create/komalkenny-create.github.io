#!/bin/bash

# CHINA KOMAL Website SEO Optimization Script
# This script adds SEO meta tags to all HTML files

WEBSITE_DIR="/home/komal/.openclaw/workspace-nova/chinakomal-website"

echo "🚀 Starting SEO Optimization for CHINA KOMAL Website..."
echo "=================================================="

# SEO Meta Tags Template
SEO_META='    <!-- SEO Meta Tags -->
    <meta name="description" content="CHINA KOMAL INTERNATIONAL CO., LTD - Professional oilfield equipment manufacturer with 15 years expertise. Supply drilling equipment, solids control systems, mud pump parts, shaker screens, and high pressure pumps.">
    <meta name="keywords" content="oilfield equipment, drilling equipment, solids control, mud pump, shaker screen, high pressure pump, petroleum equipment, oil drilling, China Komal">
    <meta name="author" content="CHINA KOMAL INTERNATIONAL CO., LTD">
    <meta name="robots" content="index, follow">
    <link rel="canonical" href="https://www.chinakomal.com/index-en.html">
    
    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://www.chinakomal.com/">
    <meta property="og:title" content="CHINA KOMAL - Professional Oilfield Equipment Manufacturer">
    <meta property="og:description" content="15 Years of Expertise in Oil Drilling Equipment R&D and Manufacturing. Complete oilfield equipment solutions.">
    <meta property="og:image" content="https://www.chinakomal.com/images/og-image.jpg">
    
    <!-- Twitter -->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:url" content="https://www.chinakomal.com/">
    <meta property="twitter:title" content="CHINA KOMAL - Professional Oilfield Equipment Manufacturer">
    <meta property="twitter:description" content="15 Years of Expertise in Oil Drilling Equipment R&D and Manufacturing.">
    <meta property="twitter:image" content="https://www.chinakomal.com/images/og-image.jpg">
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="/favicon.ico">
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
'

# Function to add SEO meta tags to index-en.html
optimize_index() {
    local file="$WEBSITE_DIR/index-en.html"
    echo "📄 Optimizing: index-en.html"
    
    # Check if SEO meta tags already exist
    if grep -q "SEO Meta Tags" "$file"; then
        echo "  ✓ SEO tags already exist, skipping..."
        return
    fi
    
    # Add SEO meta tags after viewport meta tag
    sed -i '/<meta name="viewport"/a\'"$SEO_META" "$file"
    echo "  ✅ SEO meta tags added"
}

# Function to optimize product pages
optimize_product_pages() {
    echo ""
    echo "📦 Optimizing Product Pages..."
    
    for file in "$WEBSITE_DIR"/product-*.html; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            
            # Extract product name from title
            product_name=$(grep -oP '<title>\K[^-]+' "$file" | head -1 | sed 's/|.*//' | xargs)
            
            # Create product-specific SEO meta
            PRODUCT_SEO="    <!-- SEO Meta Tags -->
    <meta name=\"description\" content=\"CHINA KOMAL - Professional manufacturer of $product_name. High quality oilfield equipment with competitive price. Contact us for quote.\">
    <meta name=\"keywords\" content=\"$product_name, oilfield equipment, drilling equipment, CHINA KOMAL, petroleum equipment\">
    <meta name=\"author\" content=\"CHINA KOMAL INTERNATIONAL CO., LTD\">
    <meta name=\"robots\" content=\"index, follow\">
    <link rel=\"canonical\" href=\"https://www.chinakomal.com/$filename\">
    
    <!-- Open Graph / Facebook -->
    <meta property=\"og:type\" content=\"product\">
    <meta property=\"og:url\" content=\"https://www.chinakomal.com/$filename\">
    <meta property=\"og:title\" content=\"$product_name | CHINA KOMAL\">
    <meta property=\"og:description\" content=\"Professional $product_name from CHINA KOMAL. High quality oilfield equipment.\">
    
    <!-- Twitter -->
    <meta property=\"twitter:card\" content=\"summary\">
    <meta property=\"twitter:url\" content=\"https://www.chinakomal.com/$filename\">
    <meta property=\"twitter:title\" content=\"$product_name | CHINA KOMAL\">
"
            
            # Check if SEO tags already exist
            if grep -q "SEO Meta Tags" "$file"; then
                echo "  ✓ $filename - SEO tags exist"
                continue
            fi
            
            # Add SEO meta tags after viewport meta tag
            echo "$PRODUCT_SEO" | cat - "$file" > /tmp/temp_file && mv /tmp/temp_file "$file"
            echo "  ✅ $filename - Optimized"
        fi
    done
}

# Function to create sitemap.xml
create_sitemap() {
    echo ""
    echo "🗺️  Creating sitemap.xml..."
    
    cat > "$WEBSITE_DIR/sitemap.xml" << 'SITEMAP'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <!-- Homepage -->
    <url>
        <loc>https://www.chinakomal.com/index-en.html</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
    </url>
    
    <!-- Product Series Pages -->
    <url>
        <loc>https://www.chinakomal.com/series.html?s=petroleum</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://www.chinakomal.com/series.html?s=solids</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://www.chinakomal.com/series.html?s=mud-pump</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://www.chinakomal.com/series.html?s=shaker</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://www.chinakomal.com/series.html?s=pump</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.9</priority>
    </url>
SITEMAP

    # Add all product pages to sitemap
    for file in "$WEBSITE_DIR"/product-*.html; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo "    <url>
        <loc>https://www.chinakomal.com/$filename</loc>
        <lastmod>2026-04-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>" >> "$WEBSITE_DIR/sitemap.xml"
        fi
    done

    echo "  ✅ sitemap.xml created"
}

# Function to create robots.txt
create_robots() {
    echo ""
    echo "🤖 Creating robots.txt..."
    
    cat > "$WEBSITE_DIR/robots.txt" << 'ROBOTS'
# robots.txt for CHINA KOMAL
# www.chinakomal.com

User-agent: *
Allow: /

# Sitemap location
Sitemap: https://www.chinakomal.com/sitemap.xml

# Crawl-delay (optional)
Crawl-delay: 1
ROBOTS

    echo "  ✅ robots.txt created"
}

# Main execution
echo ""
optimize_index
optimize_product_pages
create_sitemap
create_robots

echo ""
echo "=================================================="
echo "✅ SEO Optimization Complete!"
echo "=================================================="
echo ""
echo "📊 Summary:"
echo "  ✓ index-en.html - SEO meta tags added"
echo "  ✓ Product pages - SEO optimized"
echo "  ✓ sitemap.xml - Created"
echo "  ✓ robots.txt - Created"
echo ""
echo "🎯 Next Steps:"
echo "  1. Submit sitemap to Google Search Console"
echo "  2. Verify site in Google Search Console"
echo "  3. Create and upload favicon.ico"
echo "  4. Create and upload og-image.jpg for social sharing"
echo ""
