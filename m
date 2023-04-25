Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D620C6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 06:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B510C40A00;
	Tue, 25 Apr 2023 06:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B510C40A00
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCjPGb/b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mzv6SDRk2vPM; Tue, 25 Apr 2023 06:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 07AB9409A4;
	Tue, 25 Apr 2023 06:02:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07AB9409A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E07DCC0037;
	Tue, 25 Apr 2023 06:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B89C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC99B409F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC99B409F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPzUQEvBpUBR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5FDB409A4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5FDB409A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682402566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkoMXSxfr8lSAIpoAfT7YJFd5ToBLdbutEcr+KATTi0=;
 b=fCjPGb/bNmMNICdl/sOTWD2ejDI9RfHa0fYgx6A/CWKmGz1DhTZb+ycaM1ngGspPWheruA
 orE/bFJMphaATczF9jOn1Wd/OfdmISAred9B6d01t4r7Xvjno+bodEOStrojgv+5uJV63O
 TQrHRwJCGGdSW8oeOriR+5K70CacS9s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-scOJEu_INwW-PF0nHy33RQ-1; Tue, 25 Apr 2023 02:02:43 -0400
X-MC-Unique: scOJEu_INwW-PF0nHy33RQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4edd5a7cddeso5246480e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 23:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682402562; x=1684994562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkoMXSxfr8lSAIpoAfT7YJFd5ToBLdbutEcr+KATTi0=;
 b=VLWkYpeFsXMV6eOVUS2W4vjchUJIAyIM5qsuvHEViIzShwhe/kuK8yit9Rj9JnE/Ok
 /gWqGHQ1PDEu3DGrtIRFgFn8kwVpqT0QrNjY/orVsUy7AF7Vfl04lR7Du6IIv74f2ZsN
 8sqxXZkt9/ZNAKn5uUqvW5ygq+AJXO5U4MiX9acODm9fB7svT1d9K8xvhIcqplomq4gj
 i5MAao1XEy2Gn5tYFIOsWp/2MQvsktSsS3YFyKOLaHabMKx0CVvJg9JhS4neRTV0EF0U
 LBM2u4xoP4A012wrk0k5wpLAY7G5nnH6gwXzA/+4dNRmvHMj6biJQTr2CW+ZGjcKP4jI
 wM4g==
X-Gm-Message-State: AAQBX9fx6qTkHbpB04XgyFzn9OY0XhgvwgEg8EPUGeqnBlRrMHGm14AV
 KxD2u1Esw6uvmYfN+pwdiHCFzkMAri3tt4iPyfTn0p9/WSev6BXBbNhdbToXmNwJw6m9gBF+ONV
 uIYPOA8RGbJ136O+c0TTZKy92mkae/l/kDGQwmequPv0yrpsVUnuighuWvg==
X-Received: by 2002:a19:f617:0:b0:4b6:fddc:1fcd with SMTP id
 x23-20020a19f617000000b004b6fddc1fcdmr4104705lfe.23.1682402561889; 
 Mon, 24 Apr 2023 23:02:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350YvlHC8tWaFUYEuizRYXZgoO35hhT/935UK7cSDSmuoabA7kd3u2pUMSHg28t6QzcSx4x21AgEjRq/lG7o0plM=
X-Received: by 2002:a19:f617:0:b0:4b6:fddc:1fcd with SMTP id
 x23-20020a19f617000000b004b6fddc1fcdmr4104699lfe.23.1682402561606; Mon, 24
 Apr 2023 23:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-4-shannon.nelson@amd.com>
In-Reply-To: <20230424225031.18947-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Apr 2023 14:02:30 +0800
Message-ID: <CACGkMEuO05O5vg5mO7n4ECiaw-ECpVjVqQt9wKRukCnAhsGS7w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vhost_vdpa: support PACKED when setting-getting
 vring_base
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

T24gVHVlLCBBcHIgMjUsIDIwMjMgYXQgNjo1MOKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFD
S0VEIG9yIHNwbGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4gZ2V0dGluZyB0aGUgdnJpbmcgYmFz
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQu
Y29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cj4gLS0tCj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMjEgKysrKysrKysrKysrKysrKystLS0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
PiBpbmRleCA1OTliOGNjMjM4YzcuLmZlMzkyYjY3ZDViZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTU4NSw3ICs1
ODUsMTQgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwKPiAgICAgICAgICAgICAgICAgaWYgKHIpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4KPiAtICAgICAgICAgICAgICAgdnEtPmxh
c3RfYXZhaWxfaWR4ID0gdnFfc3RhdGUuc3BsaXQuYXZhaWxfaW5kZXg7Cj4gKyAgICAgICAgICAg
ICAgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gdnFfc3RhdGUucGFj
a2VkLmxhc3RfYXZhaWxfaWR4IHwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAodnFfc3RhdGUucGFja2VkLmxhc3RfYXZhaWxfY291bnRlciA8PCAxNSk7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHggPSB2cV9zdGF0ZS5wYWNr
ZWQubGFzdF91c2VkX2lkeCB8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAodnFfc3RhdGUucGFja2VkLmxhc3RfdXNlZF9jb3VudGVyIDw8IDE1KTsKPiArICAg
ICAgICAgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF9h
dmFpbF9pZHggPSB2cV9zdGF0ZS5zcGxpdC5hdmFpbF9pbmRleDsKPiArICAgICAgICAgICAgICAg
fQo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPgo+IEBAIC02MDMsOSArNjEw
LDE1IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X3Zk
cGEgKnYsIHVuc2lnbmVkIGludCBjbWQsCj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+Cj4gICAg
ICAgICBjYXNlIFZIT1NUX1NFVF9WUklOR19CQVNFOgo+IC0gICAgICAgICAgICAgICB2cV9zdGF0
ZS5zcGxpdC5hdmFpbF9pbmRleCA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiAtICAgICAgICAgICAg
ICAgaWYgKG9wcy0+c2V0X3ZxX3N0YXRlKHZkcGEsIGlkeCwgJnZxX3N0YXRlKSkKPiAtICAgICAg
ICAgICAgICAgICAgICAgICByID0gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAgaWYgKHZob3N0
X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpIHsKPiArICAgICAgICAgICAg
ICAgICAgICAgICB2cV9zdGF0ZS5wYWNrZWQubGFzdF9hdmFpbF9pZHggPSB2cS0+bGFzdF9hdmFp
bF9pZHggJiAweDdmZmY7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgdnFfc3RhdGUucGFja2Vk
Lmxhc3RfYXZhaWxfY291bnRlciA9ICEhKHZxLT5sYXN0X2F2YWlsX2lkeCAmIDB4ODAwMCk7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgdnFfc3RhdGUucGFja2VkLmxhc3RfdXNlZF9pZHggPSB2
cS0+bGFzdF91c2VkX2lkeCAmIDB4N2ZmZjsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cV9z
dGF0ZS5wYWNrZWQubGFzdF91c2VkX2NvdW50ZXIgPSAhISh2cS0+bGFzdF91c2VkX2lkeCAmIDB4
ODAwMCk7Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgdnFfc3RhdGUuc3BsaXQuYXZhaWxfaW5kZXggPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gKyAg
ICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgciA9IG9wcy0+c2V0X3ZxX3N0YXRlKHZk
cGEsIGlkeCwgJnZxX3N0YXRlKTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4KPiAgICAgICAg
IGNhc2UgVkhPU1RfU0VUX1ZSSU5HX0NBTEw6Cj4gLS0KPiAyLjE3LjEKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
