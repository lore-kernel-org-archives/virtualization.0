Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF764C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 09:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A135064F2C
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 09:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A135064F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CFD0844CC;
	Fri, 12 Mar 2021 09:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOtjIvXXgCgm; Fri, 12 Mar 2021 09:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A4DC844C4;
	Fri, 12 Mar 2021 09:38:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D47B2C000A;
	Fri, 12 Mar 2021 09:38:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73F9FC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 09:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D3C24ED44
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 09:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26gpDc0U-OQt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 09:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 245334EC40
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615541903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpHmkAmgeNh6Uudp5GOdEHuyeyiu4LHNc87R2DZlEKg=;
 b=BKq7Gd0c1SkBnPYVk3EeyFIAkyq1REB3ZFyyNSP8/A/7fYZyJAzA8rmZuQVGrPXllh4qw5
 06DY5ZLOf8IHXzbBN8KJcqmnMFjS5IsS0M+8vpqEofeD1O0NbOlh+6qf/Gov3X+9QNgaoZ
 mFhZqoroqBJAsUtrumiqiB1TT9FAC7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-m9MHugSjOduLBfBo7siBCg-1; Fri, 12 Mar 2021 04:38:19 -0500
X-MC-Unique: m9MHugSjOduLBfBo7siBCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDDBC802B7E;
 Fri, 12 Mar 2021 09:38:17 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-47.pek2.redhat.com
 [10.72.13.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45F9419106;
 Fri, 12 Mar 2021 09:38:06 +0000 (UTC)
Subject: Re: linux-next: Tree for Mar 11 [drivers/vdpa/virtio_pci/vp_vdpa.ko]
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210311161449.7f58e7a3@canb.auug.org.au>
 <197e3f0f-9e16-3597-f2c7-ab988e3e0a4d@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eeecbd7e-a11f-8fc7-400b-6aec3919b8f9@redhat.com>
Date: Fri, 12 Mar 2021 17:38:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <197e3f0f-9e16-3597-f2c7-ab988e3e0a4d@infradead.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjEvMy8xMiAyOjE4IOS4iuWNiCwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IE9uIDMvMTAv
MjEgOToxNCBQTSwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToKPj4gSGkgYWxsLAo+Pgo+PiBXYXJu
aW5nOiBTb21lIG9mIHRoZSBicmFuY2hlcyBpbiBsaW51eC1uZXh0IGFyZSBzdGlsbCBiYXNlZCBv
biB2NS4xMi1yYzEsCj4+IHNvIHBsZWFzZSBiZSBjYXJlZnVsIGlmIHlvdSBhcmUgdHJ5aW5nIHRv
IGJpc2VjdCBhIGJ1Zy4KPj4KPj4gTmV3czogaWYgeW91ciAtbmV4dCBpbmNsdWRlZCB0cmVlIGlz
IGJhc2VkIG9uIExpbnVzJyB0cmVlIHRhZwo+PiB2NS4xMi1yYzF7LC1kb250dXNlfSAob3Igc29t
ZXdoZXJlIGJldHdlZW4gdjUuMTEgYW5kIHRoYXQgdGFnKSwgcGxlYXNlCj4+IGNvbnNpZGVyIHJl
YmFzaW5nIGl0IG9udG8gdjUuMTItcmMyLiBBbHNvLCBwbGVhc2UgY2hlY2sgYW55IGJyYW5jaGVz
Cj4+IG1lcmdlZCBpbnRvIHlvdXIgYnJhbmNoLgo+Pgo+PiBDaGFuZ2VzIHNpbmNlIDIwMjEwMzEw
Ogo+Pgo+IG9uIGkzODY6Cj4KPiBFUlJPUjogbW9kcG9zdDogInZwX21vZGVybl9nZXRfcXVldWVf
bm90aWZ5X29mZiIgW2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEua29dIHVuZGVmaW5l
ZCEKPiBFUlJPUjogbW9kcG9zdDogInZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyIgW2RyaXZlcnMv
dmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEua29dIHVuZGVmaW5lZCEKPiBFUlJPUjogbW9kcG9zdDog
InZwX21vZGVybl9wcm9iZSIgW2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEua29dIHVu
ZGVmaW5lZCEKPiBFUlJPUjogbW9kcG9zdDogInZwX21vZGVybl9xdWV1ZV9hZGRyZXNzIiBbZHJp
dmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5rb10gdW5kZWZpbmVkIQo+IEVSUk9SOiBtb2Rw
b3N0OiAidnBfbW9kZXJuX3NldF9xdWV1ZV9zaXplIiBbZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kv
dnBfdmRwYS5rb10gdW5kZWZpbmVkIQo+IEVSUk9SOiBtb2Rwb3N0OiAidnBfbW9kZXJuX3NldF9x
dWV1ZV9lbmFibGUiIFtkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmtvXSB1bmRlZmlu
ZWQhCj4gRVJST1I6IG1vZHBvc3Q6ICJ2cF9tb2Rlcm5fZ2V0X3F1ZXVlX2VuYWJsZSIgW2RyaXZl
cnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEua29dIHVuZGVmaW5lZCEKPiBFUlJPUjogbW9kcG9z
dDogInZwX21vZGVybl9nZXRfZmVhdHVyZXMiIFtkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92
ZHBhLmtvXSB1bmRlZmluZWQhCj4gRVJST1I6IG1vZHBvc3Q6ICJ2cF9tb2Rlcm5fc2V0X2ZlYXR1
cmVzIiBbZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5rb10gdW5kZWZpbmVkIQo+IEVS
Uk9SOiBtb2Rwb3N0OiAidnBfbW9kZXJuX3NldF9zdGF0dXMiIFtkcml2ZXJzL3ZkcGEvdmlydGlv
X3BjaS92cF92ZHBhLmtvXSB1bmRlZmluZWQhCj4gRVJST1I6IG1vZHBvc3Q6ICJ2cF9tb2Rlcm5f
Z2V0X3N0YXR1cyIgW2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEua29dIHVuZGVmaW5l
ZCEKPiBFUlJPUjogbW9kcG9zdDogInZwX21vZGVybl9jb25maWdfdmVjdG9yIiBbZHJpdmVycy92
ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5rb10gdW5kZWZpbmVkIQo+IEVSUk9SOiBtb2Rwb3N0OiAi
dnBfbW9kZXJuX3F1ZXVlX3ZlY3RvciIgW2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEu
a29dIHVuZGVmaW5lZCEKPiBFUlJPUjogbW9kcG9zdDogInZwX21vZGVybl9nZW5lcmF0aW9uIiBb
ZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5rb10gdW5kZWZpbmVkIQo+IEVSUk9SOiBt
b2Rwb3N0OiAidnBfbW9kZXJuX3JlbW92ZSIgW2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3Zk
cGEua29dIHVuZGVmaW5lZCEKPgo+Cj4gRnVsbCByYW5kY29uZmlnIGZpbGUgaXMgYXR0YWNoZWQu
CgpGaXggc2VudC4KClRoYW5rcy4KCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
