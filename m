From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 03/18] virtiofs: Pass fsvq instead of vq as parameter to
	virtio_fs_enqueue_req
Date: Fri, 6 Sep 2019 11:44:25 +0100
Message-ID: <20190906104425.GK5900__37977.4757007667$1567766681$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-4-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0432668485164356889=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-4-vgoyal@redhat.com>
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


--===============0432668485164356889==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ee6FjwWxuMujAVRe"
Content-Disposition: inline


--ee6FjwWxuMujAVRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:44PM -0400, Vivek Goyal wrote:
> Pass fsvq instead of vq as parameter to virtio_fs_enqueue_req(). We will
> retrieve vq from fsvq under spin lock.
>=20
> Later in the patch series we will retrieve vq only if fsvq is still conne=
cted
> other vq might have been cleaned up by device ->remove code and we will
> return error.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ee6FjwWxuMujAVRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOIgACgkQnKSrs4Gr
c8g+8Qf9HHMGZxy914gG38i6e+DYwvC5CryjFWlCDopWdJemyDaSNvh8UTIgIHGs
swJeFt68ZxTzEW1c/YGufHhbxDlaDhTZEs6lfIvd7I+feMa1Ovwo3fZ4UfqFBiAp
SC12MZ7/8B8wMQ1z9IG2JykyYJqoe2jQLKzr1/bQ2rW/wsh7nK+i14SkbiR560z7
bAM610aHlhhm5IPmbDuKwvui2cwyMRnHsSSWatrM3IvuOoR9fd/5DhqPKoGALSNH
FLI3zz4UiELQl2ln/hAI46cFN5b3zOucaegRvn7+C4msZkccGjAMUshVh3UPpdjK
DLFNt7LWNZp+0euYiznREAKikwyZrA==
=O1h4
-----END PGP SIGNATURE-----

--ee6FjwWxuMujAVRe--

--===============0432668485164356889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0432668485164356889==--
