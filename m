From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH v2 net 0/2] drivers/net,ipv6: Fix IPv6 fragment ID selection
	for virtio
Date: Thu, 30 Oct 2014 18:26:32 +0000
Message-ID: <1414693592.16849.61.camel__30887.2433416129$1414693622$gmane$org@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5947955048384641097=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5947955048384641097==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ENpuRQMmnWEC8ORQlhJI"


--=-ENpuRQMmnWEC8ORQlhJI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The virtio net protocol supports UFO but does not provide for passing a
fragment ID for fragmentation of IPv6 packets.  We used to generate a
fragment ID wherever such a packet was fragmented, but currently we
always use ID=3D0!

v2: Add blank lines after declarations

Ben.

Ben Hutchings (2):
  drivers/net: Disable UFO through virtio
  drivers/net,ipv6: Select IPv6 fragment idents for virtio UFO packets

 drivers/net/macvtap.c    | 16 ++++++++--------
 drivers/net/tun.c        | 25 ++++++++++++++++---------
 drivers/net/virtio_net.c | 24 ++++++++++++++----------
 include/net/ipv6.h       |  2 ++
 net/ipv6/output_core.c   | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 27 deletions(-)

--=20
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.

--=-ENpuRQMmnWEC8ORQlhJI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVFKC3ee/yOyVhhEJAQouJA/8DDnny3CmqaJVX4ZazV3Xck2xMGRVaIYD
o394JZdrGTBZBrrQ1JNy98+yOHpydoe2eQK3DuGKAEIaDXdaURVUDISjb5xRZvoM
Cfm/tyXrZ/Nif+vgLfgBgVcQBN8bvRV9XnjHr2kUoXS/RnDE0Nhp5E28Q6s5UNKS
iXn0FtX1jgKGgHWtq1LzBM2EUCH8bCpQoSd5KSPqechYutTGVPC6iyJuxs4PBrvc
ydsNhLuHCqmrStrKbv63XOSLEQZZq8hVX4V26HWzJLDyAnhL+Y8g1dUj91kXdWny
bk4hA2ENR6MT6YmiqyWb+DQBwP2WfRn2Jz20yltkbhmOGQFHXPd/oK4p8oOVRuvb
QYdTwa6vK/HQeqWCyMP0lRhjJypnbDtjAXayrXiODHMLzb7ujbxWT6Wvp88QIxSk
2vCeFTQj7k+pjACrdBx3vFldYLWlg8j9g83zozwZ61NKZWr9a1SroztrORbr41w7
QZsNXcVmvlalngUjwUx8tcBkmkiO9GknmTy8lH92kMs9BsDDJFptyixqtOxTE/Qg
QPukGE6CZtGX+AMb1iD7+lS9ZwDqD6JNYw+2RS52w8VWdnRxhYwCim4kADH98gS/
HLNypkp9lAqNzmBwhPn46M1hgOPTqkfWPYXxjSyDoQ41vR215XGsNEAqESItFBqs
EgLMbpxVWRc=
=Hqcq
-----END PGP SIGNATURE-----

--=-ENpuRQMmnWEC8ORQlhJI--

--===============5947955048384641097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5947955048384641097==--
