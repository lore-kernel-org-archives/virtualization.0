From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: allow both PRIV and VRAM
	placement for QXL_GEM_DOMAIN_SURFACE
Date: Thu, 6 Dec 2018 12:34:16 +0100
Message-ID: <20181206113416.yydgi7ro47vwgf2d__28777.6176621721$1544095940$gmane$org@sirius.home.kraxel.org>
References: <20181206104638.23330-1-kraxel@redhat.com>
	<20181206104638.23330-2-kraxel@redhat.com>
	<1897496108.48579647.1544093758850.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1897496108.48579647.1544093758850.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frediano Ziglio <fziglio@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 06, 2018 at 05:55:58AM -0500, Frediano Ziglio wrote:
> 
> > qxl surfaces (used for framebuffers and gem objects) can live in both
> > VRAM and PRIV ttm domains.  Update placement setup to include both.  Put
> > PRIV first in the list so it is preferred, so VRAM will have more room
> > for objects which must be allocated there.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> I remember these kind of changes in the past made migration
> fails. I proposed similar patches years ago and they were rejected
> for these reasons.

Pointer?

> Why now they are safe?

Well, you have to be careful what object you are allocating.  Surfaces
can be in both PRIV and VRAM.  Everything else (qxl commands, monitors
config, ...) must be in VRAM.

> Looks like we are improving QXL, so that means we are actively working
> on it.

Well, I'm just trying make qxl behave better with wayland.

> Should we not then thinking about moving feature in the proper
> places (like spice-server for atomic mode setting instead of implementin
> work around) ??

Main advantage is that it doesn't need qxl device changes, so it works
on old hosts too.  But, yes, we can consider to also modernize spice
protocol and qxl device.

cheers,
  Gerd
