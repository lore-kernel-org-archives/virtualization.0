Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3FEC7EE26
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 13:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C09D83B4A;
	Mon,  8 May 2023 13:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C09D83B4A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=BQfgfPou
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0zf7VhLxyEa; Mon,  8 May 2023 13:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 876C983B78;
	Mon,  8 May 2023 13:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 876C983B78
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 527B3C0037;
	Mon,  8 May 2023 13:59:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBFB4C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 13:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A40466143E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 13:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A40466143E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=BQfgfPou
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6Jh3yvml2Ge
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 13:59:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85510611CC
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85510611CC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 13:59:13 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1929818d7faso31626787fac.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 May 2023 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683554352; x=1686146352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKI5hargzKBJ4u7aTkJl99CJ0qfSrzAu9HhTH/5DBYA=;
 b=BQfgfPoucSO9c0iYSjaKh5WEjsLp6hSV70hZxGF9TjAkJY+7/p6Nl+vDhsx9L1ZWWf
 nXRiiqmxG1ptJIeP60CAb/vG1tzQp3aaKCqoA5quhRNYwDaLA+taA/HrpcFDaebaYYLK
 TFx4iwsiU7MqaR2VgjhUizBLHi10ICQLi9yGOUikTGCFsBk4YIAS/VtILBrEUno6W6OU
 +3/p7jTt0njRB6rhvXCRxTKjQ32yVxonaeG+p6HHcRP7Wy4JhWynRY2lwI48IXn2DWxe
 9dvbCYsVbQB5v0B6igzIKSHgzqADtdDCm8FdUfFYlgPVSXwo9b73EID5SU1986f1yMD5
 xjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683554352; x=1686146352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKI5hargzKBJ4u7aTkJl99CJ0qfSrzAu9HhTH/5DBYA=;
 b=kNp3PpiYo6gKNmGglOsFOrIXttezpy2dwvH2g4YsCC0Yujum/rZ8ynuB4esiVUJ7qO
 ZESOyAUWbdY/+4R78YCWKLhRubR8x/RQXMSwmO9jY7lZ9+IB0td2qA5yGmzVjxQ8op2K
 WEgIGkuqXGWU9VhHXrYDRaJxLq1eY/bMLXI1uiEu8745MIfF5rRgWeR93hOYlq1cAPqK
 ZTn5xlVilpyZFrWJnUogsicfZyqU8H9uQ8a4dYXkwS/TvsjUF1DLMSpkg2pem0bFrmkt
 c+GFeS+y7579NWVDXxYgcfQK/OrXyI6NNbFhu/10roq3VWXIebciWq37QmpyAAyGx8r3
 /NwA==
X-Gm-Message-State: AC+VfDwRQ754oFBE1SuAwd1sCSd4ntfmZE8fDocGtJ2nxAIV4/axIiDL
 6y/S55WTzw2SFqxg3acUxENk+eIx6LTEoRbkoxA=
X-Google-Smtp-Source: ACHHUZ50LkNfTNRkSeGJJPoa/BAX/xul353Ik0wlxeRY6hIxnEX5WoLqEnM6SGjMhC3zTb7ICsPNNWeUaMeA3jfGlNY=
X-Received: by 2002:aca:c0c1:0:b0:387:31fd:1782 with SMTP id
 q184-20020acac0c1000000b0038731fd1782mr6592750oif.28.1683554352400; Mon, 08
 May 2023 06:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
 <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
In-Reply-To: <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 8 May 2023 06:59:02 -0700
Message-ID: <CAF6AEGs4fuq4i8UJdO5hvgHTNhzFMKGZ87+w1oyvL0LAqWio6A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>, kernel@collabora.com,
 Chia-I Wu <olvaffe@gmail.com>, Emil Velikov <emil.velikov@collabora.com>
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

T24gV2VkLCBNYXkgMywgMjAyMyBhdCAxMDowN+KAr0FNIEd1cmNoZXRhbiBTaW5naAo8Z3VyY2hl
dGFuc2luZ2hAY2hyb21pdW0ub3JnPiB3cm90ZToKPgo+Cj4KPiBPbiBNb24sIE1heSAxLCAyMDIz
IGF0IDg6MzjigK9BTSBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEu
Y29tPiB3cm90ZToKPj4KPj4gT24gNC8xNi8yMyAxNDo1MiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3Rl
Ogo+PiA+IFdlIGhhdmUgbXVsdGlwbGUgVnVsa2FuIGNvbnRleHQgdHlwZXMgdGhhdCBhcmUgYXdh
aXRpbmcgZm9yIHRoZSBhZGRpdGlvbgo+PiA+IG9mIHRoZSBzeW5jIG9iamVjdCBEUk0gVUFQSSBz
dXBwb3J0IHRvIHRoZSBWaXJ0SU8tR1BVIGtlcm5lbCBkcml2ZXI6Cj4+ID4KPj4gPiAgMS4gVmVu
dXMgY29udGV4dAo+PiA+ICAyLiBOYXRpdmUgY29udGV4dHMgKHZpcnRpby1mcmVlZHJlbm8sIHZp
cnRpby1pbnRlbCwgdmlydGlvLWFtZGdwdSkKPj4gPgo+PiA+IE1lc2EgY29yZSBzdXBwb3J0cyBE
Uk0gc3luYyBvYmplY3QgVUFQSSwgcHJvdmlkaW5nIFZ1bGthbiBkcml2ZXJzIHdpdGggYQo+PiA+
IGdlbmVyaWMgZmVuY2luZyBpbXBsZW1lbnRhdGlvbiB0aGF0IHdlIHdhbnQgdG8gdXRpbGl6ZS4K
Pj4gPgo+PiA+IFRoaXMgcGF0Y2ggYWRkcyBpbml0aWFsIHN5bmMgb2JqZWN0cyBzdXBwb3J0LiBJ
dCBjcmVhdGVzIGZ1bmRhbWVudCBmb3IgYQo+PiA+IGZ1cnRoZXIgZmVuY2luZyBpbXByb3ZlbWVu
dHMuIExhdGVyIG9uIHdlIHdpbGwgd2FudCB0byBleHRlbmQgdGhlIFZpcnRJTy1HUFUKPj4gPiBm
ZW5jaW5nIEFQSSB3aXRoIHBhc3NpbmcgZmVuY2UgSURzIHRvIGhvc3QgZm9yIHdhaXRpbmcsIGl0
IHdpbGwgYmUgYSBuZXcKPj4gPiBhZGRpdGlvbmFsIFZpcnRJTy1HUFUgSU9DVEwgYW5kIG1vcmUu
IFRvZGF5IHdlIGhhdmUgc2V2ZXJhbCBWaXJ0SU8tR1BVIGNvbnRleHQKPj4gPiBkcml2ZXJzIGlu
IHdvcmtzIHRoYXQgcmVxdWlyZSBWaXJ0SU8tR1BVIHRvIHN1cHBvcnQgc3luYyBvYmplY3RzIFVB
UEkuCj4+ID4KPj4gPiBUaGUgcGF0Y2ggaXMgaGVhdmlseSBpbnNwaXJlZCBieSB0aGUgc3luYyBv
YmplY3QgVUFQSSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUKPj4gPiBNU00gZHJpdmVyLgo+Pgo+PiBH
ZXJkLCBkbyB5b3UgaGF2ZSBhbnkgb2JqZWN0aW9ucyB0byBtZXJnaW5nIHRoaXMgc2VyaWVzPwo+
Pgo+PiBXZSBoYXZlIEFNREdQVSBbMV0gYW5kIEludGVsIFsyXSBuYXRpdmUgY29udGV4dCBXSVAg
ZHJpdmVycyBkZXBlbmRpbmcgb24KPj4gdGhlIHN5bmMgb2JqZWN0IHN1cHBvcnQuIEl0IGlzIHRo
ZSBvbmx5IHBhcnQgbWlzc2luZyBmcm9tIGtlcm5lbCB0b2RheQo+PiB0aGF0IGlzIHdhbnRlZCBi
eSB0aGUgbmF0aXZlIGNvbnRleHQgZHJpdmVycy4gT3RoZXJ3aXNlLCB0aGVyZSBhcmUgZmV3Cj4+
IG90aGVyIHRoaW5ncyBpbiBRZW11IGFuZCB2aXJnbHJlbmRlcmVyIGxlZnQgdG8gc29ydCBvdXQu
Cj4+Cj4+IFsxXSBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vbWVy
Z2VfcmVxdWVzdHMvMjE2NTgKPj4gWzJdIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9k
aWdldHgvbWVzYS8tL2NvbW1pdHMvbmF0aXZlLWNvbnRleHQtaXJpcwo+Cj4KPiBJJ20gbm90IHNh
eWluZyB0aGlzIGNoYW5nZSBpc24ndCBnb29kLCBqdXN0IGl0J3MgcHJvYmFibHkgcG9zc2libGUg
dG8gaW1wbGVtZW50IHRoZSBuYXRpdmUgY29udGV4dHMgKGV2ZW4gdXAgdG8gZXZlbiBWSzEuMikg
d2l0aG91dCBpdC4gIEJ1dCB0aGlzIHBhdGNoIHNlcmllcyBtYXkgYmUgdGhlIG1vc3QgZXJnb25v
bWljIHdheSB0byBkbyBpdCwgZ2l2ZW4gaG93IE1lc2EgaXMgZGVzaWduZWQuICBCdXQgeW91IHBy
b2JhYmx5IHdhbnQgb25lIG9mIE1lc2EgTVJzIHJldmlld2VkIGZpcnN0IGJlZm9yZSBtZXJnaW5n
IChJIGFkZGVkIGEgY29tbWVudCBvbiB0aGUgYW1kZ3B1IGNoYW5nZSkgYW5kIHRoYXQgaXMgYSBy
ZXF1aXJlbWVudCBbYV0uCj4KPiBbYV0gIlRoZSB1c2Vyc3BhY2Ugc2lkZSBtdXN0IGJlIGZ1bGx5
IHJldmlld2VkIGFuZCB0ZXN0ZWQgdG8gdGhlIHN0YW5kYXJkcyBvZiB0aGF0IHVzZXIgc3BhY2Ug
cHJvamVjdC4gRm9yIGUuZy4gbWVzYSB0aGlzIG1lYW5zIHBpZ2xpdCB0ZXN0Y2FzZXMgYW5kIHJl
dmlldyBvbiB0aGUgbWFpbGluZyBsaXN0LiBUaGlzIGlzIGFnYWluIHRvIGVuc3VyZSB0aGF0IHRo
ZSBuZXcgaW50ZXJmYWNlIGFjdHVhbGx5IGdldHMgdGhlIGpvYiBkb25lLiIgLS0gZnJvbSB0aGUg
cmVxdWlyZW1lbnRzCj4KCnRiaCwgdGhlIHN5bmNvYmogc3VwcG9ydCBpcyBhbGwgZHJtIGNvcmUs
IHRoZSBvbmx5IGRyaXZlciBzcGVjaWZpY3MgaXMKdGhlIGlvY3RsIHBhcnNpbmcuICBJTUhPIGV4
aXN0aW5nIHRlc3RzIGFuZCB0aGUgdHdvIGV4aXN0aW5nIGNvbnN1bWVycwphcmUgc3VmZmljaWVu
dC4gIChBbHNvLCBjb25zaWRlcmluZyB0aGF0IGFkZGl0aW9uYWwgbm9uLWRybQpkZXBlbmRlbmNp
ZXMgaW52b2x2ZWQuKQoKSWYgdGhpcyB3YXMgZm9yIHRoZSBjb3JlIGRybSBzeW5jb2JqIGltcGxl
bWVudGF0aW9uLCBhbmQgbm90IGp1c3QKZHJpdmVyIGlvY3RsIHBhcnNpbmcgYW5kIHdpcmluZyB1
cCB0aGUgY29yZSBoZWxwZXJzLCBJIHdvdWxkIGFncmVlCndpdGggeW91LgoKQlIsCi1SCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
