Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D39C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:13:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C764E9C
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C764E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5060785660;
	Tue,  2 Feb 2021 03:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcQFxsqfYuYJ; Tue,  2 Feb 2021 03:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C72D985621;
	Tue,  2 Feb 2021 03:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADE22C0174;
	Tue,  2 Feb 2021 03:13:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE77EC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C428F86290
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qu+ulpy9ihwB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 90DDD85FED
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612235584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUWFN4ekNdpi4WxcUqZD8X9JUjgbpEhAfA6K+mxCnDM=;
 b=RLyef//RASzBIdUap2YcepjW5QNuNC+p7cB0W47Y69as0hrnS4yU8lCeo5Q8lKKI0EMxo5
 22ib9AB5V+Ezdebz1ljnAQ8DzpGgHV0DblXKmqroOY9Vfj3p7L9YbUQkoZGbtYNhRmTfoe
 n4dbVVZj6qWK2hSbC5VkFJLM5i1bb5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Xm7YpHbfPKGCCPIAwAzINg-1; Mon, 01 Feb 2021 22:13:01 -0500
X-MC-Unique: Xm7YpHbfPKGCCPIAwAzINg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B4C800D53;
 Tue,  2 Feb 2021 03:12:59 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80C2360BE5;
 Tue,  2 Feb 2021 03:12:54 +0000 (UTC)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Avoid unnecessary query virtqueue
To: Si-Wei Liu <siwliu.kernel@gmail.com>, Eli Cohen <elic@nvidia.com>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-2-elic@nvidia.com>
 <CAPWQSg0XtEQ1U5N3a767Ak_naoyPdVF1CeE4r3hmN11a-aoBxg@mail.gmail.com>
 <CAPWQSg3U9DCSK_01Kzuea5B1X+Ef9JB23wBY82A3ss-UXGek_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9d6058d6-5ce1-0442-8fd9-5a6fe6a0bc6b@redhat.com>
Date: Tue, 2 Feb 2021 11:12:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPWQSg3U9DCSK_01Kzuea5B1X+Ef9JB23wBY82A3ss-UXGek_Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: lulu@redhat.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>
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

Ck9uIDIwMjEvMi8yIOS4iuWNiDM6MTcsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gT24gTW9uLCBGZWIg
MSwgMjAyMSBhdCAxMDo1MSBBTSBTaS1XZWkgTGl1IDxzaXdsaXUua2VybmVsQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDU6NDYgQU0gRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+IHdyb3RlOgo+Pj4gc3VzcGVuZF92cSBzaG91bGQgb25seSBzdXNwZW5kIHRo
ZSBWUSBvbiBub3Qgc2F2ZSB0aGUgY3VycmVudCBhdmFpbGFibGUKPj4+IGluZGV4LiBUaGlzIGlz
IGRvbmUgd2hlbiBhIGNoYW5nZSBvZiBtYXAgb2NjdXJzIHdoZW4gdGhlIGRyaXZlciBjYWxscwo+
Pj4gc2F2ZV9jaGFubmVsX2luZm8oKS4KPj4gSG1tbSwgc3VzcGVuZF92cSgpIGlzIGFsc28gY2Fs
bGVkIGJ5IHRlYXJkb3duX3ZxKCksIHRoZSBsYXR0ZXIgb2YKPj4gd2hpY2ggZG9lc24ndCBzYXZl
IHRoZSBhdmFpbGFibGUgaW5kZXggYXMgc2F2ZV9jaGFubmVsX2luZm8oKSBkb2Vzbid0Cj4+IGdl
dCBjYWxsZWQgaW4gdGhhdCBwYXRoIGF0IGFsbC4gSG93IGRvZXMgaXQgaGFuZGxlIHRoZSBjYXNl
IHRoYXQKPj4gYWdldF92cV9zdGF0ZSgpIGlzIGNhbGxlZCBmcm9tIHVzZXJzcGFjZSAoZS5nLiBR
RU1VKSB3aGlsZSB0aGUKPj4gaGFyZHdhcmUgVlEgb2JqZWN0IHdhcyB0b3JuIGRvd24sIGJ1dCB1
c2Vyc3BhY2Ugc3RpbGwgd2FudHMgdG8gYWNjZXNzCj4+IHRoZSBxdWV1ZSBpbmRleD8KPj4KPj4g
UmVmZXIgdG8gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzE2MDE1ODM1MTEtMTUxMzgt
MS1naXQtc2VuZC1lbWFpbC1zaS13ZWkubGl1QG9yYWNsZS5jb20vCj4+Cj4+IHZob3N0IFZRIDAg
cmluZyByZXN0b3JlIGZhaWxlZDogLTE6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxl
ICgxMSkKPj4gdmhvc3QgVlEgMSByaW5nIHJlc3RvcmUgZmFpbGVkOiAtMTogUmVzb3VyY2UgdGVt
cG9yYXJpbHkgdW5hdmFpbGFibGUgKDExKQo+Pgo+PiBRRU1VIHdpbGwgY29tcGxhaW4gd2l0aCB0
aGUgYWJvdmUgd2FybmluZyB3aGlsZSBWTSBpcyBiZWluZyByZWJvb3RlZAo+PiBvciBzaHV0IGRv
d24uCj4+Cj4+IExvb2tzIHRvIG1lIGVpdGhlciB0aGUga2VybmVsIGRyaXZlciBzaG91bGQgY292
ZXIgdGhpcyByZXF1aXJlbWVudCwgb3IKPj4gdGhlIHVzZXJzcGFjZSBoYXMgdG8gYmVhciB0aGUg
YnVyZGVuIGluIHNhdmluZyB0aGUgaW5kZXggYW5kIG5vdCBjYWxsCj4+IGludG8ga2VybmVsIGlm
IFZRIGlzIGRlc3Ryb3llZC4KPiBBY3R1YWxseSwgdGhlIHVzZXJzcGFjZSBkb2Vzbid0IGhhdmUg
dGhlIGluc2lnaHRzIHdoZXRoZXIgdmlydCBxdWV1ZQo+IHdpbGwgYmUgZGVzdHJveWVkIGlmIGp1
c3QgY2hhbmdpbmcgdGhlIGRldmljZSBzdGF0dXMgdmlhIHNldF9zdGF0dXMoKS4KPiBMb29raW5n
IGF0IG90aGVyIHZkcGEgZHJpdmVyIGluIHRyZWUgaS5lLiBpZmN2ZiBpdCBkb2Vzbid0IGJlaGF2
ZSBsaWtlCj4gc28uIEhlbmNlIHRoaXMgc3RpbGwgbG9va3MgdG8gbWUgdG8gYmUgTWVsbGFub3gg
c3BlY2lmaWNzIGFuZAo+IG1seDVfdmRwYSBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgdGhhdCBzaG91
bGRuJ3QgZXhwb3NlIHRvIHVzZXJzcGFjZS4KCgpTbyBJIHRoaW5rIHdlIGNhbiBzaW1wbHkgZHJv
cCB0aGlzIHBhdGNoPwoKVGhhbmtzCgoKPj4gLVNpd2VpCj4+Cj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMgfCA4IC0tLS0tLS0tCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4
IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+IGluZGV4
IDg4ZGRlMzQ1NWJmZC4uNTQ5ZGVkMDc0ZmYzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPj4+IEBAIC0xMTQ4LDggKzExNDgsNiBAQCBzdGF0aWMgaW50IHNldHVwX3ZxKHN0
cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZx
KQo+Pj4KPj4+ICAgc3RhdGljIHZvaWQgc3VzcGVuZF92cShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cSkKPj4+ICAgewo+Pj4gLSAgICAg
ICBzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIGF0dHI7Cj4+PiAtCj4+PiAgICAgICAgICBpZiAoIW12
cS0+aW5pdGlhbGl6ZWQpCj4+PiAgICAgICAgICAgICAgICAgIHJldHVybjsKPj4+Cj4+PiBAQCAt
MTE1OCwxMiArMTE1Niw2IEBAIHN0YXRpYyB2b2lkIHN1c3BlbmRfdnEoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4+Pgo+Pj4gICAgICAg
ICAgaWYgKG1vZGlmeV92aXJ0cXVldWUobmRldiwgbXZxLCBNTFg1X1ZJUlRJT19ORVRfUV9PQkpF
Q1RfU1RBVEVfU1VTUEVORCkpCj4+PiAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKCZu
ZGV2LT5tdmRldiwgIm1vZGlmeSB0byBzdXNwZW5kIGZhaWxlZFxuIik7Cj4+PiAtCj4+PiAtICAg
ICAgIGlmIChxdWVyeV92aXJ0cXVldWUobmRldiwgbXZxLCAmYXR0cikpIHsKPj4+IC0gICAgICAg
ICAgICAgICBtbHg1X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJmYWlsZWQgdG8gcXVlcnkgdmly
dHF1ZXVlXG4iKTsKPj4+IC0gICAgICAgICAgICAgICByZXR1cm47Cj4+PiAtICAgICAgIH0KPj4+
IC0gICAgICAgbXZxLT5hdmFpbF9pZHggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+ICAgfQo+
Pj4KPj4+ICAgc3RhdGljIHZvaWQgc3VzcGVuZF92cXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYpCj4+PiAtLQo+Pj4gMi4yOS4yCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
