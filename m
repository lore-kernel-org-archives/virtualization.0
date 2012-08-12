From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v7 3/4] mm: introduce putback_movable_pages()
Date: Mon, 13 Aug 2012 08:26:36 +0900
Message-ID: <20120812232636.GI21033@bbox>
References: <cover.1344619987.git.aquini@redhat.com>
	<9147e5cccc4bb2d3f2e5f155e640148eb5365af5.1344619987.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9147e5cccc4bb2d3f2e5f155e640148eb5365af5.1344619987.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 10, 2012 at 02:55:16PM -0300, Rafael Aquini wrote:
> The PATCH "mm: introduce compaction and migration for virtio ballooned pages"
> hacks around putback_lru_pages() in order to allow ballooned pages to be
> re-inserted on balloon page list as if a ballooned page was like a LRU page.
> 
> As ballooned pages are not legitimate LRU pages, this patch introduces
> putback_movable_pages() to properly cope with cases where the isolated
> pageset contains ballooned pages and LRU pages, thus fixing the mentioned
> inelegant hack around putback_lru_pages().
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
Reviewed-by: Minchan Kim <minchan@kernel.org>

Thanks for your good work, Rafael.

-- 
Kind regards,
Minchan Kim
