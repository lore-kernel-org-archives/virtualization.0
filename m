From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Qemu and virtio 1.0
Date: Wed, 25 Feb 2015 12:26:31 +0100
Message-ID: <20150225122631.4c075d43.cornelia.huck@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<877fv6mxkp.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877fv6mxkp.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mst@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 Feb 2015 14:50:22 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> OK, I am trying to experiment with virtio 1.0 support using the
> latest kernel and MST's qemu tree:
> 
>         https://git.kernel.org/cgit/virt/kvm/mst/qemu.git/?h=virtio-1.0
> 
> The first issue is that the device config endian was wrong (see
> attached patch).
> 
> I'm now setting up a BE guest on my x86 laptop, and a BE and LE guest
> on a BE powerpc machine, to check that all combinations work correctly.
> If others test too, that would be appreciated!

My virtio-1 work had been taking the back seat recently, but I plan to
look into it again soon.

> 
> Cheers,
> Rusty.
> 
> From 95ac91554ed602f856a2a5fcc25eaffcad1b1c8d Mon Sep 17 00:00:00 2001
> From: Rusty Russell <rusty@rustcorp.com.au>
> Date: Tue, 24 Feb 2015 14:47:44 +1030
> Subject: [PATCH] virtio_config_write*/virtio_config_read*: Don't endian swap
>  for virtio 1.0.

Ah, virtio-ccw doesn't use these config space accessors, that's why I
did not look at them.

> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 079944c..882a31b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -662,7 +662,12 @@ uint32_t virtio_config_readw(VirtIODevice *vdev, uint32_t addr)
> 
>      k->get_config(vdev, vdev->config);
> 
> -    val = lduw_p(vdev->config + addr);
> +    /* Virtio 1.0 is always LE */
> +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        val = lduw_le_p(vdev->config + addr);
> +    } else {
> +        val = lduw_p(vdev->config + addr);
> +    }

Can't you use the virtio_* helpers for that?

>      return val;
>  }
> 

<looks at the callers>

It seems virtio-pci does some conditional swapping based on
virtio-endianness already, which should account for virtio-1.
virtio-mmio does not seem to do so.

But:

Device code accessing config space already does use the virtio
accessors - or virtio-ccw would not work as it simply copies the whole
config space. So it seems this change simply undos the endian swap in
virtio-pci (while probably breaking virtio-mmio). Can we simply get rid
of the endian swap in virtio-pci instead, or have I been throuroughly
confused?
