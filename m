From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Date: Thu, 21 Mar 2019 15:57:46 +0000
Message-ID: <20190321155746.GE31434__5503.73617313511$1553183885$gmane$org@stefanha-x1.localdomain>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
	<20190312183351.74764f4f.cohuck@redhat.com>
	<173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
	<20190313103900.1ea7f996.cohuck@redhat.com>
	<a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
	<537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
	<20190315134112.7d63348c.cohuck@redhat.com>
	<1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
	<0fbdcfa6-cbd7-4f09-93b1-40898d5f77d1@oracle.com>
	<f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0124710237906000291=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
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
Cc: axboe@kernel.dk, mst@redhat.com, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


--===============0124710237906000291==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 08:53:33PM +0800, Jason Wang wrote:
>=20
> On 2019/3/19 =E4=B8=8A=E5=8D=8810:22, Dongli Zhang wrote:
> > Hi Jason,
> >=20
> > On 3/18/19 3:47 PM, Jason Wang wrote:
> > > On 2019/3/15 =E4=B8=8B=E5=8D=888:41, Cornelia Huck wrote:
> > > > On Fri, 15 Mar 2019 12:50:11 +0800
> > > > Jason Wang <jasowang@redhat.com> wrote:
> > option 3:
> > We should allow more vectors even the block layer would support at most
> > nr_cpu_ids queues.
> >=20
> >=20
> > I understand a new policy for queue-vector mapping is very helpful. I a=
m just
> > asking the question from block layer's point of view.
> >=20
> > Thank you very much!
> >=20
> > Dongli Zhang
>=20
>=20
> Don't know much for block, cc Stefan for more idea.

Thanks for CCing me.  I don't have much input at this stage.

Stefan

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJck7R5AAoJEJykq7OBq3PISGcH+gL2UqKuOclQNeDq8We5P/mv
norBWe7BE3V9Aj0u8b9s6rNXKi9XYRoKPMMC3jf8EZmefL95c4nsaCG8cNG0juj8
uv50QGn0VoN9tXlVakv2+b99X2mXhFfok0Z68+jPYq1LMIRFaTVqZkutgiIXOBLV
rG20zEUVSHvoY/n7TWXmJRn3O/PSYxoR312UR/vwFZWlQUwZJme4yYFpBBiuY7ur
I8F2OmH0oVtb/qvJ9XF2zqI48Nwy5OWnhkTNRHSsudw7njAwJfXRNpk/GbOlHLYD
FnQGST7MJrpiQCvCWkZADFGJ1wmlb0bFJ1R5qkME5+zxYq2VbQ9CiiklD8yBXBw=
=9/HK
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--

--===============0124710237906000291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0124710237906000291==--
