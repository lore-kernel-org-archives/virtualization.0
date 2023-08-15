Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C6C001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 02:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E322681DF8;
	Tue, 15 Aug 2023 02:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E322681DF8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YupO12QT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-SrU8lQtI0o; Tue, 15 Aug 2023 02:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 74CD18144F;
	Tue, 15 Aug 2023 02:22:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74CD18144F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33AD0C0071;
	Tue, 15 Aug 2023 02:22:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAA5DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDA8581462
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:21:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDA8581462
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6sckeg6QiW3b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:21:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 028738144F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 02:21:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 028738144F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692066116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8Mf6SJdHrVFgrHSuwN7VWvzQVHaWatOcZXjdyX1ds0=;
 b=YupO12QTNuEh6TLb67DwCzFRbYq8j2wZHv/oFcAIPmFIFKA/AAhwNQvx0Rt9gbTa+nMBsc
 HH/8hEEnQxlZJQEvMXwuz4Th+pLmXcXoAIOSlKpPzL9KNjaQMLUiZn0SDFaLVr4J5Qb4FZ
 QAF2AdYe4DZ2ppwMmLC1Wj2J4UYx0P0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-z2hKCU2JPKCV40-egii7mw-1; Mon, 14 Aug 2023 22:21:55 -0400
X-MC-Unique: z2hKCU2JPKCV40-egii7mw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba7e6c988dso24050481fa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 19:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692066113; x=1692670913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8Mf6SJdHrVFgrHSuwN7VWvzQVHaWatOcZXjdyX1ds0=;
 b=ekeGTDdfDKyVTcKg9v07RsglRjQrlGKvNzoiYbt8AiD/103FXoED9CXLOR0FfGTQFj
 Lcf9TXhx6oC8CufCr34Y5ty+Tu6h815L8HDyYGkviE2VUgijqkL3QDMTZH0okOHuBd8j
 mtM/pEZXqYnNOyZNKI0Vg66e25d8N3m6AUyd7WP3Jonr88BOPgdGsDuoaCmtCWV6QYuc
 /xMc22mM7xr1ATGqkCrZN6h7Ch2oYhc57qm5aLUQr/O7vNBa8pbHwjZrcnjf8s1ccbJ+
 NJU+zlZBXc22UUs3e0a/V5XIE5RIkIsCf+N8ZDKODs6NPxnIDUDO4b0pgsBfve5VnZNJ
 TzJw==
X-Gm-Message-State: AOJu0YxoITroB88F7k1BhgABGBCarEpgWfxXAkKDp15Xkt8luYJk6ZEo
 oAeqFN57GAgu3IKtCAF8GQ/vTjWtII3AHXhIbZC+5sufqaZTBawVAbdcVtqHS0B2fg5DC6qYJwh
 XEkkE8RRomQR7BEQqL1Eb4fdk78CyvaF4izP2NpOKUglHASrYvYMLP2qFOw==
X-Received: by 2002:a2e:874a:0:b0:2ba:3eac:bece with SMTP id
 q10-20020a2e874a000000b002ba3eacbecemr7235379ljj.49.1692066113595; 
 Mon, 14 Aug 2023 19:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnFPM+Uyg4zQmIFAr0Gb+dF/9C1kz2mM3ka9Q1CxZ53dK/3gSYuO/vmcyZ0ZRwyR2cjgf2/GprDQT/zgDHZZ8=
X-Received: by 2002:a2e:874a:0:b0:2ba:3eac:bece with SMTP id
 q10-20020a2e874a000000b002ba3eacbecemr7235374ljj.49.1692066113253; Mon, 14
 Aug 2023 19:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 10:21:42 +0800
Message-ID: <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgOTo0NuKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgNyArKysrKysr
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggZGIxYjBlYS4u
M2EzODc4ZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsrKyBiL2luY2x1
ZGUvbGludXgvdmRwYS5oCj4gQEAgLTMxNCw2ICszMTQsMTIgQEAgc3RydWN0IHZkcGFfbWFwX2Zp
bGUgewo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQGlvdmE6IGlvdmEgdG8gYmUg
dW5tYXBwZWQKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBzaXplOiBzaXplIG9m
IHRoZSBhcmVhCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm5zIGludGVn
ZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4gKyAqIEByZXNldF9tYXA6ICAgICAgICAg
ICAgICAgICBSZXNldCBkZXZpY2UgbWVtb3J5IG1hcHBpbmcgKG9wdGlvbmFsKQo+ICsgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIGZvciBkZXZpY2UgdGhhdCB1c2luZyBkZXZp
Y2UKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNpZmljIERNQSB0cmFuc2xh
dGlvbiAob24tY2hpcCBJT01NVSkKClRoaXMgZXhwb3NlcyB0aGUgZGV2aWNlIGludGVybmFsIHRv
IHRoZSB1cHBlciBsYXllciB3aGljaCBpcyBub3Qgb3B0aW1hbC4KCkJ0dywgd2hhdCdzIHRoZSBk
aWZmZXJlbmNlIGJldHdlZW4gdGhpcyBhbmQgYSBzaW1wbGUKCnNldF9tYXAoTlVMTCk/CgpUaGFu
a3MKCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UK
PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBhc2lkOiBhZGRyZXNzIHNwYWNlIGlk
ZW50aWZpZXIKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgaW50ZWdl
cjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkKPiAgICogQGdldF92cV9kbWFfZGV2OiAgICAg
ICAgICAgIEdldCB0aGUgZG1hIGRldmljZSBmb3IgYSBzcGVjaWZpYwo+ICAgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlIChvcHRpb25hbCkKPiAgICogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+IEBAIC0zOTAsNiArMzk2LDcgQEAg
c3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAgICAgICAgICAgICAgICAgICAgICB1NjQgaW92
YSwgdTY0IHNpemUsIHU2NCBwYSwgdTMyIHBlcm0sIHZvaWQgKm9wYXF1ZSk7Cj4gICAgICAgICBp
bnQgKCpkbWFfdW5tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFz
aWQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSk7Cj4gKyAg
ICAgICBpbnQgKCpyZXNldF9tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQg
aW50IGFzaWQpOwo+ICAgICAgICAgaW50ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdW5zaWduZWQgaW50IGdyb3VwLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBhc2lkKTsKPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKigqZ2V0
X3ZxX2RtYV9kZXYpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7Cj4gLS0KPiAx
LjguMy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
