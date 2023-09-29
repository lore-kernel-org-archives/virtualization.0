Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD2CE7B1F
	for <virtualization@archiver.kernel.org>; Fri, 29 Sep 2023 09:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD223409A5;
	Fri, 29 Sep 2023 09:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD223409A5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gXnB88Q4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FX4FdZjQjD6n; Fri, 29 Sep 2023 09:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D1464019D;
	Fri, 29 Sep 2023 09:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D1464019D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08FD7C0039;
	Fri, 29 Sep 2023 09:08:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5153C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B4E540640
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B4E540640
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRTd7Xf3RHa8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 360B94019D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 360B94019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/1qYpfgB/Cr65fTbE/peTu216y26U+TzDcRaWm5JW8=;
 b=gXnB88Q4RahPgEfzi9Ae/DUatC+nac5HmZj0hcIb5pnG29AH6BnR1uGfDEVgJRA6wha8Qo
 +c8QhbcVp1YErmSdrxOnpKSHTYIU4G3SpscWaCi+7YuhIutlyLora/5OED+Nu1GDhzsbOS
 k8JiW0HOntyE1ozUXsUJs/vm7UyqxXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-f7TvbMDWMxSPff7skgH1QQ-1; Fri, 29 Sep 2023 05:08:06 -0400
X-MC-Unique: f7TvbMDWMxSPff7skgH1QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69881101A53B;
 Fri, 29 Sep 2023 09:08:05 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B84340C6EBF;
 Fri, 29 Sep 2023 09:08:03 +0000 (UTC)
Message-ID: <0af14066-6cc9-bfc6-2a4c-0503f9dd4a5c@redhat.com>
Date: Fri, 29 Sep 2023 11:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
 <CACLfguVRPV_8HOy3mQbKvpWRGpM_tnjmC=oQqrEbvEz6YkMi0w@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <CACLfguVRPV_8HOy3mQbKvpWRGpM_tnjmC=oQqrEbvEz6YkMi0w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com
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

CgpPbiA5LzI1LzIzIDA2OjE1LCBDaW5keSBMdSB3cm90ZToKPiBPbiBUdWUsIFNlcCAxMiwgMjAy
MyBhdCAzOjM54oCvUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+
Cj4+IE9uIFR1ZSwgU2VwIDEyLCAyMDIzIGF0IDExOjAw4oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gSW4gVkRVU0VfVlFfR0VUX0lORk8sIHRoZSBkcml2ZXIg
d2lsbCBzeW5jIHRoZSBsYXN0X2F2YWlsX2lkeAo+Pj4gd2l0aCByZWNvbm5lY3QgaW5mbywgQWZ0
ZXIgbWFwcGluZyB0aGUgcmVjb25uZWN0IHBhZ2VzIHRvIHVzZXJzcGFjZQo+Pj4gVGhlIHVzZXJz
cGFjZSBBcHAgd2lsbCB1cGRhdGUgdGhlIHJlY29ubmVjdF90aW1lIGluCj4+PiBzdHJ1Y3Qgdmhv
c3RfcmVjb25uZWN0X3ZyaW5nLCBJZiB0aGlzIGlzIG5vdCAwIHRoZW4gaXQgbWVhbnMgdGhpcwo+
Pj4gdnEgaXMgcmVjb25uZWN0ZWQgYW5kIHdpbGwgdXBkYXRlIHRoZSBsYXN0X2F2YWlsX2lkeAo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4+PiAtLS0K
Pj4+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDEzICsrKysrKysrKysr
KysKPj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmggICAgICAgICB8ICA2ICsrKysrKwo+
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvdmR1c2VfZGV2LmMKPj4+IGluZGV4IDJjNjlmNDAwNGE2ZS4uNjgwYjIzZGJkZGUyIDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+Pj4gQEAgLTEyMjEsNiArMTIy
MSw4IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5z
aWduZWQgaW50IGNtZCwKPj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IHZkdXNlX3ZxX2luZm8g
dnFfaW5mbzsKPj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSAqdnE7
Cj4+PiAgICAgICAgICAgICAgICAgIHUzMiBpbmRleDsKPj4+ICsgICAgICAgICAgICAgICBzdHJ1
Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyAqYXJlYTsKPj4+ICsgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmhvc3RfcmVjb25uZWN0X3ZyaW5nICp2cV9yZWNvbm5lY3Q7Cj4+Pgo+Pj4gICAgICAgICAgICAg
ICAgICByZXQgPSAtRUZBVUxUOwo+Pj4gICAgICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3Vz
ZXIoJnZxX2luZm8sIGFyZ3AsIHNpemVvZih2cV9pbmZvKSkpCj4+PiBAQCAtMTI1Miw2ICsxMjU0
LDE3IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5z
aWduZWQgaW50IGNtZCwKPj4+Cj4+PiAgICAgICAgICAgICAgICAgIHZxX2luZm8ucmVhZHkgPSB2
cS0+cmVhZHk7Cj4+Pgo+Pj4gKyAgICAgICAgICAgICAgIGFyZWEgPSAmdnEtPnJlY29ubmVjdF9p
bmZvOwo+Pj4gKwo+Pj4gKyAgICAgICAgICAgICAgIHZxX3JlY29ubmVjdCA9IChzdHJ1Y3Qgdmhv
c3RfcmVjb25uZWN0X3ZyaW5nICopYXJlYS0+dmFkZHI7Cj4+PiArICAgICAgICAgICAgICAgLypj
aGVjayBpZiB0aGUgdnEgaXMgcmVjb25uZWN0LCBpZiB5ZXMgdGhlbiB1cGRhdGUgdGhlIGxhc3Rf
YXZhaWxfaWR4Ki8KPj4+ICsgICAgICAgICAgICAgICBpZiAoKHZxX3JlY29ubmVjdC0+bGFzdF9h
dmFpbF9pZHggIT0KPj4+ICsgICAgICAgICAgICAgICAgICAgIHZxX2luZm8uc3BsaXQuYXZhaWxf
aW5kZXgpICYmCj4+PiArICAgICAgICAgICAgICAgICAgICh2cV9yZWNvbm5lY3QtPnJlY29ubmVj
dF90aW1lICE9IDApKSB7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICB2cV9pbmZvLnNwbGl0
LmF2YWlsX2luZGV4ID0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnFfcmVj
b25uZWN0LT5sYXN0X2F2YWlsX2lkeDsKPj4+ICsgICAgICAgICAgICAgICB9Cj4+PiArCj4+PiAg
ICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4+PiAgICAgICAgICAgICAgICAgIGlmIChj
b3B5X3RvX3VzZXIoYXJncCwgJnZxX2luZm8sIHNpemVvZih2cV9pbmZvKSkpCj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZkdXNlLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+Pj4gaW5kZXggMTFiZDQ4
YzcyYzZjLi5kNTg1NDI1ODAzZmQgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgv
dmR1c2UuaAo+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPj4+IEBAIC0zNTAs
NCArMzUwLDEwIEBAIHN0cnVjdCB2ZHVzZV9kZXZfcmVzcG9uc2Ugewo+Pj4gICAgICAgICAgfTsK
Pj4+ICAgfTsKPj4+Cj4+PiArc3RydWN0IHZob3N0X3JlY29ubmVjdF92cmluZyB7Cj4+PiArICAg
ICAgIF9fdTE2IHJlY29ubmVjdF90aW1lOwo+Pj4gKyAgICAgICBfX3UxNiBsYXN0X2F2YWlsX2lk
eDsKPj4+ICsgICAgICAgX0Jvb2wgYXZhaWxfd3JhcF9jb3VudGVyOwo+Pgo+PiBQbGVhc2UgYWRk
IGEgY29tbWVudCBmb3IgZWFjaCBmaWVsZC4KPj4KPiBTdXJlIHdpbGwgZG8KPiAKPj4gQW5kIEkg
bmV2ZXIgc2F3IF9Cb29sIGlzIHVzZWQgaW4gdWFwaSBiZWZvcmUsIG1heWJlIGl0J3MgYmV0dGVy
IHRvCj4+IHBhY2sgaXQgd2l0aCBsYXN0X2F2YWlsX2lkeCBpbnRvIGEgX191MzIuCj4+Cj4gVGhh
bmtzIHdpbGwgZml4IHRoaXMKPj4gQnR3LCBkbyB3ZSBuZWVkIHRvIHRyYWNrIGluZmxpZ2h0IGRl
c2NyaXB0b3JzIGFzIHdlbGw/Cj4+Cj4gSSB3aWxsIGNoZWNrIHRoaXMKCkZvciBleGlzdGluZyBu
ZXR3b3JraW5nIGltcGxlbWVuYXRpb24sIHRoaXMgaXMgbm90IG5lY2Vzc2FyeS4KQnV0IGl0IHNo
b3VsZCBiZSBmb3IgYmxvY2sgZGV2aWNlcy4KCk1heGltZQoKPiBUaGFua3MKPiAKPiBjaW5keQo+
PiBUaGFua3MKPj4KPj4+ICt9Owo+Pj4gKwo+Pj4gICAjZW5kaWYgLyogX1VBUElfVkRVU0VfSF8g
Ki8KPj4+IC0tCj4+PiAyLjM0LjMKPj4+Cj4+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
