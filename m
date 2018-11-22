From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
Date: Thu, 22 Nov 2018 09:55:49 +0100
Message-ID: <20181122085549.GX4266__15090.7416399152$1542876858$gmane$org@phenom.ffwll.local>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
	<CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
	<20181121094233.GN4266@phenom.ffwll.local>
	<22044302.7aKok9czXB@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <22044302.7aKok9czXB@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: hamohammed.sa@gmail.com, Alexandre Belloni <alexandre.belloni@bootlin.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Maxime Ripard <maxime.ripard@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>, Archit Taneja <architt@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, abrodkin@synopsys.com, Dave Airlie <airlied@linux.ie>, Ludovic Desroches <ludovic.desroches@microchip.com>, kieran.bingham+renesas@ideasonboard.com, linux+etnaviv@armlinux.org.uk, Nicolas Palix <nicolas.palix@imag.fr>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, etnaviv@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Christian
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 21, 2018 at 08:21:29PM +0200, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Wednesday, 21 November 2018 11:42:33 EET Daniel Vetter wrote:
> > On Thu, Nov 15, 2018 at 11:38:35PM +0100, Linus Walleij wrote:
> > > On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos wrote:
> > >> One of the things in the DRM TODO list ("Documentation/gpu/todo.rst")
> > >> was to "switch from reference/unreference to get/put". That's what this
> > >> patch series is about.
> > > 
> > > The series:
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Since your reviewed it all, and there's a pile of acks for the driver
> > parts too: Want to go ahead and apply it too?
> 
> Please remember to give at least a week to reviewers, especially with LPC last 
> week.

I think for this undisputed cocci series waiting for everyone is not
needed. There's really not much the driver-specific reviewer perspective
would help here.

In general I do agree though, if there's something driver maintainers can
have better insight on.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
