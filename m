From: =?ks_c_5601-1987?B?sKG0z726?= <ganis@etri.re.kr>
Subject: Setting up VHost without QEMU?
Date: Wed, 3 Sep 2014 05:44:03 +0000
Message-ID: <56354052-553D-42CC-A03C-8C8E820CC153@etri.re.kr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1319413169429545746=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: ko-KR
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============1319413169429545746==
Content-Language: ko-KR
Content-Type: multipart/alternative;
	boundary="_000_56354052553D42CCA03C8C8E820CC153etrirekr_"

--_000_56354052553D42CCA03C8C8E820CC153etrirekr_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

RGVhciBhbGwsDQoNCkkgaGF2ZSBhIGZldyBxdWVzdGlvbnMuIFZob3N0IGlzIHRha2luZyBvdXQg
UUVNVSBpbiB2aXJ0aW8gZGV2aWNlIGVtdWxhdGlvbi4gQnV0IGluIEtWTSwgVmhvc3QgbmVlZHMg
UUVNVSBmb3Igc2V0dGluZyB1cCB2aXJ0cXVldWUuIFdoeSBpdCBjYW4ndCBiZSBkb25lIGluIGtl
cm5lbD8gSXMgaXQgYmVjYXVzZSB0aGUgZ3Vlc3QgVk1zIGFyZSBydW5uaW5nIGluIFFFTVU/DQoN
CkkgYW5kIG15IHRlYW0gYXJlIGRldmVsb3Bpbmcgb3VyIG93biBoeXBlcnZpc29yLiBBbmQgb3Vy
IGd1ZXN0IFZNcyBhcmUgbm90IHJ1bm5pbmcgaW4gUUVNVS4gSXMgdGhlcmUgYW55IGltcGxlbWVu
dGF0aW9uIG91dCB0aGVyZSB3aGljaCBpbXBsZW1lbnQgVmhvc3Qgd2l0aG91dCBuZWVkaW5nIFFF
TVUgYXQgYWxsPw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZS4gSGF2ZSBhIG5pY2UgZGF5L2V2
ZW5pbmchDQoNCg0KR2FuaXMNCg==

--_000_56354052553D42CCA03C8C8E820CC153etrirekr_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-ID: <036B83684D1F09459EFA286351FFB74B@etri.re.kr>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;">
Dear all,
<div><br>
</div>
<div>I have a few questions. Vhost is taking out QEMU in virtio device emul=
ation. But in KVM, Vhost needs QEMU&nbsp;for setting up virtqueue. Why it c=
an't be done in kernel? Is it because the guest VMs are running in QEMU?</d=
iv>
<div>
<div><br>
</div>
<div>I and my team are developing our own hypervisor. And our guest VMs are=
 not running in QEMU. Is there any implementation out there which implement=
 Vhost without needing QEMU at all?</div>
<div>
<div><br>
Thank you for your time. Have a nice day/evening!<br>
<div apple-content-edited=3D"true">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: normal; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px;">
<br class=3D"Apple-interchange-newline">
</div>
<br>
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: normal; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px;">
Ganis&nbsp;</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_56354052553D42CCA03C8C8E820CC153etrirekr_--

--===============1319413169429545746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1319413169429545746==--
