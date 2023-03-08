Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DCCC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 05:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03EE060B42;
	Wed,  8 Mar 2023 05:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03EE060B42
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=esfjNC2a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c67lMhgDYzYW; Wed,  8 Mar 2023 05:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DFC660706;
	Wed,  8 Mar 2023 05:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DFC660706
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43D70C0035;
	Wed,  8 Mar 2023 05:55:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0D73C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7925D81DAB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:55:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7925D81DAB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=esfjNC2a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZnMEQra4vDEj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:55:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 774B881B6D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 774B881B6D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678254918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNBUA11Osf8dPrWEjnpGmCx/URUmSHxgxMpdWlw7NFM=;
 b=esfjNC2aW3JsOKJKQjgoGlom9hl66+B+EJAyb67Q8gc60LrwMG/VN/U8K4BCwWuMhzRmM9
 bAfOwgOEGeZOhj95x0tuVWgxl02z1erxgtEbFP9ogPgG34Hku8/ceqTqAWVmiDiyyp/Nla
 nWo2zW1v43VHIkWC8Gp9X+7uvuYDPLs=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-YjvY0HZvP-ambSqhEup4uA-1; Wed, 08 Mar 2023 00:55:17 -0500
X-MC-Unique: YjvY0HZvP-ambSqhEup4uA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-176249fbc56so9465601fac.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 21:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678254916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNBUA11Osf8dPrWEjnpGmCx/URUmSHxgxMpdWlw7NFM=;
 b=ZJ+79kNykm9W9hGvxHs0SMLFs5xbVgW5kNWqHkBSW7fPQDZI8zJiuiQAuee2nR2CEK
 WMlSuXlCV6u+ehp4tZHGs73iOHErOR1uu6k8mCdGvPmrJWZUgrekCSw0iwlal+039SF8
 AJhBsmfJaPHyaqmV1p2kwHCB1h9zs2LbTLLiJr/uz3gpQGnSE87/i4Cvm0FPZSyNeAQM
 0wDqawjSn/Vb1DBMDI6F85xWO4HJVsJBLAO/ndXTSU609wng7OiXGhZKY/bp67wIRLoJ
 RwYnB+XVYhEs7DdrZwtkVqQHv5D+GaLmSEeDrm++63me3kS2yld46pJeJV9YFO8DKq1X
 N82A==
X-Gm-Message-State: AO0yUKUncJXKAMe6E8JS7ZgFz2U2UtAn5k+6RTAnGq1A+y9OBlNEynOk
 9zAstdtw7cA6uDADWDijXvYXlT5nEVDqAo3/GaMAI4DsFsWeePELvDd68PvaBBIipvSmwP42ZMn
 AuSiXXF54KOr73B5x+As8IwRXl4NTc4kP0IuNRY625VoFCbxrcJ6TK7zE/Q==
X-Received: by 2002:a4a:a3c9:0:b0:517:bff1:77e with SMTP id
 t9-20020a4aa3c9000000b00517bff1077emr6078393ool.1.1678254916612; 
 Tue, 07 Mar 2023 21:55:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+yZD0r87MOPzFjyP9eRW3tfkg2AdNMBMEmhO13A3eq8dgdF6K1Kem0unasq5UjQUcQbK4/YYAYuH3cqU88vlw=
X-Received: by 2002:a4a:a3c9:0:b0:517:bff1:77e with SMTP id
 t9-20020a4aa3c9000000b00517bff1077emr6078383ool.1.1678254916339; Tue, 07 Mar
 2023 21:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-3-feliu@nvidia.com>
In-Reply-To: <20230307035705.4479-3-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:55:05 +0800
Message-ID: <CACGkMEtBXNUPatmhoSvETik-zRKSyWgB_ugj-ZwccbzcEqaueg@mail.gmail.com>
Subject: Re: [PATCH 2/3] virtio_ring: Avoid using inline for small functions
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXIgNywgMjAyMyBhdCAxMTo1N+KAr0FNIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPiB3cm90ZToKPgo+IEFjY29yZGluZyB0byBrZXJuZWwgY29kaW5nIHN0eWxlIFsxXSwgZGVm
aW5pbmcgaW5saW5lIGZ1bmN0aW9ucyBpcyBub3QKPiBuZWNlc3NhcnkgYW5kIGJlbmVmaWNpYWwg
Zm9yIHNpbXBsZSBmdW5jdGlvbnMuIEhlbmNlIGNsZWFuIHVwIHRoZSBjb2RlCj4gYnkgcmVtb3Zp
bmcgdGhlIGlubGluZSBrZXl3b3JkLgo+Cj4gSXQgaXMgdmVyaWZpZWQgd2l0aCBHQ0MgMTIuMi4w
LCB0aGUgZ2VuZXJhdGVkIGNvZGUgd2l0aC93aXRob3V0IGlubGluZQo+IGlzIHNhbWUuIEFkZGl0
aW9uYWxseSB0ZXN0ZWQgd2l0aCBwa3RnZW4gYW5kIGlwZXJmLCBhbmQgdmVyaWZpZWQgdGhlCj4g
cmVzdWx0LCB0aGUgcHBzIHRlc3QgcmVzdWx0cyBhcmUgdGhlIHNhbWUgaW4gdGhlIGNhc2VzIG9m
IHdpdGgvd2l0aG91dAo+IGlubGluZS4KPgo+IElwZXJmIGFuZCBwcHMgb2YgcGt0Z2VuIGZvciB2
aXJ0aW8tbmV0IGRpZG4ndCBjaGFuZ2UgYmVmb3JlIGFuZCBhZnRlcgo+IHRoZSBjaGFuZ2UuCj4K
PiBbMV0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y2LjItcmMzL3Byb2Nlc3Mv
Y29kaW5nLXN0eWxlLmh0bWwjdGhlLWlubGluZS1kaXNlYXNlCj4KPiBTaWduZWQtb2ZmLWJ5OiBG
ZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amly
aUBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5j
b20+Cj4gUmV2aWV3ZWQtYnk6IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPiBSZXZpZXdl
ZC1ieTogQm9kb25nIFdhbmcgPGJvZG9uZ0BudmlkaWEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgMTIgKysrKysrLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRl
eCA0MTE0NGI1MjQ2YTguLjgwNmNjNDRlYWU2NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBA
IC0yMzMsNyArMjMzLDcgQEAgc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEpOwo+Cj4gICNkZWZpbmUgdG9fdnZxKF92cSkgY29udGFpbmVyX29mKF92cSwgc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZSwgdnEpCj4KPiAtc3RhdGljIGlubGluZSBib29sIHZpcnRxdWV1ZV91
c2VfaW5kaXJlY3Qoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gK3N0YXRpYyBib29sIHZp
cnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHRvdGFsX3Nn
KQo+ICB7Cj4gICAgICAgICAvKgo+IEBAIC0zNDksNyArMzQ5LDcgQEAgc3RhdGljIHZvaWQgdnJp
bmdfZnJlZV9xdWV1ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgc2l6ZV90IHNpemUsCj4g
ICAqIG1ha2luZyBhbGwgb2YgdGhlIGFyY2ggRE1BIG9wcyB3b3JrIG9uIHRoZSB2cmluZyBkZXZp
Y2UgaXRzZWxmCj4gICAqIGlzIGEgbWVzcy4KPiAgICovCj4gLXN0YXRpYyBpbmxpbmUgc3RydWN0
IGRldmljZSAqdnJpbmdfZG1hX2Rldihjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkK
PiArc3RhdGljIHN0cnVjdCBkZXZpY2UgKnZyaW5nX2RtYV9kZXYoY29uc3Qgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEpCj4gIHsKPiAgICAgICAgIHJldHVybiB2cS0+ZG1hX2RldjsKPiAgfQo+
IEBAIC03ODQsNyArNzg0LDcgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4gICAgICAgICB9Cj4gIH0K
Pgo+IC1zdGF0aWMgaW5saW5lIGJvb2wgbW9yZV91c2VkX3NwbGl0KGNvbnN0IHN0cnVjdCB2cmlu
Z192aXJ0cXVldWUgKnZxKQo+ICtzdGF0aWMgaW5saW5lIG1vcmVfdXNlZF9zcGxpdChjb25zdCBz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKClR5cG8gaGVyZSwgcy9pbmxpbmUvYm9vbC8/CgpU
aGFua3MKCj4gIHsKPiAgICAgICAgIHJldHVybiB2cS0+bGFzdF91c2VkX2lkeCAhPSB2aXJ0aW8x
Nl90b19jcHUodnEtPnZxLnZkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0
LnZyaW5nLnVzZWQtPmlkeCk7Cj4gQEAgLTExNzIsMTIgKzExNzIsMTIgQEAgc3RhdGljIGludCB2
aXJ0cXVldWVfcmVzaXplX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkKPiAg
LyoKPiAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQoKS4KPiAg
ICovCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBwYWNrZWRfdXNlZF93cmFwX2NvdW50ZXIodTE2IGxh
c3RfdXNlZF9pZHgpCj4gK3N0YXRpYyBib29sIHBhY2tlZF91c2VkX3dyYXBfY291bnRlcih1MTYg
bGFzdF91c2VkX2lkeCkKPiAgewo+ICAgICAgICAgcmV0dXJuICEhKGxhc3RfdXNlZF9pZHggJiAo
MSA8PCBWUklOR19QQUNLRURfRVZFTlRfRl9XUkFQX0NUUikpOwo+ICB9Cj4KPiAtc3RhdGljIGlu
bGluZSB1MTYgcGFja2VkX2xhc3RfdXNlZCh1MTYgbGFzdF91c2VkX2lkeCkKPiArc3RhdGljIHUx
NiBwYWNrZWRfbGFzdF91c2VkKHUxNiBsYXN0X3VzZWRfaWR4KQo+ICB7Cj4gICAgICAgICByZXR1
cm4gbGFzdF91c2VkX2lkeCAmIH4oLSgxIDw8IFZSSU5HX1BBQ0tFRF9FVkVOVF9GX1dSQVBfQ1RS
KSk7Cj4gIH0KPiBAQCAtMTYxMiw3ICsxNjEyLDcgQEAgc3RhdGljIGlubGluZSBib29sIGlzX3Vz
ZWRfZGVzY19wYWNrZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAgICAg
ICByZXR1cm4gYXZhaWwgPT0gdXNlZCAmJiB1c2VkID09IHVzZWRfd3JhcF9jb3VudGVyOwo+ICB9
Cj4KPiAtc3RhdGljIGlubGluZSBib29sIG1vcmVfdXNlZF9wYWNrZWQoY29uc3Qgc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEpCj4gK3N0YXRpYyBib29sIG1vcmVfdXNlZF9wYWNrZWQoY29uc3Qg
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gIHsKPiAgICAgICAgIHUxNiBsYXN0X3VzZWQ7
Cj4gICAgICAgICB1MTYgbGFzdF91c2VkX2lkeDsKPiAtLQo+IDIuMzQuMQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
