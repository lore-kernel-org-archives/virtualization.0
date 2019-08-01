From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 0/6] Unmappable DRM client buffers for fbdev emulation
Date: Thu, 1 Aug 2019 13:38:18 +0200
Message-ID: <CAKMK7uFTYJxF_JHwRjAN_nV=OCuFtx376H_7ku2H_0S-r9nRPg__11420.8733242535$1564660649$gmane$org@mail.gmail.com>
References: <20190705092613.7621-1-tzimmermann@suse.de>
	<20190801070452.wi3xxu22kq2vxovp@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190801070452.wi3xxu22kq2vxovp@sirius.home.kraxel.org>
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
Cc: "Y.C. Chen" <yc_chen@aspeedtech.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 1, 2019 at 9:04 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > and removes a large amount of framebuffer code from these drivers. For
> > bochs, a problem was reported where the driver could not display the console
> > because it was pinned in system memory. [1] The patch set fixes this bug
> > by converting bochs to use the shadow fb.
>
> So, bochs in 5.3-rcX is broken, and patches 1+2+3+5 of this series unbreak
> it.  Series already landed in drm-misc-next, but that doesn't help bochs
> in 5.3.
>
> What is the usual way to handle this?
> Just cherry-pick the four patches into drm-misc-fixes and push?

Best would be to put the patches into -fixes from the start. Cherry
pick works too, if it's not too invasive. Otherwise revert in -fixes,
and remember to not carry that revert over when backmerging.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
