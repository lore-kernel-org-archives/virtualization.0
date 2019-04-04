From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 10:52:15 +0200
Message-ID: <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ__17225.3168815345$1554367958$gmane$org@mail.gmail.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
	<20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
	<CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
	<20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 4, 2019 at 10:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Speaking of wayland:  Seems at least gnome-shell insists on using XR24.
> >
> > Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
> > convert XR24 to other formats, for display not supporting anything
> > else. Because userspace.
>
> Have a pointer to these helpers?  grepping around in drm didn't turn up
> anything so far ...

tinydrm_xrgb8888_to_*

imo these could be put into some drm_format_helpers.c to be shared.
From a quick look the xrgb8888_to_rgb888 is missing, but for a quick
hack you can just use rgb565 to get going.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
