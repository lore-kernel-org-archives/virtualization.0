From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 14 Sep 2009 12:08:55 -0400
Message-ID: <4AAE6A97.7090808__10362.5427386307$1252945192$gmane$org@gmail.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6837601033349212048=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090913120140.GA31218@redhat.com>
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
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6837601033349212048==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A7B9E21588ECA3868FA009B"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A7B9E21588ECA3868FA009B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Fri, Sep 11, 2009 at 12:00:21PM -0400, Gregory Haskins wrote:
>> FWIW: VBUS handles this situation via the "memctx" abstraction.  IOW,
>> the memory is not assumed to be a userspace address.  Rather, it is a
>> memctx-specific address, which can be userspace, or any other type
>> (including hardware, dma-engine, etc).  As long as the memctx knows ho=
w
>> to translate it, it will work.
>=20
> How would permissions be handled?

Same as anything else, really.  Read on for details.

> it's easy to allow an app to pass in virtual addresses in its own addre=
ss space.

Agreed, and this is what I do.

The guest always passes its own physical addresses (using things like
__pa() in linux).  This address passed is memctx specific, but generally
would fall into the category of "virtual-addresses" from the hosts
perspective.

For a KVM/AlacrityVM guest example, the addresses are GPAs, accessed
internally to the context via a gfn_to_hva conversion (you can see this
occuring in the citation links I sent)

For Ira's example, the addresses would represent a physical address on
the PCI boards, and would follow any kind of relevant rules for
converting a "GPA" to a host accessible address (even if indirectly, via
a dma controller).


>  But we can't let the guest specify physical addresses.

Agreed.  Neither your proposal nor mine operate this way afaict.

HTH

Kind Regards,
-Greg


--------------enig4A7B9E21588ECA3868FA009B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkquapcACgkQP5K2CMvXmqEsZQCfcQ2o0HqEYlWAuk3Qckq/ciWq
JrgAn0itJih00Z/pLWaEa7xiy99pwjUj
=Y/uW
-----END PGP SIGNATURE-----

--------------enig4A7B9E21588ECA3868FA009B--

--===============6837601033349212048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============6837601033349212048==--
