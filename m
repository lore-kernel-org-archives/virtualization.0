From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
Date: Fri, 25 Jan 2019 19:10:09 +0100
Message-ID: <20190125181009.GA8230__2209.60956519178$1548442270$gmane$org@ravnborg.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-19-kraxel@redhat.com>
	<e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Noralf.

> > Lovely diffstat, thanks to the new generic fbdev emulation.
> > =

> >  drm/qxl/Makefile   |    2
> >  drm/qxl/qxl_draw.c |  232 ----------------------------------------
> >  drm/qxl/qxl_drv.h  |   21 ---
> >  drm/qxl/qxl_fb.c   |  300 --------------------------------------------=
---------
> > =

> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.h  |  21 ---
> >  drivers/gpu/drm/qxl/qxl_draw.c | 232 -------------------------------
> >  drivers/gpu/drm/qxl/qxl_fb.c   | 300 ---------------------------------=
--------
> >  drivers/gpu/drm/qxl/Makefile   |   2 +-
> >  4 files changed, 1 insertion(+), 554 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/qxl/qxl_fb.c
> > =

> =

> Nice!
> =

> Acked-by: Noralf Tr=F8nnes <noralf@tronnes.org>
It must be a very satisfying experience to see such benefits
of the many hours of works you have put into the genric
fbdev emulation code.
Well done, and indeed a nice patch from Gerd.

	Sam
