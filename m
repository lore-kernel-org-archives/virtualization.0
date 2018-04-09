From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: kernel BUG at drivers/vhost/vhost.c:LINE! (2)
Date: Mon, 9 Apr 2018 11:28:35 +0800
Message-ID: <20180409032835.GB1648__42857.2754994549$1523244410$gmane$org@stefanha-x1.localdomain>
References: <001a11449424f11322056932b09c@google.com>
	<CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
	<20180409054316-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7840647841164505401=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180409054316-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, syzbot <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============7840647841164505401==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 05:44:36AM +0300, Michael S. Tsirkin wrote:
> On Mon, Apr 09, 2018 at 10:37:45AM +0800, Stefan Hajnoczi wrote:
> > On Sat, Apr 7, 2018 at 3:02 AM, syzbot
> > <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com> wrote:
> > > syzbot hit the following crash on upstream commit
> > > 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +00=
00)
> > > Merge tag 'armsoc-drivers' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> > > syzbot dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=3D65a84dde0214b0387ccd
> >=20
> > To prevent duplicated work: I am working on this one.
> >=20
> > Stefan
>=20
> Do you want to try this patchset:
> https://lkml.org/lkml/2018/4/5/665
>=20
> ?

Thanks, I'll give it a shot.

I also noticed a regression in commit
d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log when
IOTLB is enabled") and am currently testing a fix.

Stefan

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJayt3jAAoJEJykq7OBq3PIvCQH/2E79UtiLD6eBIXZkG58tEo5
Ez30uLYssZ++XNLiJVf/zFggkbtAbO7MxF7NC7irzgyaywS9mClGLlmfV9RTN5En
AwEnk1TVhOfZdrsO97o/k37V8WCF16mGNmQVA2XCoex6P8vnnUIMEBvdZGSToEQx
WgtPjrHCAMfpEjotN/3mstAdv6O3+Cm/utLUNC4ZsJexuk7JvskDO9AljnCViVcz
ZUAZsVHHY2nQZfjzyx1GudJrkceB/3/newMoDQDVLqvLKoFZEV65nxXWhmDO4zO9
ocWB9oLqCU+CpD3LG1Eh+BMT+KuqvWXMzzO48IFZtUn22BHAQGNrWBDdrVo22Fs=
=K4YJ
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

--===============7840647841164505401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7840647841164505401==--
