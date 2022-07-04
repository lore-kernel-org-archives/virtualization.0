Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46806C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 04:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D854A8138B;
	Mon,  4 Jul 2022 04:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D854A8138B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ctf7ihZS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TmUdDYM4XpHp; Mon,  4 Jul 2022 04:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67C2281367;
	Mon,  4 Jul 2022 04:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67C2281367
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 314E1C0032;
	Mon,  4 Jul 2022 04:44:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B86CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3304640121
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3304640121
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ctf7ihZS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id drwzGZojkbs8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:43:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F00FC40114
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F00FC40114
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656909834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7iwf0AkIgxRzHQgP0FEutfReQrr2UT7CGP9VnI7Q4k=;
 b=Ctf7ihZSLQdgvVoXF839MS/AKgV7j8CPCF7qIZf2FGiZawiAh0pbWk9gnwwCgLRJlwZe3p
 oY77kb0EtViAVjwzICiesJhuMGiAejzQJAyAHBBx7wX/Qx0cMzoegSfMGP6idF2p9qkmb6
 HrhhG9Pt6CLLdB14p8zPwPxbV2vDSf4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-G56S_La_OvGAy2K0Yo7Yxw-1; Mon, 04 Jul 2022 00:43:52 -0400
X-MC-Unique: G56S_La_OvGAy2K0Yo7Yxw-1
Received: by mail-pj1-f70.google.com with SMTP id
 i15-20020a17090a2a0f00b001ef826b921dso1767142pjd.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 21:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=i7iwf0AkIgxRzHQgP0FEutfReQrr2UT7CGP9VnI7Q4k=;
 b=jmu88vnjObUhFtPMuxF0/UbuTdNbmDIH0EzwxNxQmfs5H72ZcMRqk9RbuA8hthAn8E
 wAogkC1Sq1tXPJd1EgiFeA09Q+aH44RbmdDDUMFbnlxBU/3cxtGy2rJv4Tzs1H9hIncF
 +c+1uEiq2pCpW+tav1fWlD+d1vHZhc9j64r53+kcEHSLHSvt4grbU+LP4Bx+Sp0K3nXW
 lKvhOhAoBMskNYfr1W1T3zdg1Hwjf3J3r7itHt+fCTAZWIPwkAFrbAiVmVa4nVtkFKq4
 V7uKdcdicXyfJwhI5Ui4pty/9l1wImchWm/CesaHuCOXvF6GDOIFV5xCKY8IF6mRIlQ4
 Loqg==
X-Gm-Message-State: AJIora/7+DDeubUY6wSzjv/Pwd8jMhQNQ730auIKT9A8Y4k5M7tlI0tI
 OP76vJ/Xj8VfQMaI/FbcwHn0eTl3Hz+BPnN04ZbXK/YAJIzlGY3ew1wqUcpggiDffQHw6zVKKKw
 2bVV0xwdrEGNme/xyS3TI8hYr86xuTEPTSe4iXzrWFg==
X-Received: by 2002:a62:1606:0:b0:525:2679:f9d0 with SMTP id
 6-20020a621606000000b005252679f9d0mr35334631pfw.65.1656909831198; 
 Sun, 03 Jul 2022 21:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vd5ABgEadTDyD7ArHJ2WciogVXo3weq1+LT6uq0isirV16fZ5AZFT11uG+GvRGAq8yT91fQQ==
X-Received: by 2002:a62:1606:0:b0:525:2679:f9d0 with SMTP id
 6-20020a621606000000b005252679f9d0mr35334613pfw.65.1656909830941; 
 Sun, 03 Jul 2022 21:43:50 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a1709028c8200b0016a3248376esm19724732plo.181.2022.07.03.21.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 21:43:50 -0700 (PDT)
Message-ID: <c602c6c3-b38a-9543-2bb5-03be7d99fef3@redhat.com>
Date: Mon, 4 Jul 2022 12:43:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V3 2/6] vDPA/ifcvf: support userspace to query features
 and MQ of a management device
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220701132826.8132-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, xieyongji@bytedance.com, gautam.dawar@amd.com,
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

CuWcqCAyMDIyLzcvMSAyMToyOCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBBZGFwdGluZyB0byBj
dXJyZW50IG5ldGxpbmsgaW50ZXJmYWNlcywgdGhpcyBjb21taXQgYWxsb3dzIHVzZXJzcGFjZQo+
IHRvIHF1ZXJ5IGZlYXR1cmUgYml0cyBhbmQgTVEgY2FwYWJpbGl0eSBvZiBhIG1hbmFnZW1lbnQg
ZGV2aWNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDEyICsr
KysrKysrKysrKwo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8ICAxICsKPiAg
IGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAgMyArKysKPiAgIDMgZmlsZXMgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gaW5kZXgg
ZmI5NTdiNTc5NDFlLi43YzVmMWNjOTNhZDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX2Jhc2UuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMK
PiBAQCAtMzQ2LDYgKzM0NiwxOCBAQCBpbnQgaWZjdmZfc2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2
Zl9odyAqaHcsIHUxNiBxaWQsIHUxNiBudW0pCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAr
dTE2IGlmY3ZmX2dldF9tYXhfdnFfcGFpcnMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiArewo+ICsJ
c3RydWN0IHZpcnRpb19uZXRfY29uZmlnIF9faW9tZW0gKmNvbmZpZzsKPiArCXUxNiB2YWwsIG1x
Owo+ICsKPiArCWNvbmZpZyA9IGh3LT5kZXZfY2ZnOwo+ICsJdmFsID0gdnBfaW9yZWFkMTYoKF9f
bGUxNiBfX2lvbWVtICopJmNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9wYWlycyk7Cj4gKwltcSA9IGxl
MTZfdG9fY3B1KChfX2ZvcmNlIF9fbGUxNil2YWwpOwo+ICsKPiArCXJldHVybiBtcTsKPiArfQo+
ICsKPiAgIHN0YXRpYyBpbnQgaWZjdmZfaHdfZW5hYmxlKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4g
ICB7Cj4gICAJc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpjZmc7Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggZjU1NjNmNjY1Y2M2Li5kNTRhMWJlZDIxMmUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtMTMwLDYgKzEzMCw3IEBAIHU2NCBpZmN2
Zl9nZXRfaHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4gICBpbnQgaWZjdmZfdmVy
aWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1NjQgZmVhdHVyZXMpOwo+ICAg
dTE2IGlmY3ZmX2dldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKTsKPiAg
IGludCBpZmN2Zl9zZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTE2
IG51bSk7Cj4gK3UxNiBpZmN2Zl9nZXRfbWF4X3ZxX3BhaXJzKHN0cnVjdCBpZmN2Zl9odyAqaHcp
Owo+ICAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKnZmX3RvX2FkYXB0ZXIoc3RydWN0IGlmY3ZmX2h3
ICpodyk7Cj4gICBpbnQgaWZjdmZfcHJvYmVkX3ZpcnRpb19uZXQoc3RydWN0IGlmY3ZmX2h3ICpo
dyk7Cj4gICB1MzIgaWZjdmZfZ2V0X2NvbmZpZ19zaXplKHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDBhNTY3MDcyOTQxMi4uM2ZmNzA5NmQzMGYx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTc5MSw2ICs3OTEsOSBAQCBzdGF0
aWMgaW50IGlmY3ZmX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29u
c3QgY2hhciAqbmFtZSwKPiAgIAl2Zi0+aHdfZmVhdHVyZXMgPSBpZmN2Zl9nZXRfaHdfZmVhdHVy
ZXModmYpOwo+ICAgCXZmLT5jb25maWdfc2l6ZSA9IGlmY3ZmX2dldF9jb25maWdfc2l6ZSh2Zik7
Cj4gICAKPiArCWlmY3ZmX21nbXRfZGV2LT5tZGV2Lm1heF9zdXBwb3J0ZWRfdnFzID0gaWZjdmZf
Z2V0X21heF92cV9wYWlycyh2Zik7CgoKRG8gd2Ugd2FudCAjcXBzIG9yICNxdWV1ZXM/CgpGWUks
IHZwX3ZkcGEgZGlkOgoKZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jOiBtZ3RkZXYt
Pm1heF9zdXBwb3J0ZWRfdnFzID0gCnZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsKClRo
YW5rcwoKCj4gKwlpZmN2Zl9tZ210X2Rldi0+bWRldi5zdXBwb3J0ZWRfZmVhdHVyZXMgPSB2Zi0+
aHdfZmVhdHVyZXM7Cj4gKwo+ICAgCWFkYXB0ZXItPnZkcGEubWRldiA9ICZpZmN2Zl9tZ210X2Rl
di0+bWRldjsKPiAgIAlyZXQgPSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJmFkYXB0ZXItPnZkcGEs
IHZmLT5ucl92cmluZyk7Cj4gICAJaWYgKHJldCkgewoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
