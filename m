From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
Date: Fri, 12 Jun 2020 12:24:26 -0700
Message-ID: <20200612192426.GK8681@bombadil.infradead.org>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-2-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200529234309.484480-2-jhubbard@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Souptick Joarder <jrdr.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 29, 2020 at 04:43:08PM -0700, John Hubbard wrote:
> +CASE 5: Pinning in order to write to the data within the page
> +-------------------------------------------------------------
> +Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
> +access page's data, unpin" can cause a problem. Case 5 may be considered a
> +superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
> +other words, if the code is neither Case 1 nor Case 2, it may still require
> +FOLL_PIN, for patterns like this:
> +
> +Correct (uses FOLL_PIN calls):
> +    pin_user_pages()
> +    access the data within the pages
> +    set_page_dirty_lock()
> +    unpin_user_pages()
> +
> +INCORRECT (uses FOLL_GET calls):
> +    get_user_pages()
> +    access the data within the pages
> +    set_page_dirty_lock()
> +    put_page()

Why does this case need to pin?  Why can't it just do ...

	get_user_pages()
	lock_page(page);
	... modify the data ...
	set_page_dirty(page);
	unlock_page(page);
