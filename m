From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 14 Sep 2009 15:28:39 -0400
Message-ID: <4AAE9967.9060406__753.540828782384$1252956774$gmane$org@gmail.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
	<4AAE6A97.7090808@gmail.com> <20090914165320.GA3851@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2142444272104235755=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090914165320.GA3851@redhat.com>
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
--===============2142444272104235755==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA42345AD71EBB21A4FC6AED0"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA42345AD71EBB21A4FC6AED0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Mon, Sep 14, 2009 at 12:08:55PM -0400, Gregory Haskins wrote:
>> Michael S. Tsirkin wrote:
>>> On Fri, Sep 11, 2009 at 12:00:21PM -0400, Gregory Haskins wrote:
>>>> FWIW: VBUS handles this situation via the "memctx" abstraction.  IOW=
,
>>>> the memory is not assumed to be a userspace address.  Rather, it is =
a
>>>> memctx-specific address, which can be userspace, or any other type
>>>> (including hardware, dma-engine, etc).  As long as the memctx knows =
how
>>>> to translate it, it will work.
>>> How would permissions be handled?
>> Same as anything else, really.  Read on for details.
>>
>>> it's easy to allow an app to pass in virtual addresses in its own add=
ress space.
>> Agreed, and this is what I do.
>>
>> The guest always passes its own physical addresses (using things like
>> __pa() in linux).  This address passed is memctx specific, but general=
ly
>> would fall into the category of "virtual-addresses" from the hosts
>> perspective.
>>
>> For a KVM/AlacrityVM guest example, the addresses are GPAs, accessed
>> internally to the context via a gfn_to_hva conversion (you can see thi=
s
>> occuring in the citation links I sent)
>>
>> For Ira's example, the addresses would represent a physical address on=

>> the PCI boards, and would follow any kind of relevant rules for
>> converting a "GPA" to a host accessible address (even if indirectly, v=
ia
>> a dma controller).
>=20
> So vbus can let an application

"application" means KVM guest, or ppc board, right?

> access either its own virtual memory or a physical memory on a PCI devi=
ce.

To reiterate from the last reply: the model is the "guest" owns the
memory.  The host is granted access to that memory by means of a memctx
object, which must be admitted to the host kernel and accessed according
 to standard access-policy mechanisms.  Generally the "application" or
guest would never be accessing anything other than its own memory.

> My question is, is any application
> that's allowed to do the former also granted rights to do the later?

If I understand your question, no.  Can you elaborate?

Kind Regards,
-Greg


--------------enigA42345AD71EBB21A4FC6AED0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqumWcACgkQP5K2CMvXmqFy7ACgi8TyUR3Jecgzz5GkKkFbPghh
68MAnjdJj8I2gXA9aTDBmumt62C11d3G
=yoUM
-----END PGP SIGNATURE-----

--------------enigA42345AD71EBB21A4FC6AED0--

--===============2142444272104235755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2142444272104235755==--
