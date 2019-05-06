From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 01/19] drm: Add |struct drm_gem_vram_object| and helpers
Date: Mon, 6 May 2019 15:17:39 +0200
Message-ID: <20190506131739.hmadwiqmjil2weth__17211.4699425705$1557148722$gmane$org@sirius.home.kraxel.org>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506082649.942-2-tzimmermann@suse.de>
	<20190506123114.hzyl2hkix7lvqjyx@sirius.home.kraxel.org>
	<0fad955f-5a9e-15b1-0dca-c5e842b297c6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0fad955f-5a9e-15b1-0dca-c5e842b297c6@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> This misses the call to drm_gem_vram_placement(), where
> drm_gem_vram_push_to_system() enforces placement in system memory.

Ah, missed that detail.

> We
> could build a common implementation out of both interfaces, but that
> would obfuscate the code IMHO. I'd just leave it as it is.

Ok.

> >> +struct drm_gem_vram_object {
> >> +	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
> >> +	struct ttm_placement placement;
> >> +	struct ttm_place placements[3];
> > 
> > placements[2] should be enough I guess?
> 
> TTM_PL_VRAM has index 2 and TTM_PL_SYSTEM has index 0. There's TTM_PL_TT
> at index 1. We don't use all three array entries here, but I'm not sure
> if something in TTM does. I took the line from the drivers and didn't
> change it for that reason.

TTM_PL_* isn't an index into that array.  See drm_gem_vram_placement()
which fills that array.  It'll use one or two entries of that array.

cheers,
  Gerd
