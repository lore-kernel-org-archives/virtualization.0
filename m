From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: virtio gpu sparse warning
Date: Mon, 28 Nov 2016 08:50:44 +0100
Message-ID: <1480319444.20061.4.camel__13110.7701141902$1480319453$gmane$org@redhat.com>
References: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
	<20161108223153-mutt-send-email-mst@kernel.org>
	<1478678517.2078.12.camel@redhat.com>
	<f006e3a6-51d2-4092-57b6-eea7ff64f58f@suse.cz>
	<1479301975.25611.23.camel@redhat.com>
	<20161124045101-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161124045101-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Do, 2016-11-24 at 04:57 +0200, Michael S. Tsirkin wrote:
> sparse produces these warnings:
> 
> drivers/gpu/drm/virtio/virtgpu_fb.c:340:27: warning: incorrect type in
> assignment (different address spaces)
> drivers/gpu/drm/virtio/virtgpu_fb.c:340:27:    expected char [noderef]
> <asn:2>*screen_base
> drivers/gpu/drm/virtio/virtgpu_fb.c:340:27:    got void *vmap
> 
> This is because the expected type is void __iomem *, while
> virtio gpu object is void *vmap.
> 
> We could just cast the warning away but I'm not sure this
> is not a symptom of an actual problem. For example, might
> some code call iounmap on this address?

Nobody is ever going to unmap that, the kernel will simply use given
address to access the framebuffer.

Actually it looks like this (in include/linux/fb.h):

        union {
                char __iomem *screen_base;      /* Virtual address */
                char *screen_buffer;
        };

and given that the virtio always uses normal ram as backing storage for
the framebuffer we should simply s/screen_base/screen_buffer/.  I'll go
prepare a patch.

cheers,
  Gerd
