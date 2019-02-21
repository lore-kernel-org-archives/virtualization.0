From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Date: Thu, 21 Feb 2019 15:24:17 +0100
Message-ID: <20190221142417.GT2665__25033.0379860074$1550759314$gmane$org@phenom.ffwll.local>
References: <20190221113534.20764-1-kraxel@redhat.com>
	<20190221113534.20764-3-kraxel@redhat.com>
	<20190221122011.GP2665@phenom.ffwll.local>
	<20190221130623.rjtmtoe2qf7dgy2t@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190221130623.rjtmtoe2qf7dgy2t@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2019 at 02:06:23PM +0100, Gerd Hoffmann wrote:
> On Thu, Feb 21, 2019 at 01:20:11PM +0100, Daniel Vetter wrote:
> > On Thu, Feb 21, 2019 at 12:35:34PM +0100, Gerd Hoffmann wrote:
> > > Problem:  qxl switches from native mode back into vga compatibility mode
> > > when it notices someone is accessing vga registers.  And vgacon does
> > > exactly that before fbcon takes over.  So make sure we kick out vgacon
> > > early enough that it wouldn't disturb us.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  drivers/gpu/drm/qxl/qxl_drv.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > > index bb81e310eb..08446561aa 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > > @@ -95,6 +95,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > >  		goto modeset_cleanup;
> > >  
> > >  	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> > > +	drm_fb_helper_kick_out_vgacon();
> > 
> > I was thinking of checking whether pdev is a VGA class device and whether
> > it decodes vga access, and in that case automatically calling
> > kick_out_vgacon from remove_conflicting_pci_framebuffer. Since that's what
> > drivers want anyway, and those who don't can open code it.
> > 
> > Or is there an issue with that?
> 
> It'll need more careful testing to make sure we don't have unwanted side
> effects when just doing it for everyone.  And I guess most drivers don't
> care much because their hardware ignores vga port writes once they are
> switched out of vga text mode.
> 
> Dunno why i915 needs this.

The problem isn't loading, it's unloading again. If you boot with vgacon,
but no fbdev driver (which iirc also has magic code to throw out the vga
console), then when you unload your kms driver vgacon kicks back in. And a
pile of things go really sideways when that happens.

I have no idea whether it's just intel hw or maybe pci decoding or
something else, but seems like good practice to kick out all existing
drivers, to make sure they can never get at the hw again.

So don't think it'll hurt to do this for everyone. But yeah maybe we can
do that as a follow-up (and convert i915 over), dunno.
-Daniel


> In case of qxl it is more a historical leftover.  The very first qxl
> device revision had no explicit qxl command to switch from qxl native
> mode back to vga compatibility mode, vga port access was used for that
> instead.  It's long fixed, but the qxl device still has that quirk for
> compatibility with very old guest drivers.
> 
> cheers,
>   Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
