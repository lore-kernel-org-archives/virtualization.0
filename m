From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Wed, 18 Jun 2014 18:51:20 +0800
Message-ID: <20140618105120.GI14030@stefanha-thinkpad.redhat.com>
References: <20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0758245336398473830=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A00464.8090609@6wind.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Marchand <david.marchand@6wind.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent JARDIN <vincent.jardin@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============0758245336398473830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 11:03:32AM +0200, David Marchand wrote:
> On 06/17/2014 04:54 AM, Stefan Hajnoczi wrote:
> >ivshmem has a performance disadvantage for guest-to-host
> >communication.  Since the shared memory is exposed as PCI BARs, the
> >guest has to memcpy into the shared memory.
> >
> >vhost-user can access guest memory directly and avoid the copy inside th=
e guest.
>=20
> Actually, you can avoid this memory copy using frameworks like DPDK.

I guess it's careful to allocate all packets in the mmapped BAR?

That's fine if you can modify applications but doesn't work for
unmodified applications using regular networking APIs.

Stefan

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJToW8oAAoJEJykq7OBq3PIZE8H/1qvoO1fNeV1NTzlbG2Ct6fj
Xj65iyqXzc9SKBTBK+aN6LdPnd3mIIvrnHqgH6lpkYEAAPDfpXX7qzhYz+QzQqRh
8epEGZerirEzk+Fwdfo66I+kAIo8W1xQD9LvDsIUbB7XQIR7lnrVxeQyBR7lGzjh
KiIWcxYiBg+cns4QWr8Y1TfirplCIhyN0hYsTljWsubOHyh9LJQSax/l7S23B74o
De6rG6n8eCTTUrxxH0zC2eYfX6mEHa6pt/+ULP1Cndb/iIXC6wGZYmlGEX65Jrg7
kmROWJ0EyZzVoXZBLjBj4tLXKHsxilhEVQs4AA4bAfxewDCTqm9+zCXxurjzarQ=
=eSgA
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--

--===============0758245336398473830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0758245336398473830==--
