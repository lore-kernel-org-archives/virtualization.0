From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 10/20] s390x/virtio-ccw: add virtio set-revision
	call
Date: Tue, 20 Jan 2015 11:00:21 +0000
Message-ID: <20150120110021.GH17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-11-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6919400026859918652=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-11-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============6919400026859918652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:12PM +0100, Cornelia Huck wrote:
> From: Thomas Huth <thuth@linux.vnet.ibm.com>
>=20
> Handle the virtio-ccw revision according to what the guest sets.
> When revision 1 is selected, we have a virtio-1 standard device
> with byteswapping for the virtio rings.
>=20
> When a channel gets disabled, we have to revert to the legacy behavior
> in case the next user of the device does not negotiate the revision 1
> anymore (e.g. the boot firmware uses revision 1, but the operating
> system only uses the legacy mode).
>=20
> Note that revisions > 0 are still disabled.
>=20
> Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c |   52 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/s390x/virtio-ccw.h |    8 ++++++++
>  2 files changed, 60 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjVFAAoJEJykq7OBq3PIzw8IAIFDnCkF1F2/4ayFWYMZpK52
9Zx+XijdUiGcUj5gDjL51FgftE+992ajEBWSOXIi6HKaam/zJCvjUF/1/pQvwl3l
8eh9DzthWxZEisSMvXK1vlytg3yKxrk6i/R2N50tdtfvzn2FQHxF78j8yKGZACCh
/AIfhfgcwOwlwurceMtLEjY745upnMBv7xJJyyz3WWLuOYvV6Uo26ZM72HUVA+Jc
fjEgWo8AupyZWJNNeTy2hS6+CTsxu9wyN8OdeARj2e8S4SY6OHM2JV5ZxbrvL2yS
o9DInGWiT+CqCCvf6ckcRrHbub8ybMpO24p4qlL9XnmCLnT1PeV6kaJoZeK8BBE=
=Vy4j
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

--===============6919400026859918652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6919400026859918652==--
