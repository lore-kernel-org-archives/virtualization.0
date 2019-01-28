From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to
	correct place
Date: Mon, 28 Jan 2019 09:10:05 +0100
Message-ID: <20190128081005.j6z2ecnytuocfidh__43830.3692311578$1548681672$gmane$org@sirius.home.kraxel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-11-kraxel@redhat.com>
	<b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

> > The cursor must be set again after creating the primary surface.
> > Also drop the error message.

> >  	if (!bo->is_primary) {
> > -		if (!same_shadow)
> > +		if (!same_shadow) {
> >  			qxl_io_create_primary(qdev, 0, bo);
> > +			qxl_primary_apply_cursor(plane);
> > +		}
> >  		bo->is_primary =3D true;
> >  	}
> >  =

> > =

> =

> I don't see how the commit message matches what you're doing. It gives
> the impression that it must be applied under yet another condition, but
> the condition for applying the cursor is changed from bo_old->is_primary
> to !bo->is_primary.

The qxl device ties the cursor to the primary surface.  Therefore
calling qxl_io_destroy_primary() and qxl_io_create_primary() to switch
the framebuffer causes the cursor information being lost and the driver
must re-apply it.

The correct call order to do that is qxl_io_destroy_primary() +
qxl_io_create_primary() + qxl_primary_apply_cursor().

The old code did qxl_io_destroy_primary() + qxl_primary_apply_cursor() +
qxl_io_create_primary().  Due to qxl_primary_apply_cursor request being
queued in a ringbuffer and qxl_io_create_primary() trapping to the
hypervisor instantly there is a high chance that qxl_io_create_primary()
is processed first even with the wrong call order.  But it's racy and
thus not reliable.

> It probably makes sense to someone that knows the driver.

If the above explains things better to you I should probably replace the
commit message with that.

> Acked-by: Noralf Tr=F8nnes <noralf@tronnes.org>

thanks,
  Gerd
