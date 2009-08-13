From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 13 Aug 2009 07:35:52 -0400
Message-ID: <4A83FA98.1010708__6926.47092878378$1250163452$gmane$org@gmail.com>
References: <20090810192304.GA16781@redhat.com> <4A8325C0.7060001@gmail.com>
	<20090813055941.GB3029@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9058679665709078330=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813055941.GB3029@redhat.com>
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
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============9058679665709078330==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E4A7861D670552356E594A6"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E4A7861D670552356E594A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Wed, Aug 12, 2009 at 04:27:44PM -0400, Gregory Haskins wrote:
>> Michael S. Tsirkin wrote:
>>> This adds support for vhost-net virtio kernel backend.
>>>
>>> This is RFC, but works without issues for me.
>>>
>>> Still needs to be split up, tested and benchmarked properly,
>>> but posting it here in case people want to test drive
>>> the kernel bits I posted.
>> This has a large degree of rejects against qemu-kvm.git/master.  What
>> tree does this apply to?
>>
>> -Greg
>>
>=20
> Likely that tree has advanced since.
> This is on top of commit b6bbd41fac4b6fb0efc65e083d2151ce1521f615.
>=20


Hmm....better, but I still get rejects.  Of particular concern is this
one in net.c:

@@ -1903,7 +1903,7 @@ static TAPState *net_tap_init(VLANState *vlan,
const char *model,
 typedef struct RAWState {
     VLANClientState *vc;
     int fd;
-    uint8_t buf[4096];
+    uint8_t buf[65000];
     int promisc;
 } RAWState;


I do not see any occurrence of "RAWState" in b6bbd41f (or master, for
that matter).  There is probably an operator error somewhere in here ;),
but any help getting this working is appreciated.  Do you have a git
tree I can pull somewhere?

Kind Regards,
-Greg


--------------enig4E4A7861D670552356E594A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqD+pgACgkQP5K2CMvXmqEu/wCeIxX3KFkGpS9NANgZGJrrohrt
QxoAn0fLa4IAuKpW5wbddTJ2qamwuFbR
=YaMv
-----END PGP SIGNATURE-----

--------------enig4E4A7861D670552356E594A6--

--===============9058679665709078330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============9058679665709078330==--
