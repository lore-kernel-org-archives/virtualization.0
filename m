From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Thu, 17 Jan 2019 18:45:31 +0100
Message-ID: <20190117174531.GA14041__41268.936036113$1547755202$gmane$org@ravnborg.org>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
	<20190116181018.GA27364@ravnborg.org>
	<20190117164541.GE3271@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190117164541.GE3271@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 17, 2019 at 05:45:41PM +0100, Daniel Vetter wrote:
> On Wed, Jan 16, 2019 at 07:10:18PM +0100, Sam Ravnborg wrote:
> > Hi Daniel.
> > 
> > > v5: Actually try to sort them, and while at it, sort all the ones I
> > > touch.
> > 
> > Applied this variant on top of drm-misc and did a build test.
> > Looked good for ia64, x86 and alpha.
> > 
> > Took a closer look at the changes to atmel_hlcd - and they looked OK.
> > 
> > But I noticed that atmel_hlcdc uses only drm_kms_helper_poll_init() and
> > drm_kms_helper_poll_fini().
> > But there are no hits on DRM_CONNECTOR_POLL - so I think we maybe
> > have a driver here where we have plugged the drm_poll infrastructure,
> > but it is not in use.
> > 
> > >  include/drm/drm_crtc_helper.h                 | 16 -----------
> > 
> > The list of include files in this file could be dropped and replaced by:
> > struct drm_connector;
> > struct drm_device;
> > struct drm_display_mode;
> > struct drm_encoder;
> > struct drm_framebuffer;
> > struct drm_mode_set;
> > struct drm_modeset_acquire_ctx;
> > 
> > I tried to do so on top of your patch.
> > But there were too many build errros and I somehow lost the motivation.
> 
> Yeah the drm_crtc_helper.h header is a bit the miniature drmP.h for legacy
> kms drivers. Just removing it from all the atomic drivers caused lots of
> fallout, I expect even more if you entirely remove the includes it has.
> Maybe a todo, care to pls create that patch since it's your idea?

The main reason I bailed out initially was that this would create
small changes to several otherwise seldomly touched files.
And then we would later come and remove drmP.h - so lots of
small but incremental changes to the same otherwise seldomly
edited files.
And the job was only partially done.

I will try to experiment with an approach where I clean up the
include/drm/*.h files a little (like suggested above, +delete drmP.h
and maybe a bit more).

Then to try on a driver by driver basis to make it build with a
cleaned set of include files.
I hope that the cleaned up driver can still build without the
cleaned header files so the changes can be submitted piecemal.

Will do so with an eye on the lesser maintained drivers to try it
out to avoid creating too much chrunch for others.

And if it works out I expect the active drivers to follow the
example.

todo.rst item will wait until I run out of energy.

	Sam
