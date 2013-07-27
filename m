From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Merge of "virtio_net: fix race in RX VQ processing" for
	linux-3.2.48
Date: Sat, 27 Jul 2013 15:42:53 +0100
Message-ID: <1374936173.13555.19.camel@deadeye.wl.decadent.org.uk>
References: <u4ehb37a8w.fsf@md.dent.med.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8953273587968514706=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <u4ehb37a8w.fsf@md.dent.med.uni-muenchen.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
Cc: virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============8953273587968514706==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6bnD4esdAHFtZlXYzXTD"


--=-6bnD4esdAHFtZlXYzXTD
Content-Type: multipart/mixed; boundary="=-zhsmlbE+szULmgFYYyV4"


--=-zhsmlbE+szULmgFYYyV4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2013-07-12 at 23:13 +0200, Wolfram Gloger wrote:
> Hi,
>=20
> Today I merged M. Tsirkin's patch v2 "virtio_net: fix race in RX VQ
> processing":
>=20
> http://lkml.indiana.edu/hypermail/linux/kernel/1307.1/00503.html
>=20
> into 3.2.48 and lightly tested the result (vhost-net, virtio-disk
> and 9pfs using virtio).

This sounds like it could be suitable for stable, but that doesn't seem
to have been requested by the author.  I'm cc'ing those involved so they
can make a decision whether this should be included in 3.2.y or other
stable branches.

> Merge is not completely trivial, so might save you some time, if only
> for a comparison that you arrive at the same result.

Thanks, but these are not in quite the right patch format.  The
filenames should always have a leading directory name which will be
stripped (patch -p1).  The original patch header must be preserved and a
reference to the upstream commit inserted e.g.
'commit 0123456789abcdef0123456789abcdef012345678 upstream.'

(Attachments copied for reference.)

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.


--=-zhsmlbE+szULmgFYYyV4
Content-Disposition: attachment; filename="virtio-race-tsirkin-1of2.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="virtio-race-tsirkin-1of2.diff"; charset="UTF-8"

LS0tIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMub3JpZwkyMDEzLTA2LTMwIDExOjM1OjQ0
LjAwMDAwMDAwMCArMDIwMA0KKysrIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMJMjAxMy0w
Ny0xMiAxNToxODo0OC4wMDAwMDAwMDAgKzAyMDANCkBAIC0zNjAsOSArMzYwLDIyIEBAIHZvaWQg
dmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3RydWN0IHZpcnRxdWUNCiB9DQogRVhQT1JUX1NZTUJPTF9H
UEwodmlydHF1ZXVlX2Rpc2FibGVfY2IpOw0KIA0KLWJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYihz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEpDQorLyoqDQorICogdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVw
YXJlIC0gcmVzdGFydCBjYWxsYmFja3MgYWZ0ZXIgZGlzYWJsZV9jYg0KKyAqIEB2cTogdGhlIHN0
cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4NCisgKg0KKyAqIFRoaXMgcmUtZW5h
YmxlcyBjYWxsYmFja3M7IGl0IHJldHVybnMgY3VycmVudCBxdWV1ZSBzdGF0ZQ0KKyAqIGluIGFu
IG9wYXF1ZSB1bnNpZ25lZCB2YWx1ZS4gVGhpcyB2YWx1ZSBzaG91bGQgYmUgbGF0ZXIgdGVzdGVk
IGJ5DQorICogdmlydHF1ZXVlX3BvbGwsIHRvIGRldGVjdCBhIHBvc3NpYmxlIHJhY2UgYmV0d2Vl
biB0aGUgZHJpdmVyIGNoZWNraW5nIGZvcg0KKyAqIG1vcmUgd29yaywgYW5kIGVuYWJsaW5nIGNh
bGxiYWNrcy4NCisgKg0KKyAqIENhbGxlciBtdXN0IGVuc3VyZSB3ZSBkb24ndCBjYWxsIHRoaXMg
d2l0aCBvdGhlciB2aXJ0cXVldWUNCisgKiBvcGVyYXRpb25zIGF0IHRoZSBzYW1lIHRpbWUgKGV4
Y2VwdCB3aGVyZSBub3RlZCkuDQorICovDQordW5zaWduZWQgdmlydHF1ZXVlX2VuYWJsZV9jYl9w
cmVwYXJlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkNCiB7DQogCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7DQorCXUxNiBsYXN0X3VzZWRfaWR4Ow0KIA0KIAlTVEFSVF9V
U0UodnEpOw0KIA0KQEAgLTM3MiwxNSArMzg1LDQ1IEBAIGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9j
YihzdHJ1Y3QgdmlydHF1ZXUNCiAJICogZWl0aGVyIGNsZWFyIHRoZSBmbGFncyBiaXQgb3IgcG9p
bnQgdGhlIGV2ZW50IGluZGV4IGF0IHRoZSBuZXh0DQogCSAqIGVudHJ5LiBBbHdheXMgZG8gYm90
aCB0byBrZWVwIGNvZGUgc2ltcGxlLiAqLw0KIAl2cS0+dnJpbmcuYXZhaWwtPmZsYWdzICY9IH5W
UklOR19BVkFJTF9GX05PX0lOVEVSUlVQVDsNCi0JdnJpbmdfdXNlZF9ldmVudCgmdnEtPnZyaW5n
KSA9IHZxLT5sYXN0X3VzZWRfaWR4Ow0KKwl2cmluZ191c2VkX2V2ZW50KCZ2cS0+dnJpbmcpID0g
bGFzdF91c2VkX2lkeCA9IHZxLT5sYXN0X3VzZWRfaWR4Ow0KKwlFTkRfVVNFKHZxKTsNCisJcmV0
dXJuIGxhc3RfdXNlZF9pZHg7DQorfQ0KK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9lbmFi
bGVfY2JfcHJlcGFyZSk7DQorDQorLyoqDQorICogdmlydHF1ZXVlX3BvbGwgLSBxdWVyeSBwZW5k
aW5nIHVzZWQgYnVmZmVycw0KKyAqIEB2cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFs
a2luZyBhYm91dC4NCisgKiBAbGFzdF91c2VkX2lkeDogdmlydHF1ZXVlIHN0YXRlIChmcm9tIGNh
bGwgdG8gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKS4NCisgKg0KKyAqIFJldHVybnMgInRy
dWUiIGlmIHRoZXJlIGFyZSBwZW5kaW5nIHVzZWQgYnVmZmVycyBpbiB0aGUgcXVldWUuDQorICoN
CisgKiBUaGlzIGRvZXMgbm90IG5lZWQgdG8gYmUgc2VyaWFsaXplZC4NCisgKi8NCitib29sIHZp
cnRxdWV1ZV9wb2xsKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdW5zaWduZWQgbGFzdF91c2VkX2lk
eCkNCit7DQorCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7DQorDQog
CXZpcnRpb19tYigpOw0KLQlpZiAodW5saWtlbHkobW9yZV91c2VkKHZxKSkpIHsNCi0JCUVORF9V
U0UodnEpOw0KLQkJcmV0dXJuIGZhbHNlOw0KLQl9DQorCXJldHVybiAodTE2KWxhc3RfdXNlZF9p
ZHggIT0gdnEtPnZyaW5nLnVzZWQtPmlkeDsNCit9DQorRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1
ZXVlX3BvbGwpOw0KIA0KLQlFTkRfVVNFKHZxKTsNCi0JcmV0dXJuIHRydWU7DQorLyoqDQorICog
dmlydHF1ZXVlX2VuYWJsZV9jYiAtIHJlc3RhcnQgY2FsbGJhY2tzIGFmdGVyIGRpc2FibGVfY2Iu
DQorICogQHZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lg0KKyAq
DQorICogVGhpcyByZS1lbmFibGVzIGNhbGxiYWNrczsgaXQgcmV0dXJucyAiZmFsc2UiIGlmIHRo
ZXJlIGFyZSBwZW5kaW5nDQorICogYnVmZmVycyBpbiB0aGUgcXVldWUsIHRvIGRldGVjdCBhIHBv
c3NpYmxlIHJhY2UgYmV0d2VlbiB0aGUgZHJpdmVyDQorICogY2hlY2tpbmcgZm9yIG1vcmUgd29y
aywgYW5kIGVuYWJsaW5nIGNhbGxiYWNrcy4NCisgKg0KKyAqIENhbGxlciBtdXN0IGVuc3VyZSB3
ZSBkb24ndCBjYWxsIHRoaXMgd2l0aCBvdGhlciB2aXJ0cXVldWUNCisgKiBvcGVyYXRpb25zIGF0
IHRoZSBzYW1lIHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuDQorICovDQorYm9vbCB2aXJ0cXVl
dWVfZW5hYmxlX2NiKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkNCit7DQorCXVuc2lnbmVkIGxhc3Rf
dXNlZF9pZHggPSB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUoX3ZxKTsNCisJcmV0dXJuICF2
aXJ0cXVldWVfcG9sbChfdnEsIGxhc3RfdXNlZF9pZHgpOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQ
TCh2aXJ0cXVldWVfZW5hYmxlX2NiKTsNCiANCi0tLSBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oLm9y
aWcJMjAxMi0wMS0wNSAwMDo1NTo0NC4wMDAwMDAwMDAgKzAxMDANCisrKyBpbmNsdWRlL2xpbnV4
L3ZpcnRpby5oCTIwMTMtMDctMTIgMTQ6NDI6MjYuMDAwMDAwMDAwICswMjAwDQpAQCAtOTYsNiAr
OTYsMTAgQEAgdm9pZCB2aXJ0cXVldWVfZGlzYWJsZV9jYihzdHJ1Y3QgdmlydHF1ZQ0KIA0KIGJv
b2wgdmlydHF1ZXVlX2VuYWJsZV9jYihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7DQogDQordW5zaWdu
ZWQgdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsNCisN
Citib29sIHZpcnRxdWV1ZV9wb2xsKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCk7DQor
DQogYm9vbCB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Ow0KIA0KIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSk7DQo=


--=-zhsmlbE+szULmgFYYyV4
Content-Disposition: attachment; filename="virtio-race-tsirkin-2of2.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="virtio-race-tsirkin-2of2.diff"; charset="UTF-8"

LS0tIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYy5vcmlnCTIwMTItMDEtMDUgMDA6NTU6NDQuMDAw
MDAwMDAwICswMTAwDQorKysgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCTIwMTMtMDctMTIgMTU6
Mzk6MDYuMDAwMDAwMDAwICswMjAwDQpAQCAtNTA4LDcgKzUwOCw3IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnUNCiB7DQogCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
ID0gY29udGFpbmVyX29mKG5hcGksIHN0cnVjdCB2aXJ0bmV0X2luZm8sIG5hcGkpOw0KIAl2b2lk
ICpidWY7DQotCXVuc2lnbmVkIGludCBsZW4sIHJlY2VpdmVkID0gMDsNCisJdW5zaWduZWQgaW50
IHIsIGxlbiwgcmVjZWl2ZWQgPSAwOw0KIA0KIGFnYWluOg0KIAl3aGlsZSAocmVjZWl2ZWQgPCBi
dWRnZXQgJiYNCkBAIC01MjUsOCArNTI1LDkgQEAgYWdhaW46DQogDQogCS8qIE91dCBvZiBwYWNr
ZXRzPyAqLw0KIAlpZiAocmVjZWl2ZWQgPCBidWRnZXQpIHsNCisJCXIgPSB2aXJ0cXVldWVfZW5h
YmxlX2NiX3ByZXBhcmUodmktPnJ2cSk7DQogCQluYXBpX2NvbXBsZXRlKG5hcGkpOw0KLQkJaWYg
KHVubGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiKHZpLT5ydnEpKSAmJg0KKwkJaWYgKHVubGlr
ZWx5KHZpcnRxdWV1ZV9wb2xsKHZpLT5ydnEsIHIpKSAmJg0KIAkJICAgIG5hcGlfc2NoZWR1bGVf
cHJlcChuYXBpKSkgew0KIAkJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHZpLT5ydnEpOw0KIAkJCV9f
bmFwaV9zY2hlZHVsZShuYXBpKTsNCg==


--=-zhsmlbE+szULmgFYYyV4--

--=-6bnD4esdAHFtZlXYzXTD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUfPcbee/yOyVhhEJAQokFw/+IpoFK7serP0jNzrDvxqSKRKXYFawDt08
FJmQmRTRN47ZfSgVh22D35b/Vncdd4wlGSRDvIzUK3YKEGPfH9IPngmEkEvjY/oH
UtQbSAMaL/ILWDmejjzyRcXcYy03sUHZ0T0GO9rhsIwytqWSgQBk5jJdwsxCeEXV
TPS/K6y6rUe3/lsXOffxDaMJw/9CgyfmgnRtTvtO3U8ITg5lAFlB+stxWWHB26do
SzdrtS7iwy3MBVsfdmco06Wgfcl2uo7UnY5B4SET+JA+QJMfhY4WilhJ2aTQHBjv
i+WJyxyxDFHJBcsQijg335TC7Hdctp/vy1qiYi/nQcumFaJMOdjVjWP5ZzjCZQu3
5Z3BOlqk9+1ZPa46KJV+eVyStPB/oHF0GFlXr41VMgCFOByp5I9h5LqSjJvfFSzz
kHXmQkiI7PVISt2o4RyIqBXEhSM388QVNGmJNCaKfrL3QiVLp74RXMN7b8lB/W2r
1hMvTCm+1KR/bMNhspOm33O7v/D7QN/IoixhgfR5hH/5kVS0i7yCXAZwU7d/9kor
KijvpJOW69bfQp3GRT/1fnBvPqUccwcEk7uGIWc+KKqUpoMg5v4UGTFqWChK1bb7
pxpHwzQDyooQX+pJU3fSHgnau/nrSBBNs+Pkp6xrpms7JJgdrulzRkKnXJALzbl4
A9n/bRm3Erw=
=HlTU
-----END PGP SIGNATURE-----

--=-6bnD4esdAHFtZlXYzXTD--

--===============8953273587968514706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8953273587968514706==--
