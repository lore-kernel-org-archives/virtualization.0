Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04FCC001DB
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 02:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3780481E1A;
	Tue, 15 Aug 2023 02:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3780481E1A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QNPcU9mS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VnGmr95TrljC; Tue, 15 Aug 2023 02:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D807781DF9;
	Tue, 15 Aug 2023 02:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D807781DF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1AECC0071;
	Tue, 15 Aug 2023 02:32:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3A4FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2CA981DFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:32:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2CA981DFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dqHyXnc32C2S
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:32:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4BBB81DF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:32:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4BBB81DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692066737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNemsS+xeBZrPRoyejjjBBpC6xRjaAOSiLlxHQBTkjs=;
 b=QNPcU9mSCB8QVnOWhC2qh7tFJ6fkP+1vRU3/0JOS3b3Dw9rCViThRJDITzw/CBj6p0NIE9
 dxPBK75i+kj2FhqXzOEVT75Xmqn0rCpdOhKwZWh2hC9dwzvi1/ndPnrO2qsdcqlYy5fXCj
 IvdC+lzaiXn5DLjUkSVrp0CtCtVqeNU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-OeZ6S4SiN2yos-OZlD8KfQ-1; Mon, 14 Aug 2023 22:32:15 -0400
X-MC-Unique: OeZ6S4SiN2yos-OZlD8KfQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bb8ab25c51so1494181fa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 19:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692066734; x=1692671534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNemsS+xeBZrPRoyejjjBBpC6xRjaAOSiLlxHQBTkjs=;
 b=gyUXqr0WKmPnN59Nndc3Ce34tHVarnj/+k5FwO73OB/vqLShJ+cTpzAZn3QmrUcTun
 pJZXCR0qkflUq8J38bVuTGgNwhwv8YtMSaA7uoyzYa/6Pmd/M/O9hetua45MY1mLJYOv
 rxlZXWi6GsNFTocLA9bQ/nOVdvFNFCmP1fEMYBq52WsmA1I/Z8lfcKGKngoHRDeloT/Z
 BlsUM0dGimhmD3eX35BoloTDHeK2PjgtQWN9FopiFQfKUADt3SsSvuFiWG8PvWlwdKtd
 FO+N28PzxN1uffd+wnXpBOjKLIzE8APIXSMGHnuiEYl/5LGiz3hHPSOGjGE8g0jd0Ew2
 1zKA==
X-Gm-Message-State: AOJu0Yyzmp4bWToVooIc7yUxTva2tLGZiXipZZh2jzLvnKp16iZUClCp
 HPMr+f/g0jpfs0vMTA+SvbTHHuaQ4zIkIlLxjcCwEyNRRr0LFiT3FwGwgrHrRLyDXS/c0c9gk47
 vn3ePX5sHLVV/XjqH+jjxwUfTz5WCSecD/04ojtkpiOTe6Ill1SGBKZYcMA==
X-Received: by 2002:a2e:3206:0:b0:2b7:3656:c594 with SMTP id
 y6-20020a2e3206000000b002b73656c594mr8648542ljy.3.1692066734380; 
 Mon, 14 Aug 2023 19:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJmvQQV3BTnu4wfl0ducCx2L3QaITyRrAxjqVHnhDP/J1HYi/le3Ws0YJdz9jLCvMX+/IOIXZAR7suJHeaZ8=
X-Received: by 2002:a2e:3206:0:b0:2b7:3656:c594 with SMTP id
 y6-20020a2e3206000000b002b73656c594mr8648534ljy.3.1692066734088; Mon, 14 Aug
 2023 19:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 10:32:03 +0800
Message-ID: <CACGkMEvrg0qA6=E-5WJL79XAdO3SpSr=rumsyYMW4a-7tZkD8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] vhost-vdpa: should restore 1:1 dma mapping before
 detaching driver
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgOTo0NeKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTcgKysrKysr
KysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5k
ZXggYjQzZTg2OC4uNjJiMGEwMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTEzMSw2ICsxMzEsMTUgQEAgc3RhdGlj
IHN0cnVjdCB2aG9zdF92ZHBhX2FzICp2aG9zdF92ZHBhX2ZpbmRfYWxsb2NfYXMoc3RydWN0IHZo
b3N0X3ZkcGEgKnYsCj4gICAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9hbGxvY19hcyh2LCBhc2lk
KTsKPiAgfQo+Cj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHN0cnVjdCB2aG9z
dF92ZHBhICp2LCB1MzIgYXNpZCkKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhID0gdi0+dmRwYTsKPiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9w
cyA9IHZkcGEtPmNvbmZpZzsKPiArCj4gKyAgICAgICBpZiAob3BzLT5yZXNldF9tYXApCj4gKyAg
ICAgICAgICAgICAgIG9wcy0+cmVzZXRfbWFwKHZkcGEsIGFzaWQpOwo+ICt9Cj4gKwo+ICBzdGF0
aWMgaW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNp
ZCkKPiAgewo+ICAgICAgICAgc3RydWN0IHZob3N0X3ZkcGFfYXMgKmFzID0gYXNpZF90b19hcyh2
LCBhc2lkKTsKPiBAQCAtMTQwLDYgKzE0OSwxNCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVt
b3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkKPgo+ICAgICAgICAgaGxpc3Rf
ZGVsKCZhcy0+aGFzaF9saW5rKTsKPiAgICAgICAgIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAodiwg
JmFzLT5pb3RsYiwgMFVMTCwgMFVMTCAtIDEsIGFzaWQpOwo+ICsgICAgICAgLyoKPiArICAgICAg
ICAqIERldmljZXMgd2l0aCBvbi1jaGlwIElPTU1VIG5lZWQgdG8gcmVzdG9yZSBpb3RsYgo+ICsg
ICAgICAgICogdG8gMToxIGlkZW50aXR5IG1hcHBpbmcgYmVmb3JlIHZob3N0LXZkcGEgaXMgZ29p
bmcKPiArICAgICAgICAqIHRvIGJlIHJlbW92ZWQgYW5kIGRldGFjaGVkIGZyb20gdGhlIGRldmlj
ZS4gR2l2ZQo+ICsgICAgICAgICogdGhlbSBhIGNoYW5jZSB0byBkbyBzbywgYXMgdGhpcyBjYW5u
b3QgYmUgZG9uZQo+ICsgICAgICAgICogZWZmaWNpZW50bHkgdmlhIHRoZSB3aG9sZS1yYW5nZSB1
bm1hcCBjYWxsIGFib3ZlLgo+ICsgICAgICAgICovCgpTYW1lIHF1ZXN0aW9uIGFzIGJlZm9yZSwg
aWYgMToxIGlzIHJlc3RvcmVkIGFuZCB0aGUgdXNlcnNwYWNlIGRvZXNuJ3QKZG8gYW55IElPVExC
IHVwZGF0aW5nLiBJdCBsb29rcyBsaWtlIGEgc2VjdXJpdHkgaXNzdWU/IChBc3N1bWluZyBJT1ZB
CmlzIFBBKQoKVGhhbmtzCgo+ICsgICAgICAgdmhvc3RfdmRwYV9yZXNldF9tYXAodiwgYXNpZCk7
Cj4gICAgICAgICBrZnJlZShhcyk7Cj4KPiAgICAgICAgIHJldHVybiAwOwo+IC0tCj4gMS44LjMu
MQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
