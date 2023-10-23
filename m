Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB39FCDB474
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 07:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CC8B41EAA;
	Mon, 23 Oct 2023 07:43:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CC8B41EAA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TDmYaqmt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwOe_uoT0VGT; Mon, 23 Oct 2023 07:43:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04B1841E88;
	Mon, 23 Oct 2023 07:43:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04B1841E88
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C036EC0039;
	Mon, 23 Oct 2023 07:43:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA9DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 07:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28DB640CBE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 07:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28DB640CBE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TDmYaqmt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NDCql242Yy1P
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 07:43:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1126940158
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 07:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1126940158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698047000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n4pnr/01geKklbuZTPmDUDub+KmFboZIfKOWl4pyxfw=;
 b=TDmYaqmtuiQjx/kPZx7iwtz6evO6wcjzOCx+S1iZZwVv76qtBT/wAHSVWdobJ33LmOtVph
 JUHR5s7kbgOblxGXULJwOPYj9E7/gZhmh1+A+9YPg84gpgYTLo5ZDLtcy9JtGE3A5D6Ep7
 8728r26vDNiat4I3BM29FLOb89BYW4E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-13mRTdf7PIKXi3XcFY6UZQ-1; Mon, 23 Oct 2023 03:43:16 -0400
X-MC-Unique: 13mRTdf7PIKXi3XcFY6UZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A07A3C1043C;
 Mon, 23 Oct 2023 07:43:15 +0000 (UTC)
Received: from [10.39.208.17] (unknown [10.39.208.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A6651C060AE;
 Mon, 23 Oct 2023 07:43:11 +0000 (UTC)
Message-ID: <86532026-d1bc-491e-8fae-765ce493b7c2@redhat.com>
Date: Mon, 23 Oct 2023 09:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] vduse: Temporarily disable control queue features
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-4-maxime.coquelin@redhat.com>
 <CACGkMEsKvLTQNPp3JE9V4MBEuv5LVC+tRXgYYijgb9N0DNtGZw@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <CACGkMEsKvLTQNPp3JE9V4MBEuv5LVC+tRXgYYijgb9N0DNtGZw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Cc: xuanzhuo@linux.alibaba.com, paul@paul-moore.com, lulu@redhat.com,
 mst@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stephen.smalley.work@gmail.com, jmorris@namei.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 linux-security-module@vger.kernel.org, eparis@parisplace.org,
 david.marchand@redhat.com, serge@hallyn.com
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

CgpPbiAxMC8yMy8yMyAwNTowOCwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBGcmksIE9jdCAyMCwg
MjAyMyBhdCAxMTo1OOKAr1BNIE1heGltZSBDb3F1ZWxpbgo+IDxtYXhpbWUuY29xdWVsaW5AcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IFZpcnRpby1uZXQgZHJpdmVyIGNvbnRyb2wgcXVldWUgaW1w
bGVtZW50YXRpb24gaXMgbm90IHNhZmUKPj4gd2hlbiB1c2VkIHdpdGggVkRVU0UuIElmIHRoZSBW
RFVTRSBhcHBsaWNhdGlvbiBkb2VzIG5vdAo+PiByZXBseSB0byBjb250cm9sIHF1ZXVlIG1lc3Nh
Z2VzLCBpdCBjdXJyZW50bHkgZW5kcyB1cAo+PiBoYW5naW5nIHRoZSBrZXJuZWwgdGhyZWFkIHNl
bmRpbmcgdGhpcyBjb21tYW5kLgo+Pgo+PiBTb21lIHdvcmsgaXMgb24tZ29pbmcgdG8gbWFrZSB0
aGUgY29udHJvbCBxdWV1ZQo+PiBpbXBsZW1lbnRhdGlvbiByb2J1c3Qgd2l0aCBWRFVTRS4gVW50
aWwgaXQgaXMgY29tcGxldGVkLAo+PiBsZXQncyBkaXNhYmxlIGNvbnRyb2wgdmlydHF1ZXVlIGFu
ZCBmZWF0dXJlcyB0aGF0IGRlcGVuZCBvbgo+PiBpdC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWF4
aW1lIENvcXVlbGluIDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4KPiAKPiBJIHdvbmRlciBp
ZiBpdCdzIGJldHRlciB0byBkbyB0aGlzIHdpdGggcGF0Y2ggMiBvciBiZWZvcmUgcGF0Y2ggMiB0
bwo+IHVuYnJlYWsgdGhlIGJpc2VjdGlvbj8KCkkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRv
IGtlZXAgaXQgaW4gYSBkZWRpY2F0ZWQgcGF0Y2ggdG8gZWFzZSB0aGUKcmV2ZXJ0IGxhdGVyIHdo
ZW4geW91ciB3b3JrIHdpbGwgaGF2ZSBiZWVuIGFjY2VwdGVkLCBzbyBiZWZvcmUgcGF0Y2ggMi4K
ClRoYW5rcywKTWF4aW1lCgo+IFRoYW5rcwo+IAo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2Vy
L3ZkdXNlX2Rldi5jCj4+IGluZGV4IDczYWQzYjdlZmQ4ZS4uMDI0M2RlZTljZjBlIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPj4gQEAgLTI4LDYgKzI4LDcgQEAKPj4gICAj
aW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmg+Cj4+ICAgI2luY2x1ZGUgPHVhcGkv
bGludXgvdmlydGlvX2lkcy5oPgo+PiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19ibGsu
aD4KPj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmg+Cj4+ICAgI2luY2x1ZGUg
PGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPgo+Pgo+PiAgICNpbmNsdWRlICJpb3ZhX2RvbWFpbi5o
Igo+PiBAQCAtNDYsNiArNDcsMzAgQEAKPj4KPj4gICAjZGVmaW5lIElSUV9VTkJPVU5EIC0xCj4+
Cj4+ICsjZGVmaW5lIFZEVVNFX05FVF9WQUxJRF9GRUFUVVJFU19NQVNLICAgICAgICAgICBcCj4+
ICsgICAgICAgKEJJVF9VTEwoVklSVElPX05FVF9GX0NTVU0pIHwgICAgICAgICAgIFwKPj4gKyAg
ICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkgfCAgICAgXAo+PiArICAgICAg
ICBCSVRfVUxMKFZJUlRJT19ORVRfRl9NVFUpIHwgICAgICAgICAgICBcCj4+ICsgICAgICAgIEJJ
VF9VTEwoVklSVElPX05FVF9GX01BQykgfCAgICAgICAgICAgIFwKPj4gKyAgICAgICAgQklUX1VM
TChWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfCAgICAgXAo+PiArICAgICAgICBCSVRfVUxMKFZJ
UlRJT19ORVRfRl9HVUVTVF9UU082KSB8ICAgICBcCj4+ICsgICAgICAgIEJJVF9VTEwoVklSVElP
X05FVF9GX0dVRVNUX0VDTikgfCAgICAgIFwKPj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVU
X0ZfR1VFU1RfVUZPKSB8ICAgICAgXAo+PiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9I
T1NUX1RTTzQpIHwgICAgICBcCj4+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX0hPU1Rf
VFNPNikgfCAgICAgIFwKPj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfSE9TVF9FQ04p
IHwgICAgICAgXAo+PiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9IT1NUX1VGTykgfCAg
ICAgICBcCj4+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX01SR19SWEJVRikgfCAgICAg
IFwKPj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfU1RBVFVTKSB8ICAgICAgICAgXAo+
PiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9IT1NUX1VTTykgfCAgICAgICBcCj4+ICsg
ICAgICAgIEJJVF9VTEwoVklSVElPX0ZfQU5ZX0xBWU9VVCkgfCAgICAgICAgIFwKPj4gKyAgICAg
ICAgQklUX1VMTChWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpIHwgXAo+PiArICAgICAgICBC
SVRfVUxMKFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYKSB8ICAgICAgICAgIFwKPj4gKyAgICAgICAg
QklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpIHwgICAgICAgICAgXAo+PiArICAgICAgICBCSVRf
VUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkgfCAgICAgXAo+PiArICAgICAgICBCSVRfVUxM
KFZJUlRJT19GX1JJTkdfUEFDS0VEKSB8ICAgICAgICBcCj4+ICsgICAgICAgIEJJVF9VTEwoVklS
VElPX0ZfSU5fT1JERVIpKQo+PiArCj4+ICAgc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSB7Cj4+ICAg
ICAgICAgIHUxNiBpbmRleDsKPj4gICAgICAgICAgdTE2IG51bV9tYXg7Cj4+IEBAIC0xNzc4LDYg
KzE4MDMsMTYgQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnZkdXNlX2Rldl9hdHRyc1tdID0g
ewo+Pgo+PiAgIEFUVFJJQlVURV9HUk9VUFModmR1c2VfZGV2KTsKPj4KPj4gK3N0YXRpYyB2b2lk
IHZkdXNlX2Rldl9mZWF0dXJlc19maWx0ZXIoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZp
ZykKPj4gK3sKPj4gKyAgICAgICAvKgo+PiArICAgICAgICAqIFRlbXBvcmFyaWx5IGZpbHRlciBv
dXQgdmlydGlvLW5ldCdzIGNvbnRyb2wgdmlydHF1ZXVlIGFuZCBmZWF0dXJlcwo+PiArICAgICAg
ICAqIHRoYXQgZGVwZW5kIG9uIGl0IHdoaWxlIENWUSBpcyBiZWluZyBtYWRlIG1vcmUgcm9idXN0
IGZvciBWRFVTRS4KPj4gKyAgICAgICAgKi8KPj4gKyAgICAgICBpZiAoY29uZmlnLT5kZXZpY2Vf
aWQgPT0gVklSVElPX0lEX05FVCkKPj4gKyAgICAgICAgICAgICAgIGNvbmZpZy0+ZmVhdHVyZXMg
Jj0gVkRVU0VfTkVUX1ZBTElEX0ZFQVRVUkVTX01BU0s7Cj4+ICt9Cj4+ICsKPj4gICBzdGF0aWMg
aW50IHZkdXNlX2NyZWF0ZV9kZXYoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZywKPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpjb25maWdfYnVmLCB1NjQgYXBpX3Zl
cnNpb24pCj4+ICAgewo+PiBAQCAtMTc5Myw2ICsxODI4LDggQEAgc3RhdGljIGludCB2ZHVzZV9j
cmVhdGVfZGV2KHN0cnVjdCB2ZHVzZV9kZXZfY29uZmlnICpjb25maWcsCj4+ICAgICAgICAgIGlm
ICghZGV2KQo+PiAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+Pgo+PiArICAgICAgIHZkdXNl
X2Rldl9mZWF0dXJlc19maWx0ZXIoY29uZmlnKTsKPj4gKwo+PiAgICAgICAgICBkZXYtPmFwaV92
ZXJzaW9uID0gYXBpX3ZlcnNpb247Cj4+ICAgICAgICAgIGRldi0+ZGV2aWNlX2ZlYXR1cmVzID0g
Y29uZmlnLT5mZWF0dXJlczsKPj4gICAgICAgICAgZGV2LT5kZXZpY2VfaWQgPSBjb25maWctPmRl
dmljZV9pZDsKPj4gLS0KPj4gMi40MS4wCj4+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
