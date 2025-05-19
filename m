Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E2267B9F;
	Mon, 19 May 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644211; cv=none; b=mXNRdLZ3eIRdVpJLdQySS6wKQdgJ+xdBnD8n/IjfSpj/yBGNZTh8+JADxG1aI5N76QllxnRPP1OUxUqrTlcTLeGE06cjYRE0Al7gDGJCoTevfwgpBJ1ixILGjBiLH28v1IPB6bAm9Dcef7l5riQ3Xvx62qCYri/5Imbk81fkyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644211; c=relaxed/simple;
	bh=ZOT0C0K0vPz9f06+lIVOOzuxP0Ka7pZHBD9bPzHiIx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu0i4DtG7uYDGKpayRJ5CJo4RSYf7FwiK43OCYktoCOZjlOG0kBEZ9ewGIr419nYuMsL/ppyaeGE1R7O9N3naKN4UyI0XMK4m4G4PDw4FJoALrYkmSxxX4jotkgATl3C2CqXxwLnvBkxx86tfkVfaiTBV0yDHc/vlmdDMmrcoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmRVvjCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmRVvjCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A6C4CEE4;
	Mon, 19 May 2025 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747644210;
	bh=ZOT0C0K0vPz9f06+lIVOOzuxP0Ka7pZHBD9bPzHiIx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmRVvjCgl5wYhy2TDehbZ/hmlXluy2bVk24nSycH7kLGPj39FqYMztARpvCnlRQIp
	 /pWZI7pKYGPZ4qH6AG6hPG45IzKXVaT07tVG6z8GnzMJeLmDjcYbBo0c7OlCpD9ewa
	 sddYOAVCDeDzsJBum3oIUX5l1PPyOT+nTWh/3BKInEyhGEry1W8/rkHnzLoMDIm7wP
	 A1EQBElwa2FIQgTN0AKmNDVQUx3Qt+C+oeeJ0PhLtsJ6C0OJ33ByfOUS4WkRUiJtqp
	 ikHmua/hlYQWDJ58eiZSaacjvLl6hx2qwxBkgRnx1eFRv2JRNg3cP0KVdhJws92wTc
	 2RZBFEQzyr9dQ==
Date: Mon, 19 May 2025 10:43:27 +0200
From: Maxime Ripard <mripard@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, 
	Eric Auger <eric.auger@redhat.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: implement virtio_gpu_shutdown
Message-ID: <20250519-crazy-wisteria-mule-ef8e28@houat>
References: <20250507082821.2710706-1-kraxel@redhat.com>
 <urpxto3fgvwoe4hob2aukggeop4bcsyb7m5wflgru4c3otd6rq@aktopqufgxom>
 <iptz2uxajkl3l62piqu6tq5pembbmqho667otbaj7nneh5vk3r@sxdvm7e57nae>
 <20250518175332-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="owfohtpihfpfbao7"
Content-Disposition: inline
In-Reply-To: <20250518175332-mutt-send-email-mst@kernel.org>


--owfohtpihfpfbao7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/virtio: implement virtio_gpu_shutdown
MIME-Version: 1.0

On Sun, May 18, 2025 at 05:53:59PM -0400, Michael S. Tsirkin wrote:
> On Tue, May 13, 2025 at 12:18:44PM +0200, Gerd Hoffmann wrote:
> > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm=
/virtio/virtgpu_drv.c
> > > > index e32e680c7197..71c6ccad4b99 100644
> > > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_d=
evice *vdev)
> > > > =20
> > > >  static void virtio_gpu_shutdown(struct virtio_device *vdev)
> > > >  {
> > > > -	/*
> > > > -	 * drm does its own synchronization on shutdown.
> > > > -	 * Do nothing here, opt out of device reset.
> > > > -	 */
> > > > +	struct drm_device *dev =3D vdev->priv;
> > > > +
> > > > +	/* stop talking to the device */
> > > > +	drm_dev_unplug(dev);
> > >=20
> > > I'm not necessarily opposed to using drm_dev_unplug() here, but it's
> > > still pretty surprising to me. It's typically used in remove, not
> > > shutdown. The typical helper to use at shutdown is
> > > drm_atomic_helper_shutdown.
> > >=20
> > > So if the latter isn't enough or wrong, we should at least document w=
hy.
> >=20
> > The intention of this is to make sure the driver stops talking to the
> > device (as the comment already says).
> >=20
> > There are checks in place in the virt queue functions which will make
> > sure the driver will not try place new requests in the queues after
> > drm_dev_unplug() has been called.  Which why I decided to implement it
> > that way.
> >=20
> > drm_atomic_helper_shutdown() tears down all outputs according to the
> > documentation.  Which is something different.  I don't think calling
> > drm_atomic_helper_shutdown() will do what I need here.  Calling it in
> > addition to drm_dev_unplug() might make sense, not sure.
> >=20
> > Suggestions are welcome.
> >=20
> > take care,
> >   Gerd
>=20
>=20
> I suggest adding comments in code explaining why it's approriate here.
> Want to try?

Yes, that would be great

Maxime

--owfohtpihfpfbao7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaCrvLwAKCRAnX84Zoj2+
dgnnAX41YH5MdklVDoci3LCBdtMOwNXiHuO4oHPW3spALAh+ceP1tjWrDivp1KWs
HIHscPgBgLrrA1SdGDzvZnHluVFSvh0V6BWTaFk5wrcnF3tCW2hOXdbJLnN3ocJI
Jbo2yI9kOQ==
=36F7
-----END PGP SIGNATURE-----

--owfohtpihfpfbao7--
