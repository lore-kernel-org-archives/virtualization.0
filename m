From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-blk: remove VIRTIO_BLK_F_SCSI support
Date: Fri, 13 Dec 2019 11:12:48 +0000
Message-ID: <20191213111248.GF1180977@stefanha-x1.localdomain>
References: <20191212163719.28432-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2806254460053145579=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212163719.28432-1-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

--===============2806254460053145579==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline

--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 05:37:19PM +0100, Christoph Hellwig wrote:
> Since the need for a special flag to support SCSI passthrough on a
> block device was added in May 2017 the SCSI passthrough support in
> virtio-blk has been disabled.  It has always been a bad idea
> (just ask the original author..) and we have virtio-scsi for proper
> passthrough.  The feature also never made it into the virtio 1.0
> or later specifications.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/configs/guest.config |   1 -
>  drivers/block/Kconfig             |  10 ---
>  drivers/block/virtio_blk.c        | 115 +-----------------------------
>  3 files changed, 1 insertion(+), 125 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zcjAACgkQnKSrs4Gr
c8hUCwgAwoDSWLqUUFcE49cvm2R06U1mq/S+1RD+NEKHblyqWDsshV3UG8/It0EK
P0UJdPG99+Px7vbsh8WoZx0THO+YT3pBT0UzxY/KggDZYU2IAStfaSxBwDa0mULu
utlt/elBTbhtTd8dNIDz0w9qxyVHaa/8urGHtFe8mWw7xhOg5LHLqQESRV6V7y9v
f7+Za7/DFg1XeFxGDlZW3dWY22lPTe8gAGrOqQRnj69lrYZuezbCIDNf3Ab+PJQp
p2HoSZBNZTRrekMap2n3iEA63GNQAlXrDRfdWqRXkK3EXjHlVJcGe86ZZD8XqiCp
g/TdO1+w4c9ds5Oqo6dO/MWQKOVYGg==
=+gj9
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--


--===============2806254460053145579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2806254460053145579==--
