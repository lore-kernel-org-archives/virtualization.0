From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 12:27:22 +0200
Message-ID: <20190404102722.w6c7aoxzcrhn5xhi__41377.877029457$1554373654$gmane$org@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
	<20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
	<CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
	<20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
	<CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
	<2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > tinydrm_xrgb8888_to_*
> > 
> > imo these could be put into some drm_format_helpers.c to be shared.
> 
> I agree, my long term goal is to get rid of tinydrm.ko. Just haven't got
> there yet.
> 
> Gerd, if you end up using some of those functions, feel free to move
> just those you need and I can do the rest later. But if you have time to
> spare I wouldn't mind getting all of them moved ;-)

For now I just promoted cirrus to be a tinydrm driver ;)

Noticed that those helpers (including tinydrm_memcpy for the
non-converting case) apply clipping on the source but not on
the destination.  So, for fullscreen updates that works ok,
but for updating sub-rectangles it doesn't ...

So I guess I have to add a dest_clip bool parameter when moving them.
/me looks for a good place.  drm_fb_helpers.c I think.

cheers,
  Gerd
