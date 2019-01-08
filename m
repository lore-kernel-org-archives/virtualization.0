From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
Date: Tue, 8 Jan 2019 11:24:11 +0000
Message-ID: <20190108112411.GC32358@stefanha-x1.localdomain>
References: <20190108080703.70050-1-zhabin@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3521133288749353956=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190108080703.70050-1-zhabin@linux.alibaba.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zha Bin <zhabin@linux.alibaba.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, kata-dev@lists.katacontainers.io, gerry@linux.alibaba.com
List-Id: virtualization@lists.linuxfoundation.org


--===============3521133288749353956==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 04:07:03PM +0800, Zha Bin wrote:
> The vsock core only supports 32bit CID, but the Virtio-vsock spec define
> CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
> zero. This inconsistency causes one bug in vhost vsock driver. The
> scenarios is:
>=20
>   0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
>   object. And hash_min() is used to compute the hash key. hash_min() is
>   defined as:
>   (sizeof(val) <=3D 4 ? hash_32(val, bits) : hash_long(val, bits)).
>   That means the hash algorithm has dependency on the size of macro
>   argument 'val'.
>   0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
>   hash_min() to compute the hash key when inserting a vsock object into
>   the hash table.
>   0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
>   to compute the hash key when looking up a vsock for an CID.
>=20
> Because the different size of the CID, hash_min() returns different hash
> key, thus fails to look up the vsock object for an CID.
>=20
> To fix this bug, we keep CID as u64 in the IOCTLs and virtio message
> headers, but explicitly convert u64 to u32 when deal with the hash table
> and vsock core.
>=20
> Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack ca=
llers")
> Link: https://github.com/stefanha/virtio/blob/vsock/trunk/content.tex
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for tracking this down!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNIhbAAoJEJykq7OBq3PInaoH/ji5ogIrLawH19suKLZrlABN
9XRO5FJrUISYIksh6jpjW2x2hPtts2MjaKLYAm8LrhBMw2c8yquB7AkdIwCS7RXK
1mo0raIPCuFBLFmrqVaogPzzraHTH1FFSr+S1VXVjp9VBZIP2eogLMR2KaUbbVaS
num4kgLF0hOtQUeP6XwQIXVPzdZ8kKlO7ytaJaPxmTXA9CZD0/9NoSWq+FSY4gpk
RO+LiSETk9TgyuEf8zpvCAtRoIL8ohlmoXEy/rkhgM6JpOyQSWF0X6bzqlRaRrvX
HSWB9fPfEKSLVO8G1cZTAVGUVv9Ku/5l09TcrQxZfTbhgjYbI8XMWHGtN2Nf5cg=
=ZJ2v
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

--===============3521133288749353956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3521133288749353956==--
