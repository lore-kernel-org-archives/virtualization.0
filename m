Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC4EB64DC
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 00:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18094404FF;
	Tue,  4 Jul 2023 00:18:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18094404FF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Qyq4jbbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zsMCRwY2Zoz; Tue,  4 Jul 2023 00:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3ECF404C8;
	Tue,  4 Jul 2023 00:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3ECF404C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D80E5C0072;
	Tue,  4 Jul 2023 00:18:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A7FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 483B2402A7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 483B2402A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=Qyq4jbbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p2dNpwy9vTtk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:18:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 617D0400C4
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 617D0400C4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:18:24 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-553ad54d3c6so2847046a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1688429903; x=1691021903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5o23Iu39e3OIONFSj282h74DwqacDMnB3TCrmdFJIM8=;
 b=Qyq4jbbcMmpPz5Cznk2Qkp4TqFzJoe8d7s695eDssZvcVyAD855oUv5+iU8u6fLwLX
 z90uoBJjpBDaIbdj5Y6hTqIf5+YN5MwRra8/zsqcQJ4M+AKh0e1KC46UcLhJYAsHzoFF
 pxkvPeOeHo7W/4ZIW+c45CcyvPhxgUvvY50VPOsuhmI+XNNhpydvPJXqcFDL4jdPI6An
 iJ3pr7M2QhZ4TcgcR75JFsF3t8Vah8dMXPJ8fP5yHRW6vaQ+kHOxPJXWXSUQ1eH/4mHv
 TgajaR2h+IkXbPmhmAQNumuQj0URFKaReFYDXFyZ7lXg9AHOiRqp1evHI3hQcVGrBbfT
 PXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688429903; x=1691021903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5o23Iu39e3OIONFSj282h74DwqacDMnB3TCrmdFJIM8=;
 b=bsLdjIwXJmelkdagfcjoPEwZ7YN0l+N7c+G8PANJ34PQ459HqU+j/hqpOokr8+A2NV
 OaYCtEm6BdoCk8QUs6jLekzGaQlLoVQDFzNejKnCRl52BrubZ4EKCX80AZsscpgoED2F
 nN3Hzt7pLzDFCjQCHE5WW1goplESNZfSRDs4/ErS3ukrSDCJBbVqDwgzrHaIXzE3YTjD
 9O+nBs9sUuOeTad3lsIwg4RMhelSIcaw80OuSWrnA+AZqA7Onlw1UraqYdgR4YTOTYoi
 Du9awUb6lM6ms0wjEcLdezIDCmjZ7y1l9Gd5cXT+pfTlQEHe81lapi49DHEeNAquzEnG
 E99w==
X-Gm-Message-State: ABy/qLa6rdPIC7Iwp31axZg2d4gxT/GWjh00/Bk2WMlEzA7RxmC65l+2
 1v3iyqbuhfKeLcoAQqRLuLEdkw==
X-Google-Smtp-Source: APBJJlF+wwZOEuuppIYrWhooY2UAhMT9iKvEGMeG1kAUzbvR5MEo6fFf8aQUZWSqrT/hu+nohX4ixA==
X-Received: by 2002:a05:6a20:a10b:b0:12e:641b:454a with SMTP id
 q11-20020a056a20a10b00b0012e641b454amr4752721pzk.30.1688429903455; 
 Mon, 03 Jul 2023 17:18:23 -0700 (PDT)
Received: from [10.255.136.59] ([139.177.225.236])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a170902dace00b001b893b689a0sm2741799plx.84.2023.07.03.17.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 17:18:22 -0700 (PDT)
Message-ID: <7a8f7a66-f454-a4af-b42e-29c2aab6d3a4@bytedance.com>
Date: Tue, 4 Jul 2023 08:18:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: PING Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
 <20230509233907-mutt-send-email-mst@kernel.org>
 <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
 <20230510000603-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20230510000603-mutt-send-email-mst@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgTWljaGFlbCwKClRoaXMgc2VlbXMgdG8gYmUgaWdub3JlZC4uLgoKT24gNS8xMC8yMyAxMjow
NiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0IDEy
OjA0OjUwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIFdlZCwgTWF5IDEwLCAyMDIz
IGF0IDExOjQ04oCvQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4+Pgo+Pj4gT24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTE6MjY6NTRBTSArMDgwMCwgWHVhbiBa
aHVvIHdyb3RlOgo+Pj4+IE9uIFdlZCwgMTAgTWF5IDIwMjMgMTA6NTQ6MzcgKzA4MDAsIHpoZW53
ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPiB3cm90ZToKPj4+Pj4gQm90aCBzcGxpdCBy
aW5nIGFuZCBwYWNrZWQgcmluZyB1c2UgMzJiaXRzIHRvIGRlc2NyaWJlIHRoZSBsZW5ndGggb2YK
Pj4+Pj4gYSBkZXNjcmlwdG9yOiBzZWUgc3RydWN0IHZyaW5nX2Rlc2MgYW5kIHN0cnVjdCB2cmlu
Z19wYWNrZWRfZGVzYy4KPj4+Pj4gVGhpcyBtZWFucyB0aGUgbWF4IHNlZ21lbnQgc2l6ZSBzdXBw
b3J0ZWQgYnkgdmlydGlvIGlzIFUzMl9NQVguCj4+Pj4+Cj4+Pj4+IEFuIGV4YW1wbGUgb2Ygdmly
dGlvX21heF9kbWFfc2l6ZSBpbiB2aXJ0aW9fYmxrLmM6Cj4+Pj4+ICAgIHUzMiB2LCBtYXhfc2l6
ZTsKPj4+Pj4KPj4+Pj4gICAgbWF4X3NpemUgPSB2aXJ0aW9fbWF4X2RtYV9zaXplKHZkZXYpOyAg
LT4gaW1wbGljaXQgY29udmVydAo+Pj4+PiAgICBlcnIgPSB2aXJ0aW9fY3JlYWRfZmVhdHVyZSh2
ZGV2LCBWSVJUSU9fQkxLX0ZfU0laRV9NQVgsCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZywgc2l6ZV9tYXgsICZ2KTsKPj4+Pj4gICAg
bWF4X3NpemUgPSBtaW4obWF4X3NpemUsIHYpOwo+Pj4+Pgo+Pj4+PiBUaGVyZSBpcyBhIHJpc2sg
ZHVyaW5nIGltcGxpY2l0IGNvbnZlcnQgaGVyZSwgb25jZSB2aXJ0aW9fbWF4X2RtYV9zaXplCj4+
Pj4+IHJldHVybnMgNEcsIG1heF9zaXplIGJlY29tZXMgMC4KPj4+Pj4KPj4+Pj4gRml4ZXM6IGU2
ZDZkZDZjODc1ZSAoInZpcnRpbzogSW50cm9kdWNlIHZpcnRpb19tYXhfZG1hX3NpemUoKSIpCj4+
Pj4+IENjOiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KPj4+Pj4gU2lnbmVkLW9mZi1i
eTogemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAg
IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMiArKysrKysrKy0tLS0KPj4+Pj4gICBp
bmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDIgKy0KPj4+Pj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4+Pj4+IGluZGV4IGM1MzEwZWFmOGI0Ni4uNTVjZmVjZjAzMGExIDEwMDY0NAo+Pj4+
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+Pj4gQEAgLTI4OSwxMiArMjg5LDE2IEBAIHN0YXRpYyBi
b29sIHZyaW5nX3VzZV9kbWFfYXBpKGNvbnN0IHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
Pj4+PiAgICAgIHJldHVybiBmYWxzZTsKPj4+Pj4gICB9Cj4+Pj4+Cj4+Pj4+IC1zaXplX3Qgdmly
dGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+Pj4g
K3UzMiB2aXJ0aW9fbWF4X2RtYV9zaXplKGNvbnN0IHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+Pj4+Cj4+Pj4KPj4+PiBMR1RNCj4+Pj4KPj4+PiBCdXQsIHNob3VsZCB3ZSBjaGFuZ2UgdGhl
IHBhcmFtZXRlciB0byB2cSwgdGhlbiB1c2UgdGhlIGRtYV9kZXY/Cj4+Pj4KPj4+PiBASmFzb24K
Pj4+Pgo+Pj4+IFRoYW5rcy4KPj4+Pgo+Pj4KPj4+Cj4+PiB0aGF0IHdvdWxkIGJlIGFuIHVucmVs
YXRlZCByZXdvcmsuCj4+Cj4+IFByb2JhYmx5LCBidXQgSSB0aGluayBpdCdzIGJldHRlciB0byBi
ZSBkb25lIG9uIHRvcCBvdGhlcndpc2Ugd2UgbWF5IGZvcmdldC4KPj4KPj4gVGhhbmtzCj4gCj4g
SnVzdCB0byBtYWtlIHRoaW5ncyBjbGVhciBJJ20gbWVyZ2luZyBmaXhlcyBmb3IgdGhpcwo+IHJl
bGVhc2UgYnV0IGNsZWFudXBzIGJlbG9uZyBpbiB0aGUgbmV4dCBvbmUuCj4gCj4+Pgo+Pj4+PiAg
IHsKPj4+Pj4gLSAgIHNpemVfdCBtYXhfc2VnbWVudF9zaXplID0gU0laRV9NQVg7Cj4+Pj4+ICsg
ICB1MzIgbWF4X3NlZ21lbnRfc2l6ZSA9IFUzMl9NQVg7Cj4+Pj4+Cj4+Pj4+IC0gICBpZiAodnJp
bmdfdXNlX2RtYV9hcGkodmRldikpCj4+Pj4+IC0gICAgICAgICAgIG1heF9zZWdtZW50X3NpemUg
PSBkbWFfbWF4X21hcHBpbmdfc2l6ZSh2ZGV2LT5kZXYucGFyZW50KTsKPj4+Pj4gKyAgIGlmICh2
cmluZ191c2VfZG1hX2FwaSh2ZGV2KSkgewo+Pj4+PiArICAgICAgICAgICBzaXplX3QgbWF4X2Rt
YV9zaXplID0gZG1hX21heF9tYXBwaW5nX3NpemUodmRldi0+ZGV2LnBhcmVudCk7Cj4+Pj4+ICsK
Pj4+Pj4gKyAgICAgICAgICAgaWYgKG1heF9kbWFfc2l6ZSA8IG1heF9zZWdtZW50X3NpemUpCj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgbWF4X3NlZ21lbnRfc2l6ZSA9IG1heF9kbWFfc2l6ZTsK
Pj4+Pj4gKyAgIH0KPj4+Pj4KPj4+Pj4gICAgICByZXR1cm4gbWF4X3NlZ21lbnRfc2l6ZTsKPj4+
Pj4gICB9Cj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVk
ZS9saW51eC92aXJ0aW8uaAo+Pj4+PiBpbmRleCBiOTMyMzhkYjk0ZTMuLjFhNjA1ZjQwODMyOSAx
MDA2NDQKPj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+Pj4+PiArKysgYi9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oCj4+Pj4+IEBAIC0xNDcsNyArMTQ3LDcgQEAgaW50IHZpcnRpb19k
ZXZpY2VfcmVzdG9yZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4+Pj4gICAjZW5kaWYK
Pj4+Pj4gICB2b2lkIHZpcnRpb19yZXNldF9kZXZpY2Uoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRl
dik7Cj4+Pj4+Cj4+Pj4+IC1zaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldik7Cj4+Pj4+ICt1MzIgdmlydGlvX21heF9kbWFfc2l6ZShjb25z
dCBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4+Pj4+Cj4+Pj4+ICAgI2RlZmluZSB2aXJ0
aW9fZGV2aWNlX2Zvcl9lYWNoX3ZxKHZkZXYsIHZxKSBcCj4+Pj4+ICAgICAgbGlzdF9mb3JfZWFj
aF9lbnRyeSh2cSwgJnZkZXYtPnZxcywgbGlzdCkKPj4+Pj4gLS0KPj4+Pj4gMi4yMC4xCj4+Pj4+
Cj4+Pgo+IAoKLS0gCnpoZW53ZWkgcGkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
