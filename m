From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v2 13/14] drm: stm: remove dead code and
	pointless local lut storage
Date: Fri, 23 Jun 2017 11:35:32 +0200
Message-ID: <20170623093532.gtkl4ia7smc5gudc__47001.1682752103$1498210545$gmane$org@phenom.ffwll.local>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
	<1498111597-10714-14-git-send-email-peda@axentia.se>
	<159dad37-7f12-0b4d-5512-d19a80670d5c@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <159dad37-7f12-0b4d-5512-d19a80670d5c@st.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Russell King <linux@armlinux.org.uk>, Yannick FERTRE <yannick.fertre@st.com>, Ben Skeggs <bskeggs@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Vincent ABRIOU <vincent.abriou@st>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 22, 2017 at 11:49:34AM +0000, Philippe CORNU wrote:
> 
> 
> On 06/22/2017 08:06 AM, Peter Rosin wrote:
> > The redundant fb helper .load_lut is no longer used, and can not
> > work right without also providing the fb helpers .gamma_set and
> > .gamma_get thus rendering the code in this driver suspect.
> > 
> 
> Hi Peter,
> STM32 chipsets supports 8-bit CLUT mode but this driver version does not 
> support it "yet" (final patch has not been upstreamed because it was a 
> too big fbdev patch for simply adding CLUT...).
> 
> Regarding your patch below, if it helps you to ease the drm framework 
> update then I am agree to "acknowledge it" asap, else if you are not in 
> a hurry, I would prefer a better and definitive patch handling 8-bit 
> CLUT properly and I am ok to help or/and to do it : )

I'll take your ack, since your 8bit lut support will be massively simpler
with Peter's series here :-)

> Extra questions:
> - any plan to update modetest with the DRM_FORMAT_C8 support + gamma 
> get/set?

We have gamma igts, well for the fancy new atomic color manager stuff.
Testing drivers with modetest is kinda not that awesome :-)
-Daniel

> - do you have a simple way to test clut with fbdev, last year we where 
> using an old version of the SDL but I am still looking for a small piece 
> of code to do it (else I will do it myself but C8 on fbdev is not really 
> a priority ;-)
> 
> best regards,
> Philippe
> 
> > Just remove the dead code.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 12 ------------
> >   drivers/gpu/drm/stm/ltdc.h |  1 -
> >   2 files changed, 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 1b9483d..87829b9 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -375,17 +375,6 @@ static irqreturn_t ltdc_irq(int irq, void *arg)
> >    * DRM_CRTC
> >    */
> >   
> > -static void ltdc_crtc_load_lut(struct drm_crtc *crtc)
> > -{
> > -	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
> > -	unsigned int i, lay;
> > -
> > -	for (lay = 0; lay < ldev->caps.nb_layers; lay++)
> > -		for (i = 0; i < 256; i++)
> > -			reg_write(ldev->regs, LTDC_L1CLUTWR + lay * LAY_OFS,
> > -				  ldev->clut[i]);
> > -}
> > -
> >   static void ltdc_crtc_enable(struct drm_crtc *crtc)
> >   {
> >   	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
> > @@ -523,7 +512,6 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
> >   }
> >   
> >   static struct drm_crtc_helper_funcs ltdc_crtc_helper_funcs = {
> > -	.load_lut = ltdc_crtc_load_lut,
> >   	.enable = ltdc_crtc_enable,
> >   	.disable = ltdc_crtc_disable,
> >   	.mode_set_nofb = ltdc_crtc_mode_set_nofb,
> > diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> > index d7a9c73..620ca55 100644
> > --- a/drivers/gpu/drm/stm/ltdc.h
> > +++ b/drivers/gpu/drm/stm/ltdc.h
> > @@ -27,7 +27,6 @@ struct ltdc_device {
> >   	struct drm_panel *panel;
> >   	struct mutex err_lock;	/* protecting error_status */
> >   	struct ltdc_caps caps;
> > -	u32 clut[256];		/* color look up table */
> >   	u32 error_status;
> >   	u32 irq_status;
> >   };
> > 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
