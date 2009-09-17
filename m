From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Thu, 17 Sep 2009 00:13:06 -0400
Message-ID: <4AB1B752.4010505__14453.4104424112$1253160835$gmane$org@gmail.com>
References: <4AAF8A03.5020806@redhat.com> <4AAF909F.9080306@gmail.com>
	<4AAF95D1.1080600@redhat.com> <4AAF9BAF.3030109@gmail.com>
	<4AAFACB5.9050808@redhat.com> <4AAFF437.7060100@gmail.com>
	<4AB0A070.1050400@redhat.com> <4AB0CFA5.6040104@gmail.com>
	<4AB0E2A2.3080409@redhat.com> <4AB0F1EF.5050102@gmail.com>
	<20090917035717.GB3088@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4760054087290619471=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090917035717.GB3088@redhat.com>
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
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, Avi Kivity <avi@redhat.com>, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4760054087290619471==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEC75824AD85A44F4912F87A4"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC75824AD85A44F4912F87A4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Wed, Sep 16, 2009 at 10:10:55AM -0400, Gregory Haskins wrote:
>>> There is no role reversal.
>> So if I have virtio-blk driver running on the x86 and vhost-blk device=

>> running on the ppc board, I can use the ppc board as a block-device.
>> What if I really wanted to go the other way?
>=20
> It seems ppc is the only one that can initiate DMA to an arbitrary
> address, so you can't do this really, or you can by tunneling each
> request back to ppc, or doing an extra data copy, but it's unlikely to
> work well.
>=20
> The limitation comes from hardware, not from the API we use.

Understood, but presumably it can be exposed as a sub-function of the
ppc's board's register file as a DMA-controller service to the x86.
This would fall into the "tunnel requests back" category you mention
above, though I think "tunnel" implies a heavier protocol than it would
actually require.  This would look more like a PIO cycle to a DMA
controller than some higher layer protocol.

You would then utilize that DMA service inside the memctx, and it the
rest of vbus would work transparently with the existing devices/drivers.

I do agree it would require some benchmarking to determine its
feasibility, which is why I was careful to say things like "may work"
;).  I also do not even know if its possible to expose the service this
way on his system.  If this design is not possible or performs poorly, I
admit vbus is just as hosed as vhost in regard to the "role correction"
benefit.

Kind Regards,
-Greg


--------------enigEC75824AD85A44F4912F87A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqxt1IACgkQP5K2CMvXmqFcBACdEdK6dMDD1cgvHnfb47PWv9rw
arAAn0YoNmyNwDHyndyfBYpZXKHxTcPt
=/ezZ
-----END PGP SIGNATURE-----

--------------enigEC75824AD85A44F4912F87A4--

--===============4760054087290619471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4760054087290619471==--
