From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 5/5] VSOCK: batch sending rx buffer to increase
	bandwidth
Date: Thu, 13 Dec 2018 15:17:52 +0000
Message-ID: <20181213151752.GK23318__21505.5000423037$1544714158$gmane$org@stefanha-x1.localdomain>
References: <5C10D65F.7030407@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1668022064278097359=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C10D65F.7030407@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1668022064278097359==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Content-Disposition: inline


--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 05:35:27PM +0800, jiangyiwen wrote:
> Batch sending rx buffer can improve total bandwidth.
>=20
> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> ---

Please send patches with git-send-email --thread --no-chain-reply-to so
that your patch series email thread looks like this:

  * [PATCH 00/NN] My feature
  +-- [PATCH 01/NN] First patch
  +-- [PATCH 02/NN] Second patch
  .
  .
  .
  +-- [PATCH NN/NN] Last patch

This way it's much easier to view the entire series.  At the moment you
are sending each patch as an independent email and there is no
relationship between the emails.

Thanks,
Stefan

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEnggAAoJEJykq7OBq3PI/VwH/2iojiX1oUhJCV8fLUKXuMpI
GnJJLimi4otl24JKApsaziIbtyGS4lwSUseWYVygvMxUgHVq1t+4GunIc6h87BeD
1JfNQpNBMOnuZMGlyylrgu1QBS/6dNSqMSGMAfCmQfYP4K5/gt9egrmi9LFq7yYJ
RO6Xn5C9CaWDGHgxotLlzmjnziqUqYBJhLrNbkOPVlwn4LOpyxTmKIZjxLRkYwPp
gDF01gvs8qUeDMpeP8rsMC12dRVFjqv7aPJOrC7JtxC/0sbrj/TuO9BvygE8bLo8
LraBqhU8ZsA9aNXlYylu1u4ogH5X7gXVyG0sR8Iaf23beHDiFzXoUDeutLbHKjQ=
=1sSR
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--

--===============1668022064278097359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1668022064278097359==--
