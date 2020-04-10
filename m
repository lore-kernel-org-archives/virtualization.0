From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: vhost: refine vhost and vringh kconfig
Date: Fri, 10 Apr 2020 09:53:20 +0200
Message-ID: <CAMuHMdUkff8XUrbHa90nGxa8Kj3HO9b2CRO57s3YZrSFPM51pg@mail.gmail.com>
References: <git-mailbomb-linux-master-20c384f1ea1a0bc7320bc445c72dd02d2970d594@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <git-mailbomb-linux-master-20c384f1ea1a0bc7320bc445c72dd02d2970d594@kernel.org>
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Jason,

On Thu, Apr 9, 2020 at 6:04 AM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Commit:     20c384f1ea1a0bc7320bc445c72dd02d2970d594
> Parent:     5a6b4cc5b7a1892a8d7f63d6cbac6e0ae2a9d031
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/20c384f1ea1a0bc7320bc445c72dd02d2970d594
> Author:     Jason Wang <jasowang@redhat.com>
> AuthorDate: Thu Mar 26 22:01:17 2020 +0800
> Committer:  Michael S. Tsirkin <mst@redhat.com>
> CommitDate: Wed Apr 1 12:06:26 2020 -0400
>
>     vhost: refine vhost and vringh kconfig
>
>     Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
>     not necessarily for VM since it's a generic userspace and kernel
>     communication protocol. Such dependency may prevent archs without
>     virtualization support from using vhost.
>
>     To solve this, a dedicated vhost menu is created under drivers so
>     CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
>
>     While at it, also squash Kconfig.vringh into vhost Kconfig file. This
>     avoids the trick of conditional inclusion from VOP or CAIF. Then it
>     will be easier to introduce new vringh users and common dependency for
>     both vringh and vhost.
>
>     Signed-off-by: Jason Wang <jasowang@redhat.com>
>     Link: https://lore.kernel.org/r/20200326140125.19794-2-jasowang@redhat.com
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/arm/kvm/Kconfig         |  2 --
>  arch/arm64/kvm/Kconfig       |  2 --
>  arch/mips/kvm/Kconfig        |  2 --
>  arch/powerpc/kvm/Kconfig     |  2 --
>  arch/s390/kvm/Kconfig        |  4 ----
>  arch/x86/kvm/Kconfig         |  4 ----
>  drivers/Kconfig              |  2 ++
>  drivers/misc/mic/Kconfig     |  4 ----
>  drivers/net/caif/Kconfig     |  4 ----
>  drivers/vhost/Kconfig        | 28 +++++++++++++++++++++-------
>  drivers/vhost/Kconfig.vringh |  6 ------
>  11 files changed, 23 insertions(+), 37 deletions(-)

> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -1,4 +1,23 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config VHOST_RING
> +       tristate
> +       help
> +         This option is selected by any driver which needs to access
> +         the host side of a virtio ring.
> +
> +config VHOST
> +       tristate
> +       select VHOST_IOTLB
> +       help
> +         This option is selected by any driver which needs to access
> +         the core of vhost.
> +
> +menuconfig VHOST_MENU
> +       bool "VHOST drivers"
> +       default y

Please do not use default y. Your subsystem is not special.

> +

I think this deserves a help text, so users know if they want to enable this
option or not.

Thanks!

> +if VHOST_MENU
> +
>  config VHOST_NET
>         tristate "Host kernel accelerator for virtio net"
>         depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
