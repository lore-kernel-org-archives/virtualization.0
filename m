Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA8C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:42:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D676527B
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D676527B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B3078364F;
	Tue,  9 Mar 2021 02:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8nWPRiC39ZUN; Tue,  9 Mar 2021 02:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1952D83417;
	Tue,  9 Mar 2021 02:42:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED233C000B;
	Tue,  9 Mar 2021 02:42:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A00C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4618C8364F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9o1f8d7XwSkK
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:42:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EA2F83417
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615257734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3NcIctlEacedKnvWxLBPKXMEmj3VYiIJnpjJRUyQZE=;
 b=IiFDyxZgNAvQHkFkvt6o7xp2pc34PngQF9XI5LmVX/bpL/eo1gOSDtHUqtd0Wdhe8QvaSr
 IlarUSWvuw1KmuTbhGLYO6r0l8TtJh9TwzssEKqO4hJezx1man9a4VEt16klUR2WV6axpL
 dTat95KbTdKUzF7AaQFCJXyJVLmyIgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-o4boJwIyOoqeBNKvt6YJ-g-1; Mon, 08 Mar 2021 21:42:10 -0500
X-MC-Unique: o4boJwIyOoqeBNKvt6YJ-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DB1B814313;
 Tue,  9 Mar 2021 02:42:09 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-202.pek2.redhat.com
 [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B23C5D6D7;
 Tue,  9 Mar 2021 02:42:03 +0000 (UTC)
Subject: Re: [PATCH V2 2/4] vDPA/ifcvf: enable Intel C5000X-PL virtio-net for
 vDPA
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com
References: <20210308083525.382514-1-lingshan.zhu@intel.com>
 <20210308083525.382514-3-lingshan.zhu@intel.com>
 <d37ea3f4-1c18-087b-a444-0d4e1ebbe417@redhat.com>
 <93aabf0c-3ea0-72d7-e7d7-1d503fe6cc75@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <91c08fdd-0a36-ddca-5b8c-ef2eef7cddc2@redhat.com>
Date: Tue, 9 Mar 2021 10:42:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <93aabf0c-3ea0-72d7-e7d7-1d503fe6cc75@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMy85IDEwOjI4IOS4iuWNiCwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
My85LzIwMjEgMTA6MjMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMy84IDQ6
MzUg5LiL5Y2ILCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+PiBUaGlzIGNvbW1pdCBlbmFibGVkIElu
dGVsIEZQR0EgU21hcnROSUMgQzUwMDBYLVBMIHZpcnRpby1uZXQKPj4+IGZvciB2RFBBCj4+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgNSArKysrKwo+
Pj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDUgKysrKysKPj4+IMKgIDIg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIAo+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5oCj4+PiBpbmRleCA2NDY5NmQ2M2ZlMDcuLjc1ZDlhODA1MjAzOSAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+ICsrKyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+IEBAIC0yMyw2ICsyMywxMSBAQAo+Pj4gwqAgI2Rl
ZmluZSBJRkNWRl9TVUJTWVNfVkVORE9SX0lEwqDCoMKgIDB4ODA4Ngo+Pj4gwqAgI2RlZmluZSBJ
RkNWRl9TVUJTWVNfREVWSUNFX0lEwqDCoMKgIDB4MDAxQQo+Pj4gwqAgKyNkZWZpbmUgQzUwMDBY
X1BMX1ZFTkRPUl9JRMKgwqDCoMKgwqDCoMKgIDB4MUFGNAo+Pj4gKyNkZWZpbmUgQzUwMDBYX1BM
X0RFVklDRV9JRMKgwqDCoMKgwqDCoMKgIDB4MTAwMAo+Pj4gKyNkZWZpbmUgQzUwMDBYX1BMX1NV
QlNZU19WRU5ET1JfSUTCoMKgwqAgMHg4MDg2Cj4+PiArI2RlZmluZSBDNTAwMFhfUExfU1VCU1lT
X0RFVklDRV9JRMKgwqDCoCAweDAwMDEKPj4KPj4KPj4gSSBqdXN0IG5vdGljZSB0aGF0IHRoZSBk
ZXZpY2UgaXMgYSB0cmFuc3RpdGlvbmFsIG9uZS4gQW55IHJlYXNvbiBmb3IgCj4+IGRvaW5nIHRo
aXM/Cj4+Cj4+IE5vdGUgdGhhdCBJRkNWRiBpcyBhIG1vZGVuIGRldmljZSBhbnlob3cgKDB4MTA0
MSkuIFN1cHBvcnRpbmcgbGVnYWN5IAo+PiBkcml2ZSBtYXkgYnJpbmcgbWFueSBpc3N1ZXMgKGUu
ZyB0aGUgZGVmaW5pdGlvbiBpcyBub24tbm9tYXJ0aXZlKS4gCj4+IE9uZSBleGFtcGxlIGlzIHRo
ZSBzdXBwb3J0IG9mIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNLCBsZWdhY3kgZHJpdmVyIAo+PiBt
YXkgYXNzdW1lIHRoZSBkZXZpY2UgY2FuIGJ5cGFzcyBJT01NVS4KPj4KPj4gVGhhbmtzCj4gSGkg
SmFzb24sCj4KPiBUaGlzIGRldmljZSB3aWxsIHN1cHBvcnQgdmlydGlvMS4wIGJ5IGRlZmF1bHQs
IHNvIGhhcyAKPiBWSVJUSU9fRl9JT01NVV9QTEFURk9STSBieSBkZWZhdWx0LgoKCklmIHlvdSBk
ZXZpY2Ugd2FudCB0byBmb3JjZSBWSVJUSU9fRl9JT01NVV9QTEFURk9STSB5b3UgcHJvYmFibHkg
bmVlZCB0byAKZG8gd2hhdCBoYXMgYmVlbiBkb25lIGJ5IG1seDUgKHZlcmlmeV9taW5fZmVhdHVy
ZXMpLgoKQWNjb3JkaW5nIHRvIHRoZSBzcGVjLCBpZiBWSVJUSU9fRl9JT01NVV9QTEFURk9STSBp
cyBub3QgbWFuZGF0b3J5LCB3aGVuIAppdCdzIG5vdCBuZWdvdGlhdGVkLCBkZXZpY2UgbmVlZHMg
dG8gZGlzYWJsZSBvciBieXBhc3MgSU9NTVU6CgoKIgoKSWYgdGhpcyBmZWF0dXJlIGJpdCBpcyBz
ZXQgdG8gMCwgdGhlbiB0aGUgZGV2aWNlIGhhcyBzYW1lIGFjY2VzcyB0byAKbWVtb3J5IGFkZHJl
c3NlcyBzdXBwbGllZCB0byBpdCBhcyB0aGUgZHJpdmVyIGhhcy4gSW4gcGFydGljdWxhciwgdGhl
IApkZXZpY2Ugd2lsbCBhbHdheXMgdXNlIHBoeXNpY2FsIGFkZHJlc3NlcyBtYXRjaGluZyBhZGRy
ZXNzZXMgdXNlZCBieSB0aGUgCmRyaXZlciAodHlwaWNhbGx5IG1lYW5pbmcgcGh5c2ljYWwgYWRk
cmVzc2VzIHVzZWQgYnkgdGhlIENQVSkgYW5kIG5vdCAKdHJhbnNsYXRlZCBmdXJ0aGVyLCBhbmQg
Y2FuIGFjY2VzcyBhbnkgYWRkcmVzcyBzdXBwbGllZCB0byBpdCBieSB0aGUgZHJpdmVyLgoKIgoK
Cj4gVHJhbnNpdGlvbmFsIGRldmljZSBnaXZlcyB0aGUgc29mdHdhcmUgYSBjaGFuY2UgdG8gZmFs
bCBiYWNrIHRvIHZpcnRpbyAKPiAwLjk1LgoKClRoaXMgb25seSBhcHBsaWVzIGlmIHlvdSB3YW50
IHRvIHBhc3N0aHJvdWdoIHRoZSBjYXJkIHRvIGd1ZXN0IGRpcmVjdGx5IAp3aXRob3V0IHRoZSBo
ZWxwIG9mIHZEUEEuCgpJZiB3ZSBnbyB3aXRoIHZEUEEsIGl0IGRvZXNuJ3QgaGxlcC4gRm9yIHZp
cnRpby12ZHBhLCB3ZSBrbm93IGl0IHdpbGwgCm5lZ290aWF0ZWQgSU9NTVVfUExBVEZPUk0uIEZv
ciB2aG9zdC12ZHBhLCBRZW11IGNhbiBwcm92aWRlIGEgbGVnYWN5IG9yIAp0cmFuc2l0aW9uYWwg
ZGV2aWNlIG9uIHRvcCBvZiBhIG1vZGVybiB2RFBBIGRldmljZS4KClRoYW5rcwoKCj4gaWZjdmYg
ZHJpdmVzIHRoaXMgZGV2aWNlIGluIHZpcnRpbyAxLjAgbW9kZSwgc2V0IGZlYXR1cmVzIAo+IFZJ
UlRJT19GX0lPTU1VX1BMQVRGT1JNIHN1Y2Nlc3NmdWxseS4KPgo+IFRoYW5rcywKPiBaaHUgTGlu
Z3NoYW4KPj4KPj4KPj4+ICsKPj4+IMKgICNkZWZpbmUgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVT
IFwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAoKDFVTEwgPDwgVklSVElPX05FVF9GX01BQynCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwg
VklSVElPX0ZfQU5ZX0xBWU9VVCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgXAo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+PiBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+IGluZGV4IGU1MDFlZTA3ZGUxNy4uMjZhMmRhYjdjYTY2
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4gQEAgLTQ4NCw2ICs0ODQsMTEg
QEAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGlmY3ZmX3BjaV9pZHNbXSA9IHsKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBJRkNWRl9ERVZJQ0VfSUQsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
SUZDVkZfU1VCU1lTX1ZFTkRPUl9JRCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBJRkNWRl9TVUJT
WVNfREVWSUNFX0lEKSB9LAo+Pj4gK8KgwqDCoCB7IFBDSV9ERVZJQ0VfU1VCKEM1MDAwWF9QTF9W
RU5ET1JfSUQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9ERVZJQ0Vf
SUQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9TVUJTWVNfVkVORE9S
X0lELAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhfUExfU1VCU1lTX0RFVklD
RV9JRCkgfSwKPj4+ICsKPj4+IMKgwqDCoMKgwqAgeyAwIH0sCj4+PiDCoCB9Owo+Pj4gwqAgTU9E
VUxFX0RFVklDRV9UQUJMRShwY2ksIGlmY3ZmX3BjaV9pZHMpOwo+Pgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
