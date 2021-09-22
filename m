Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73395C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 17:51:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0538E611CA
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 17:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0538E611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAFB7608B8;
	Wed, 22 Sep 2021 17:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dmy9WK-McgQw; Wed, 22 Sep 2021 17:51:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7935D60609;
	Wed, 22 Sep 2021 17:51:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F292C000F;
	Wed, 22 Sep 2021 17:51:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B706C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CA51407A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvTaxIj_OBY0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:51:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 438A240691
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:51:09 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id i132so12819135qke.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rZT2K/Q8MUfaC2qjpJTTFyZ9xAJMAYxQ7cgEJCjq2XY=;
 b=MPds0ZGb7d0+CWzI3IilgsLSQygqyPWCjWlOAXUh2tHeCGrHgpetNvxFmfD6QnhOQV
 1bdl5zXekJR4RUdJYMmgVcLebiNcBUPeRUVsy57tWR2SJvZEqg0xZb8frrm+Wom5QqIT
 mL5HC0qmGPH+zzRqBhXinHZCCIGvLqAs+9S2biycWjurIpNIxmG3M5PU9IuPk9VzCgmK
 Qsnw0QAypE6Sfu8609A3TGaAQ6ue+0MbApyeG7ZX4YH92Fy/L6sCPY+AU3JdXySi60Yw
 WKz0pXYX6Mkcd7YiEgbzEpUyKfBEiTXlEGs1h7v6hyQPpGvXTU+xSDQCWXTGHkOVMoir
 90VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rZT2K/Q8MUfaC2qjpJTTFyZ9xAJMAYxQ7cgEJCjq2XY=;
 b=7lHEwQ/28EpY8wm6GcGg/gUyZfH13VeticgCP7SfY86qxZHvycx5M+r5LKV8yupT/6
 xxiQXV1wrD0t1B+f/uO8A1vHP2sq0Z4WA54YFYtRSD9UEz51qZc+x/Wt9d5qVnk7dRwP
 uFJBtsPII18fDVWmRkAXujPKjJ2L/TeFllNh/CchIlF0WPb/IU0nn1unh+x79XrV33L4
 gjoeaJNd4dZYAC87rfjenkz9pwfsFJhJI4CxCVyGqikpnDw9IO693rrdd9kNr8wPNPfz
 92TgJ2Cc1UDs9G16n66usihWwbzpMHZY1XvOo6YJIm6JcuWPvC+qbK2MnDO6p1wIdXHC
 J7rg==
X-Gm-Message-State: AOAM531l9EKaN+S3BpHbUU66W1ky1+GG4DAtmR5+dwFL3PpQZ6oBJcQv
 YnkDn0uwd+DDaLTwWF8z3R3XJn7z4pG9/0n5b2xPEA==
X-Google-Smtp-Source: ABdhPJxZSPLU6e99TrTbzJ6w6df7pzDnSCeIHFgfVnVpx2mXfKFc++W0UqO880O7okYtJcSCtbBn/emVclazGAvdlEg=
X-Received: by 2002:a37:8044:: with SMTP id b65mr531503qkd.150.1632333067678; 
 Wed, 22 Sep 2021 10:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210922170903.577801-1-lvivier@redhat.com>
In-Reply-To: <20210922170903.577801-1-lvivier@redhat.com>
Date: Wed, 22 Sep 2021 19:50:31 +0200
Message-ID: <CAG_fn=Xpek=e6drdCBQXUUvd5kAh-Ui7Xfjg6CY=MNpt0KHjqg@mail.gmail.com>
Subject: Re: [PATCH 0/4] hwrng: virtio - add an internal buffer
To: Laurent Vivier <lvivier@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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
From: Alexander Potapenko via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgNzowOSBQTSBMYXVyZW50IFZpdmllciA8bHZpdmllckBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IGh3cm5nIGNvcmUgdXNlcyB0d28gYnVmZmVycyB0aGF0IGNh
biBiZSBtaXhlZCBpbiB0aGUgdmlydGlvLXJuZyBxdWV1ZS4KPgo+IFRoaXMgc2VyaWVzIGZpeGVz
IHRoZSBwcm9ibGVtIGJ5IGFkZGluZyBhbiBpbnRlcm5hbCBidWZmZXIgaW4gdmlydGlvLXJuZy4K
Pgo+IE9uY2UgdGhlIGludGVybmFsIGJ1ZmZlciBpcyBhZGRlZCwgd2UgY2FuIGZpeCB0d28gb3Ro
ZXIgcHJvYmxlbXM6Cj4KPiAtIHRvIGJlIGFibGUgdG8gcmVsZWFzZSB0aGUgZHJpdmVyIHdpdGhv
dXQgd2FpdGluZyB0aGUgZGV2aWNlIHJlbGVhc2VzIHRoZQo+ICAgYnVmZmVyCj4KPiAtIGFjdHVh
bGx5IHJldHVybnMgc29tZSBkYXRhIHdoZW4gd2FpdD0wIGFzIHdlIGNhbiBoYXZlIHNvbWUgYWxy
ZWFkeQo+ICAgYXZhaWxhYmxlIGRhdGEKPgo+IEl0IGFsc28gdHJpZXMgdG8gaW1wcm92ZSB0aGUg
cGVyZm9ybWFuY2UgYnkgYWx3YXlzIGhhdmluZyBhIGJ1ZmZlciBpbgo+IHRoZSBxdWV1ZSBvZiB0
aGUgZGV2aWNlLgoKVGVzdGVkLWJ5OiBBbGV4YW5kZXIgUG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xl
LmNvbT4KZm9yIHRoZSBzZXJpZXMKCldpdGggdGhlc2UgZm91ciBwYXRjaGVzIGFwcGxpZWQsIEtN
U0FOIHN0b3BzIHJlcG9ydGluZyBib290LXRpbWUKZXJyb3JzIGluIF9taXhfcG9vbF9ieXRlcyBy
ZXBvcnRlZCBoZXJlOgpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC12aXJ0dWFs
aXphdGlvbi9tc2c0NjMxMC5odG1sCgo+IExhdXJlbnQgVml2aWVyICg0KToKPiAgIGh3cm5nOiB2
aXJ0aW8gLSBhZGQgYW4gaW50ZXJuYWwgYnVmZmVyCj4gICBod3JuZzogdmlydGlvIC0gZG9uJ3Qg
d2FpdCBvbiBjbGVhbnVwCj4gICBod3JuZzogdmlydGlvIC0gZG9uJ3Qgd2FzdGUgZW50cm9weQo+
ICAgaHdybmc6IHZpcnRpbyAtIGFsd2F5cyBhZGQgYSBwZW5kaW5nIHJlcXVlc3QKPgo+ICBkcml2
ZXJzL2NoYXIvaHdfcmFuZG9tL3ZpcnRpby1ybmcuYyB8IDg0ICsrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlv
bnMoLSkKPgo+IC0tCj4gMi4zMS4xCj4KPgoKCi0tIApBbGV4YW5kZXIgUG90YXBlbmtvClNvZnR3
YXJlIEVuZ2luZWVyCgpHb29nbGUgR2VybWFueSBHbWJICkVyaWthLU1hbm4tU3RyYcOfZSwgMzMK
ODA2MzYgTcO8bmNoZW4KCkdlc2Now6RmdHNmw7xocmVyOiBQYXVsIE1hbmljbGUsIEhhbGltYWgg
RGVMYWluZSBQcmFkbwpSZWdpc3RlcmdlcmljaHQgdW5kIC1udW1tZXI6IEhhbWJ1cmcsIEhSQiA4
Njg5MQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IEhhbWJ1cmcKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
