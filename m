From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 14 Sep 2009 15:14:35 -0400
Message-ID: <4AAE961B.6020509__48557.6382176534$1252955806$gmane$org@gmail.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
	<4AAE6A97.7090808@gmail.com> <20090914164750.GB3745@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8146359604896917222=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090914164750.GB3745@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8146359604896917222==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2959D78D936A954B1F0C2FB2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2959D78D936A954B1F0C2FB2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Mon, Sep 14, 2009 at 12:08:55PM -0400, Gregory Haskins wrote:
>> For Ira's example, the addresses would represent a physical address on=

>> the PCI boards, and would follow any kind of relevant rules for
>> converting a "GPA" to a host accessible address (even if indirectly, v=
ia
>> a dma controller).
>=20
> I don't think limiting addresses to PCI physical addresses will work
> well.

The only "limit" is imposed by the memctx.  If a given context needs to
meet certain requirements beyond PCI physical addresses, it would
presumably be designed that way.


>  From what I rememeber, Ira's x86 can not initiate burst
> transactions on PCI, and it's the ppc that initiates all DMA.

The only requirement is that the "guest" "owns" the memory.  IOW: As
with virtio/vhost, the guest can access the pointers in the ring
directly but the host must pass through a translation function.

Your translation is direct: you use a slots/hva scheme.  My translation
is abstracted, which means it can support slots/hva (such as in
alacrityvm) or some other scheme as long as the general model of "guest
owned" holds true.

>=20
>>>  But we can't let the guest specify physical addresses.
>> Agreed.  Neither your proposal nor mine operate this way afaict.
>=20
> But this seems to be what Ira needs.

So what he could do then is implement the memctx to integrate with the
ppc side dma controller.  E.g. "translation" in his box means a protocol
from the x86 to the ppc to initiate the dma cycle.  This could be
exposed as a dma facility in the register file of the ppc boards, for
instance.

To reiterate, as long as the model is such that the ppc boards are
considered the "owner" (direct access, no translation needed) I believe
it will work.  If the pointers are expected to be owned by the host,
then my model doesn't work well either.

Kind Regards,
-Greg


--------------enig2959D78D936A954B1F0C2FB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqulhsACgkQP5K2CMvXmqHsYACePYzh0H3oY5W3aAc6pFFp4w3u
tYEAnRNmpU/44+9P++MVTtjbqreGPiiM
=J8am
-----END PGP SIGNATURE-----

--------------enig2959D78D936A954B1F0C2FB2--

--===============8146359604896917222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8146359604896917222==--
