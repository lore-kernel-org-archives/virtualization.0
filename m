From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v3 23/23] drm/qxl: add overflow checks to
	qxl_mode_dumb_create()
Date: Fri, 18 Jan 2019 18:32:33 +0200
Message-ID: <20190118163233.GM20097__15580.7265117348$1547845173$gmane$org@intel.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-24-kraxel@redhat.com>
	<20190118154944.GH3271@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190118154944.GH3271@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 18, 2019 at 04:49:44PM +0100, Daniel Vetter wrote:
> On Fri, Jan 18, 2019 at 01:20:20PM +0100, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> =

> We already do all reasonable overflow checks in drm_mode_create_dumb(). If
> you don't trust them I think would be better time spent typing an igt to
> test this than adding redundant check in all drivers.
> =

> You're also missing one check for bpp underflows :-)

BTW I just noticed that we don't seem to validating =

create_dumb->flags at all. Someone should probably add some
checks for that, or mark it as deprecated in case we already
lost the battle with userspace stack garbage.

> -Daniel
> =

> > ---
> >  drivers/gpu/drm/qxl/qxl_dumb.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_d=
umb.c
> > index 272d19b677..bed6d06ee4 100644
> > --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> > +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> > @@ -37,11 +37,13 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
> >  	uint32_t handle;
> >  	int r;
> >  	struct qxl_surface surf;
> > -	uint32_t pitch, format;
> > +	uint32_t pitch, size, format;
> >  =

> > -	pitch =3D args->width * ((args->bpp + 1) / 8);
> > -	args->size =3D pitch * args->height;
> > -	args->size =3D ALIGN(args->size, PAGE_SIZE);
> > +	if (check_mul_overflow(args->width, ((args->bpp + 1) / 8), &pitch))
> > +		return -EINVAL;
> > +	if (check_mul_overflow(pitch, args->height, &size))
> > +		return -EINVAL;
> > +	args->size =3D ALIGN(size, PAGE_SIZE);
> >  =

> >  	switch (args->bpp) {
> >  	case 16:
> > -- =

> > 2.9.3
> > =

> =

> -- =

> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Ville Syrj=E4l=E4
Intel
