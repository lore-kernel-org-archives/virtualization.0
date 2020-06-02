From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: convert get_user_pages() --> pin_user_pages()
Date: Tue, 2 Jun 2020 08:08:44 +0200
Message-ID: <CAM9Jb+hNSWp-TaQQFg4bs5uR8rYk_POZPT23RYy5V_B9-aOcYg@mail.gmail.com>
References: <20200601052633.853874-1-jhubbard@nvidia.com> <20200601052633.853874-3-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200601052633.853874-3-jhubbard@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Souptick Joarder <jrdr.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

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
> ---
>  drivers/vhost/vhost.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 21a59b598ed8..596132a96cd5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1762,15 +1762,14 @@ static int set_bit_to_user(int nr, void __user *addr)
>         int bit = nr + (log % PAGE_SIZE) * 8;
>         int r;
>
> -       r = get_user_pages_fast(log, 1, FOLL_WRITE, &page);
> +       r = pin_user_pages_fast(log, 1, FOLL_WRITE, &page);
>         if (r < 0)
>                 return r;
>         BUG_ON(r != 1);
>         base = kmap_atomic(page);
>         set_bit(bit, base);
>         kunmap_atomic(base);
> -       set_page_dirty_lock(page);
> -       put_page(page);
> +       unpin_user_pages_dirty_lock(&page, 1, true);
>         return 0;
>  }

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
