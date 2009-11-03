From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 03 Nov 2009 13:08:25 -0500
Message-ID: <4AF07199.2020601__26480.0653946169$1257271753$gmane$org@gmail.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com> <4AF0708B.4020406@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8336388933587469449=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AF0708B.4020406@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8336388933587469449==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig77CFE234DE15F23B398FB30F"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77CFE234DE15F23B398FB30F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> Michael S. Tsirkin a =E9crit :
>> +static void handle_tx(struct vhost_net *net)
>> +{
>> +	struct vhost_virtqueue *vq =3D &net->dev.vqs[VHOST_NET_VQ_TX];
>> +	unsigned head, out, in, s;
>> +	struct msghdr msg =3D {
>> +		.msg_name =3D NULL,
>> +		.msg_namelen =3D 0,
>> +		.msg_control =3D NULL,
>> +		.msg_controllen =3D 0,
>> +		.msg_iov =3D vq->iov,
>> +		.msg_flags =3D MSG_DONTWAIT,
>> +	};
>> +	size_t len, total_len =3D 0;
>> +	int err, wmem;
>> +	size_t hdr_size;
>> +	struct socket *sock =3D rcu_dereference(vq->private_data);
>> +	if (!sock)
>> +		return;
>> +
>> +	wmem =3D atomic_read(&sock->sk->sk_wmem_alloc);
>> +	if (wmem >=3D sock->sk->sk_sndbuf)
>> +		return;
>> +
>> +	use_mm(net->dev.mm);
>> +	mutex_lock(&vq->mutex);
>> +	vhost_no_notify(vq);
>> +
>=20
> using rcu_dereference() and mutex_lock() at the same time seems wrong, =
I suspect
> that your use of RCU is not correct.
>=20
> 1) rcu_dereference() should be done inside a read_rcu_lock() section, a=
nd
>    we are not allowed to sleep in such a section.
>    (Quoting Documentation/RCU/whatisRCU.txt :
>      It is illegal to block while in an RCU read-side critical section,=
 )
>=20
> 2) mutex_lock() can sleep (ie block)
>=20


Michael,
  I warned you that this needed better documentation ;)

Eric,
  I think I flagged this once before, but Michael convinced me that it
was indeed "ok", if but perhaps a bit unconventional.  I will try to
find the thread.

Kind Regards,
-Greg


--------------enig77CFE234DE15F23B398FB30F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrwcZkACgkQP5K2CMvXmqGhOACePT9ytdQxnqeObfA1h+nnRfJY
vNwAn2y4p+io84eG19OyEly9IqSi8EDf
=XPsn
-----END PGP SIGNATURE-----

--------------enig77CFE234DE15F23B398FB30F--

--===============8336388933587469449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8336388933587469449==--
