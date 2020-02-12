From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4] drm/bochs: add drm_driver.release callback.
Date: Wed, 12 Feb 2020 10:20:42 +0100
Message-ID: <20200212092042.wnolwagpiucyw25m@sirius.home.kraxel.org>
References: <20200211135218.22871-1-kraxel@redhat.com>
 <20200211141956.GC2363188@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200211141956.GC2363188@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 03:19:56PM +0100, Daniel Vetter wrote:
> On Tue, Feb 11, 2020 at 02:52:18PM +0100, Gerd Hoffmann wrote:
> > Call bochs_unload via drm_driver.release to make sure we release stuff
> > when it is safe to do so.  Use drm_dev_{enter,exit,unplug} to avoid
> > touching hardware after device removal.  Tidy up here and there.
> > 
> > v4: add changelog.
> > v3: use drm_dev_*().
> > v2: move hardware deinit to pci_remove().
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Btw I checked around whether there's anything else that obviously needs a
> drm_dev_enter/exit, and I spotted the !bochs->mmio check in
> bochs_hw_load_edid. That one looks like cargo-cult, there's a single
> caller in the init path, so either mmio works at that point or this is
> dead code ... slightly confusing.

FYI:  bochs->mmio actually can be NULL when running on very old qemu
versions, the mmio bar was added in qemu release 1.3.  All the register
access functions in bochs_hw.c have a fallback going to ioports because
of that.  So there is a reason for the check, even though it is highly
unlikely that mmio actually is NULL these days.  qemu 1.3 was released
in 2013 ...

cheers,
  Gerd
