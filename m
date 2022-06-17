Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC57DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 09:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 385E9844F9;
	Fri, 17 Jun 2022 09:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 385E9844F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vfrz0bdpZAZJ; Fri, 17 Jun 2022 09:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA3E0844F1;
	Fri, 17 Jun 2022 09:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA3E0844F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31D80C002D;
	Fri, 17 Jun 2022 09:02:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18CD1C002D;
 Fri, 17 Jun 2022 09:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 715856128B;
 Fri, 17 Jun 2022 09:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 715856128B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFkTqvpOATkW; Fri, 17 Jun 2022 09:02:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAAD9612AE
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAAD9612AE;
 Fri, 17 Jun 2022 09:02:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id EBA0379E; Fri, 17 Jun 2022 11:02:19 +0200 (CEST)
Date: Fri, 17 Jun 2022 11:02:14 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [CFP LPC 2022] VFIO/IOMMU/PCI Microconference
Message-ID: <YqxDFkAFdLjqnW8O@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Will Deacon <will@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ashok Raj <ashok.raj@intel.com>, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Baolu Lu <baolu.lu@linux.intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGVsbG8gZXZlcnlvbmUhCgpXZSBhcmUgcGxlYXNlZCB0byBhbm5vdW5jZSB0aGF0IHRoZXJlIHdp
bGwgYmUgYW5vdGhlcgoKCVZGSU8vSU9NTVUvUENJIE1pY3JvY29uZmVyZW5jZQoKYXQgdGhpcyB5
ZWFyJ3MgTGludXggUGx1bWJlcnMgQ29uZmVyZW5jZSAoTFBDKSwgZnJvbSAxMnRoIHRvIHRoZSAx
NHRoIG9mClNlcHRlbWJlciBpbiBEdWJsaW4sIElyZWxhbmQuIExQQyBpcyBhIGh5YnJpZCBldmVu
dCB0aGlzIHllYXI7CmF0dGVuZGFuY2UgY2FuIGJlIGluIHBlcnNvbiBvciByZW1vdGUuCgpJbiB0
aGlzIG1pY3JvY29uZmVyZW5jZSB3ZSB3YW50IHRvIGRpc2N1c3Mgb25nb2luZyBkZXZlbG9wbWVu
dHMgYXJvdW5kCnRoZSBWRklPLCBJT01NVSBhbmQgUENJIHN1YnN5c3RlbXMgYW5kIHRoZWlyIGlu
dGVyYWN0aW9ucyBpbiBMaW51eC4KClRlbnRhdGl2ZSB0b3BpY3MgdGhhdCBhcmUgdW5kZXIgY29u
c2lkZXJhdGlvbiBmb3IgdGhpcyB5ZWFyIGluY2x1ZGUgKGJ1dApub3QgbGltaXRlZCB0byk6CgoJ
KiBQQ0k6CgkgIC0gQ2FjaGUgQ29oZXJlbnQgSW50ZXJjb25uZWN0IGZvciBBY2NlbGVyYXRvcnMg
KENDSVgpL0NvbXB1dGUKCSAgICBFeHByZXNzIExpbmsgKENYTCkgZXhwYW5zaW9uIG1lbW9yeSBh
bmQgYWNjZWxlcmF0b3JzCgkgICAgbWFuYWdlbWVudAoJICAtIERhdGEgT2JqZWN0IEV4Y2hhbmdl
IChET0UpCgkgIC0gSW50ZWdyaXR5IGFuZCBEYXRhIEVuY3J5cHRpb24gKElERSkKCSAgLSBDb21w
b25lbnQgTWVhc3VyZW1lbnQgYW5kIEF1dGhlbnRpY2F0aW9uIChDTUEpCgkgIC0gU2VjdXJpdHkg
UHJvdG9jb2wgYW5kIERhdGEgTW9kZWwgKFNQRE0pCgkgIC0gSS9PIEFkZHJlc3MgU3BhY2UgSUQg
QWxsb2NhdG9yIChJT0FTSUQpCgkgIC0gSU5UWC9NU0kgSVJRIGRvbWFpbiBjb25zb2xpZGF0aW9u
CgkgIC0gR2VuLVogaW50ZXJjb25uZWN0IGZhYnJpYwoJICAtIEFSTTY0IGFyY2hpdGVjdHVyZSBh
bmQgaGFyZHdhcmUKCSAgLSBQQ0kgbmF0aXZlIGhvc3QgY29udHJvbGxlcnMvZW5kcG9pbnRzIGRy
aXZlcnMgY3VycmVudAoJICAgIGNoYWxsZW5nZXMgYW5kIGltcHJvdmVtZW50cyAoZS5nLiwgc3Rh
dGUgb2YgUENJIHF1aXJrcywgZXRjLikKCSAgLSBQQ0kgZXJyb3IgaGFuZGxpbmcgYW5kIG1hbmFn
ZW1lbnQgZS5nLiwgQWR2YW5jZWQgRXJyb3IKCSAgICBSZXBvcnRpbmcgKEFFUiksIERvd25zdHJl
YW0gUG9ydCBDb250YWlubWVudCAoRFBDKSwgQUNQSQoJICAgIFBsYXRmb3JtIEVycm9yIEludGVy
ZmFjZSAoQVBFSSkgYW5kIEVycm9yIERpc2Nvbm5lY3QgUmVjb3ZlcgoJICAgIChFRFIpCgkgIC0g
UG93ZXIgbWFuYWdlbWVudCBhbmQgZGV2aWNlcyBzdXBwb3J0aW5nIEFjdGl2ZS1zdGF0ZSBQb3dl
cgoJICAgIE1hbmFnZW1lbnQgKEFTUE0pCgkgIC0gUGVlci10by1QZWVyIERNQSAoUDJQRE1BKQoJ
ICAtIFJlc291cmNlcyBjbGFpbWluZy9hc3NpZ25tZW50IGNvbnNvbGlkYXRpb24KCSAgLSBQcm9i
aW5nIG9mIG5hdGl2ZSBQQ0llIGNvbnRyb2xsZXJzIGFuZCBnZW5lcmFsIHJlc2V0CgkgICAgaW1w
bGVtZW50YXRpb24KCSAgLSBQcmVmZXRjaGFibGUgdnMgbm9uLXByZWZldGNoYWJsZSBCQVIgYWRk
cmVzcyBtYXBwaW5ncwoJICAtIFVudHJ1c3RlZC9leHRlcm5hbCBkZXZpY2VzIG1hbmFnZW1lbnQK
CSAgLSBETUEgb3duZXJzaGlwIG1vZGVscwoJICAtIFRodW5kZXJib2x0LCBETUEsIFJETUEgYW5k
IFVTQjQgc2VjdXJpdHkKCgkqIFZGSU86CgkgIC0gV3JpdGUtY29tYmluZSBvbiBub24teDg2IGFy
Y2hpdGVjdHVyZXMKCSAgLSBJL08gUGFnZSBGYXVsdCAoSU9QRikgZm9yIHBhc3N0aHJvdWdoIGRl
dmljZXMKCSAgLSBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nIChTVkEpIGludGVyZmFjZQoJICAt
IFNpbmdsZS1yb290IEkvTyBWaXJ0dWFsaXphdGlvbihTUklPVikvUHJvY2VzcyBBZGRyZXNzIFNw
YWNlCgkgICAgSUQgKFBBU0lEKSBpbnRlZ3JhdGlvbgoJICAtIFBBU0lEIGluIFNSSU9WIHZpcnR1
YWwgZnVuY3Rpb25zCgkgIC0gRGV2aWNlIGFzc2lnbm1lbnQvc3ViLWFzc2lnbm1lbnQKCgkqIElP
TU1VOgoJICAtIC9kZXYvaW9tbXVmZCBkZXZlbG9wbWVudAoJICAtIElPTU1VIHZpcnR1YWxpemF0
aW9uCgkgIC0gSU9NTVUgZHJpdmVycyBTVkEgaW50ZXJmYWNlCgkgIC0gRE1BLUFQSSBsYXllciBp
bnRlcmFjdGlvbnMgYW5kIHRoZSBtb3ZlIHRvd2FyZHMgZ2VuZXJpYwoJICAgIGRtYS1vcHMgZm9y
IElPTU1VIGRyaXZlcnMKCSAgLSBQb3NzaWJsZSBJT01NVSBjb3JlIGNoYW5nZXMgKGUuZy4sIGJl
dHRlciBpbnRlZ3JhdGlvbiB3aXRoCgkgICAgZGV2aWNlLWRyaXZlciBjb3JlLCBldGMuKQoKUGxl
YXNlIHN1Ym1pdCB5b3VyIHByb3Bvc2FscyBvbiB0aGUgTFBDIHdlYnNpdGUgYXQ6CgoJaHR0cHM6
Ly9scGMuZXZlbnRzL2V2ZW50LzE2L2Fic3RyYWN0cy8KCk1ha2Ugc3VyZSB0byBzZWxlY3QgdGhl
ICJWRklPL0lPTU1VL1BDSSBNQyIgaW4gdGhlIFRyYWNrIHB1bGxkb3duCm1lbnUuCgpMb29raW5n
IGZvcndhcmQgdG8gc2VlaW5nIHlvdSBhbGwgdGhlcmUsIGVpdGhlciBpbiBEdWJsaW4gb3Igdmly
dHVhbCEgOikKClRoZSBvcmdhbml6ZXJzLAoKCUFsZXggV2lsbGlhbXNvbgoJQmpvcm4gSGVsZ2Fh
cwoJSsO2cmcgUsO2ZGVsCglMb3JlbnpvIFBpZXJhbGlzaQoJS3J6eXN6dG9mIFdpbGN6ecWEc2tp
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
