From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v6 1/3] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Thu, 9 Aug 2012 12:12:19 -0300
Message-ID: <20120809151218.GB2719@t510.redhat.com>
References: <cover.1344463786.git.aquini@redhat.com>
	<efb9756c5d6de8952a793bfc99a9db9cdd66b12f.1344463786.git.aquini@redhat.com>
	<20120809090019.GB10288@csn.ul.ie>
	<20120809144835.GA2719@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120809144835.GA2719@t510.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mel Gorman <mel@csn.ul.ie>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 09, 2012 at 11:48:36AM -0300, Rafael Aquini wrote:
> Sure! 
> what do you think of:
> 
> +/* putback_lru_page() counterpart for a ballooned page */
> +void putback_balloon_page(struct page *page)
> +{
> +   lock_page(page);
> +   if (!WARN_ON(!movable_balloon_page(page))) {
> +           __putback_balloon_page(page);
> +           put_page(page);
> +   }
> +   unlock_page(page);
> +}
>
Or perhaps
 
+/* putback_lru_page() counterpart for a ballooned page */
+void putback_balloon_page(struct page *page)
+{
+   if (!WARN_ON(!movable_balloon_page(page))) {
+           lock_page(page);
+           __putback_balloon_page(page);
+           put_page(page);
+           unlock_page(page);
+   }
+}
