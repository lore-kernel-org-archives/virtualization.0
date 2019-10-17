From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V3 0/7] mdev based hardware virtio offloading support
Date: Thu, 17 Oct 2019 10:43:41 +0100
Message-ID: <20191017094341.GF23557__7743.04076783068$1571305437$gmane$org@stefanha-x1.localdomain>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191014174946.GC5359@stefanha-x1.localdomain>
	<6d12ad8f-8137-e07d-d735-da59a326e8ed@redhat.com>
	<20191015143720.GA13108@stefanha-x1.localdomain>
	<ba81e603-cb7d-b152-8fae-97f070a7e460@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0579911445614330695=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ba81e603-cb7d-b152-8fae-97f070a7e460@redhat.com>
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


--===============0579911445614330695==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 09:42:53AM +0800, Jason Wang wrote:
>=20
> On 2019/10/15 =E4=B8=8B=E5=8D=8810:37, Stefan Hajnoczi wrote:
> > On Tue, Oct 15, 2019 at 11:37:17AM +0800, Jason Wang wrote:
> > > On 2019/10/15 =E4=B8=8A=E5=8D=881:49, Stefan Hajnoczi wrote:
> > > > On Fri, Oct 11, 2019 at 04:15:50PM +0800, Jason Wang wrote:
> > > > > There are hardware that can do virtio datapath offloading while h=
aving
> > > > > its own control path. This path tries to implement a mdev based
> > > > > unified API to support using kernel virtio driver to drive those
> > > > > devices. This is done by introducing a new mdev transport for vir=
tio
> > > > > (virtio_mdev) and register itself as a new kind of mdev driver. T=
hen
> > > > > it provides a unified way for kernel virtio driver to talk with m=
dev
> > > > > device implementation.
> > > > >=20
> > > > > Though the series only contains kernel driver support, the goal i=
s to
> > > > > make the transport generic enough to support userspace drivers. T=
his
> > > > > means vhost-mdev[1] could be built on top as well by resuing the
> > > > > transport.
> > > > >=20
> > > > > A sample driver is also implemented which simulate a virito-net
> > > > > loopback ethernet device on top of vringh + workqueue. This could=
 be
> > > > > used as a reference implementation for real hardware driver.
> > > > >=20
> > > > > Consider mdev framework only support VFIO device and driver right=
 now,
> > > > > this series also extend it to support other types. This is done
> > > > > through introducing class id to the device and pairing it with
> > > > > id_talbe claimed by the driver. On top, this seris also decouple
> > > > > device specific parents ops out of the common ones.
> > > > I was curious so I took a quick look and posted comments.
> > > >=20
> > > > I guess this driver runs inside the guest since it registers virtio
> > > > devices?
> > >=20
> > > It could run in either guest or host. But the main focus is to run in=
 the
> > > host then we can use virtio drivers in containers.
> > >=20
> > >=20
> > > > If this is used with physical PCI devices that support datapath
> > > > offloading then how are physical devices presented to the guest wit=
hout
> > > > SR-IOV?
> > >=20
> > > We will do control path meditation through vhost-mdev[1] and vhost-vf=
io[2].
> > > Then we will present a full virtio compatible ethernet device for gue=
st.
> > >=20
> > > SR-IOV is not a must, any mdev device that implements the API defined=
 in
> > > patch 5 can be used by this framework.
> > What I'm trying to understand is: if you want to present a virtio-pci
> > device to the guest (e.g. using vhost-mdev or vhost-vfio), then how is
> > that related to this patch series?
>=20
>=20
> This series introduce some infrastructure that would be used by vhost-mde=
v:
>=20
> 1) allow new type of mdev devices/drivers other than vfio (through class_=
id
> and device ops)
>=20
> 2) a set of virtio specific callbacks that will be used by both vhost-mdev
> and virtio-mdev defined in patch 5
>=20
> Then vhost-mdev can be implemented on top: a new mdev class id but reuse =
the
> callback defined in 2. Through this way the parent can provides a single =
set
> of callbacks (device ops) for both kernel virtio driver (through
> virtio-mdev) or userspace virtio driver (through vhost-mdev).

Okay, thanks for explaining!

Stefan

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2oN8wACgkQnKSrs4Gr
c8gqswf/fQBq+qX21L3QGLUXUsf7OZ9kLP3ksR+9RYfGDJaFva/fV/aULknTmAiO
OA0s+Eiw7K5Hy2ooKGPQXPYgAJhgnHqmhKgOEdsOGDWyCilYAiJzk/YXkpPvaCTp
ovWC5Fz/shXyY3m2YGPXuwnWjbCam7cqMCRVPrmzJWoS6kdvsYsPxBVnhGFOm0Ms
gbll/8mZQDQWsOZ8ZFeXLXCcHifXaiLa+yiGcZfxtV37oHsSapT+MOXEstGy4jEe
uvos/V8tSLLMOJ+zgMYGOI0oOJIejMOrLU2zxPlktTbBVcM1RQtpJL69F30gi89K
qCue5w57Z1UNfPVbXLiobIkPcZBGVw==
=EXDt
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--

--===============0579911445614330695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0579911445614330695==--
