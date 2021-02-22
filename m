Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D343C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 04:14:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226D164E44
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 04:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226D164E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3FE682ACD;
	Mon, 22 Feb 2021 04:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8EYm8oF6ISR; Mon, 22 Feb 2021 04:14:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1942F82ADD;
	Mon, 22 Feb 2021 04:14:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C699C000A;
	Mon, 22 Feb 2021 04:14:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0813C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 04:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DEE1C87085
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 04:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1RjqE5k0SNy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 04:14:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E73D98707D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 04:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613967267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+x2TUELl7mIVGk/ohyT3Fe+rS53LsnETTro7AaKiEY=;
 b=HHwaiOd87D7gzCq9keJmrraERvauRvKr9QgTSV20O9rmMV4rtRXvYPJy4n2lZlRvahy+29
 peEAiywqXUCzne1Ax/TsNI5lEP/zqeKP7IIaVs8cLPEFjQnQnZQydszeflYxKluzCDcCg6
 clrbtVbbEG6JvHOZ9AJdApAvBGgvhiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-kMsuTl1_NKemZuv_UIhDrw-1; Sun, 21 Feb 2021 23:14:25 -0500
X-MC-Unique: kMsuTl1_NKemZuv_UIhDrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 702D18030BB;
 Mon, 22 Feb 2021 04:14:24 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com
 [10.72.13.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D41660C5C;
 Mon, 22 Feb 2021 04:14:19 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
Date: Mon, 22 Feb 2021 12:14:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPiBDb21taXQgNDUy
NjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2VkCj4gZm9y
IGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4g
ZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1
cmVzCj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZlcmlmeV9taW5fZmVhdHVyZXMo
KSBjaGVjawo+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4K
PiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNj
ZXNzCj4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0LiBGb3IgaW5zdGFuY2Us
IHdoZW4KPiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVy
biBkcml2ZXIKPiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2Vu
dCBpbiB0aGUgY29uZmlnCj4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0LgoK
ClRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgoKIgoKVGhlIGZvbGxvd2luZyBkcml2
ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYgClZJUlRJT19ORVRfRl9NVFUg
aXMgc2V0LiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZSAKZHJp
dmVyIHRvIHVzZS4KIgoKRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29ya2Fyb3VuZCB0aGlzPwoKVGhh
bmtzCgoKPiBSZWplY3RpbmcgcmVzZXQgdG8gMAo+IHByZW1hdHVyZWx5IGNhdXNlcyBjb3JyZWN0
IE1UVSBhbmQgbGluayBzdGF0dXMgdW5hYmxlIHRvIGxvYWQKPiBmb3IgdGhlIHZlcnkgZmlyc3Qg
Y29uZmlnIHNwYWNlIGFjY2VzcywgcmVuZGVyaW5nIGlzc3VlcyBsaWtlCj4gZ3Vlc3Qgc2hvd2lu
ZyBpbmFjY3VyYXRlIE1UVSB2YWx1ZSwgb3IgZmFpbHVyZSB0byByZWplY3QKPiBvdXQtb2YtcmFu
Z2UgTVRVLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJp
dmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4gaW5kZXggN2MxZjc4OS4uNTQwZGQ2NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0YXRpYyB1NjQgbWx4NV92ZHBhX2dldF9m
ZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gICAJcmV0dXJuIG12ZGV2LT5tbHhf
ZmVhdHVyZXM7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1cmVzKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTY0IGZlYXR1cmVzKQo+IC17Cj4gLQlpZiAoIShm
ZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gLQkJcmV0dXJu
IC1FT1BOT1RTVVBQOwo+IC0KPiAtCXJldHVybiAwOwo+IC19Cj4gLQo+ICAgc3RhdGljIGludCBz
ZXR1cF92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICAgewo+ICAgCWlu
dCBlcnI7Cj4gQEAgLTE1NTgsMTggKzE1NTAsMTMgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0
X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgewo+
ICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+ICAgCXN0
cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+IC0J
aW50IGVycjsKPiAgIAo+ICAgCXByaW50X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcywgdHJ1ZSk7
Cj4gICAKPiAtCWVyciA9IHZlcmlmeV9taW5fZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzKTsKPiAt
CWlmIChlcnIpCj4gLQkJcmV0dXJuIGVycjsKPiAtCj4gICAJbmRldi0+bXZkZXYuYWN0dWFsX2Zl
YXR1cmVzID0gZmVhdHVyZXMgJiBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4gICAJbmRldi0+
Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBuZGV2LT5tdHUpOwo+ICAgCW5k
ZXYtPmNvbmZpZy5zdGF0dXMgfD0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIFZJUlRJT19ORVRf
U19MSU5LX1VQKTsKPiAtCXJldHVybiBlcnI7Cj4gKwlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICAg
c3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9jb25maWdfY2Ioc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqY2IpCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
