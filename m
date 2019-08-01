From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/6] Unmappable DRM client buffers for fbdev emulation
Date: Thu, 1 Aug 2019 09:04:52 +0200
Message-ID: <20190801070452.wi3xxu22kq2vxovp__8190.86082499183$1564643932$gmane$org@sirius.home.kraxel.org>
References: <20190705092613.7621-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190705092613.7621-1-tzimmermann@suse.de>
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
Cc: yc_chen@aspeedtech.com, maxime.ripard@bootlin.com, sam@ravnborg.org, maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, daniel@ffwll.ch, airlied@redhat.com, sean@poorly.run
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> and removes a large amount of framebuffer code from these drivers. For
> bochs, a problem was reported where the driver could not display the console
> because it was pinned in system memory. [1] The patch set fixes this bug
> by converting bochs to use the shadow fb.

So, bochs in 5.3-rcX is broken, and patches 1+2+3+5 of this series unbreak
it.  Series already landed in drm-misc-next, but that doesn't help bochs
in 5.3.

What is the usual way to handle this?
Just cherry-pick the four patches into drm-misc-fixes and push?

thanks,
  Gerd
