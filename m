From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v9 09/11] vhost/scsi: switch to buf APIs
Date: Mon, 22 Jun 2020 11:01:46 +0100
Message-ID: <20200622100146.GC6675@stefanha-x1.localdomain>
References: <20200619182302.850-1-eperezma@redhat.com>
 <20200619182302.850-10-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200619182302.850-10-eperezma@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, kvm list <kvm@vger.kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 08:23:00PM +0200, Eugenio P=E9rez wrote:
> @@ -1139,9 +1154,9 @@ vhost_scsi_send_tmf_reject(struct vhost_scsi *vs,
>  =09iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp)=
);
> =20
>  =09ret =3D copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
> -=09if (likely(ret =3D=3D sizeof(rsp)))
> -=09=09vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
> -=09else
> +=09if (likely(ret =3D=3D sizeof(rsp))) {
> +=09=09vhost_scsi_signal_noinput(&vs->dev, vq, &vc->buf);
> +=09} else
>  =09=09pr_err("Faulted on virtio_scsi_ctrl_tmf_resp\n");
>  }

The curly brackets are not necessary, but the patch still looks fine:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wgYoACgkQnKSrs4Gr
c8iU0wgAsLU1H/KwuKf6yqFN/L0od7nMvZEId3V8dwQBJLUc48Mxam6NlNI0Y/Fb
fY8+U4GIN38UTCj3sWf9KwU/jUVxdwtFHljPNcdDG4IRARU9bLZ1Z8XDrPvXqx0L
SiXWJRPbZhCS0vSKlStWVPsiKhntXocPX805bya3z0B5ix5U3TjfEWjmJnMtq8Vm
RrJGKjF8TYNLCXbJWmeFCKIzZ9HNkaPlZ8X3yb7J5xoPtf7wzxoRdFXbDeJPlMsa
JTN2jd6r8TRyN5zWukPwYe3Q5vX1QfVtCcZwNY9Iwys45cn7AoZrwhEMtDqaJCkN
0VZfJdyLT6+w8Ns35FIqT9XGxccMMw==
=yt/w
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
