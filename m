From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 06/18] virtiofs: ->remove should not clean virtiofs fuse
	devices
Date: Fri, 6 Sep 2019 11:47:08 +0100
Message-ID: <20190906104708.GN5900__26329.898186826$1567766845$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-7-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8771087932482653607=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-7-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============8771087932482653607==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:47PM -0400, Vivek Goyal wrote:
> We maintain a fuse device per virt queue. This fuse devices are allocated
> and installed during mount time and should be cleaned up when super block
> is going away. Device removal should not clean it. Device removal should
> stop queues and virtuques can go away.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOSwACgkQnKSrs4Gr
c8h6Qwf/WpO4mnEca0Q5mo2lnzp1LNn53yJFIz8baldN1jOcw33zkeKDoJ8jQ4ij
1MbNgXpZWvKRM3ne2pDWOTfgU+JfCLruMSB7cgawvizBo2wsehRoCQ7Y+rEFrPhT
QkfKngAlQfkxdMH0s3efds0D/ra9rWftywFg4BxtNrwWwq85JA5bA6IulJBeydlL
kYibfDTxusBufOj57M6CzGNkcrhbBbGoGp29/WKGDTJPYr10IOINpG1VLMRalyyY
DR1y94cFvWz3qNz1CduPxLeBXjCfAjd9u9RNV+U/JnsmVDm6+csXA70wr7tmPjEY
mc+3IOwSwASzAjknAwn7k4QHKwpUmA==
=TIQ2
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--

--===============8771087932482653607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8771087932482653607==--
