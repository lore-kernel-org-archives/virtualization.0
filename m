Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878E2CDB465
	for <virtualization@archiver.kernel.org>; Sat, 14 Oct 2023 15:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E403D60C09;
	Sat, 14 Oct 2023 15:49:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E403D60C09
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CgV+iaRf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32t8ue6_zJpd; Sat, 14 Oct 2023 15:49:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2067A60AF6;
	Sat, 14 Oct 2023 15:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2067A60AF6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01334C0071;
	Sat, 14 Oct 2023 15:49:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93140C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Oct 2023 15:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D4B6404C3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Oct 2023 15:49:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D4B6404C3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=CgV+iaRf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDjdpnqGPzyS
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Oct 2023 15:49:48 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C69A7400FB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Oct 2023 15:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C69A7400FB
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbee70so5230527a12.2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Oct 2023 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1697298586; x=1697903386;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRaP3B8APc0QjJRRLVqcvono0/aZBTuKQ1vWSapHFgk=;
 b=CgV+iaRfzm753vYpN/M0I6EWscux9dOcH3ltfRwaHvJFupa8Hi26cA9kwuG4mGOCM0
 nddjfK9EmlOeoBaAddWURjZqOzblRlgeqa/eVyoyAClPmTXcrWLHxcPWZdVr6y89MfoP
 IZZmgfoQXmCgxZT/RP95tBUlnszYSoUGJev8ZA2cQs9sDPr4NnnznSAyC9n4YoS+jZVQ
 k0rWKs+cR+/uvXiASwiR82Bdua7E0gLwfsiSqQw8rlFYq2C1/qIkAd2eYJw0zLzFtfEI
 aOylwN1Bl1YFPDt+59mu6vdB1TnLshXwlZRgjxCZGLU/RZBBevx0e5BxGiCqDn7bwV5T
 ew5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697298586; x=1697903386;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dRaP3B8APc0QjJRRLVqcvono0/aZBTuKQ1vWSapHFgk=;
 b=hsBmQaToddUhRjPNPuxBqjlGEDsWDde2GNI9584bNqpy1qrCRy/hbn7GpSqqfYrqas
 FvNwG+hgG2i1GY+z7m71qemldYjZT7XaKT60ipwlIai+4pYKf46SB69etEvFbg5HuKDC
 nKzMccHGaEpZV2h0aP0d9fkMgqdRJLh+mQJjZrcxjdyOjETuRJeM6LnHGgyrCDOcCbCj
 0truzsthlcjJuuedFBdPqLZ3ehNQXd9QZS30vALHo4yRd2B/h4xiEHUai2wX/ZylPZ1a
 GGvmzAi2DohHjkck4nhyH0z+HNe5oFxgIDMj56qzaoIfn8gkBd4f+UALwPakZqQudwUT
 kUHg==
X-Gm-Message-State: AOJu0Ywa/uaSksXjekc/ZfU66ShLDvXErV7GxqN8n/hYpuVAMw7mOd/3
 gZSPprKBqpihTO8z5GkX88bJRg==
X-Google-Smtp-Source: AGHT+IHOPLIM5HFm5fcWPLjz5lPglOLQqXJt1+y7SX0ijIjWPGhqc2RNXci34nt+pri9vzCQwWrx8A==
X-Received: by 2002:a05:6402:1859:b0:530:74ed:fc8a with SMTP id
 v25-20020a056402185900b0053074edfc8amr25516936edy.41.1697298585500; 
 Sat, 14 Oct 2023 08:49:45 -0700 (PDT)
Received: from cloudflare.com (79.184.153.26.ipv4.supernova.orange.pl.
 [79.184.153.26]) by smtp.gmail.com with ESMTPSA id
 dm9-20020a05640222c900b0053db1ca293asm5240698edb.19.2023.10.14.08.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 08:49:44 -0700 (PDT)
References: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
 <20230929-jakub-os-90-trim-v1-2-a3af0c08f812@cloudflare.com>
 <CACGkMEsFYJ7VsyLua2BuCbCCrntkrJ4eUrCUrojCrirRpNT4Aw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Support multiple interrupts per device
Date: Sat, 14 Oct 2023 12:49:38 +0200
In-reply-to: <CACGkMEsFYJ7VsyLua2BuCbCCrntkrJ4eUrCUrojCrirRpNT4Aw@mail.gmail.com>
Message-ID: <87o7h1dx0n.fsf@cloudflare.com>
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kernel-team@cloudflare.com,
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
From: Jakub Sitnicki via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

U29ycnkgZm9yIHRoZSBkZWxheSBpbiBteSByZXNwb25zZS4gSSd2ZSBiZWVuIGF3YXkgYXQgYSBj
b25mZXJlbmNlLgoKT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMDI6NTIgUE0gKzA4LCBKYXNvbiBX
YW5nIHdyb3RlOgo+IE9uIFNhdCwgU2VwIDMwLCAyMDIzIGF0IDQ6NDbigK9BTSBKYWt1YiBTaXRu
aWNraSA8amFrdWJAY2xvdWRmbGFyZS5jb20+IHdyb3RlOgo+Pgo+PiBTb21lIHZpcnR1YWwgZGV2
aWNlcywgc3VjaCBhcyB0aGUgdmlydGlvIG5ldHdvcmsgZGV2aWNlLCBjYW4gdXNlIG11bHRpcGxl
Cj4+IHZpcnRxdWV1ZXMgKG9yIG11bHRpcGxlIHBhaXJzIG9mIHZpcnRxdWV1ZXMgaW4gdGhlIGNh
c2Ugb2YgYSB2TklDKS4gSW4gc3VjaAo+PiBjYXNlLCB3aGVuIHRoZXJlIGFyZSBtdWx0aXBsZSB2
Q1BVcyBwcmVzZW50LCBpdCBpcyBwb3NzaWJsZSB0byBwcm9jZXNzCj4+IHZpcnRxdWV1ZSBldmVu
dHMgaW4gcGFyYWxsZWwuIEVhY2ggdkNQVSBjYW4gc2VydmljZSBhIHN1YnNldCBvZiBhbGwKPj4g
dmlydHF1ZXVlcyB3aGVuIG5vdGlmaWVkIHRoYXQgdGhlcmUgaXMgd29yayB0byBjYXJyeSBvdXQu
Cj4+Cj4+IEhvd2V2ZXIsIHRoZSBjdXJyZW50IHZpcnRpby1tbWlvIHRyYW5zcG9ydCBpbXBsZW1l
bnRhdGlvbiBwb3NlcyBhCj4+IGxpbWl0YXRpb24uIE9ubHkgb25lIHZDUFUgY2FuIHNlcnZpY2Ug
bm90aWZpY2F0aW9ucyBmcm9tIGFueSBvZiB0aGUKPj4gdmlydHF1ZXVlcyBvZiBhIHNpbmdsZSB2
aXJ0aW8gZGV2aWNlLiBUaGlzIGlzIGJlY2F1c2UgYSB2aXJ0aW8tbW1pbyBkZXZpY2UKPj4gZHJp
dmVyIHN1cHBvcnRzIHJlZ2lzdGVyaW5nIGp1c3Qgb25lIGludGVycnVwdCBwZXIgZGV2aWNlLiBX
aXRoIHN1Y2ggc2V0dXAKPj4gd2UgYXJlIG5vdCBhYmxlIHRvIHNjYWxlIHZpcnRxdWV1ZSBldmVu
dCBwcm9jZXNzaW5nIGFtb25nIHZDUFVzLgo+Pgo+PiBOb3csIHdpdGggbW9yZSB0aGFuIG9uZSBJ
UlEgcmVzb3VyY2UgcmVnaXN0ZXJlZCBmb3IgYSB2aXJ0aW8tbW1pbyBwbGF0Zm9ybQo+PiBkZXZp
Y2UsIHdlIGNhbiBhZGRyZXNzIHRoaXMgbGltaXRhdGlvbi4KPj4KPj4gRmlyc3QsIHdlIHJlcXVl
c3QgbXVsdGlwbGUgSVJRcyB3aGVuIGNyZWF0aW5nIHZpcnRxdWV1ZXMgZm9yIGEgZGV2aWNlLgo+
Pgo+PiBUaGVuLCBtYXAgZWFjaCB2aXJ0cXVldWUgdG8gb25lIG9mIHRoZSBJUlFzIGFzc2lnbmVk
IHRvIHRoZSBkZXZpY2UuIFRoZQo+PiBtYXBwaW5nIGlzIGRvbmUgaW4gYSBkZXZpY2UgdHlwZSBz
cGVjaWZpYyBtYW5uZXIuIEZvciBpbnN0YW5jZSwgYSBuZXR3b3JrCj4+IGRldmljZSB3aWxsIHdh
bnQgZWFjaCBSWC9UWCB2aXJ0cXVldWUgcGFpciBtYXBwZWQgdG8gYSBkaWZmZXJlbnQgSVJRCj4+
IGxpbmUuIE90aGVyIGRldmljZSB0eXBlcyBtaWdodCByZXF1aXJlIGEgZGlmZmVyZW50IG1hcHBp
bmcgc2NoZW1lLiBXZQo+PiBjdXJyZW50bHkgcHJvdmlkZSBhIG1hcHBpbmcgZm9yIHZpcnRpby1u
ZXQgZGV2aWNlIHR5cGUuCj4+Cj4+IEZpbmFsbHksIHdoZW4gaGFuZGxpbmcgYW4gaW50ZXJydXB0
LCB3ZSBzZXJ2aWNlIG9ubHkgdGhlIHZpcnRxdWV1ZXMKPj4gYXNzb2NpYXRlZCB3aXRoIHRoZSBJ
UlEgbGluZSB0aGF0IHRyaWdnZXJlZCB0aGUgZXZlbnQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEph
a3ViIFNpdG5pY2tpIDxqYWt1YkBjbG91ZGZsYXJlLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fbW1pby5jIHwgMTAyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA4MyBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4+IGluZGV4IDA2YTU4N2IyMzU0Mi4uMTgw
YzUxYzI3NzA0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4+
ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKClsuLi5dCgo+PiBAQCAtNDg4LDYg
KzUxMSwxOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdm1fc2V0dXBfdnEoc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbgo+PiAgICAgICAgIHJldHVybiBFUlJf
UFRSKGVycik7Cj4+ICB9Cj4+Cj4+ICsvKiBNYXAgdmlydHF1ZXVlIHRvIHplcm8tYmFzZWQgaW50
ZXJydXB0IG51bWJlciAqLwo+PiArc3RhdGljIHVuc2lnbmVkIGludCB2cTJpcnEoY29uc3Qgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEpCj4+ICt7Cj4+ICsgICAgICAgc3dpdGNoICh2cS0+dmRldi0+aWQu
ZGV2aWNlKSB7Cj4+ICsgICAgICAgY2FzZSBWSVJUSU9fSURfTkVUOgo+PiArICAgICAgICAgICAg
ICAgLyogaW50ZXJydXB0IHNoYXJlZCBieSByeC90eCB2aXJ0cXVldWUgcGFpciAqLwo+PiArICAg
ICAgICAgICAgICAgcmV0dXJuIHZxLT5pbmRleCAvIDI7Cj4+ICsgICAgICAgZGVmYXVsdDoKPj4g
KyAgICAgICAgICAgICAgIHJldHVybiAwOwo+PiArICAgICAgIH0KPgo+IFRyYW5zcG9ydCBkcml2
ZXJzIHNob3VsZCBoYXZlIG5vIGtub3dsZWRnZSBvZiBhIHNwZWNpZmljIHR5cGUgb2YgZGV2aWNl
Lgo+CgpNYWtlcyBzZW5zZS4gVGhpcyBicmVha3MgbGF5ZXJpbmcuIEkgd2lsbCBzZWUgaG93IHRv
IHB1bGwgdGhpcyBpbnRvIHRoZQpkZXZpY2UgZHJpdmVyLiBQZXJoYXBzIHRoaXMgY2FuIGJlIGNv
bW11bmljYXRlZCB0aHJvdWdoIHNldF92cV9hZmZpbml0eQpvcC4KCj4+ICt9Cj4+ICsKPj4gIHN0
YXRpYyBpbnQgdm1fZmluZF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVk
IGludCBudnFzLAo+PiAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZx
c1tdLAo+PiAgICAgICAgICAgICAgICAgICAgICAgIHZxX2NhbGxiYWNrX3QgKmNhbGxiYWNrc1td
LAoKWy4uLl0KCj4+IEBAIC01MTksMTIgKzU0NCw1MSBAQCBzdGF0aWMgaW50IHZtX2ZpbmRfdnFz
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgbnZxcywKPj4gICAgICAg
ICAgICAgICAgIHZxc1tpXSA9IHZtX3NldHVwX3ZxKHZkZXYsIHF1ZXVlX2lkeCsrLCBjYWxsYmFj
a3NbaV0sIG5hbWVzW2ldLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3R4ID8gY3R4W2ldIDogZmFsc2UpOwo+PiAgICAgICAgICAgICAgICAgaWYgKElTX0VSUih2cXNb
aV0pKSB7Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHZtX2RlbF92cXModmRldik7Cj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHZxc1tpXSk7Cj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGVyciA9IFBUUl9FUlIodnFzW2ldKTsKPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBmYWlsX3ZxOwo+PiAgICAgICAgICAgICAgICAgfQo+PiAgICAgICAgIH0K
Pj4KPj4gKyAgICAgICBuaXJxcyA9IHBsYXRmb3JtX2lycV9jb3VudCh2bV9kZXYtPnBkZXYpOwo+
PiArICAgICAgIGlmIChuaXJxcyA8IDApIHsKPj4gKyAgICAgICAgICAgICAgIGVyciA9IG5pcnFz
Owo+PiArICAgICAgICAgICAgICAgZ290byBmYWlsX3ZxOwo+PiArICAgICAgIH0KPj4gKwo+PiAr
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBuaXJxczsgaSsrKSB7Cj4+ICsgICAgICAgICAgICAgICBp
cnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHZtX2Rldi0+cGRldiwgaSk7Cj4+ICsgICAgICAgICAgICAg
ICBpZiAoaXJxIDwgMCkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBmYWlsX2lycTsK
Pj4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPCBpcnFfYmFzZSkKPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaXJxX2Jhc2UgPSBpcnE7Cj4+ICsKPj4gKyAgICAgICAgICAgICAgIGVyciA9IGRl
dm1fcmVxdWVzdF9pcnEoJnZkZXYtPmRldiwgaXJxLCB2bV9pbnRlcnJ1cHQsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElSUUZfU0hBUkVELCBOVUxMLCB2bV9kZXYp
Owo+PiArICAgICAgICAgICAgICAgaWYgKGVycikKPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z290byBmYWlsX2lycTsKPj4gKwo+PiArICAgICAgICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3Jl
YWRfYm9vbCh2bV9kZXYtPnBkZXYtPmRldi5vZl9ub2RlLCAid2FrZXVwLXNvdXJjZSIpKQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBlbmFibGVfaXJxX3dha2UoaXJxKTsKPgo+IENvdWxkIHdl
IHNpbXBseSB1c2UgdGhlIHNhbWUgcG9saWN5IGFzIFBDSSAodnBfZmluZF92cXNfbXNpeCgpKT8K
ClJlYWRpbmcgdGhhdCByb3V0aW5lLCB0aGUgUENJIHBvbGljeSBpczoKCjEpIEJlc3Qgb3B0aW9u
OiBvbmUgZm9yIGNoYW5nZSBpbnRlcnJ1cHQsIG9uZSBwZXIgdnEuCjIpIFNlY29uZCBiZXN0OiBv
bmUgZm9yIGNoYW5nZSwgc2hhcmVkIGZvciBhbGwgdnFzLgoKV291bGQgYmUgZ3JlYXQgdG8gYmUg
YWJsZSB0byBnbyB3aXRoIG9wdGlvbiAoMSksIGJ1dCB3ZSBoYXZlIG9ubHkgYQpsaW1pdGVkIG51
bWJlciBvZiBsZWdhY3kgSVJRcyB0byBzcHJlYWQgYW1vbmcgTU1JTyBkZXZpY2VzLiA0OCBJUlFz
IGF0Cm1vc3QgaW4gYSAyIHggSU9BUElDIHNldHVwLgoKSGF2aW5nIG9uZSBJUlEgcGVyIFZRIHdv
dWxkIG1lYW4gbGVzcyBSeC9UeCBxdWV1ZSBwYWlycyBmb3IgYSB2TklDLiBMZXNzCnRoYW4gMjQg
cXVldWUgcGFpcnMuIFdoaWxlLCBmcm9tIG91ciB0YXJnZXQgd29ya2xvYWQgUG9WLCBpZGVhbGx5
LCB3ZQp3b3VsZCBsaWtlIHRvIHN1cHBvcnQgYXQgbGVhc3QgMzIgcXVldWUgcGFpcnMuCgpIZW5j
ZSB0aGUgaWRlYSB0byBoYXZlIG9uZSBJUlEgcGVyIFJ4L1R4IFZRIHBhaXIuIE5vdCBhcyBpZGVh
bCBhcyAoMSksCmJ1dCBhIGxvdCBiZXR0ZXIgdGhhbiAoMikuCgpDb21wYXJpbmcgdGhpcyB0byBQ
Q0kgLSB2aXJ0aW8tbmV0LCB3aXRoIG9uZSBpbnRlcnJ1cHQgcGVyIFZRLCB3aWxsIG1hcAplYWNo
IFJ4L1R4IFZRIHBhaXIgdG8gdGhlIHNhbWUgQ1BVLgoKV2UgY291bGQgYWNoaWV2ZSB0aGUgc2Ft
ZSBWUS1DUFUgYWZmaW5pdHkgc2V0dXAgZm9yIE1NSU8sIGJ1dCB3aXRoIGxlc3MKaW50ZXJydXB0
IHZlY3RvcnMuCgpUaGFua3MgZm9yIGZlZWRiYWNrLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
