Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D91C64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:15:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40182076E
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQL/VS9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40182076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7AD786BAD;
	Mon, 30 Nov 2020 14:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fVouvR4dkQ8v; Mon, 30 Nov 2020 14:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B584486B9E;
	Mon, 30 Nov 2020 14:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA46C163C;
	Mon, 30 Nov 2020 14:15:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3BADC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DA37D86BC3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYG1hy-RPCRM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:15:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8649C86B9E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606745703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3gBLWLKl7W4Xq6wM+ZxQ2x038DmE926WYCMQCHr66g=;
 b=CQL/VS9+l8c7DJ7WAmJPE2hSC0Mv+mM/6KUt7Bei+VBj0d69BDhJYl2vwVCiz+4kRs8P9z
 LlsTP6DD21OmT8JDz8SGZ3bFkKnIJ2y8CUPv32WvBkimKsW7RY5PgC0+vvmPZT2z7cwlZb
 MJgMF8PleHsWTJOVyPOHg0NhO90Da9o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-GHpp2EwEN1agoISCqDT0aw-1; Mon, 30 Nov 2020 09:14:58 -0500
X-MC-Unique: GHpp2EwEN1agoISCqDT0aw-1
Received: by mail-wm1-f72.google.com with SMTP id v5so7527890wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 06:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=J3gBLWLKl7W4Xq6wM+ZxQ2x038DmE926WYCMQCHr66g=;
 b=MVCx4K0v9IdVETQkv/jd6ELKiPXS88BXEta85S9Jb4uxCWnSHUGwL96wDohYU9mRzn
 OTATa83DtNhBy/8lXcXvOY353yOumK/wUWHi12TvfKAmyGlk0IelVmEmlzZ4Cf92+YSL
 gYUHpDZwxX6K8O61vRv2CgrAD+KN0Ntn2kJPtQO7zC+pvnj+IaTQX9EjvOI0whEyxvEq
 fFKHKE8SbvJo7QBkwJYqvlAAP4Ytby/ettvfHdNfiEHCEAsFImgL+ptNqEPioJJC8VQg
 KcUQ+/b7MQvn69QiJoy/bv5JVVnazVU4T5jCBvN4ibmpPKkMPm07DKxQcr/Wzf351CSt
 Cszw==
X-Gm-Message-State: AOAM5326snQ2KSyqZIseOCR8CD/Nw2jd7qni/Li3CN0EGW2wkabSfgUO
 rnwdHKKaadIckbC5qEPqjusNgBpz2LjDgocmSiLGOl9oycnJYoBMuUIDhVFVUkb8PBRAzi+hjRl
 gYRzR5JWFB+nW3ATDB135xwIYgJ3Sotcc/AZove/1Nw==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4415251wmc.117.1606745696781; 
 Mon, 30 Nov 2020 06:14:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcKrJpx3nrREkeE45HL6YslRFXos8EHDtmO3OikwsemUZ2+z0sSoboa+Itjc1V17186xvQOg==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4415222wmc.117.1606745696434; 
 Mon, 30 Nov 2020 06:14:56 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id q16sm29246641wrn.13.2020.11.30.06.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 06:14:55 -0800 (PST)
Date: Mon, 30 Nov 2020 15:14:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Message-ID: <20201130141453.jobe76loyfy4qrdw@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
 <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MjU6MzFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8yNiDkuIvljYgxMDo0OSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+PlRoZSBnZXRfY29uZmlnIGNhbGxiYWNrIGNhbiBiZSB1c2VkIGJ5IHRoZSBkZXZpY2UgdG8g
ZmlsbCB0aGUKPj5jb25maWcgc3RydWN0dXJlLgo+PlRoZSBjYWxsYmFjayB3aWxsIGJlIGludm9r
ZWQgaW4gdmRwYXNpbV9nZXRfY29uZmlnKCkgYmVmb3JlIGNvcHlpbmcKPj5ieXRlcyBpbnRvIGNh
bGxlciBidWZmZXIuCj4+Cj4+TW92ZSB2RFBBLW5ldCBjb25maWcgdXBkYXRlcyBmcm9tIHZkcGFz
aW1fc2V0X2ZlYXR1cmVzKCkgaW4gdGhlCj4+bmV3IHZkcGFzaW1fbmV0X2dldF9jb25maWcoKSBj
YWxsYmFjay4KPj4KPj5TaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJl
QHJlZGhhdC5jb20+Cj4+LS0tCj4+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8
IDMzICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMKPj5pbmRleCBjMDdkZGY2YWY3MjAuLjhiODdjZTA0ODViNiAxMDA2NDQKPj4tLS0gYS9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PisrKyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbS5jCj4+QEAgLTU4LDYgKzU4LDggQEAgc3RydWN0IHZkcGFzaW1fdmlydHF1
ZXVlIHsKPj4gICNkZWZpbmUgVkRQQVNJTV9ORVRfRkVBVFVSRVMJKFZEUEFTSU1fRkVBVFVSRVMg
fCBcCj4+ICAJCQkJICgxVUxMIDw8IFZJUlRJT19ORVRfRl9NQUMpKQo+PitzdHJ1Y3QgdmRwYXNp
bTsKPj4rCj4+ICBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4+ICAJdTY0IHN1cHBvcnRlZF9m
ZWF0dXJlczsKPj4gIAlzaXplX3QgY29uZmlnX3NpemU7Cj4+QEAgLTY1LDYgKzY3LDcgQEAgc3Ry
dWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+PiAgCXUzMiBpZDsKPj4gIAl3b3JrX2Z1bmNfdCB3b3Jr
X2ZuOwo+PisJdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB2b2lk
ICpjb25maWcpOwo+PiAgfTsKPj4gIC8qIFN0YXRlIG9mIGVhY2ggdmRwYXNpbSBkZXZpY2UgKi8K
Pj5AQCAtNTIwLDggKzUyMyw2IEBAIHN0YXRpYyB1NjQgdmRwYXNpbV9nZXRfZmVhdHVyZXMoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+PiAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJl
cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykKPj4gIHsKPj4gIAlzdHJ1
Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+Pi0Jc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnICpjb25maWcgPQo+Pi0JCShzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKil2
ZHBhc2ltLT5jb25maWc7Cj4+ICAJLyogRE1BIG1hcHBpbmcgbXVzdCBiZSBkb25lIGJ5IGRyaXZl
ciAqLwo+PiAgCWlmICghKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRG
T1JNKSkpCj4+QEAgLTUyOSwxNSArNTMwLDYgQEAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0
dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykKPj4gIAl2ZHBhc2lt
LT5mZWF0dXJlcyA9IGZlYXR1cmVzICYgdmRwYXNpbS0+ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1
cmVzOwo+Pi0JLyogV2UgZ2VuZXJhbGx5IG9ubHkga25vdyB3aGV0aGVyIGd1ZXN0IGlzIHVzaW5n
IHRoZSBsZWdhY3kgaW50ZXJmYWNlCj4+LQkgKiBoZXJlLCBzbyBnZW5lcmFsbHkgdGhhdCdzIHRo
ZSBlYXJsaWVzdCB3ZSBjYW4gc2V0IGNvbmZpZyBmaWVsZHMuCj4+LQkgKiBOb3RlOiBXZSBhY3R1
YWxseSByZXF1aXJlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBhYm92ZSB3aGljaAo+Pi0JICog
aW1wbGllcyBWSVJUSU9fRl9WRVJTSU9OXzEsIGJ1dCBsZXQncyBub3QgdHJ5IHRvIGJlIGNsZXZl
ciBoZXJlLgo+Pi0JICovCj4+LQo+Pi0JY29uZmlnLT5tdHUgPSBjcHVfdG9fdmRwYXNpbTE2KHZk
cGFzaW0sIDE1MDApOwo+Pi0JY29uZmlnLT5zdGF0dXMgPSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFz
aW0sIFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4tCW1lbWNweShjb25maWctPm1hYywgbWFjYWRk
cl9idWYsIEVUSF9BTEVOKTsKPj4gIAlyZXR1cm4gMDsKPj4gIH0KPj5AQCAtNTkzLDggKzU4NSwx
MiBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+PiAgewo+PiAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4+LQlpZiAob2Zmc2V0ICsgbGVuIDwgdmRwYXNpbS0+
ZGV2X2F0dHIuY29uZmlnX3NpemUpCj4+LQkJbWVtY3B5KGJ1ZiwgdmRwYXNpbS0+Y29uZmlnICsg
b2Zmc2V0LCBsZW4pOwo+PisJaWYgKG9mZnNldCArIGxlbiA+IHZkcGFzaW0tPmRldl9hdHRyLmNv
bmZpZ19zaXplKQo+PisJCXJldHVybjsKPj4rCj4+Kwl2ZHBhc2ltLT5kZXZfYXR0ci5nZXRfY29u
ZmlnKHZkcGFzaW0sIHZkcGFzaW0tPmNvbmZpZyk7Cj4+Kwo+PisJbWVtY3B5KGJ1ZiwgdmRwYXNp
bS0+Y29uZmlnICsgb2Zmc2V0LCBsZW4pOwo+PiAgfQo+Cj4KPkkgd29uZGVyIGhvdyBtdWNoIHZh
bHVlIHdlIGNhbiBnZXQgZnJvbSB2ZHBhc2ltLT5jb25maWcgY29uc2lkZXIgd2UndmUgCj5hbHJl
YWR5IGhhZCBnZXRfY29uZmlnKCkgbWV0aG9kLgo+Cj5JcyBpdCBwb3NzaWJsZSB0byBjb3B5IHRv
IHRoZSBidWZmZXIgZGlyZWN0bHkgaGVyZT8KCkkgaGFkIHRob3VnaHQgb2YgZWxpbWluYXRpbmcg
aXQgdG9vLCBidXQgdGhlbiBJIHdhbnRlZCB0byBkbyBzb21ldGhpbmcgCnNpbWlsYXIgdG8gd2hh
dCB3ZSBkbyBpbiBRRU1VIChody92aXJ0aW8vdmlydGlvLmMpLCBsZWF2aW5nIGluIHRoZSAKc2lt
dWxhdG9yIGNvcmUgdGhlIGJ1ZmZlciwgdGhlIG1lbW9yeSBjb3B5IChoYW5kbGluZyBvZmZzZXQg
YW5kIGxlbiksIAphbmQgdGhlIGJvdW5kYXJ5IGNoZWNrcy4KCkluIHRoaXMgd2F5IGVhY2ggZGV2
aWNlIHNob3VsZCBzaW1wbHkgZmlsbCB0aGUgZW50aXJlIGNvbmZpZ3VyYXRpb24gYW5kIAp3ZSBj
YW4gYXZvaWQgY29kZSBkdXBsaWNhdGlvbi4KClN0b3JpbmcgdGhlIGNvbmZpZ3VyYXRpb24gaW4g
dGhlIGNvcmUgbWF5IGFsc28gYmUgdXNlZnVsIGlmIHNvbWUgZGV2aWNlIApuZWVkcyB0byBzdXBw
b3J0IGNvbmZpZyB3cml0ZXMuCgpEbyB5b3UgdGhpbmsgaXQgbWFrZXMgc2Vuc2UsIG9yIGlzIGl0
IGJldHRlciB0byBtb3ZlIGV2ZXJ5dGhpbmcgaW4gdGhlIApkZXZpY2U/CgpUaGFua3MsClN0ZWZh
bm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
