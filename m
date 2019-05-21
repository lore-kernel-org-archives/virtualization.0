From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/2] drm: Add drm_gem_vram_{pin/unpin}_reserved() and
	convert mgag200
Date: Tue, 21 May 2019 12:35:46 +0200
Message-ID: <20190521103546.ehrrboraeoe2e6fh__43524.8928306223$1558434969$gmane$org@sirius.home.kraxel.org>
References: <20190516162746.11636-1-tzimmermann@suse.de>
	<20190516162746.11636-2-tzimmermann@suse.de>
	<20190520161900.GB21222@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190520161900.GB21222@phenom.ffwll.local>
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
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, Thomas Zimmermann <tzimmermann@suse.de>, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> I think would be good to have a lockdep_assert_held here for the ww_mutex.
> 
> Also general thing: _reserved is kinda ttm lingo, for dma-buf reservations
> we call the structure tracking the fences+lock the "reservation", but the
> naming scheme used is _lock/_unlock.
> 
> I think would be good to be consistent with that, and use _locked here.
> Especially for a very simplified vram helper like this one I expect that's
> going to lead to less wtf moments by driver writers :-)
> 
> Maybe we should also do a large-scale s/reserve/lock/ within ttm, to align
> more with what we now have in dma-buf.

Given that mgag200 is the only user I think the best way forward is to
improve the mgag200 cursor handling so we can just drop the _reserved
variants ...

When looking at mga_crtc_cursor_set() I suspect the easierst way to do
that would be to simply pin the cursor bo's at driver_load time, then we
don't have to bother with pinning in mga_crtc_cursor_set() at all.

Thomas, as you have test hardware, can you look into this?

thanks,
  Gerd
