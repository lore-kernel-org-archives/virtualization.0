From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
Date: Thu, 29 Nov 2018 15:55:28 +0100
Message-ID: <CAKMK7uF9Q-LySAXg=kT9B-ueFR9qhr_B0N3y1g1D_OTc-+Vbdg__45012.5804324218$1543503226$gmane$org@mail.gmail.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
	<CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
	<20181121094233.GN4266@phenom.ffwll.local>
	<CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
	<20181126141241.GM4266@phenom.ffwll.local>
	<CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>, Archit Taneja <architt@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Dave Airlie <airlied@linux.ie>, Ludovic Desroches <ludovic.desroches@microchip.com>, greenfoo@gluegarage.com, Russell King <linux+etnaviv@armlinux.org.uk>, Nicolas Palix <nicolas.palix@imag.fr>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, etnaviv@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Christian
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 29, 2018 at 3:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Nov 26, 2018 at 3:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sat, Nov 24, 2018 at 10:17:13PM +0100, Linus Walleij wrote:
>
> > > It was especially scary.
> > >
> > > But I think I managed to apply the patches and push the
> > > branch now.
> >
> > Except when you're racing with someone else you should only see conflicts
> > with stuff you've just pushed. Or if someone forgot to fix up their mess.
> > What was the conflict?
>
> dim push-branches was complaining that one of the commits was
> missing the proper committer sign-off, it was the bottom commit under
> mine (IIRC "drm/atomic-helper: WARN if fake_commit->hw_done is not
> completed as expected")
> and dim update-branches seemed to rebase and fix up my patches
> and then everything was fine.

This sounds like you (or dim?) accidentaly amended that commit (which
changes the committer and results in the warning), and a rebase would
indeed have fixed that. If the first patch conflicts this can happen
because dim apply-branch doesn't bail out correctly. Or at least did
in the past, I recently fixed that in

commit ee299e510ae468aab27610bcbc4fdd4de932f74b
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed Oct 17 08:53:00 2018 +0200

    dim: make apply-patch fail again

> I just felt slightly out of control :D

If your dim didn't have the above commit and you had a conflict it's
all explained. Otherwise I'm not sure what's been going on ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
