Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2969C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 08:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E5BF81373;
	Tue, 22 Feb 2022 08:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bpVzVsQ6u5FS; Tue, 22 Feb 2022 08:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C22338136F;
	Tue, 22 Feb 2022 08:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 952C9C0070;
	Tue, 22 Feb 2022 08:00:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C14CC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B1A64094E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sngg2HrcqvhA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BC964093D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:00:38 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0V5C0fJm_1645516832; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5C0fJm_1645516832) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 22 Feb 2022 16:00:33 +0800
Message-ID: <1645516096.2526364-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
Date: Tue, 22 Feb 2022 15:48:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645442604.5901623-1-xuanzhuo@linux.alibaba.com>
 <c98a4fd4-af0e-f97f-55a7-a8804eb1fb40@redhat.com>
In-Reply-To: <c98a4fd4-af0e-f97f-55a7-a8804eb1fb40@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAyMiBGZWIgMjAyMiAxMjowMjoxNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8yLzIxIOS4i+WNiDc6MjMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBPbiBNb24sIDIxIEZlYiAyMDIyIDExOjMyOjUyICswODAwLCBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+PiBPbiBGcmksIEZlYiAxOCwgMjAy
MiBhdCA1OjAwIFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3Rl
Ogo+ID4+PiBPbiBUaHUsIDE3IEZlYiAyMDIyIDE1OjE5OjQ0ICswODAwLCBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+IE9uIFRodSwgRmViIDEwLCAyMDIyIGF0
IDQ6NTEgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4g
Pj4+Pj4gdmlydHF1ZXVlX2FkZCgpIG9ubHkgc3VwcG9ydHMgdmlydHVhbCBhZGRyZXNzZXMsIGRt
YSBpcyBjb21wbGV0ZWQgaW4KPiA+Pj4+PiB2aXJ0cXVldWVfYWRkKCkuCj4gPj4+Pj4KPiA+Pj4+
PiBJbiBzb21lIHNjZW5hcmlvcyAoc3VjaCBhcyB0aGUgQUZfWERQIHNjZW5hcmlvKSwgRE1BIGlz
IGNvbXBsZXRlZCBpbiBhZHZhbmNlLCBzbwo+ID4+Pj4+IGl0IGlzIG5lY2Vzc2FyeSBmb3IgdXMg
dG8gc3VwcG9ydCBwYXNzaW5nIHRoZSBETUEgYWRkcmVzcyB0byB2aXJ0cXVldWVfYWRkKCkuCj4g
Pj4+PiBJJ2Qgc3VnZ2VzdCByZW5hbWUgdGhpcyBmZWF0dXJlIGFzICJ1bm1hbmFnZWQgRE1BIi4K
PiA+Pj4gT0sKPiA+Pj4KPiA+Pj4+PiBSZWNvcmQgdGhpcyBwcmVkbWEgaW5mb3JtYXRpb24gaW4g
ZXh0cmEtPmZsYWdzLCB3aGljaCBjYW4gYmUgc2tpcHBlZCB3aGVuCj4gPj4+Pj4gZXhlY3V0aW5n
IGRtYSB1bm1hcC4KPiA+Pj4+IFF1ZXN0aW9uIHN0aWxsLCBjYW4gd2UgdXNlIHBlci12aXJ0cXVl
dWUgZmxhZyBpbnN0ZWFkIG9mIHBlcgo+ID4+Pj4gZGVzY3JpcHRvciBmbGFnPyBJZiBteSBtZW1v
cnkgaXMgY29ycmVjdCwgdGhlIGFuc3dlciBpcyB5ZXMgaW4gdGhlCj4gPj4+PiBkaXNjdXNzaW9u
IGZvciB0aGUgcHJldmlvdXMgdmVyc2lvbi4KPiA+Pj4+Cj4gPj4+IFllcy4KPiA+Pj4KPiA+Pj4g
cGVyLXZpcnRxdWV1ZT8gSSBndWVzcyBpdCBzaG91bGQgYmUgcGVyLXN1Ym1pdC4KPiA+Pj4KPiA+
Pj4gVGhpcyBwYXRjaCBzZXQgb25seSBhZGRzIGEgZmxhZyB0byBkZXNjX2V4dHJhW2hlYWRdLmZs
YWdzLCBzbyB0aGF0IHdlIGNhbiBrbm93Cj4gPj4+IGlmIHdlIG5lZWQgdG8gdW5tYXAgZG1hIHdo
ZW4gd2UgZGV0YWNoLgo+ID4+IEkgbWVhbnQgaWYgd2UgY2FuIG1hbmFnZSB0byBtYWtlIGl0IHBl
ciB2aXJ0cXVldWUsIHRoZXJlJ3Mgbm8gbmVlZCB0bwo+ID4+IG1haW50YWluIHBlciBidWZmZXIg
ZmxhZy4KPiA+Pgo+ID4gUmV0aGlua2luZyB0aGlzIHF1ZXN0aW9uLCBJIGZlZWwgdGhlcmUgaXMg
bm8gZXNzZW50aWFsIGRpZmZlcmVuY2UgYmV0d2VlbiBwZXIKPiA+IHZpcnRxdWV1ZSBhbmQgcGVy
IHNncy4KPiA+Cj4gPiBwZXIgdmlydHF1ZXVlOgo+ID4gCTEuIGFkZCBidWY6Cj4gPiAJCWEuIGNo
ZWNrIHZxLT5wcmVtYXBwZWQgZm9yIG1hcCBldmVyeSBzZwo+ID4gCTIuIGRldGFjaDoKPiA+IAkg
ICAgICAgIGEuIGNoZWNrIHZxLT5wcmVtYXBlZCBmb3IgdW5tYXAKPiA+Cj4gPiBwZXIgc2dzOgo+
ID4gCTEuIGFkZCBidWY6Cj4gPiAJICAgICAgICBhLiBjaGVjayBmdW5jdGlvbiBwYXJhbWV0ZXIg
InByZW1hcHBlZCIgZm9yIG1hcCBldmVyeSBzZwo+ID4gCQliLiBhZGQgZmxhZyB0byBleHRyYVto
ZWFkXS5mbGFnCj4gPgo+ID4gCTIuIGRldGFjaDoKPiA+IAkgICAgICAgIGE6IGNoZWNrIGV4dHJh
W2hlYWRdLmZsYWcgZm9yIHVubWFwCj4gPgo+ID4KPiA+IFRoYW5rcy4KPgo+Cj4gUGVyLXZpcnRx
dWV1ZSBpcyBzdGlsbCBhIGxpdHRsZSBiaXQgZWFzaWVyIGF0IHRoZSBmaXJzdCBnbGFuY2UuCj4K
PiBBY3R1YWxseSwgcGVyLXNnIGhhdmUgb25lIGFkdmFudGFnZTogaXQgY2FuIGJlIHVzZWQgd2l0
aG91dCB2aXJ0cXVldWUKPiByZXNldCAodG8gYWxsb3cgc3dpdGNoaW5nIGJldHdlZW4gdGhlIHR3
byBtb2RlcykuIEJ1dCBJJ20gbm90IHN1cmUKPiB3aGV0aGVyIHdlIGhhZCBzdWNoIHJlcXVpcmVt
ZW50cy4KPgo+IEkgdGhpbmsgdG8gYW5zd2VyIHRoaXMgcXVlc3Rpb24sIHdlIHByb2JhYmx5IG5l
ZWQgYSByZWFsIHVzZSBjYXNlIChpZiB3ZQo+IGNhbiBjb21lIHVwIHdpdGggYSBjYXNlIHRoYXQg
aXMgbW9yZSBsaWdodHdlaWdodCB0aGFuIEFGX1hEUCwgdGhhdCB3b3VsZAo+IGJlIGV2ZW4gYmV0
dGVyKS4KClNhZGx5LCBJIGRpZG4ndCB0aGluayBvZiBvdGhlciBzY2VuYXJpb3MuIEhvcGUgc29t
ZW9uZSBjYW4gZ2l2ZSBhIHNjZW5hcmlvLgoKRm9yIHBlciB2aXJ0cXVldWUsIHZpcnRpby1uZXQg
d2lsbCBhbHNvIHN3aXRjaCB0byBwcmVtYXBwZWQuIEJlY2F1c2UgdGhlIHR4CnF1ZXVlIGlzIHNo
YXJlZC4KCkJ1dCBpbiB0aGUgcHJvY2VzcyBvZiBpbXBsZW1lbnRpbmcgdGhpcywgSSBlbmNvdW50
ZXJlZCBhIHRyb3VibGVzb21lIHByb2JsZW0uIFdlCm5lZWQgdG8gcmVjb3JkIHRoZSBkbWEgYWRk
cmVzcyBpbiB2aXJ0bmV0LiBGb3IgdHgsIHNpbmNlIHNrYiBjb250YWlucyBtdWx0aXBsZQpmcmFn
cywgdGhlcmUgd2lsbCBiZSBtYW55IGRtYSBhZGRyZXNzZXMuIFdoZW4gdW5tYXAgaW4gdmlydG5l
dCBJdCB3aWxsIGJlIG1vcmUKdHJvdWJsZXNvbWUuIEJlY2F1c2Ugd2UgaGF2ZSB0byByZWdhaW4g
dGhlc2UgZG1hIGFkZHJlc3Nlcy4KCkkgdGhpbmsgb2YgdHdvIHdheXM6CgoxLiBMZXQgdmlydGlv
IHJldHVybiB0aGUgYWRkciBvZiBlYWNoIGRlc2Mgd2hlbiBkZXRhY2hlZC4KMi4gQWxsb2NhdGUg
YSBibG9jayBvZiBtZW1vcnkgZm9yIGVhY2ggc3EvcnEgdG8gaG9sZCB0aGUgZG1hIGFkZHJlc3Mu
CgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4KPiA+Cj4gPj4gU28gd2Uga25vdyBzb21ldGhp
bmcgdGhhdCBuZWVkcyB0byBiZSBtYXBwZWQgYnkgdmlydGlvIGNvcmUgaXRzZWxmLAo+ID4+IGUu
ZyB0aGUgaW5kaXJlY3QgcGFnZS4gT3RoZXIgdGhhbiB0aGlzLCBhbGwgdGhlIHJlc3QgY291bGQg
YmUKPiA+PiBwcmUtbWFwcGVkLgo+ID4+Cj4gPj4gRm9yIHZuZXQgaGVhZGVyLCBpdCBjb3VsZCBi
ZSBtYXBwZWQgYnkgdmlydGlvLW5ldCB3aGljaCBjb3VsZCBiZSBzdGlsbAo+ID4+IHRyZWF0ZWQg
YXMgcHJlIG1hcHBlZCBETUEgc2luY2UgaXQncyBub3QgdGhlIHZpcnRpbyByaW5nIGNvZGUuCj4g
Pj4KPiA+PiBBbnl0aGluZyBJIG1pc3MgaGVyZT8KPiA+Pgo+ID4+IFRoYW5rcwo+ID4+Cj4gPj4K
PiA+Pj4gVGhhbmtzLgo+ID4+Pgo+ID4+Pj4gVGhhbmtzCj4gPj4+Pgo+ID4+Pj4+IHYxOgo+ID4+
Pj4+ICAgICAxLiBBbGwgc2dzIHJlcXVlc3RlZCBhdCBvbmUgdGltZSBhcmUgcmVxdWlyZWQgdG8g
YmUgdW5pZmllZCBQUkVETUEsIGFuZCBzZXZlcmFsCj4gPj4+Pj4gICAgICAgIG9mIHRoZW0gYXJl
IG5vdCBzdXBwb3J0ZWQgdG8gYmUgUFJFRE1BCj4gPj4+Pj4gICAgIDIuIHZpcnRpb19kbWFfbWFw
KCkgaXMgcmVtb3ZlZCBmcm9tIHRoaXMgcGF0Y2ggc2V0IGFuZCB3aWxsIGJlIHN1Ym1pdHRlZAo+
ID4+Pj4+ICAgICAgICB0b2dldGhlciB3aXRoIHRoZSBuZXh0IHRpbWUgQUZfWERQIHN1cHBvcnRz
IHZpcnRpbyBkbWEKPiA+Pj4+PiAgICAgMy4gQWRkZWQgcGF0Y2ggIzIgIzMgdG8gcmVtb3ZlIHRo
ZSBjaGVjayBmb3IgZmxhZ3Mgd2hlbiBwZXJmb3JtaW5nIHVubWFwCj4gPj4+Pj4gICAgICAgIGlu
ZGlyZWN0IGRlc2MKPiA+Pj4+Pgo+ID4+Pj4+IFh1YW4gWmh1byAoNik6Cj4gPj4+Pj4gICAgdmly
dGlvOiByZW5hbWUgdnJpbmdfdW5tYXBfc3RhdGVfcGFja2VkKCkgdG8KPiA+Pj4+PiAgICAgIHZy
aW5nX3VubWFwX2V4dHJhX3BhY2tlZCgpCj4gPj4+Pj4gICAgdmlydGlvOiByZW1vdmUgZmxhZ3Mg
Y2hlY2sgZm9yIHVubWFwIHNwbGl0IGluZGlyZWN0IGRlc2MKPiA+Pj4+PiAgICB2aXJ0aW86IHJl
bW92ZSBmbGFncyBjaGVjayBmb3IgdW5tYXAgcGFja2VkIGluZGlyZWN0IGRlc2MKPiA+Pj4+PiAg
ICB2aXJ0aW86IHZpcnRxdWV1ZV9hZGQoKSBzdXBwb3J0IHByZWRtYQo+ID4+Pj4+ICAgIHZpcnRp
bzogc3BsaXQ6IHZpcnRxdWV1ZV9hZGRfc3BsaXQoKSBzdXBwb3J0IGRtYSBhZGRyZXNzCj4gPj4+
Pj4gICAgdmlydGlvOiBwYWNrZWQ6IHZpcnRxdWV1ZV9hZGRfcGFja2VkKCkgc3VwcG9ydCBkbWEg
YWRkcmVzcwo+ID4+Pj4+Cj4gPj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwg
MTk5ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4gPj4+Pj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTI2IGluc2VydGlvbnMoKyksIDczIGRlbGV0aW9ucygtKQo+ID4+Pj4+Cj4gPj4+
Pj4gLS0KPiA+Pj4+PiAyLjMxLjAKPiA+Pj4+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
