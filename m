Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B99BE81810
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 03:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A40A882239;
	Tue, 26 Sep 2023 03:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A40A882239
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fz5KTfPw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8nBFHJg6hW1O; Tue, 26 Sep 2023 03:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B52782237;
	Tue, 26 Sep 2023 03:11:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B52782237
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA43C0039;
	Tue, 26 Sep 2023 03:11:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0712C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85B0341DE7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85B0341DE7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fz5KTfPw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMM62i-q_Dtb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:11:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07EB341DE6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07EB341DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695697902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBsDTuplom88hCQIlxCCgcKGJXWlSC24YB3TjkgTh+4=;
 b=Fz5KTfPwwf+DM1nhbwUvTDN6Lp+0p51TdVnZWN80C+b+A+gyv9589nIGH0HfSTXfKqIAph
 I5HhTDuUHG+qv1+wgH/iHVBSpL3uBEh+EKINSNV0/zlO/QigE+RSU65nf/Q2F7RBPgUeCT
 LF27RD/u9ZBt/UgorUofEAaN4fr1qxg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-L1_6S4BOP-O2tCkK5UO6gQ-1; Mon, 25 Sep 2023 23:11:41 -0400
X-MC-Unique: L1_6S4BOP-O2tCkK5UO6gQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-502fff967ccso10551557e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 20:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695697899; x=1696302699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBsDTuplom88hCQIlxCCgcKGJXWlSC24YB3TjkgTh+4=;
 b=KNKrIRDGKb+HEPmY1lZ9BRAeqxzigyPnaBqRyu8Xju6NI4173NH94GWM3xLLodYOdJ
 bGiLWEBFcBiylzi01IyqWU0gxBTxl2lZESj9gZULkUojXgNfUNzb1izQY+9KWRuXzBHE
 qrGi1zQ4wV3oXwxGBY/UPPYW9X+b0nMM+1GyxVCQtZz3HCG1ZILb31jZhz7VcaM0TlvL
 QI9BIU8YmSmyByfBB3yZweb5Wlr4Nv1JtN4Xe9ZJ3ryyCAG8VcjOKIYuXr7fGgHst4Bg
 te+HZgmFvDUEHM+NaNVcc+V6fIGdsKjXJZRd0+CsyYg+vyz+5EzYRY+NMvbLX8XPFU8e
 RlKg==
X-Gm-Message-State: AOJu0Yy5FYTeZ9iNZR3PmktQlQ/QtsJLnVHVQjW8h/x0BGM49XWzOPx1
 97Cau1UB5HFWvcSqdOXOsCQM5TTvDTFuH0RWPPMjMKMvZKxQlidgHt0tFjdz1/zqTvRLdSXZ5Gh
 LsMQ+0IvzXeqyAWxUtnQsOkGVtxsnXqx3KY7pEwJQCUPaXaz4Ek+rVl0wqA==
X-Received: by 2002:a05:6512:3e05:b0:504:2730:40cc with SMTP id
 i5-20020a0565123e0500b00504273040ccmr8911196lfv.49.1695697899490; 
 Mon, 25 Sep 2023 20:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGBQbSSgxiCAy9e7onyFmLeQjkVxkYaQmAu8X+NVidEWYPOjlAADezTJxFA+1jgzt9fmsEBXQrsZci7djKN2A=
X-Received: by 2002:a05:6512:3e05:b0:504:2730:40cc with SMTP id
 i5-20020a0565123e0500b00504273040ccmr8911175lfv.49.1695697899185; Mon, 25 Sep
 2023 20:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-5-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-5-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 11:11:28 +0800
Message-ID: <CACGkMEsbCwBuES7G+Gam4gpLEbJJZinp8ZhAQkLLBrtLMBbbxQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] vdpa/mlx5: Create helper function for dma mappings
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgOTowMuKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IE5lY2Vzc2FyeSBmb3IgdXBjb21pbmcgY3ZxIHNlcGFy
YXRpb24gZnJvbSBtciBhbGxvY2F0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVs
ZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4
NV92ZHBhLmggfCAxICsKPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8IDUg
KysrKysKPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8IDQgKystLQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBh
L21seDUvY29yZS9tbHg1X3ZkcGEuaAo+IGluZGV4IGNhNTYyNDI5NzJiMy4uMzc0OGYwMjdjZmU5
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gQEAgLTEyMCw2ICsxMjAsNyBA
QCBpbnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgaW50IGFzaWQpOwo+ICB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldik7Cj4gIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKPiAraW50IG1seDVfdmRw
YV9jcmVhdGVfZG1hX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldik7Cj4KPiAgI2RlZmlu
ZSBtbHg1X3ZkcGFfd2FybihfX2RldiwgZm9ybWF0LCAuLi4pICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgZGV2X3dhcm4o
KF9fZGV2KS0+bWRldi0+ZGV2aWNlLCAiJXM6JWQ6KHBpZCAlZCkgd2FybmluZzogIiBmb3JtYXQs
IF9fZnVuY19fLCBfX0xJTkVfXywgICAgIFwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gaW5kZXggNWExOTcx
ZmNkODdiLi43YmQwODgzYjhiMjUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tci5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gQEAgLTYxOSwzICs2
MTksOCBAQCBpbnQgbWx4NV92ZHBhX2hhbmRsZV9zZXRfbWFwKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppbwo+Cj4gICAgICAgICByZXR1cm4gZXJyOwo+
ICB9Cj4gKwo+ICtpbnQgbWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2KQo+ICt7Cj4gKyAgICAgICByZXR1cm4gbWx4NV92ZHBhX2NyZWF0ZV9tcihtdmRl
diwgTlVMTCwgMCk7Cj4gK30KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXggMzdi
ZTk0NWEwMjMwLi5kMzRjMTliNGUxMzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4gQEAgLTI4MzYsNyArMjgzNiw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldikKPiAgICAgICAgICsrbXZkZXYtPmdlbmVyYXRpb247Cj4KPiAg
ICAgICAgIGlmIChNTFg1X0NBUF9HRU4obXZkZXYtPm1kZXYsIHVtZW1fdWlkXzApKSB7Cj4gLSAg
ICAgICAgICAgICAgIGlmIChtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBOVUxMLCAwKSkKPiAr
ICAgICAgICAgICAgICAgaWYgKG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKG12ZGV2KSkKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBtbHg1X3ZkcGFfd2FybihtdmRldiwgImNyZWF0ZSBNUiBmYWls
ZWRcbiIpOwo+ICAgICAgICAgfQo+ICAgICAgICAgdXBfd3JpdGUoJm5kZXYtPnJlc2xvY2spOwo+
IEBAIC0zNDQxLDcgKzM0NDEsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVj
dCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAgICAgICAgICAg
ICAgIGdvdG8gZXJyX21wZnM7Cj4KPiAgICAgICAgIGlmIChNTFg1X0NBUF9HRU4obXZkZXYtPm1k
ZXYsIHVtZW1fdWlkXzApKSB7Cj4gLSAgICAgICAgICAgICAgIGVyciA9IG1seDVfdmRwYV9jcmVh
dGVfbXIobXZkZXYsIE5VTEwsIDApOwo+ICsgICAgICAgICAgICAgICBlcnIgPSBtbHg1X3ZkcGFf
Y3JlYXRlX2RtYV9tcihtdmRldik7Cj4gICAgICAgICAgICAgICAgIGlmIChlcnIpCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBlcnJfcmVzOwo+ICAgICAgICAgfQo+IC0tCj4gMi40MS4w
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
