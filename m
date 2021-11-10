Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7FC4321E
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 19:10:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC27610FF
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 19:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EC27610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38EBE401E2;
	Wed, 10 Nov 2021 19:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BG-TtS4d65Hq; Wed, 10 Nov 2021 19:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D26D640373;
	Wed, 10 Nov 2021 19:09:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B619AC0019;
	Wed, 10 Nov 2021 19:09:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF5B9C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 19:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C862B40373
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 19:09:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yyUHaHNg5ayk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 19:09:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CBE2401E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 19:09:56 +0000 (UTC)
Received: from [128.177.79.46] (helo=csail.mit.edu)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1mksyl-000UxK-A3; Wed, 10 Nov 2021 14:09:51 -0500
Date: Wed, 10 Nov 2021 11:13:03 -0800
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as
 private
Message-ID: <20211110191303.GA122235@csail.mit.edu>
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
 <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
 <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
 <cb03ca42-b777-3d1a-5aba-b01cd19efa9a@csail.mit.edu>
 <dcbd19fcd1625146f4db267f84abd7412513d20e.camel@perches.com>
 <5C24FB2A-D2C0-4D95-A0C0-B48C4B8D5AF4@vmware.com>
 <1875b0458294d23d8e3260d2824894b095d6a62d.camel@perches.com>
 <20211110172000.GA121926@csail.mit.edu>
 <F21C4118-BFDE-4DA7-B42F-90EC71CFED57@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F21C4118-BFDE-4DA7-B42F-90EC71CFED57@vmware.com>
Cc: Ronak Doshi <doshir@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Alexey Makhalov <amakhalov@vmware.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Vishal Bhakta <vbhakta@vmware.com>, X86 ML <x86@kernel.org>,
 Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 Keerthana Kalyanasundaram <keerthanak@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Anish Swaminathan <anishs@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
 Zack Rusin <zackr@vmware.com>
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

T24gV2VkLCBOb3YgMTAsIDIwMjEgYXQgMDU6NDA6MDlQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90
ZToKPiAKPiAKPiA+IE9uIE5vdiAxMCwgMjAyMSwgYXQgOToyMCBBTSwgU3JpdmF0c2EgUy4gQmhh
dCA8c3JpdmF0c2FAY3NhaWwubWl0LmVkdT4gd3JvdGU6Cj4gPiAKPiA+IE9uIFR1ZSwgTm92IDA5
LCAyMDIxIGF0IDAxOjU3OjMxUE0gLTA4MDAsIEpvZSBQZXJjaGVzIHdyb3RlOgo+ID4+IE9uIFR1
ZSwgMjAyMS0xMS0wOSBhdCAwMDo1OCArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToKPiA+Pj4+IE9u
IE5vdiA4LCAyMDIxLCBhdCA0OjM3IFBNLCBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPiB3
cm90ZToKPiA+Pj4+IE9uIE1vbiwgMjAyMS0xMS0wOCBhdCAxNjoyMiAtMDgwMCwgU3JpdmF0c2Eg
Uy4gQmhhdCB3cm90ZToKPiA+Pj4+IAo+ID4+Pj4gU28gaXQncyBhbiBleHBsb2RlciBub3QgYW4g
YWN0dWFsIG1haW50YWluZXIgYW5kIGl0IGxpa2VseSBpc24ndAo+ID4+Pj4gcHVibGljYWxseSBh
cmNoaXZlZCB3aXRoIGFueSBub3JtYWwgbGlzdCBtZWNoYW5pc20uCj4gPj4+PiAKPiA+Pj4+IFNv
IElNTyAicHJpdmF0ZSIgaXNuJ3QgYXBwcm9wcmlhdGUuICBOZWl0aGVyIGlzICJMOiIKPiA+Pj4+
IFBlcmhhcHMganVzdCBtYXJrIGl0IGFzIHdoYXQgaXQgaXMgYXMgYW4gImV4cGxvZGVyIi4KPiA+
Pj4+IAo+ID4+Pj4gT3IgbWF5YmUgdGhlc2UgYmxvY2tzIHNob3VsZCBiZSBzaW1pbGFyIHRvOgo+
ID4+Pj4gCj4gPj4+PiBNOglOYW1lIG9mIExlYWQgRGV2ZWxvcGVyIDxzb21lYm9keUB2bXdhcmUu
Y29tPgo+ID4+Pj4gTToJVk13YXJlIDxmb28+IG1haW50YWluZXJzIDxsaW51eC08Zm9vPi1tYWlu
dGFpbmVyc0B2bWxpbnV4LmNvbT4KPiA+PiAKPiA+PiBNYXliZSBhZGRpbmcgZW50cmllcyBsaWtl
Cj4gPj4gCj4gPj4gTToJTmFtZWQgbWFpbnRhaW5lciA8d2hvZXZlckB2bXdhcmUuY29tPgo+ID4+
IFI6CVZNd2FyZSA8Zm9vPiByZXZpZXdlcnMgPGxpbnV4LTxmb28+LW1haW50YWluZXJzQHZtd2Fy
ZS5jb20+Cj4gPj4gCj4gPj4gd291bGQgYmUgYmVzdC9zaW1wbGVzdC4KPiA+PiAKPiA+IAo+ID4g
U3VyZSwgdGhhdCBzb3VuZHMgZ29vZCB0byBtZS4gSSBhbHNvIGNvbnNpZGVyZWQgYWRkaW5nICIo
ZW1haWwgYWxpYXMpIgo+ID4gbGlrZSBKdWVyZ2VuIHN1Z2dlc3RlZCwgYnV0IEkgdGhpbmsgdGhl
IFI6IGVudHJ5IGlzIGNsZWFyIGVub3VnaC4KPiA+IFBsZWFzZSBmaW5kIHRoZSB1cGRhdGVkIHBh
dGNoIGJlbG93Lgo+ID4gCj4gPiAtLS0KPiA+IAo+ID4gRnJvbSBmNjZmYWEyMzhmYWNmNTA0Y2Zj
NjYzMjU5MTJjZTdhZjhjYmY3OWVjIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+ID4gRnJvbTog
IlNyaXZhdHNhIFMuIEJoYXQgKFZNd2FyZSkiIDxzcml2YXRzYUBjc2FpbC5taXQuZWR1Pgo+ID4g
RGF0ZTogTW9uLCA4IE5vdiAyMDIxIDExOjQ2OjU3IC0wODAwCj4gPiBTdWJqZWN0OiBbUEFUQ0gg
djIgMi8yXSBNQUlOVEFJTkVSUzogTWFyayBWTXdhcmUgbWFpbGluZyBsaXN0IGVudHJpZXMgYXMg
ZW1haWwKPiA+IGFsaWFzZXMKPiA+IAo+ID4gVk13YXJlIG1haWxpbmcgbGlzdHMgaW4gdGhlIE1B
SU5UQUlORVJTIGZpbGUgYXJlIHByaXZhdGUgbGlzdHMgbWVhbnQKPiA+IGZvciBWTXdhcmUtaW50
ZXJuYWwgcmV2aWV3L25vdGlmaWNhdGlvbiBmb3IgcGF0Y2hlcyB0byB0aGUgcmVzcGVjdGl2ZQo+
ID4gc3Vic3lzdGVtcy4gQW55b25lIGNhbiBwb3N0IHRvIHRoZXNlIGFkZHJlc3NlcywgYnV0IHRo
ZXJlIGlzIG5vIHB1YmxpYwo+ID4gcmVhZCBhY2Nlc3MgbGlrZSBvcGVuIG1haWxpbmcgbGlzdHMs
IHdoaWNoIG1ha2VzIHRoZW0gbW9yZSBsaWtlIGVtYWlsCj4gPiBhbGlhc2VzIGluc3RlYWQgKHRv
IHJlYWNoIG91dCB0byByZXZpZXdlcnMpLgo+ID4gCj4gPiBTbyB1cGRhdGUgYWxsIHRoZSBWTXdh
cmUgbWFpbGluZyBsaXN0IHJlZmVyZW5jZXMgaW4gdGhlIE1BSU5UQUlORVJTCj4gPiBmaWxlIHRv
IG1hcmsgdGhlbSBhcyBzdWNoLCB1c2luZyAiUjogZW1haWwtYWxpYXNAdm13YXJlLmNvbSIuCj4g
PiAKPiA+IFNpZ25lZC1vZmYtYnk6IFNyaXZhdHNhIFMuIEJoYXQgKFZNd2FyZSkgPHNyaXZhdHNh
QGNzYWlsLm1pdC5lZHU+Cj4gPiBDYzogWmFjayBSdXNpbiA8emFja3JAdm13YXJlLmNvbT4KPiA+
IENjOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPgo+ID4gQ2M6IFZpdmVrIFRoYW1waSA8
dml0aGFtcGlAdm13YXJlLmNvbT4KPiA+IENjOiBWaXNoYWwgQmhha3RhIDx2Ymhha3RhQHZtd2Fy
ZS5jb20+Cj4gPiBDYzogUm9uYWsgRG9zaGkgPGRvc2hpckB2bXdhcmUuY29tPgo+ID4gQ2M6IHB2
LWRyaXZlcnNAdm13YXJlLmNvbQo+ID4gQ2M6IGxpbnV4LWdyYXBoaWNzLW1haW50YWluZXJAdm13
YXJlLmNvbQo+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IENjOiBs
aW51eC1yZG1hQHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwu
b3JnCj4gPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6IGxpbnV4LWlucHV0QHZn
ZXIua2VybmVsLm9yZwo+ID4gLS0tCj4gPiBNQUlOVEFJTkVSUyB8IDIyICsrKysrKysrKysrLS0t
LS0tLS0tLS0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiA+
IGluZGV4IDExOGNmODE3MGQwMi4uNDM3MmQ3OTAyN2U5IDEwMDY0NAo+ID4gLS0tIGEvTUFJTlRB
SU5FUlMKPiA+ICsrKyBiL01BSU5UQUlORVJTCj4gPiBAQCAtNjEzNCw4ICs2MTM0LDggQEAgVDoJ
Z2l0IGdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tbWlzYwo+ID4gRjoJZHJp
dmVycy9ncHUvZHJtL3Zib3h2aWRlby8KPiA+IAo+ID4gRFJNIERSSVZFUiBGT1IgVk1XQVJFIFZJ
UlRVQUwgR1BVCj4gPiAtTToJIlZNd2FyZSBHcmFwaGljcyIgPGxpbnV4LWdyYXBoaWNzLW1haW50
YWluZXJAdm13YXJlLmNvbT4KPiA+IE06CVphY2sgUnVzaW4gPHphY2tyQHZtd2FyZS5jb20+Cj4g
PiArUjoJVk13YXJlIEdyYXBoaWNzIFJldmlld2VycyA8bGludXgtZ3JhcGhpY3MtbWFpbnRhaW5l
ckB2bXdhcmUuY29tPgo+ID4gTDoJZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4g
UzoJU3VwcG9ydGVkCj4gPiBUOglnaXQgZ2l0Oi8vYW5vbmdpdC5mcmVlZGVza3RvcC5vcmcvZHJt
L2RybS1taXNjCj4gPiBAQCAtMTQxODksNyArMTQxODksNyBAQCBGOglpbmNsdWRlL3VhcGkvbGlu
dXgvcHBkZXYuaAo+ID4gUEFSQVZJUlRfT1BTIElOVEVSRkFDRQo+ID4gTToJSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPgo+ID4gTToJU3JpdmF0c2EgUy4gQmhhdCAoVk13YXJlKSA8c3Jp
dmF0c2FAY3NhaWwubWl0LmVkdT4KPiA+IC1MOglwdi1kcml2ZXJzQHZtd2FyZS5jb20gKHByaXZh
dGUpCj4gPiArUjoJVk13YXJlIFBWLURyaXZlcnMgUmV2aWV3ZXJzIDxwdi1kcml2ZXJzQHZtd2Fy
ZS5jb20+Cj4gCj4gVGhpcyBwYXRjaCB0aGF0IHlvdSBqdXN0IHNlbnQgc2VlbXMgdG8gZ28gb24g
dG9wIG9mIHRoZSBwcmV2aW91cyBwYXRjaGVzCj4gKGFzIGl0IHJlbW92ZXMgIkw6IHB2LWRyaXZl
cnNAdm13YXJlLmNvbSAocHJpdmF0ZSnigJ0pLgo+IAoKQWN0dWFsbHksIHRoYXQncyBhIGJpdCBt
aXNsZWFkaW5nLCBzaW5jZSBJIGhhZCBjb3JyZWN0ZWQgdGhhdCBlbnRyeSBpbgp0aGUgZmlyc3Qg
cGF0Y2ggaXRzZWxmLCB3aGlsZSBhZGRpbmcgbXlzZWxmIGFzIHRoZSBtYWludGFpbmVyLiBTbwp0
aGVyZSBhcmUgc3RpbGwgb25seSAyIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgcmlnaHQgbm93LgoK
VGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dCEgSSdsbCBtb3ZlIHRoZSBWTXdhcmUgbGlzdCBt
b2RpZmljYXRpb25zCm91dCBvZiB0aGUgZmlyc3QgcGF0Y2gsIHRvIGF2b2lkIGNvbmZ1c2lvbi4K
Cj4gU2luY2UgdGhlIHBhdGNoZXMgd2VyZSBzdGlsbCBub3QgbWVyZ2VkLCBJIHdvdWxkIHByZXN1
bWUgeW91IHNob3VsZCBzcXVhc2gKPiB0aGUgb2xkIDIvMiB3aXRoIHRoaXMgbmV3IHBhdGNoIGFu
ZCBzZW5kIHYzIG9mIHRoZXNlIHBhdGNoZXMuCj4gCgpJJ2xsIHNlbmQgb3V0IGEgdjMsIGFuZCBh
bHNvIGFkZCBaYWNrIFJ1c2luIGFzIHRoZSBtYWludGFpbmVyIGZvciB0aGUKdm1tb3VzZSBzdWIt
ZHJpdmVyLCBzaW5jZSBpdCBkb2VzIG5vdCBoYXZlIGEgbmFtZWQgbWFpbnRhaW5lciBhdCB0aGUK
bW9tZW50IChaYWNrIGluZGljYXRlZCB0aGF0IGhlIHdpbGwgYmUgdGFraW5nIHVwIHRoZSBtYWlu
dGFpbmVyc2hpcCkuCgpUaGFuayB5b3UhCgpSZWdhcmRzLApTcml2YXRzYQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
