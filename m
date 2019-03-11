From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Date: Mon, 11 Mar 2019 14:07:16 +0100
Message-ID: <20190311130716.6hjqci43clic5lxx__20144.0955557459$1552309650$gmane$org@sirius.home.kraxel.org>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
	<20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
	<20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > >  static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
> > >  				    struct drm_crtc_state *old_crtc_state)
> > >  {
> > > @@ -66,6 +71,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
> > >  static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
> > >  	.mode_set_nofb = bochs_crtc_mode_set_nofb,
> > >  	.atomic_enable = bochs_crtc_atomic_enable,
> > > +	.atomic_disable = bochs_crtc_atomic_disable,
> > 
> > Shouldn't we make the callback optional instead of adding empty dummy
> > functions to drivers?
> 
> Hi Gerd,
> 
> I agree, and I can work in this issue.
> Just one question, should we make atomic_enable optional as well?

IIRC the drm code checks for the atomic_enable callback presence to
figure whenever it should take the atomic or legacy code paths.

So, I think that will not work.

cheers,
  Gerd
