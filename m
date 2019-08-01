From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/6] Unmappable DRM client buffers for fbdev emulation
Date: Thu, 1 Aug 2019 15:03:48 +0200
Message-ID: <20190801130348.7kj374g534fle7wu__37637.3084423662$1564665334$gmane$org@sirius.home.kraxel.org>
References: <20190705092613.7621-1-tzimmermann@suse.de>
	<20190801070452.wi3xxu22kq2vxovp@sirius.home.kraxel.org>
	<CAKMK7uFTYJxF_JHwRjAN_nV=OCuFtx376H_7ku2H_0S-r9nRPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uFTYJxF_JHwRjAN_nV=OCuFtx376H_7ku2H_0S-r9nRPg@mail.gmail.com>
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
Cc: "Y.C. Chen" <yc_chen@aspeedtech.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 01, 2019 at 01:38:18PM +0200, Daniel Vetter wrote:
> On Thu, Aug 1, 2019 at 9:04 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > and removes a large amount of framebuffer code from these drivers. For
> > > bochs, a problem was reported where the driver could not display the console
> > > because it was pinned in system memory. [1] The patch set fixes this bug
> > > by converting bochs to use the shadow fb.
> >
> > So, bochs in 5.3-rcX is broken, and patches 1+2+3+5 of this series unbreak
> > it.  Series already landed in drm-misc-next, but that doesn't help bochs
> > in 5.3.
> >
> > What is the usual way to handle this?
> > Just cherry-pick the four patches into drm-misc-fixes and push?
> 
> Best would be to put the patches into -fixes from the start.

Sure, but that ship is sailed in this case.

> Cherry pick works too, if it's not too invasive.

All 4 patches are clean cherry-picks, so I did that.

thanks,
  Gerd
