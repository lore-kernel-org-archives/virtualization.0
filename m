Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94027EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 06:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E1A84177A;
	Thu, 27 Jul 2023 06:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E1A84177A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BU4Fxp0K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inWGnnybhMQk; Thu, 27 Jul 2023 06:09:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B588A401A1;
	Thu, 27 Jul 2023 06:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B588A401A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F642C0072;
	Thu, 27 Jul 2023 06:09:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDAB6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6B1A60BE8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6B1A60BE8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BU4Fxp0K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wwAoevRhU6ZI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:09:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E90C060BC7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E90C060BC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690438165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHlsz0LypAsJKen8iGzFwcAD9nS/sYfmhPmKhEwdVpQ=;
 b=BU4Fxp0KT9Pg9iJMhdh/7CrcHL9dRz16qwq6MIhZUhOLAAkbmJvH6x3Tt6OSUIsuP7EkIC
 zXVIPXn+5yQM/nOq3dd+De3NYdo181gInVuf60lS8l95r4KUv8yWVUDxX9d0Lo1DfP1Nqv
 qT+x2YJvUE2swDmVypS9DrYkrB0gMLI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-B8DoCvGIMme8_g3CMC6IMw-1; Thu, 27 Jul 2023 02:09:22 -0400
X-MC-Unique: B8DoCvGIMme8_g3CMC6IMw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9b820c94fso4777571fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690438160; x=1691042960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHlsz0LypAsJKen8iGzFwcAD9nS/sYfmhPmKhEwdVpQ=;
 b=XHmXCU19mSNoSUZGpJeZEI98D5MdZwvDdH4+eBGvk/d7lpoViwU+oDfJ+FpcllQznm
 cbHXFG9XOwQnUCzyR2++GYwNf0+4mZ7RDWLzBGfGyVj/oYRtDYFdDAh/pUr6ezaxv/a2
 NvMU33PUII0dBQj52sZvPXIMUd6jS+ivFvbmQzmUXA5BjoqLGxHGDqNDV+r21jOqDsho
 R4Gf2FwXct39MtZpVHU5dp8HhUBCQpW1kwXUsh51nMQXk01Ye8ecrELq9JCh4nJnSeRW
 EU0XunWeRAu4l+oC47tz0kkZKB+r9ZnKwhkTgEN6uTxavP1YQdfb5nvqrMTwYhlCmtui
 Yp1A==
X-Gm-Message-State: ABy/qLaCLblR5clcGbCd5QynDhc+pO26mPxwl2H0CEAeZsLeAlnMc6Tr
 DCqZGEaXMt1vndyWoimIRJLqM+dyosm29z8xSEEqkvqv3hjgjgO8QNHaNASZNnSPQBk7rxKpNPx
 2QWc0OLsI/QeveT01JDi20sDGB3/qmb41Gqh55tEj9IoDmX0Fwbfta38ogA==
X-Received: by 2002:a2e:a0c7:0:b0:2b6:dc55:c3c7 with SMTP id
 f7-20020a2ea0c7000000b002b6dc55c3c7mr914281ljm.20.1690438160627; 
 Wed, 26 Jul 2023 23:09:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9gSQ6pqMIto55DqQ/PMDpcLyo2v1QAuKSuzXquZGm1GzyjEzrvi1fgxAP/gY2dc9tZHcbKbyVth3agxWpbD4=
X-Received: by 2002:a2e:a0c7:0:b0:2b6:dc55:c3c7 with SMTP id
 f7-20020a2ea0c7000000b002b6dc55c3c7mr914260ljm.20.1690438160346; Wed, 26 Jul
 2023 23:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230726191036.14324-1-dtatulea@nvidia.com>
In-Reply-To: <20230726191036.14324-1-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Jul 2023 14:09:09 +0800
Message-ID: <CACGkMEspMnAQq+mX_eNH9u32m+=7WN69aHi01J_DxSVL6qOiyQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-vdpa: Fix cpumask memory leak in
 virtio_vdpa_find_vqs()
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gal Pressman <gal@nvidia.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMzoxMeKAr0FNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IEZyb206IEdhbCBQcmVzc21hbiA8Z2FsQG52aWRpYS5j
b20+Cj4KPiBGcmVlIHRoZSBjcHVtYXNrIGFsbG9jYXRlZCBieSBjcmVhdGVfYWZmaW5pdHlfbWFz
a3MoKSBiZWZvcmUgcmV0dXJuaW5nCj4gZnJvbSB0aGUgZnVuY3Rpb24uCj4KPiBGaXhlczogM2Rh
ZDU2ODIzYjUzICgidmlydGlvLXZkcGE6IFN1cHBvcnQgaW50ZXJydXB0IGFmZmluaXR5IHNwcmVh
ZGluZyBtZWNoYW5pc20iKQo+IFNpZ25lZC1vZmYtYnk6IEdhbCBQcmVzc21hbiA8Z2FsQG52aWRp
YS5jb20+Cj4gUmV2aWV3ZWQtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29t
PgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4g
LS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAyICsrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IGluZGV4IDk4OWUyZDcx
ODRjZS4uOTYxMTYxZGE1OTAwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gQEAgLTM5MywxMSAr
MzkzLDEzIEBAIHN0YXRpYyBpbnQgdmlydGlvX3ZkcGFfZmluZF92cXMoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBudnFzLAo+ICAgICAgICAgY2IuY2FsbGJhY2sgPSB2
aXJ0aW9fdmRwYV9jb25maWdfY2I7Cj4gICAgICAgICBjYi5wcml2YXRlID0gdmRfZGV2Owo+ICAg
ICAgICAgb3BzLT5zZXRfY29uZmlnX2NiKHZkcGEsICZjYik7Cj4gKyAgICAgICBrZnJlZShtYXNr
cyk7Cj4KPiAgICAgICAgIHJldHVybiAwOwo+Cj4gIGVycl9zZXR1cF92cToKPiAgICAgICAgIHZp
cnRpb192ZHBhX2RlbF92cXModmRldik7Cj4gKyAgICAgICBrZnJlZShtYXNrcyk7Cj4gICAgICAg
ICByZXR1cm4gZXJyOwo+ICB9Cj4KPiAtLQo+IDIuNDEuMAo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
