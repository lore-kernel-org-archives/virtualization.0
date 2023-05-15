Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB39CC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 15:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1774541B31;
	Mon, 15 May 2023 15:45:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1774541B31
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gImqqK7E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOTqGlr65Q_4; Mon, 15 May 2023 15:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25E0341B19;
	Mon, 15 May 2023 15:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25E0341B19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEADDC0036;
	Mon, 15 May 2023 15:45:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72676C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CEAF60B12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:45:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CEAF60B12
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=gImqqK7E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HR622yeRLK9q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:45:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6038760AE6
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6038760AE6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:45:13 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-50bc4bc2880so19836478a12.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1684165511; x=1686757511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPEGaC+x0TYEuX7HHgeWtz7pyNM4DGEHBqF/DDq7Iw0=;
 b=gImqqK7Ez4ILwctNY0AcR7B6kOcnLZLrABJErDV0yJSdTCJO24RZwul28fa1YXP4J5
 bKoHYDUdz0GrdUt1uvyJRzrL7wHWnEE7CFgoVdIxKph77hkZpY5hXoE8CN2AnKNyhvPE
 1WD55DRKkWgfPnF1cu9nglLrdj/x+IQwngXX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684165511; x=1686757511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPEGaC+x0TYEuX7HHgeWtz7pyNM4DGEHBqF/DDq7Iw0=;
 b=HoV3LBrwgGFAyBG0jsJdT7t3OVdDwQZV/vtzKVISWCWMHpi8Plvf7M2T17ddlFWgbv
 bc9nXygm2FJfCJST6fwC37RK8q69ztTTETYwywNz9f96t+2V4OfObFtTX/mzm0SGtnMO
 MX1JnGrXnUPEr6+eu/sxjE8Z+sg6wEzRcmcJbtG87XrVhrD67QYhdmeGBUsuNhFO63+H
 ecIcVhz2rwLILqoDXK9DMVBo3PnicRESqAZkW5AHzgpQ4rTgIl4zwoNMmj+TlEOX+HGJ
 c5KJPnjrchh68g6wxvHeq3tCA80d+ZlmWm2H+WR/qQO81rwtmLdzunCkm09JWEUJxM+n
 WO9A==
X-Gm-Message-State: AC+VfDzL0JQmaHbU+t0k5yD2mPtqzoQYkaA0egHGZevvuVzbDGTyuhkX
 9Cc91UomTaWHPDQcecnS2ItBiNBSMt9sUjLW87dDjAkg
X-Google-Smtp-Source: ACHHUZ7TTRaXXbVxxry8seKbMqqGxyU4p3jJF4LGCJ9A1gs+EmUsACiZhn9cbkSIQYiwJXH16gyISw==
X-Received: by 2002:a17:907:1614:b0:956:f4f8:23b6 with SMTP id
 hb20-20020a170907161400b00956f4f823b6mr36575670ejc.43.1684165511245; 
 Mon, 15 May 2023 08:45:11 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com.
 [209.85.218.54]) by smtp.gmail.com with ESMTPSA id
 hg14-20020a1709072cce00b009662de1937dsm9680060ejc.131.2023.05.15.08.45.09
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 08:45:10 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-965cc5170bdso1986312366b.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 08:45:09 -0700 (PDT)
X-Received: by 2002:a17:907:70d:b0:94b:d57e:9d4b with SMTP id
 xb13-20020a170907070d00b0094bd57e9d4bmr30521770ejb.2.1684165509441; Mon, 15
 May 2023 08:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
In-Reply-To: <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 May 2023 08:44:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Message-ID: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgNzoyM+KAr0FNIENocmlzdGlhbiBCcmF1bmVyIDxicmF1
bmVyQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gU28gSSB0aGluayB3ZSB3aWxsIGJlIGFibGUgdG8g
YWRkcmVzcyAoMSkgYW5kICgyKSBieSBtYWtpbmcgdmhvc3QgdGFza3MKPiBwcm9wZXIgdGhyZWFk
cyBhbmQgYmxvY2tpbmcgZXZlcnkgc2lnbmFsIGV4Y2VwdCBmb3IgU0lHS0lMTCBhbmQgU0lHU1RP
UAo+IGFuZCB0aGVuIGhhdmluZyB2aG9zdCBoYW5kbGUgZ2V0X3NpZ25hbCgpIC0gYXMgeW91IG1l
bnRpb25lZCAtIHRoZSBzYW1lCj4gd2F5IGlvIHVyaW5nIGFscmVhZHkgZG9lcy4gV2Ugc2hvdWxk
IGFsc28gcmVtb3ZlIHRoZSBpbmdvcmVfc2lnbmFscwo+IHRoaW5nIGNvbXBsZXRlbHkgaW1oby4g
SSBkb24ndCB0aGluayB3ZSBldmVyIHdhbnQgdG8gZG8gdGhpcyB3aXRoIHVzZXIKPiB3b3JrZXJz
LgoKUmlnaHQuIFRoYXQncyB3aGF0IElPX1VSSU5HIGRvZXM6CgogICAgICAgIGlmIChhcmdzLT5p
b190aHJlYWQpIHsKICAgICAgICAgICAgICAgIC8qCiAgICAgICAgICAgICAgICAgKiBNYXJrIHVz
IGFuIElPIHdvcmtlciwgYW5kIGJsb2NrIGFueSBzaWduYWwgdGhhdCBpc24ndAogICAgICAgICAg
ICAgICAgICogZmF0YWwgb3IgU1RPUAogICAgICAgICAgICAgICAgICovCiAgICAgICAgICAgICAg
ICBwLT5mbGFncyB8PSBQRl9JT19XT1JLRVI7CiAgICAgICAgICAgICAgICBzaWdpbml0c2V0aW52
KCZwLT5ibG9ja2VkLCBzaWdtYXNrKFNJR0tJTEwpfHNpZ21hc2soU0lHU1RPUCkpOwogICAgICAg
IH0KCmFuZCBJIHJlYWxseSB0aGluayB0aGF0IHZob3N0IHNob3VsZCBiYXNpY2FsbHkgZG8gZXhh
Y3RseSB3aGF0IGlvX3VyaW5nIGRvZXMuCgpOb3QgYmVjYXVzZSBpb191cmluZyBmdW5kYW1lbnRh
bGx5IGdvdCB0aGlzIHJpZ2h0IC0gYnV0IHNpbXBseSBiZWNhdXNlCmlvX3VyaW5nIGhhZCBhbG1v
c3QgYWxsIHRoZSBzYW1lIGJ1Z3MgKGFuZCB0aGVuIHNvbWUpLCBhbmQgd2hhdCB0aGUKaW9fdXJp
bmcgd29ya2VyIHRocmVhZHMgZW5kZWQgdXAgZG9pbmcgd2FzIHRvIGJhc2ljYWxseSB6b29tIGlu
IG9uCiJ0aGlzIHdvcmtzIi4KCkFuZCBpdCB6b29tZWQgaW4gb24gaXQgbGFyZ2VseSBieSBqdXN0
IGdvaW5nIGZvciAibWFrZSBpdCBsb29rIGFzIG11Y2gKYXMgcG9zc2libGUgYXMgYSByZWFsIHVz
ZXIgdGhyZWFkIiwgYmVjYXVzZSBldmVyeSB0aW1lIHRoZSBrZXJuZWwKdGhyZWFkIGRpZCBzb21l
dGhpbmcgZGlmZmVyZW50LCBpdCBqdXN0IGNhdXNlZCBwcm9ibGVtcy4KClNvIEkgdGhpbmsgdGhl
IHBhdGNoIHNob3VsZCBqdXN0IGxvb2sgc29tZXRoaW5nIGxpa2UgdGhlIGF0dGFjaGVkLgpNaWtl
LCBjYW4geW91IHRlc3QgdGhpcyBvbiB3aGF0ZXZlciB2aG9zdCB0ZXN0LXN1aXRlPwoKSSBkaWQg
Y29uc2lkZXIgZ2V0dGluZyByaWQgb2YgIi5pZ25vcmVfc2lnbmFscyIgZW50aXJlbHksIGFuZCBp
bnN0ZWFkCmp1c3Qga2V5aW5nIHRoZSAiYmxvY2sgc2lnbmFscyIgYmVoYXZpb3Igb2ZmIHRoZSAi
LnVzZXJfd29ya2VyIiBmbGFnLgpCdXQgdGhpcyBhcHByb2FjaCBkb2Vzbid0IHNlZW0gd3Jvbmcg
ZWl0aGVyLCBhbmQgSSBkb24ndCB0aGluayBpdCdzCndyb25nIHRvIG1ha2UgdGhlIGNyZWF0ZV9p
b190aHJlYWQoKSBmdW5jdGlvbiBzYXkgdGhhdAoiLmlnbm9yZV9zaWduYWxzID0gMSIgdGhpbmcg
ZXhwbGljaXRseSwgcmF0aGVyIHRoYW4ga2V5IGl0IG9mZiB0aGUKIi5pb190aHJlYWQiIGZsYWcu
CgpKZW5zL0NocmlzdGlhbiAtIGNvbW1lbnRzPwoKU2xpZ2h0bHkgcmVsYXRlZCB0byB0aGlzIGFs
bDogSSB0aGluayB2aG9zdCBzaG91bGQgYWxzbyBkbwpDTE9ORV9GSUxFUywgYW5kIGdldCByaWQg
b2YgdGhlIHdob2xlICIubm9fZmlsZXMiIHRoaW5nLiBBZ2FpbiwgaWYKdmhvc3QgZG9lc24ndCB1
c2UgYW55IGZpbGVzLCBpdCBzaG91bGRuJ3QgbWF0dGVyLCBhbmQgbG9va2luZwpkaWZmZXJlbnQg
anVzdCB0byBiZSBkaWZmZXJlbnQgaXMgd3JvbmcuIEJ1dCBpZiB2aG9zdCBkb2Vzbid0IHVzZSBh
bnkKZmlsZXMsIHRoZSBjdXJyZW50IHNpdHVhdGlvbiBzaG91bGRuJ3QgYmUgYSBidWcgZWl0aGVy
LgoKICAgICAgICAgICAgICAgICAgICAgTGludXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
