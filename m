From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 15 Sep 2009 16:43:58 -0400
Message-ID: <4AAFFC8E.9010404__35737.2837643654$1253048045$gmane$org@gmail.com>
References: <20090913120140.GA31218@redhat.com> <4AAE6A97.7090808@gmail.com>
	<20090914164750.GB3745@redhat.com> <4AAE961B.6020509@gmail.com>
	<4AAF8A03.5020806@redhat.com> <4AAF909F.9080306@gmail.com>
	<4AAF95D1.1080600@redhat.com> <4AAF9BAF.3030109@gmail.com>
	<4AAFACB5.9050808@redhat.com> <4AAFF437.7060100@gmail.com>
	<20090915204036.GA27954@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7850314047221605143=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090915204036.GA27954@redhat.com>
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
--===============7850314047221605143==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig24896E66E3C399935D536D3E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24896E66E3C399935D536D3E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Tue, Sep 15, 2009 at 04:08:23PM -0400, Gregory Haskins wrote:
>> No, what I mean is how do you surface multiple ethernet and consoles t=
o
>> the guests?  For Ira's case, I think he needs at minimum at least one =
of
>> each, and he mentioned possibly having two unique ethernets at one poi=
nt.
>>
>> His slave boards surface themselves as PCI devices to the x86
>> host.  So how do you use that to make multiple vhost-based devices (sa=
y
>> two virtio-nets, and a virtio-console) communicate across the transpor=
t?
>>
>> There are multiple ways to do this, but what I am saying is that
>> whatever is conceived will start to look eerily like a vbus-connector,=

>> since this is one of its primary purposes ;)
>=20
> Can't all this be in userspace?

Can you outline your proposal?

-Greg


--------------enig24896E66E3C399935D536D3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqv/I4ACgkQP5K2CMvXmqFXNgCeITGEZIQyY1AzJ7od1rh0LGyp
QJcAnAuw/OPdj+0i1gYeklbBHida5NMq
=Fiqk
-----END PGP SIGNATURE-----

--------------enig24896E66E3C399935D536D3E--

--===============7850314047221605143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7850314047221605143==--
