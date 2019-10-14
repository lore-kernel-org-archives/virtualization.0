From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V3 5/7] mdev: introduce virtio device and its device ops
Date: Mon, 14 Oct 2019 18:23:01 +0100
Message-ID: <20191014172301.GA5359__30609.9623137683$1571073800$gmane$org@stefanha-x1.localdomain>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0553217446153230562=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-6-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coque
List-Id: virtualization@lists.linuxfoundation.org


--===============0553217446153230562==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2019 at 04:15:55PM +0800, Jason Wang wrote:
> + * @set_vq_cb:			Set the interrut calback function for

s/interrut/interrupt/

s/calback/callback/

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2krvUACgkQnKSrs4Gr
c8hIpQgArOf5wNMCOOx9mrAoFEfDyFDnQGYWa6Ce2/25rBYZVN1BIaLrZLwRk4Za
aM65SiUsAMIh+UTdezqEPyUZCoRZbcxFRWUtyQZqHLCVg3yrwM++9xtTFclrIY0p
hP+v2ZVAMUT/1BQiaAo3+qlItEYbUDwtSl+wsSwzlvu9nFRlHjjdbUZAJmU78zv0
Y50LNaXQf3+E9GqPDj6nJEUSxpww44C1FOgxh9SErmqG8j7ReyAfng0loRKNdZbv
6g7U1I0J+vNgzcCxTSipVRS8EH0bOEY07w3OggpIoIRnOx6voaXYz8SMEQZ8tiRu
k0SSOtAyZ48s1BaOt3vREX8uYFlt0A==
=/ZZN
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============0553217446153230562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0553217446153230562==--
