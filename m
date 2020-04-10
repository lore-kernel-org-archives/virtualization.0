From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Date: Fri, 10 Apr 2020 11:51:22 +0200
Message-ID: <CAMuHMdXedy2knwgW7-tYB8-d=RaqpvQcoL-MQp3WAED-g1Xpkw@mail.gmail.com>
References: <20200405081355.2870-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

On Sun, Apr 5, 2020 at 10:17 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> set_dma_ops isn't available on all architectures:
>
>         make ARCH=um
> ...
>
>    drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
> >> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration of function 'set_dma_ops'; did you mean 'set_groups'?
> +[-Werror=implicit-function-declaration]
>      set_dma_ops(dev, &vdpasim_dma_ops);
>      ^~~~~~~~~~~
>      set_groups
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

As this fixes the Sun-3 all{mod,yes}-config build, which has NO_DMA=y:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

However, you may want to follow Christoph's suggestion instead.

> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -14,7 +14,7 @@ if VDPA_MENU
>
>  config VDPA_SIM
>         tristate "vDPA device simulator"
> -       depends on RUNTIME_TESTING_MENU
> +       depends on RUNTIME_TESTING_MENU && HAS_DMA
>         select VDPA
>         select VHOST_RING
>         select VHOST_IOTLB

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
