Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE7EC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F53C60E70;
	Mon,  6 Nov 2023 07:26:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F53C60E70
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aa4PPyLH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kl4jaCszMrH; Mon,  6 Nov 2023 07:26:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24B9F60FD4;
	Mon,  6 Nov 2023 07:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24B9F60FD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3960C0071;
	Mon,  6 Nov 2023 07:26:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B87C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF00F40C01
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:26:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF00F40C01
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aa4PPyLH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7CbTh4uqdRBP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:26:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDA6440350
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:26:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDA6440350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evSFj1U1p+Ny9gPIF1c5/6yqRIJ9hrTGuB8/aTR/hqw=;
 b=aa4PPyLHSLeWmM3nWbyRMwqqX04W9a+KcbN3yokCllH2rOACVLy4hj6JukpPbmd7iYQi5E
 wIJA7ACHuuOkN2Wd4AWgKg8LvLFHDGjbCEPtQ0U5asvxNQSLTVos4P5TLDdruadqfiNxia
 pN0pdELxKvH9HfEB6xamor/BFLdjc3Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-AIOjZ3gTPl-ZL5IGzSWFXw-1; Mon, 06 Nov 2023 02:26:25 -0500
X-MC-Unique: AIOjZ3gTPl-ZL5IGzSWFXw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c5161838d8so40318281fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Nov 2023 23:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699255583; x=1699860383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evSFj1U1p+Ny9gPIF1c5/6yqRIJ9hrTGuB8/aTR/hqw=;
 b=Wdi0uxnim86G0YyIzGOvI+Hz0fFJftTNacneixuGoYaUEwOVr+gHsfQTqln/wyVA+c
 EQMRKPzgPPeDJGr0IsdfPt610Ss4JSwMIUpWQQQHdx1P0PWM8E+StzcUxNyQOqIsGjm5
 Fw0B5tM80eoeNYlz7UwgoleEoRL5xnrlZTkmE2vTPWy3dDGHD1meLguAMAmqAUVx+kwS
 a9MZO+/j3mUCYDmWXg9g+GRqjgmv/VsgUsPKDsKJm8jhRZCN4HYZvryahZ6CgejWA8qd
 GDfzgKxZ8ruUomXsCPMrY8a8qS08XDhJm2bKCYl9txzX3uLsvKLBxEFs+iTuBbXKEX54
 aZMQ==
X-Gm-Message-State: AOJu0Yy2xgf7fgndT4VyQifjXRmVfPycDc1PY8qG5dTZutDTl+yMXqG7
 QzjBuYmtC5pK0riCJdQMqMTeRMRNpmOYO5aZ3R4jy2LBn1MZ+Ej/CyssuWDa4J4kjEjEgL9clG4
 A9HSt1e6FCmoM/OitCJWtKlpJFwUq3srsYmkpGP2BAglo0f9uiW5gvi7PdQ==
X-Received: by 2002:ac2:4903:0:b0:507:9628:afb with SMTP id
 n3-20020ac24903000000b0050796280afbmr22045588lfi.68.1699255583630; 
 Sun, 05 Nov 2023 23:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcZHQqKWdEULM3eBwn+4d0ZXxU5lMFxm0yiPC67W449u3K16MJzdZf96kxwAhxM88I6SzimJ/v/7HYurwI7AQ=
X-Received: by 2002:ac2:4903:0:b0:507:9628:afb with SMTP id
 n3-20020ac24903000000b0050796280afbmr22045574lfi.68.1699255583367; Sun, 05
 Nov 2023 23:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-9-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-9-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:26:12 +0800
Message-ID: <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function
 iommu_device_use_default_domain
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU2F0LCBOb3YgNCwgMjAyMyBhdCAxOjE44oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPiBFeHBvc2UgdGhlIGZ1bmN0aW9uIGlvbW11X2RldmljZV91c2VfZGVmYXVs
dF9kb21haW4oKSBhbmQKPiBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4oKe+8jAo+
IFdoaWxlIHZkcGEgYmluZCB0aGUgaW9tbXVmZCBkZXZpY2UgYW5kIGRldGFjaCB0aGUgaW9tbXUg
ZGV2aWNlLAo+IHZkcGEgbmVlZCB0byBjYWxsIHRoZSBmdW5jdGlvbgo+IGlvbW11X2RldmljZV91
bnVzZV9kZWZhdWx0X2RvbWFpbigpIHRvIHJlbGVhc2UgdGhlIG93bmVyCj4KPiBTaWduZWQtb2Zm
LWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgoKVGhpcyBpcyB0aGUgZW5kIG9mIHRoZSBz
ZXJpZXMsIHdobyBpcyB0aGUgdXNlciB0aGVuPwoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL2lv
bW11L2lvbW11LmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11
LmMKPiBpbmRleCAzYmZjNTZkZjRmNzguLjk4N2NiZjhjOWE4NyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2lvbW11L2lvbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiBAQCAtMzE2
NCw2ICszMTY0LDcgQEAgaW50IGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4oc3RydWN0
IGRldmljZSAqZGV2KQo+Cj4gICAgICAgICByZXR1cm4gcmV0Owo+ICB9Cj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4pOwo+Cj4gIC8qKgo+ICAgKiBp
b21tdV9kZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4oKSAtIERldmljZSBkcml2ZXIgc3RvcHMg
aGFuZGxpbmcgZGV2aWNlCj4gQEAgLTMxODcsNiArMzE4OCw3IEBAIHZvaWQgaW9tbXVfZGV2aWNl
X3VudXNlX2RlZmF1bHRfZG9tYWluKHN0cnVjdCBkZXZpY2UgKmRldikKPiAgICAgICAgIG11dGV4
X3VubG9jaygmZ3JvdXAtPm11dGV4KTsKPiAgICAgICAgIGlvbW11X2dyb3VwX3B1dChncm91cCk7
Cj4gIH0KPiArRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGV2aWNlX3VudXNlX2RlZmF1bHRfZG9t
YWluKTsKPgo+ICBzdGF0aWMgaW50IF9faW9tbXVfZ3JvdXBfYWxsb2NfYmxvY2tpbmdfZG9tYWlu
KHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXApCj4gIHsKPiAtLQo+IDIuMzQuMwo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
