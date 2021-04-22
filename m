Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D97C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 04:52:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECF660FD7
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 04:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECF660FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E88A6064B;
	Thu, 22 Apr 2021 04:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpF1FHGUAN6N; Thu, 22 Apr 2021 04:52:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E1060605;
	Thu, 22 Apr 2021 04:52:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF628C000E;
	Thu, 22 Apr 2021 04:52:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31B30C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 04:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F3F840E4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 04:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GcOFzt8-FtNX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 04:52:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FFA0405E6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 04:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619067142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9k2K+Ex6th6PfN+n1tdJx10Bdm1/2R+GEbRdjId//8=;
 b=gtQncPCYpHNHPdk8800cHteE3RB1gDrGNXv+tF8s1X6586eiXHfPEAintdUDEgcxENPVH6
 ZalNVgLbQMQC8iqBAxe7ISn4PHkFlFj7oxpCRRcBahNqTG9ApORURiqlbmzVnEBBfm3wwF
 BsKGZ7nnDpAzAsgcMyXzZ2AwzUpVGT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-GO-Dxq9TPE6RJTrUoLDQWw-1; Thu, 22 Apr 2021 00:52:19 -0400
X-MC-Unique: GO-Dxq9TPE6RJTrUoLDQWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 444EF8189C6;
 Thu, 22 Apr 2021 04:52:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-214.pek2.redhat.com
 [10.72.13.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61A5662693;
 Thu, 22 Apr 2021 04:52:11 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
 Eli Cohen <elic@nvidia.com>, mst@redhat.com
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <a77efb06-b2ae-c94a-96bc-290b8b7332ba@nextfour.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7bdb251a-5e16-dd22-d204-6ff57e12e72f@redhat.com>
Date: Thu, 22 Apr 2021 12:52:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <a77efb06-b2ae-c94a-96bc-290b8b7332ba@nextfour.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzQvMjIg5LiK5Y2IMTE6MjcsIE1pa2EgUGVudHRpbMOkIOWGmemBkzoKPgo+Cj4g
T24gMjIuNC4yMDIxIDUuMzcsIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzQvMjEg
5LiL5Y2INjo0MSwgRWxpIENvaGVuIOWGmemBkzoKPj4+IEltcGxlbWVudCBtbHg1X2dldF92cV9u
b3RpZmljYXRpb24oKSB0byByZXR1cm4gdGhlIGRvb3JiZWxsIGFkZHJlc3MuCj4+PiBTaXplIGlz
IHNldCB0byBvbmUgc3lzdGVtIHBhZ2UgYXMgcmVxdWlyZWQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAxICsKPj4+IMKgIGRyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvcmVzb3VyY2VzLmMgfCAxICsKPj4+IMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuY8KgIHwgNiArKysrKysKPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgg
Cj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+IGluZGV4IGI2Y2M1
M2JhOTgwYy4uNDlkZTYyY2RhNTk4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaAo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaAo+Pj4gQEAgLTQxLDYgKzQxLDcgQEAgc3RydWN0IG1seDVfdmRwYV9yZXNvdXJjZXMgewo+
Pj4gwqDCoMKgwqDCoCB1MzIgcGRuOwo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV91YXJzX3Bh
Z2UgKnVhcjsKPj4+IMKgwqDCoMKgwqAgdm9pZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4+PiArwqDC
oMKgIHU2NCBwaHlzX2tpY2tfYWRkcjsKPj4+IMKgwqDCoMKgwqAgdTE2IHVpZDsKPj4+IMKgwqDC
oMKgwqAgdTMyIG51bGxfbWtleTsKPj4+IMKgwqDCoMKgwqAgYm9vbCB2YWxpZDsKPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIAo+Pj4gYi9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+PiBpbmRleCA2NTIxY2JkMGY1YzIuLjY2NWY4
ZmMxNzEwZiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2Vz
LmMKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPj4+IEBAIC0y
NDcsNiArMjQ3LDcgQEAgaW50IG1seDVfdmRwYV9hbGxvY19yZXNvdXJjZXMoc3RydWN0IAo+Pj4g
bWx4NV92ZHBhX2RldiAqbXZkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfa2V5
Owo+Pj4gwqAgwqDCoMKgwqDCoCBraWNrX2FkZHIgPSBtZGV2LT5iYXJfYWRkciArIG9mZnNldDsK
Pj4+ICvCoMKgwqAgcmVzLT5waHlzX2tpY2tfYWRkciA9IGtpY2tfYWRkcjsKPj4+IMKgIMKgwqDC
oMKgwqAgcmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tfYWRkciwgUEFHRV9TSVpFKTsKPj4+
IMKgwqDCoMKgwqAgaWYgKCFyZXMtPmtpY2tfYWRkcikgewo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAKPj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jCj4+PiBpbmRleCAxMGM1ZmVmM2MwMjAuLjY4MDc1MTA3NGQyYSAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gKysrIGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBAQCAtMTg2NSw4ICsxODY1LDE0IEBA
IHN0YXRpYyB2b2lkIG1seDVfdmRwYV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAKPj4+ICp2ZGV2
KQo+Pj4gwqAgwqAgc3RhdGljIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIAo+Pj4gbWx4
NV9nZXRfdnFfbm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkK
Pj4+IMKgIHsKPj4+ICvCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZk
ZXYodmRldik7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIHJl
dCA9IHt9Owo+Pj4gK8KgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldjsKPj4+ICsKPj4+
ICvCoMKgwqAgbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPj4+IMKgICvCoMKgwqAg
cmV0LmFkZHIgPSAocGh5c19hZGRyX3QpbmRldi0+bXZkZXYucmVzLnBoeXNfa2lja19hZGRyOwo+
Pj4gK8KgwqDCoCByZXQuc2l6ZSA9IFBBR0VfU0laRTsKPj4KPj4KPj4gTm90ZSB0aGF0IHRoZSBw
YWdlIHdpbGwgYmUgbWFwcGVkIGluIHRvIGd1ZXN0LCBzbyBpdCdzIG9ubHkgc2FmZSBpZiAKPj4g
dGhlIGRvb3JiZWVsIGV4Y2x1c2l2ZWx5IG93biB0aGUgcGFnZS4gVGhpcyBtZWFucyBpZiB0aGVy
ZSdyZSBvdGhlciAKPj4gcmVnaXN0ZXJzIGluIHRoZSBwYWdlLCB3ZSBjYW4gbm90IGxldCB0aGUg
ZG9vcmJlbGwgYnlwYXNzIHRvIHdvcmsuCj4+Cj4+IFNvIHRoaXMgaXMgc3VzcGljaW91cyBhdCBs
ZWFzdCBpbiB0aGUgY2FzZSBvZiBzdWJmdW5jdGlvbiB3aGVyZSB3ZSAKPj4gY2FsY3VsYXRlIHRo
ZSBiYXIgbGVuZ3RoIGluIG1seDVfc2ZfZGV2X3RhYmxlX2NyZWF0ZSgpIGFzOgo+Pgo+PiB0YWJs
ZS0+c2ZfYmFyX2xlbmd0aCA9IDEgPDwgKE1MWDVfQ0FQX0dFTihkZXYsIGxvZ19taW5fc2Zfc2l6
ZSkgKyAxMik7Cj4+Cj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgY2FuIG9ubHkgd29yayBmb3IgdGhl
IGFyY2ggd2l0aCBQQUdFX1NJWkUgPSA0MDk2LCAKPj4gb3RoZXJ3aXNlIHdlIGNhbiBtYXAgbW9y
ZSBpbnRvIHRoZSB1c2Vyc3BhY2UoZ3Vlc3QpLgo+Pgo+PiBUaGFua3MKPj4KPj4KPiBJcyB0aGVy
ZSBzdXBwb3J0IGFzIG9mIHRvZGF5IChpbiBxZW11wqAgb3IgZWxzZXdoZXJlKSB0byB1c2UgdGhp
cyBtbWFwIAo+IGRvb3JiZWxsIGluc3RlYWQgb2YgdGhlIHRyYWRpdGlvbmFsIGtpY2suCgoKVmhv
c3QtdXNlciBoYWQgYWxyZWFkeSBoYWQgdGhpcyBzdXBwb3J0IGluIFFlbXUgKHNlZSBzZXRfaG9z
dF9ub3RpZmllcl9tcikuCgpBbmQgSSd2ZSBwb3N0ZWQgcGF0Y2hlcyB0byBzdXBwb3J0IHRoaXMg
Zm9yIHFlbXVbMV0gYW5kIHZwX3ZkcGFbMl0gZHJpdmVyLgoKVGhhbmtzCgpbMV0gaHR0cHM6Ly93
d3cubWFpbC1hcmNoaXZlLmNvbS9xZW11LWRldmVsQG5vbmdudS5vcmcvbXNnNzk4OTM1Lmh0bWwK
ClsyXSAKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMTA0MTUwNzMx
NDcuMTkzMzEtNS1qYXNvd2FuZ0ByZWRoYXQuY29tL1QvCgoKPgo+IC0tTWlrYQo+Cj4KPgo+Pgo+
Pj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gwqAgfQo+Pgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
