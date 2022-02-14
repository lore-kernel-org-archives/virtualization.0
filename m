Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B31C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 06:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D34B4029B;
	Mon, 14 Feb 2022 06:28:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NJInOMTRiZy; Mon, 14 Feb 2022 06:28:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 339834029F;
	Mon, 14 Feb 2022 06:28:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09481C0011;
	Mon, 14 Feb 2022 06:28:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36262C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 181E9606F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gCByCj-Is7OR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:28:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B19A60648
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644820113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gS2aVmuoCtNo2/qNoxUIuIA2KGBRg4tAugCTlOlURtc=;
 b=DKFxj+3n6Nm2/UcVFZCXOwnd4s8xCsUUFbYn9G/9tPQUZXQMN3kM0DoA75RYY5L/uXfViO
 vVx01yOiV3kKDcg0Wz0znSIvOEkVsRzF/A4SwUFIV16t/K1MQcXxU4Z4XHm8N8l1w7zkhc
 R/Sj05FCRgwYzHhx0gCmlNPsBi2y5nQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-zCarzctGPo6Cnvp-253Ikw-1; Mon, 14 Feb 2022 01:28:30 -0500
X-MC-Unique: zCarzctGPo6Cnvp-253Ikw-1
Received: by mail-pf1-f200.google.com with SMTP id
 i16-20020aa78d90000000b004be3e88d746so11051775pfr.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gS2aVmuoCtNo2/qNoxUIuIA2KGBRg4tAugCTlOlURtc=;
 b=n3P08gvMVpyessIvmmAM6yYmqBuMALm5MAxGhz6yJ35Sx5jrOb+XkhNxO7MKB35iW8
 E5KksiTHvuYomiSWD2DQeVgnc4V874nTddRfvPS1SEBq/nXGh3cM12xfWc7g3pBms4xn
 yU/S1Y9UdlyHhJnm6ZFYnsWSKJWm8DhHamqcz/hyrtbzaAe/k9k3IoqQ0jhsN1OsHL3E
 BDEYVK5MCvZASYcZbziLLyz+fLbWvbecojUyM+RK1EttRv6PGsXfEaVn8+HkGrcN+haY
 73IbamazDtFVhHJawxo1uvHJH1C8dFmceNa8j+RGYT442pcwytgCU4KD40glaG0QTYIQ
 pGYQ==
X-Gm-Message-State: AOAM533NSRXjnmwTz7cSPMrhSfAU0VpwsfRNorLq5f9Zdi3zvf/qAmaI
 FPuXMvBdrUQAlh2J4tPojKdpcDLtFqcWKFjTbCKKseF+4LBD/3lzpdfuPb8/ftUdzTu7yuYF3/Z
 RQLo+t7UcDS85kSc/tRKwEZOmFczLkUgcj6CpiEJpIg==
X-Received: by 2002:a65:4bc9:: with SMTP id p9mr10524814pgr.168.1644820109459; 
 Sun, 13 Feb 2022 22:28:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy08bsIikDcGp2bA1tyX8g5QfTM2Ih/be5IzmuVhJji489CNCEeYdKeS+uiIb0h5jrkZCyCA==
X-Received: by 2002:a65:4bc9:: with SMTP id p9mr10524806pgr.168.1644820109276; 
 Sun, 13 Feb 2022 22:28:29 -0800 (PST)
Received: from [10.72.12.239] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j14sm36793051pfj.218.2022.02.13.22.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Feb 2022 22:28:28 -0800 (PST)
Message-ID: <850f56f6-870f-deb3-da6a-6df6e238e234@redhat.com>
Date: Mon, 14 Feb 2022 14:28:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH V4 3/4] vhost_vdpa: don't setup irq offloading when
 irq_num < 0
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220203072735.189716-1-lingshan.zhu@intel.com>
 <20220203072735.189716-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220203072735.189716-4-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzIvMyDkuIvljYgzOjI3LCBaaHUgTGluZ3NoYW4g5YaZ6YGTOgo+IFdoZW4gaXJx
IG51bWJlciBpcyBuZWdhdGl2ZShlLmcuLCAtRUlOVkFMKSwgdGhlIHZpcnRxdWV1ZQo+IG1heSBi
ZSBkaXNhYmxlZCBvciB0aGUgdmlydHF1ZXVlcyBhcmUgc2hhcmluZyBhIGRldmljZSBpcnEuCj4g
SW4gc3VjaCBjYXNlLCB3ZSBzaG91bGQgbm90IHNldHVwIGlycSBvZmZsb2FkaW5nIGZvciBhIHZp
cnRxdWV1ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNCArKysrCj4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9z
dC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4IDg1MTUzOTgwN2JjOS4uYzRm
Y2FjYjBkZTNhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiBAQCAtOTYsNiArOTYsMTAgQEAgc3RhdGljIHZvaWQgdmhvc3Rf
dmRwYV9zZXR1cF92cV9pcnEoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4gICAJaWYg
KCFvcHMtPmdldF92cV9pcnEpCj4gICAJCXJldHVybjsKPiAgIAo+ICsJaXJxID0gb3BzLT5nZXRf
dnFfaXJxKHZkcGEsIHFpZCk7Cj4gKwlpZiAoaXJxIDwgMCkKPiArCQlyZXR1cm47Cj4gKwo+ICAg
CWlycSA9IG9wcy0+Z2V0X3ZxX2lycSh2ZHBhLCBxaWQpOwoKClNvIHRoZSBnZXRfdnFfaXJxKCkg
d2lsbCBiZSBjYWxsZWQgdHdpY2U/CgoKPiAgIAlpcnFfYnlwYXNzX3VucmVnaXN0ZXJfcHJvZHVj
ZXIoJnZxLT5jYWxsX2N0eC5wcm9kdWNlcik7Cj4gICAJaWYgKCF2cS0+Y2FsbF9jdHguY3R4IHx8
IGlycSA8IDApCgoKV2UncmUgYWxyZWFkeSBjaGVja2VkIGlycSBhZ2FpbnN0IDAgaGVyZS4KClRo
YW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
