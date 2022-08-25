Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B71FC6498F
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 07:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4BDA40C15;
	Thu, 25 Aug 2022 07:03:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4BDA40C15
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RflCKUJJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VRCrfvnpO1aw; Thu, 25 Aug 2022 07:03:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5445740C0F;
	Thu, 25 Aug 2022 07:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5445740C0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FE0C0033;
	Thu, 25 Aug 2022 07:03:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0E57C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6568840C0F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6568840C0F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5XcuXWW6HwLh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A077A40C11
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A077A40C11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661411032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ffg639fyFav+yTERy7xieKmvjhwhKltTl/7JA3fe1o=;
 b=RflCKUJJm0slv4OFe1zBDy73bvHnU2M/hu/LdhYrGfQHfhmdcZOnDTEnfAZErkKUU4Qm5A
 nnCFIrxvtiOO13eW97accZNk7mn40ceFWYwmsEGhDEi5zvuc4EbzDeFLanZTayLZSazPOf
 8hwSnQ6FZ0X9pUZoMMIXKH61Uuzw4bQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-kLWf2MaCO3SNiXXl1D67fA-1; Thu, 25 Aug 2022 03:03:50 -0400
X-MC-Unique: kLWf2MaCO3SNiXXl1D67fA-1
Received: by mail-pj1-f72.google.com with SMTP id
 a16-20020a17090abe1000b001fad8c29b0bso2428601pjs.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 00:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=+Ffg639fyFav+yTERy7xieKmvjhwhKltTl/7JA3fe1o=;
 b=0VUzpcXDeF/FYhZjMtOn1LJ2+bCONZe6KRrpXj7qGAMXQfVMKmhuA8dUnwyZO/coe5
 1OKfoM0gQAldy1euylIb42HEcX33mhY+UBWQFFYBBb+YYYdnj8hj5RfltuWdNfDP0C9x
 TCHfpYvwOd47fj4FZYw4kCcGS32JkTvUEyRv+cQ8jSj8DIMbMM9sztIdRbpjgkEF4jjI
 p+b8uG7jyWJ5hrzRSMXQ45aDPbsh9hWZrqgBDYpvSEJkNXaNqku/ROylFT2ieqJWw8dc
 BeiW6ONJsPteG9taM5IZxz0coWA5JOz9wdLhoR1wV1EjMgaTPVJ0LHdOfb+GFHXYTPcu
 7ZPQ==
X-Gm-Message-State: ACgBeo2Yzkr+NGkOhFBc3VFKJ/EmCW7hAL8rSZHicpLJUoe7tWHutPiJ
 gZyp8PWAS4rD8WIZacHvTRrABOqB48B6ug18ux3tgR+mtcQTw8PuKssmMQ6zb5JbJX5iOulq0Px
 qUL9o9tGZkZlXLbmQLjI3UZHdeXhRm+FAra9Shf8HpQ==
X-Received: by 2002:a17:903:120c:b0:170:aa42:dbba with SMTP id
 l12-20020a170903120c00b00170aa42dbbamr2638235plh.67.1661411029964; 
 Thu, 25 Aug 2022 00:03:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71A9+1ssM8l0gU1/rJujbzZ0dEmhpSI0OZl7bEsrI1ruifEdYAsxDq2H0vI9SqQdgeiSLCKg==
X-Received: by 2002:a17:903:120c:b0:170:aa42:dbba with SMTP id
 l12-20020a170903120c00b00170aa42dbbamr2638212plh.67.1661411029695; 
 Thu, 25 Aug 2022 00:03:49 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a170902e38b00b001726ea1b716sm559783ple.237.2022.08.25.00.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:03:49 -0700 (PDT)
Message-ID: <06761c62-93b4-8eaa-370f-f26b7c5306ca@redhat.com>
Date: Thu, 25 Aug 2022 15:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v2 2/7] vhost_test: batch used buffer
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-3-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817135718.2553-3-qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzgvMTcgMjE6NTcsIEd1byBaaGkg5YaZ6YGTOgo+IE9ubHkgYWRkIHRvIHVzZWQg
cmluZyB3aGVuIGEgYmF0Y2ggb2YgYnVmZmVyIGhhdmUgYWxsIGJlZW4gdXNlZC4gIEFuZCBpZgo+
IGluIG9yZGVyIGZlYXR1cmUgbmVnb3RpYXRlZCwgb25seSBhZGQgdGhlIGxhc3QgdXNlZCBkZXNj
cmlwdG9yIGZvciBhCj4gYmF0Y2ggb2YgYnVmZmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogR3VvIFpo
aSA8cXR4dW5pbmcxOTk5QHNqdHUuZWR1LmNuPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC90ZXN0
LmMgfCA4ICsrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC90ZXN0LmMgYi9kcml2ZXJz
L3Zob3N0L3Rlc3QuYwo+IGluZGV4IGJjOGU3ZmIxZTYzNS4uNTdjZGIzYTNlZGY2IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmhvc3QvdGVzdC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC90ZXN0LmMK
PiBAQCAtNDMsNiArNDMsOSBAQCBzdHJ1Y3Qgdmhvc3RfdGVzdCB7Cj4gICBzdGF0aWMgdm9pZCBo
YW5kbGVfdnEoc3RydWN0IHZob3N0X3Rlc3QgKm4pCj4gICB7Cj4gICAJc3RydWN0IHZob3N0X3Zp
cnRxdWV1ZSAqdnEgPSAmbi0+dnFzW1ZIT1NUX1RFU1RfVlFdOwo+ICsJc3RydWN0IHZyaW5nX3Vz
ZWRfZWxlbSAqaGVhZHMgPSBrbWFsbG9jKHNpemVvZigqaGVhZHMpCj4gKwkJCSogdnEtPm51bSwg
R0ZQX0tFUk5FTCk7CgoKVGhvdWdoIGl0J3MgYSB0ZXN0IGRldmljZSwgaXQgd291bGQgYmUgYmV0
dGVyIHRvIHRyeSBhdm9pZCBtZW1vcnkgCmFsbG9jYXRpb24gaW4gdGhlIGRhdGFwYXRoLgoKQW5k
IHdoZXJlIGlzIGlzIGZyZWVkPwoKVGhhbmtzCgoKPiArCWludCBiYXRjaF9pZHggPSAwOwo+ICAg
CXVuc2lnbmVkIG91dCwgaW47Cj4gICAJaW50IGhlYWQ7Cj4gICAJc2l6ZV90IGxlbiwgdG90YWxf
bGVuID0gMDsKPiBAQCAtODQsMTEgKzg3LDE0IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV92cShzdHJ1
Y3Qgdmhvc3RfdGVzdCAqbikKPiAgIAkJCXZxX2Vycih2cSwgIlVuZXhwZWN0ZWQgMCBsZW4gZm9y
IFRYXG4iKTsKPiAgIAkJCWJyZWFrOwo+ICAgCQl9Cj4gLQkJdmhvc3RfYWRkX3VzZWRfYW5kX3Np
Z25hbCgmbi0+ZGV2LCB2cSwgaGVhZCwgMCk7Cj4gKwkJaGVhZHNbYmF0Y2hfaWR4XS5pZCA9IGNw
dV90b192aG9zdDMyKHZxLCBoZWFkKTsKPiArCQloZWFkc1tiYXRjaF9pZHgrK10ubGVuID0gY3B1
X3RvX3Zob3N0MzIodnEsIGxlbik7Cj4gICAJCXRvdGFsX2xlbiArPSBsZW47Cj4gICAJCWlmICh1
bmxpa2VseSh2aG9zdF9leGNlZWRzX3dlaWdodCh2cSwgMCwgdG90YWxfbGVuKSkpCj4gICAJCQli
cmVhazsKPiAgIAl9Cj4gKwlpZiAoYmF0Y2hfaWR4KQo+ICsJCXZob3N0X2FkZF91c2VkX2FuZF9z
aWduYWxfbigmbi0+ZGV2LCB2cSwgaGVhZHMsIGJhdGNoX2lkeCk7Cj4gICAKPiAgIAltdXRleF91
bmxvY2soJnZxLT5tdXRleCk7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
