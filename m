From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: get vga ioports
Date: Mon, 5 Aug 2019 12:50:39 +0200
Message-ID: <20190805105039.cxf2ogbzdf7hropp__12673.1517304265$1565002254$gmane$org@sirius.home.kraxel.org>
References: <20190805085355.12527-1-kraxel@redhat.com>
	<1869747233.4556840.1564996693878.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1869747233.4556840.1564996693878.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frediano Ziglio <fziglio@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > +	ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
> > +	if (ret) {
> > +		DRM_ERROR("can't get legacy vga ports\n");
> > +		goto put_vga;
> 
> I suppose that if this fails it's secondary so should continue.

Ah, right, there are secondary qxl cards (without the vga compat bits).
We should skip the call in that case (likewise for the cleanups).

> What happen configuring 2 QXL devices?
> Only a card should provide VGA registers in the system so
> if any other card provide them QXL won't work.

Well, with intel vgpu everything works fine with this patch.  Probably
i915 skips direct vga register access in case vga_get fails (because qxl
grabed them first).

In any case I'd prefer to fail qxl initialization over continuing
despite vga_get() having failed.  The failure mode is rather awkward:
qemu thinks the qxl card is in vga mode while the guest kernel thinks
qxl is in native mode.  Guest keeps queuing commands until the ring is
full while qemu never takes them out, so at some point the guest kernel
blocks forever in qxl_ring_push().

cheers,
  Gerd
