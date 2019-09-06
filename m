From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 16/18] virtiofs: Use virtio_fs_mutex for races w.r.t
	->remove and mount path
Date: Fri, 6 Sep 2019 13:05:34 +0100
Message-ID: <20190906120534.GX5900__17848.3855373756$1567771546$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-17-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3750306256798096800=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-17-vgoyal@redhat.com>
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


--===============3750306256798096800==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZcaUvQ23gCOmDTXi"
Content-Disposition: inline


--ZcaUvQ23gCOmDTXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:57PM -0400, Vivek Goyal wrote:
> It is possible that a mount is in progress and device is being removed at
> the same time. Use virtio_fs_mutex to avoid races.
>=20
> This also takes care of bunch of races and removes some TODO items.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

Let's move to a per-device mutex in the future.  That way a single
device that fails to drain/complete requests will not hang all other
virtio-fs instances.  This is fine for now.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZcaUvQ23gCOmDTXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yS44ACgkQnKSrs4Gr
c8gUCQf+Lirs+hHg5s88TZfhFQDIDlsjp7llI3ghi4VGGjOuWrHpg5U7YPVCoG+A
+0eiFCQiNg4fqbw/TLcaT8YknKoReHjLZb8waWsV+NWa4EVPLLcQHM4NPVMQpHXg
/CNlyVrgI608sj4hndY5xrbKsnmJdSUBedMLU7nNpnl2dId2yIHYMzHrwsce+Fth
a0bRjYBP1KZqXLaiTi+D7ytBAdRcIyacS+pJ8eeOOk+wOgWaoeQx8oZUfy6/IXyq
hZ+zZpC6c7xcxaNJqgvs+eBG3oQBFJHWCqRtFJad+TSEPgSNOiRU/fcVTAR1Anmj
czpMpNPM8lGfcpjr4tW456SPBRyiVw==
=nWjp
-----END PGP SIGNATURE-----

--ZcaUvQ23gCOmDTXi--

--===============3750306256798096800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3750306256798096800==--
