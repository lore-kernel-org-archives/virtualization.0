From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: add URL for virtio-mem
Date: Wed, 17 Jun 2020 13:37:29 +0200
Message-ID: <CAM9Jb+iUb4Ksm2VD-jgUc14V+T9TnGL1a48JuV_FWJd0ZeT1_w@mail.gmail.com>
References: <20200617104756.6312-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200617104756.6312-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Let's add the status/info page, which is still under construction, however,
> already contains valuable documentation/information.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 301330e02bca7..3470c5bfbdc7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18234,6 +18234,7 @@ VIRTIO MEM DRIVER
>  M:     David Hildenbrand <david@redhat.com>
>  L:     virtualization@lists.linux-foundation.org
>  S:     Maintained
> +W:     https://virtio-mem.gitlab.io/
>  F:     drivers/virtio/virtio_mem.c
>  F:     include/uapi/linux/virtio_mem.h

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
