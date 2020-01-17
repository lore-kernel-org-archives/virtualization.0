From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Fri, 17 Jan 2020 16:22:11 +0100
Message-ID: <20200117152211.GZ1314@mail-itl>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
 <20200115134119.GP1314@mail-itl>
 <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
 <20200115142741.GM2507@mail-itl>
 <20200115161635.ekrnk5rmjqbxxu77@sirius.home.kraxel.org>
 <20200116025232.GN2507@mail-itl>
 <20200117125825.3in2t2m6nxbblsaf@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2228732945785509442=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200117125825.3in2t2m6nxbblsaf@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2228732945785509442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+cTHE2B7cPyeMCYH"
Content-Disposition: inline


--+cTHE2B7cPyeMCYH
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible

On Fri, Jan 17, 2020 at 01:58:25PM +0100, Gerd Hoffmann wrote:
> > Should switching to bochsdrmfb be deferred until efifb gets properly
> > destroyed? How?
>=20
> Should be in do_remove_conflicting_framebuffers, everyone might run into
> this.  So lets try wait for all (other) references went away:

Yes, this solves the problem. I guess the proper solution would be to
replace it with some wait queue or such, right?
Is there any guarantee that the process holding /dev/fb0 (plymouthd in
this case) will eventually release it? If not, what could this
(indefinite then) wait cause? Is there any lock held here that could
hang other operations?

> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index d04554959ea7..2d4911cc7ec4 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1726,7 +1726,9 @@ static void do_unregister_framebuffer(struct fb_inf=
o *fb_info)
>  	fbcon_fb_unregistered(fb_info);
>  	console_unlock();
> =20
> -	/* this may free fb info */
> +	while (atomic_read(&fb_info->count) > 1)
> +		msleep(10);
> +	/* this will free fb info */
>  	put_fb_info(fb_info);
>  }
> =20
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--+cTHE2B7cPyeMCYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4h0SMACgkQ24/THMrX
1yyHRgf/cvdh48JzcslTWiyh345ddD4+7EJ8KhQOmZDlOygdHMUpLFV466aCtlqy
p7TO82lg4odvx5ig5s2HxfP1/xvZsRC3WukdPMIR+XYvGTdCPY1VtgNNTJPGrjfQ
uyeJ4Tc9WejLiSLgcqkEp9Ge47Z+fkbIF3nm3DPThvPYpn1DrdRUvu2nCXQxcQum
EQwi+NyHJZEVx5KCIC7/wPJDJRbya2DNeRSpswE99HbTWM2cqqFGfyvfkNlWtiif
XQihw62Lph70Rqq24uWybEoip0NwFBpFuFEbtq45SWcVe+duHPJKHyoo4vWL+Jti
685xudC9u3WkcUkqn/MzVZGW8I44Pg==
=kcPT
-----END PGP SIGNATURE-----

--+cTHE2B7cPyeMCYH--

--===============2228732945785509442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2228732945785509442==--
