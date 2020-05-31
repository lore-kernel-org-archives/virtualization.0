From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
Date: Sun, 31 May 2020 12:41:19 +0530
Message-ID: <CAFqt6zaCSngh7-N_qZ6-S3Cj8CHF8DTSPv8anP_oJg5E6UWu9g@mail.gmail.com>
References: <20200529234309.484480-1-jhubbard@nvidia.com> <20200529234309.484480-2-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200529234309.484480-2-jhubbard@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 30, 2020 at 5:13 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> There are four cases listed in pin_user_pages.rst. These are
> intended to help developers figure out whether to use
> get_user_pages*(), or pin_user_pages*(). However, the four cases
> do not cover all the situations. For example, drivers/vhost/vhost.c
> has a "pin, write to page, set page dirty, unpin" case.
>
> Add a fifth case, to help explain that there is a general pattern
> that requires pin_user_pages*() API calls.
>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jan Kara <jack@suse.cz>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/core-api/pin_user_pages.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/co=
re-api/pin_user_pages.rst
> index 4675b04e8829..b9f2688a2c67 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -171,6 +171,26 @@ If only struct page data (as opposed to the actual m=
emory contents that a page
>  is tracking) is affected, then normal GUP calls are sufficient, and neit=
her flag
>  needs to be set.
>
> +CASE 5: Pinning in order to write to the data within the page
> +-------------------------------------------------------------
> +Even though neither DMA nor Direct IO is involved, just a simple case of=
 "pin,
> +access page's data, unpin" can cause a problem.

Will it be, *"pin, access page's data, set page dirty, unpin" * ?

Case 5 may be considered a
> +superset of Case 1, plus Case 2, plus anything that invokes that pattern=
. In
> +other words, if the code is neither Case 1 nor Case 2, it may still requ=
ire
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
> +
>  page_maybe_dma_pinned(): the whole point of pinning
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> --
> 2.26.2
>
