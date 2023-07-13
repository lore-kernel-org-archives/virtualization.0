Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF437C001B0
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 05:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8ECD04044C;
	Thu, 13 Jul 2023 05:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ECD04044C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzB1GFtx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rl09SAtTXffr; Thu, 13 Jul 2023 05:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 349EC40018;
	Thu, 13 Jul 2023 05:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 349EC40018
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A99AC0072;
	Thu, 13 Jul 2023 05:09:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA3AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57F7D40166
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57F7D40166
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HfapGqoned7T
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F23340018
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F23340018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689224962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9UnSZw2zINFM+43O4S+VDOdiqFk5UjfU6ueUWZWUo8=;
 b=SzB1GFtxCvZikaMnQrbv2vLRrW+Zz53Ng4se82rmt1lZOi1qrWvj/7NJvXCVnPQheGyObE
 vW7hudWqKNYjmJBf9yOvPPglEzo3YwCXqvWndyuXEwBTDPP1YoAqZM3bwJxQxxoqK3S70q
 7eQ0Q8+pPmmk+HXN7eCmFzUDwjxOnZ8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-7KCFqYZsO0eLom75uC_2ng-1; Thu, 13 Jul 2023 01:09:20 -0400
X-MC-Unique: 7KCFqYZsO0eLom75uC_2ng-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b704f6bbeaso2113691fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 22:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689224959; x=1691816959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9UnSZw2zINFM+43O4S+VDOdiqFk5UjfU6ueUWZWUo8=;
 b=eTKluPZQBi8B2m8hJMIScPfyHl/W3QaJ65U/r0HC5pXonSHrUMf95tQ8wVoTHQMRGx
 SMS4GMCbCrWoAR6GrlzNQyzOTNkUmw3Zius5fFjaU0b1tAF3yvP9yC/DNQILdEKNp7yr
 IgeO8QqRW1PMtl/T8lHZkvtZUSXchxLhU4JblSuLhgY9ZD9BW0zikDTTeYQt2Y/ihRJj
 ST3p/vx14IUJ2xwqou9k1IWGoqRF2OkB2LihYzBoQ+zlBzPlLvJsreOvJBuVaJWWD3Pi
 afre8S1004djux8DoN5I5alxHWADHZHio4CgPP8rk0wll/F7aou3UumN5JdxsGX4vNp7
 gw8A==
X-Gm-Message-State: ABy/qLazpU1h2O91rUHICNVDvu/lSNcxcyavTPKSTDRbrs6lor7H/4yy
 AShTvvhE4bXB76F209mLJy7w7cbxyQWXTA2UA6RYcyVJephGIvT3fdSD8CQHkUuQvgdxSmxek95
 N1n5irSzyI8Tdydx550tj3arxwYkDfZFdMKFFtHRa7ZZR2mXZd8iZCmPUIw==
X-Received: by 2002:a2e:a30d:0:b0:2b6:dd9a:e1d3 with SMTP id
 l13-20020a2ea30d000000b002b6dd9ae1d3mr375451lje.44.1689224959458; 
 Wed, 12 Jul 2023 22:09:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqWN1kH3hGXbUkWA8u/d4/dLXMnmETubLrnJkH8ITTqVyyJQgTmmYctpj3Refn0mum/wcEiLq0bfp6CjePFSo=
X-Received: by 2002:a2e:a30d:0:b0:2b6:dd9a:e1d3 with SMTP id
 l13-20020a2ea30d000000b002b6dd9ae1d3mr375440lje.44.1689224959182; Wed, 12 Jul
 2023 22:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com>
 <20230711042437.69381-6-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-6-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 13:09:08 +0800
Message-ID: <CACGkMEvXCb0C0TdYc6CYa_shS_MFbVNegciiwxhqrVKAHkVKnw@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 5/5] pds_vdpa: fix up debugfs feature bit
 printing
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, drivers@pensando.io,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
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

T24gVHVlLCBKdWwgMTEsIDIwMjMgYXQgMTI6MjXigK9QTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBNYWtlIGNsZWFyZXIgaW4gZGVidWdmcyBvdXRw
dXQgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgaHcKPiBmZWF0dXJlIGJpdHMsIHRoZSBmZWF0
dXJlcyBzdXBwb3J0ZWQgdGhyb3VnaCB0aGUgZHJpdmVyLCBhbmQKPiB0aGUgZmVhdHVyZXMgdGhh
dCBoYXZlIGJlZW4gbmVnb3RpYXRlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29u
IDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9wZHMvZGVidWdmcy5j
IHwgMTMgKysrKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9wZHMvZGVidWdmcy5j
IGIvZHJpdmVycy92ZHBhL3Bkcy9kZWJ1Z2ZzLmMKPiBpbmRleCA3NTRjY2I3YTY2NjYuLjliMDRh
YWQ2ZWMzNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRzL2RlYnVnZnMuYwo+ICsrKyBi
L2RyaXZlcnMvdmRwYS9wZHMvZGVidWdmcy5jCj4gQEAgLTE3Niw2ICsxNzYsNyBAQCBzdGF0aWMg
aW50IGlkZW50aXR5X3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEsIHZvaWQgKnYpCj4gIHsKPiAg
ICAgICAgIHN0cnVjdCBwZHNfdmRwYV9hdXggKnZkcGFfYXV4ID0gc2VxLT5wcml2YXRlOwo+ICAg
ICAgICAgc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1nbXQ7Cj4gKyAgICAgICB1NjQgaHdfZmVhdHVy
ZXM7Cj4KPiAgICAgICAgIHNlcV9wcmludGYoc2VxLCAiYXV4X2RldjogICAgICAgICAgICAlc1xu
IiwKPiAgICAgICAgICAgICAgICAgICAgZGV2X25hbWUoJnZkcGFfYXV4LT5wYWRldi0+YXV4X2Rl
di5kZXYpKTsKPiBAQCAtMTgzLDggKzE4NCw5IEBAIHN0YXRpYyBpbnQgaWRlbnRpdHlfc2hvdyhz
dHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKPiAgICAgICAgIG1nbXQgPSAmdmRwYV9hdXgt
PnZkcGFfbWRldjsKPiAgICAgICAgIHNlcV9wcmludGYoc2VxLCAibWF4X3ZxczogICAgICAgICAg
ICAlZFxuIiwgbWdtdC0+bWF4X3N1cHBvcnRlZF92cXMpOwo+ICAgICAgICAgc2VxX3ByaW50Zihz
ZXEsICJjb25maWdfYXR0cl9tYXNrOiAgICUjbGx4XG4iLCBtZ210LT5jb25maWdfYXR0cl9tYXNr
KTsKPiAtICAgICAgIHNlcV9wcmludGYoc2VxLCAic3VwcG9ydGVkX2ZlYXR1cmVzOiAlI2xseFxu
IiwgbWdtdC0+c3VwcG9ydGVkX2ZlYXR1cmVzKTsKPiAtICAgICAgIHByaW50X2ZlYXR1cmVfYml0
c19hbGwoc2VxLCBtZ210LT5zdXBwb3J0ZWRfZmVhdHVyZXMpOwo+ICsgICAgICAgaHdfZmVhdHVy
ZXMgPSBsZTY0X3RvX2NwdSh2ZHBhX2F1eC0+aWRlbnQuaHdfZmVhdHVyZXMpOwo+ICsgICAgICAg
c2VxX3ByaW50ZihzZXEsICJod19mZWF0dXJlczogICAgICAgICUjbGx4XG4iLCBod19mZWF0dXJl
cyk7Cj4gKyAgICAgICBwcmludF9mZWF0dXJlX2JpdHNfYWxsKHNlcSwgaHdfZmVhdHVyZXMpOwo+
Cj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+IEBAIC0yMDAsNyArMjAyLDYgQEAgc3RhdGljIGlu
dCBjb25maWdfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKPiAgewo+ICAgICAg
ICAgc3RydWN0IHBkc192ZHBhX2RldmljZSAqcGRzdiA9IHNlcS0+cHJpdmF0ZTsKPiAgICAgICAg
IHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyB2YzsKPiAtICAgICAgIHU2NCBkcml2ZXJfZmVhdHVy
ZXM7Cj4gICAgICAgICB1OCBzdGF0dXM7Cj4KPiAgICAgICAgIG1lbWNweV9mcm9taW8oJnZjLCBw
ZHN2LT52ZHBhX2F1eC0+dmRfbWRldi5kZXZpY2UsCj4gQEAgLTIyMywxMCArMjI0LDggQEAgc3Rh
dGljIGludCBjb25maWdfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKPiAgICAg
ICAgIHN0YXR1cyA9IHZwX21vZGVybl9nZXRfc3RhdHVzKCZwZHN2LT52ZHBhX2F1eC0+dmRfbWRl
dik7Cj4gICAgICAgICBzZXFfcHJpbnRmKHNlcSwgImRldl9zdGF0dXM6ICAgICAgICAgICAlI3hc
biIsIHN0YXR1cyk7Cj4gICAgICAgICBwcmludF9zdGF0dXNfYml0cyhzZXEsIHN0YXR1cyk7Cj4g
LQo+IC0gICAgICAgZHJpdmVyX2ZlYXR1cmVzID0gdnBfbW9kZXJuX2dldF9kcml2ZXJfZmVhdHVy
ZXMoJnBkc3YtPnZkcGFfYXV4LT52ZF9tZGV2KTsKPiAtICAgICAgIHNlcV9wcmludGYoc2VxLCAi
ZHJpdmVyX2ZlYXR1cmVzOiAgICAgICUjbGx4XG4iLCBkcml2ZXJfZmVhdHVyZXMpOwo+IC0gICAg
ICAgcHJpbnRfZmVhdHVyZV9iaXRzX2FsbChzZXEsIGRyaXZlcl9mZWF0dXJlcyk7Cj4gKyAgICAg
ICBzZXFfcHJpbnRmKHNlcSwgIm5lZ290aWF0ZWRfZmVhdHVyZXM6ICAlI2xseFxuIiwgcGRzdi0+
bmVnb3RpYXRlZF9mZWF0dXJlcyk7Cj4gKyAgICAgICBwcmludF9mZWF0dXJlX2JpdHNfYWxsKHNl
cSwgcGRzdi0+bmVnb3RpYXRlZF9mZWF0dXJlcyk7Cj4gICAgICAgICBzZXFfcHJpbnRmKHNlcSwg
InZkcGFfaW5kZXg6ICAgICAgICAgICAlZFxuIiwgcGRzdi0+dmRwYV9pbmRleCk7Cj4gICAgICAg
ICBzZXFfcHJpbnRmKHNlcSwgIm51bV92cXM6ICAgICAgICAgICAgICAlZFxuIiwgcGRzdi0+bnVt
X3Zxcyk7Cj4KPiAtLQo+IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
