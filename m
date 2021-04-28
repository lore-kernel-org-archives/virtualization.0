Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9676C43460
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 10:09:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434706142F
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 10:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434706142F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D456C60693;
	Wed, 28 Apr 2021 10:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYWDwwgcdiXt; Wed, 28 Apr 2021 10:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53DD960678;
	Wed, 28 Apr 2021 10:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 159EDC001C;
	Wed, 28 Apr 2021 10:09:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF591C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC74E40EC6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dh6YFyMznZkl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C9E240EC2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619604561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCmCVcCGcXEgbhMIg1rIIz1DwzlDEOvC3LtivSI+s+8=;
 b=IFFAIn0CkougvgKMQOKZbxKyMArZ9qLnpCkLQxxakndJ8EOdtfs14PgbIiKdokI0qjT0PE
 cge86TSAydPqkeBwhRmPpmK4O0y2oho7xkotF2dSl3Eu3flor0pVLT21cCQwHWP26yzdM1
 O8bnJ8hguoKNa0htfi29/ghAFVAxOjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-mXh6x8uYMpOqAsImOovtJw-1; Wed, 28 Apr 2021 06:09:19 -0400
X-MC-Unique: mXh6x8uYMpOqAsImOovtJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F34CF801106;
 Wed, 28 Apr 2021 10:09:17 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-25.pek2.redhat.com
 [10.72.12.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5A021001B2C;
 Wed, 28 Apr 2021 10:09:12 +0000 (UTC)
Subject: Re: [PATCH 1/2] vDPA/ifcvf: record virtio notify base
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210428082133.6766-1-lingshan.zhu@intel.com>
 <20210428082133.6766-2-lingshan.zhu@intel.com>
 <55217869-b456-f3bc-0b5a-6beaf34c19f8@redhat.com>
 <3243eeef-2891-5b79-29cb-bc969802c5dc@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4cee04f1-a3fc-eaf0-747a-004ca09b06c0@redhat.com>
Date: Wed, 28 Apr 2021 18:09:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <3243eeef-2891-5b79-29cb-bc969802c5dc@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

CuWcqCAyMDIxLzQvMjgg5LiL5Y2INjowMCwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDQvMjgvMjAyMSA0OjM5IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzI4
IOS4i+WNiDQ6MjEsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+PiBUaGlzIGNvbW1pdCByZWNvcmRz
IHZpcnRpbyBub3RpZnkgYmFzZSBhZGRyIHRvIGltcGxlbWVudGUKPj4+IGRvb3JiZWxsIG1hcHBp
bmcgZmVhdHVyZQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuYyB8IDEgKwo+Pj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDEgKwo+
Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyAKPj4+IGIvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX2Jhc2UuYwo+Pj4gaW5kZXggMWE2NjFhYjQ1YWY1Li5jYzYxYTViZmM1YjEgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+PiArKysgYi9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+PiBAQCAtMTMzLDYgKzEzMyw3IEBAIGlu
dCBpZmN2Zl9pbml0X2h3KHN0cnVjdCBpZmN2Zl9odyAqaHcsIHN0cnVjdCAKPj4+IHBjaV9kZXYg
KnBkZXYpCj4+PiAmaHctPm5vdGlmeV9vZmZfbXVsdGlwbGllcik7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBody0+bm90aWZ5X2JhciA9IGNhcC5iYXI7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBody0+bm90aWZ5X2Jhc2UgPSBnZXRfY2FwX2FkZHIoaHcsICZjYXApOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHctPm5vdGlmeV9wYSA9IHBjaV9yZXNvdXJjZV9z
dGFydChwZGV2LCBjYXAuYmFyKSArIAo+Pj4gY2FwLm9mZnNldDsKPj4KPj4KPj4gVG8gYmUgbW9y
ZSBnZW5lcmljIGFuZCBhdm9pZCBmdXR1cmUgY2hhbmdlcywgbGV0J3MgdXNlIHRoZSBtYXRoIAo+
PiBkZWZpbmVkIGluIHRoZSB2aXJ0aW8gc3BlYy4KPj4KPj4gWW91IG1heSByZWZlciBob3cgaXQg
aXMgaW1wbGVtZW50ZWQgaW4gdmlydGlvX3BjaSB2ZHBhIGRyaXZlclsxXS4KPiBBcmUgeW91IHN1
Z2dlc3RpbmcgZXZlcnkgdnEga2VlcCBpdHMgb3duIG5vdGlmeV9wYT8gSW4gdGhpcyBjYXNlLCB3
ZSAKPiBzdGlsbCBuZWVkIHRvIHJlY29yZCBub3RpZnlfcGEgaW4gaHcgd2hlbiBpbml0X2h3LCB0
aGVuIGluaXRpYWxpemUgCj4gdnEtPm5vdGlmeV9wYSBhY2NyZWRpdGluZyB0byBody0+bm90aWZ5
X3BhLgoKCkkgbWVhbnQgeW91IG5lZWQgdG8gZm9sbG93IGhvdyB2aXJ0aW8gc3BlYyBkaWQgdG8g
Y2FsY3VsYXRlIHRoZSBkb29yYmVsbCAKYWRkcmVzcyBwZXIgdnE6CgogwqDCoMKgwqDCoMKgwqAg
Y2FwLm9mZnNldCArIHF1ZXVlX25vdGlmeV9vZmYgKiBub3RpZnlfb2ZmX211bHRpcGxpZXIKCk9i
dmlvdXNseSwgeW91IGlnbm9yZSBxdWV1ZV9ub3RpZnlfb2ZmIGFuZCBub3RpZnlfb2ZmX211bHRp
cGxpZXIgaGVyZS4gClRoaXMgbWF5IGJyaW5nIHRyb3VibGVzIGZvciB0aGUgZXhpc3RpbmcgZGV2
aWNlIElGQ1ZGIGFuZCBmdXR1cmUgZGV2aWNlcy4KCklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHks
IHRoaXMgZGV2aWNlIGNhbiBiZSBwcm9iZWQgYnkgdmlydGlvLXBjaSAKZHJpdmVyIHdoaWNoIHVz
ZSB0aGUgYWJvdmUgbWF0aC4gVGhlcmUncyBubyByZWFzb24gZm9yIHVzaW5nIGFkLWhvYyBoYWNr
LgoKVGhhbmtzCgoKPgo+IFRoYW5rcwo+IFpodSBMaW5nc2hhbgo+Pgo+PiBUaGFua3MKPj4KPj4g
WzFdIAo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8yMDIxMDQxNTA3
MzE0Ny4xOTMzMS01LWphc293YW5nQHJlZGhhdC5jb20vVC8KPj4KPj4KPj4+IElGQ1ZGX0RCRyhw
ZGV2LCAiaHctPm5vdGlmeV9iYXNlID0gJXBcbiIsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBody0+bm90aWZ5X2Jhc2UpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaCAKPj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4gaW5kZXgg
MDExMWJmZGViMzQyLi5iY2NhN2MxNjY5ZGQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfYmFzZS5oCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFz
ZS5oCj4+PiBAQCAtOTgsNiArOTgsNyBAQCBzdHJ1Y3QgaWZjdmZfaHcgewo+Pj4gwqDCoMKgwqDC
oCBjaGFyIGNvbmZpZ19tc2l4X25hbWVbMjU2XTsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHZkcGFf
Y2FsbGJhY2sgY29uZmlnX2NiOwo+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgY29uZmlnX2ly
cTsKPj4+ICvCoMKgwqAgcGh5c19hZGRyX3TCoCBub3RpZnlfcGE7Cj4+PiDCoCB9Owo+Pj4gwqAg
wqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgewo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
