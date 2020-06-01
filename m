From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] vhost: convert get_user_pages() --> pin_user_pages()
Date: Mon, 1 Jun 2020 13:30:00 +0200
Message-ID: <20200601113000.GE3960@quack2.suse.cz>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-3-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200529234309.484480-3-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Souptick Joarder <jrdr.linux@gmail.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Fri 29-05-20 16:43:09, John Hubbard wrote:
> This code was using get_user_pages*(), in approximately a "Case 5"
> scenario (accessing the data within a page), using the categorization
> from [1]. That means that it's time to convert the get_user_pages*() +
> put_page() calls to pin_user_pages*() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/vhost/vhost.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 21a59b598ed8..596132a96cd5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1762,15 +1762,14 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	int bit = nr + (log % PAGE_SIZE) * 8;
>  	int r;
>  
> -	r = get_user_pages_fast(log, 1, FOLL_WRITE, &page);
> +	r = pin_user_pages_fast(log, 1, FOLL_WRITE, &page);
>  	if (r < 0)
>  		return r;
>  	BUG_ON(r != 1);
>  	base = kmap_atomic(page);
>  	set_bit(bit, base);
>  	kunmap_atomic(base);
> -	set_page_dirty_lock(page);
> -	put_page(page);
> +	unpin_user_pages_dirty_lock(&page, 1, true);
>  	return 0;
>  }
>  
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
