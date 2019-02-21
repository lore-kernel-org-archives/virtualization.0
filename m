From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Date: Thu, 21 Feb 2019 14:06:23 +0100
Message-ID: <20190221130623.rjtmtoe2qf7dgy2t__18299.2752221011$1550754598$gmane$org@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
	<20190221113534.20764-3-kraxel@redhat.com>
	<20190221122011.GP2665@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190221122011.GP2665@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2019 at 01:20:11PM +0100, Daniel Vetter wrote:
> On Thu, Feb 21, 2019 at 12:35:34PM +0100, Gerd Hoffmann wrote:
> > Problem:  qxl switches from native mode back into vga compatibility mode
> > when it notices someone is accessing vga registers.  And vgacon does
> > exactly that before fbcon takes over.  So make sure we kick out vgacon
> > early enough that it wouldn't disturb us.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index bb81e310eb..08446561aa 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -95,6 +95,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  		goto modeset_cleanup;
> >  
> >  	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> > +	drm_fb_helper_kick_out_vgacon();
> 
> I was thinking of checking whether pdev is a VGA class device and whether
> it decodes vga access, and in that case automatically calling
> kick_out_vgacon from remove_conflicting_pci_framebuffer. Since that's what
> drivers want anyway, and those who don't can open code it.
> 
> Or is there an issue with that?

It'll need more careful testing to make sure we don't have unwanted side
effects when just doing it for everyone.  And I guess most drivers don't
care much because their hardware ignores vga port writes once they are
switched out of vga text mode.

Dunno why i915 needs this.

In case of qxl it is more a historical leftover.  The very first qxl
device revision had no explicit qxl command to switch from qxl native
mode back to vga compatibility mode, vga port access was used for that
instead.  It's long fixed, but the qxl device still has that quirk for
compatibility with very old guest drivers.

cheers,
  Gerd
