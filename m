From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Using virtio for inter-VM communication
Date: Sun, 15 Jun 2014 08:20:37 +0200
Message-ID: <539D3B35.2010706__19209.9128886641$1402940057$gmane$org@web.de>
References: <20140610184818.2e490419@nbschild1>	<87r42uq2v8.fsf@rustcorp.com.au>	<53993B7B.7010404@siemens.com>	<87fvj9prdi.fsf@rustcorp.com.au>	<539A98D3.3070601@siemens.com>
	<539ABA41.3070701@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9064469963980697719=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539ABA41.3070701@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Henning Schild <henning.schild@siemens.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Jailhouse <jailhouse-dev@googlegroups.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============9064469963980697719==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cRLQKXi54eaooTwxxeJmKxnMFB25QgCqN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cRLQKXi54eaooTwxxeJmKxnMFB25QgCqN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-06-13 10:45, Paolo Bonzini wrote:
> Il 13/06/2014 08:23, Jan Kiszka ha scritto:
>>>> That would preserve zero-copy capabilities (as long as you can work
>>>> against the shared mem directly, e.g. doing DMA from a physical NIC =
or
>>>> storage device into it) and keep the hypervisor out of the loop.
>> >
>> > This seems ill thought out.  How will you program a NIC via the virt=
io
>> > protocol without a hypervisor?  And how will you make it safe?  You'=
ll
>> > need an IOMMU.  But if you have an IOMMU you don't need shared memor=
y.
>>
>> Scenarios behind this are things like driver VMs: You pass through the=

>> physical hardware to a driver guest that talks to the hardware and
>> relays data via one or more virtual channels to other VMs. This confin=
es
>> a certain set of security and stability risks to the driver VM.
>=20
> I think implementing Xen hypercalls in jailhouse for grant table and
> event channels would actually make a lot of sense.  The Xen
> implementation is 2.5kLOC and I think it should be possible to compact
> it noticeably, especially if you limit yourself to 64-bit guests.

At least the grant table model seems unsuited for Jailhouse. It allows a
guest to influence the mapping of another guest during runtime. This we
want (or even have) to avoid in Jailhouse.

I'm therefore more in favor of a model where the shared memory region is
defined on cell (guest) creation by adding a virtual device that comes
with such a region.

Jan

>=20
> It should also be almost enough to run Xen PVH guests as jailhouse
> partitions.
>=20
> If later Xen starts to support virtio, you will get that for free.
>=20
> Paolo



--cRLQKXi54eaooTwxxeJmKxnMFB25QgCqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOdOzoACgkQitSsb3rl5xTyTwCgt5AKtLnT8cmZ5ILYh/bMgnva
BmAAoL9HlHBp2eARliY8PicSwe2JuxQp
=Vsxr
-----END PGP SIGNATURE-----

--cRLQKXi54eaooTwxxeJmKxnMFB25QgCqN--

--===============9064469963980697719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9064469963980697719==--
