From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 15 Sep 2009 17:39:27 -0400
Message-ID: <4AB0098F.9030207__47311.7958558307$1253050967$gmane$org@gmail.com>
References: <20090914164750.GB3745@redhat.com> <4AAE961B.6020509@gmail.com>
	<4AAF8A03.5020806@redhat.com> <4AAF909F.9080306@gmail.com>
	<4AAF95D1.1080600@redhat.com> <4AAF9BAF.3030109@gmail.com>
	<4AAFACB5.9050808@redhat.com> <4AAFF437.7060100@gmail.com>
	<20090915204036.GA27954@redhat.com> <4AAFFC8E.9010404@gmail.com>
	<20090915212545.GC27954@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5243227580889461823=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090915212545.GC27954@redhat.com>
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
--===============5243227580889461823==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE1C8E234A80666A2DFF10887"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1C8E234A80666A2DFF10887
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Tue, Sep 15, 2009 at 04:43:58PM -0400, Gregory Haskins wrote:
>> Michael S. Tsirkin wrote:
>>> On Tue, Sep 15, 2009 at 04:08:23PM -0400, Gregory Haskins wrote:
>>>> No, what I mean is how do you surface multiple ethernet and consoles=
 to
>>>> the guests?  For Ira's case, I think he needs at minimum at least on=
e of
>>>> each, and he mentioned possibly having two unique ethernets at one p=
oint.
>>>>
>>>> His slave boards surface themselves as PCI devices to the x86
>>>> host.  So how do you use that to make multiple vhost-based devices (=
say
>>>> two virtio-nets, and a virtio-console) communicate across the transp=
ort?
>>>>
>>>> There are multiple ways to do this, but what I am saying is that
>>>> whatever is conceived will start to look eerily like a vbus-connecto=
r,
>>>> since this is one of its primary purposes ;)
>>> Can't all this be in userspace?
>> Can you outline your proposal?
>>
>> -Greg
>>
>=20
> Userspace in x86 maps a PCI region, uses it for communication with ppc?=

>=20

And what do you propose this communication to look like?

-Greg


--------------enigE1C8E234A80666A2DFF10887
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqwCY8ACgkQP5K2CMvXmqFo6QCfX2e/9YFa3RtxY3QkALvECB9D
CyoAnRdufMvyfZD3ahmI8vuciuOZXXil
=N7UX
-----END PGP SIGNATURE-----

--------------enigE1C8E234A80666A2DFF10887--

--===============5243227580889461823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5243227580889461823==--
