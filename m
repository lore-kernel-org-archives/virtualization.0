Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFBE81810
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 03:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9A104032E;
	Tue, 26 Sep 2023 03:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9A104032E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uts2QJIU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wtshpb5wafCm; Tue, 26 Sep 2023 03:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE7EA40316;
	Tue, 26 Sep 2023 03:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE7EA40316
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A646C0039;
	Tue, 26 Sep 2023 03:33:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B680C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5573741764
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5573741764
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uts2QJIU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJpBzPyaY-gV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:33:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57FF041761
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57FF041761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695699200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJajdCncSMr7ZiqVnyceQ22WaLa+UzWhCY/lPANEMZs=;
 b=Uts2QJIUEu7opgPoemUJeHq6bmkEVxldeT+/2p9EKDoKwgpYDcAtJBzXQsqxdR0obOKVg8
 o+lq2VBIfXhtmKXvcZqXQ4HY3JbwR8K8uBc1dZwMldbsLXUSfGAqVz0nl9c6z4vcAkqUEh
 S/i+P4w3DB545zOUMTgGIhFDgHlMLfs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-SzWNAP-wO8u9t4Jg9-ttLw-1; Mon, 25 Sep 2023 23:33:18 -0400
X-MC-Unique: SzWNAP-wO8u9t4Jg9-ttLw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503269edbb3so10745703e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 20:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695699197; x=1696303997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJajdCncSMr7ZiqVnyceQ22WaLa+UzWhCY/lPANEMZs=;
 b=vAKdU6S1iIIqYU4Hj52lZs/cxYlThOpubKnlSxl7qRQJVKQrLEFQha1/HxO0/a4tHm
 8WI9S7hST3XiaaSjkm+IX9BdFJ/jU3NXtIBPAJTKTs1BlwC6uFmfQrT8IJ7KbPTNUQjO
 x4T2F4hMo4MpwCYofg/BoH3vTIEiMaEQnHAXcosyuJw6FLdQs7jP8PrWjCW65jMk1r7J
 hMj2iMLz60gcSP1enbuQI1NDvtva72M2CMUkjtC+VK+yACRHyLboEJDPgzmMOcvLCS3F
 UM6Ops3POaLBmomf6CLmn3EL/RCrsjrurXvJ14SwY8bUrLwvmIxqvNl5i62BJEEOohqa
 tQag==
X-Gm-Message-State: AOJu0YzJcyYtkyXa1cFB4o0fyB7avM/SmTbPzSmbSzZuOS8oIxK6pqRA
 ZKkp8avpRYmVwdZRfVw7X1XmL48/OYGEtEUFtlSTBdSJOrZlpPMpO0Vb1Xz1lXYmDoulOQ4Q2Wb
 PeefJpp6AT1xx8vGQ/TmdTKzLfSNPuVMUKd1WXWLpqBGwuhy+tZUuIltY4g==
X-Received: by 2002:a05:6512:3582:b0:4fb:7675:1c16 with SMTP id
 m2-20020a056512358200b004fb76751c16mr6143407lfr.49.1695699197429; 
 Mon, 25 Sep 2023 20:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2IUSLrpbg7ATZw7UjipL9J+f0jI6j6UhxJvO4Obqb5zgvMY53uGnraEAY/6btCcjutBxYmcv45efC8Qi2mZI=
X-Received: by 2002:a05:6512:3582:b0:4fb:7675:1c16 with SMTP id
 m2-20020a056512358200b004fb76751c16mr6143395lfr.49.1695699197146; Mon, 25 Sep
 2023 20:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-7-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-7-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 11:33:06 +0800
Message-ID: <CACGkMEsXQQoQ3eg6XxcS6FLZ3qgZ9phBR714r8OYqKs1Z26sCw@mail.gmail.com>
Subject: Re: [PATCH 06/16] vdpa/mlx5: Take cvq iotlb lock during refresh
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
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IFRoZSByZXNsb2NrIGlzIHRha2VuIHdoaWxlIHJlZnJl
c2ggaXMgY2FsbGVkIGJ1dCBpb21tdV9sb2NrIGlzIG1vcmUKPiBzcGVjaWZpYyB0byB0aGlzIHJl
c291cmNlLiBTbyB0YWtlIHRoZSBpb21tdV9sb2NrIGR1cmluZyBjdnEgaW90bGIKPiByZWZyZXNo
Lgo+Cj4gQmFzZWQgb24gRXVnZW5pbydzIHBhdGNoIFswXS4KPgo+IFswXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwMTEyMTQyMjE4LjcyNTYyMi00LWVwZXJlem1hQHJlZGhhdC5j
b20vCj4KPiBTdWdnZXN0ZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgoK
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0t
Cj4gIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyB8IDEwICsrKysrKysrKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
Ywo+IGluZGV4IGZjYjZhZTMyZTllZC4uNTg3MzAwZTdjMThlIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
Ywo+IEBAIC01OTAsMTEgKzU5MCwxOSBAQCBpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIo
c3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCBhc2lkKQo+ICB7Cj4gKyAgICAgICBpbnQgZXJyOwo+ICsK
PiAgICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBh
c2lkKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPgo+ICsgICAgICAgc3Bpbl9sb2NrKCZt
dmRldi0+Y3ZxLmlvbW11X2xvY2spOwo+ICsKPiAgICAgICAgIHBydW5lX2lvdGxiKG12ZGV2KTsK
PiAtICAgICAgIHJldHVybiBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKPiArICAgICAgIGVyciA9
IGR1cF9pb3RsYihtdmRldiwgaW90bGIpOwo+ICsKPiArICAgICAgIHNwaW5fdW5sb2NrKCZtdmRl
di0+Y3ZxLmlvbW11X2xvY2spOwo+ICsKPiArICAgICAgIHJldHVybiBlcnI7Cj4gIH0KPgo+ICBp
bnQgbWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+
IC0tCj4gMi40MS4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
