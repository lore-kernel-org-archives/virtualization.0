Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B34CC77B78
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 18:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3E1F4150E;
	Mon, 24 Apr 2023 18:40:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3E1F4150E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Xlsh1dnv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsAUYNJlO_cM; Mon, 24 Apr 2023 18:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 908734151A;
	Mon, 24 Apr 2023 18:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 908734151A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D575C0037;
	Mon, 24 Apr 2023 18:40:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BCDCC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 18:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5B6C60FD0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 18:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5B6C60FD0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Xlsh1dnv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n52Ue71jQgjD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 18:40:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B760C606C6
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B760C606C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 18:40:38 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5058181d58dso8556932a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1682361636; x=1684953636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzJOzH+7Z8w3/WGFZ7bEKUxGZRSO1RUpCg2aWmbmuJ4=;
 b=Xlsh1dnvxH4Rhmaqp+YZbzeXQYEPyjVZhfnq3CgiAa9mEJt5/4BFI5hUqu8uxIO7Nl
 eoH9JfIcJXRUY69/yYzDNqDJ4UY+pMTy53BnhFVTnZ9n/mI9DhJoYgPSKQ/O1sOHrb5h
 5y8y8UcHYq3X9v4Bne6h/6OvM763JXLP8wcWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682361636; x=1684953636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzJOzH+7Z8w3/WGFZ7bEKUxGZRSO1RUpCg2aWmbmuJ4=;
 b=D7pCxJJ97lBE9Uyr/Rm0UK6+4hNynS7XrqAt86aa26ZSzPyW5o7BzxaV/p0bdcFJ2u
 QpkOS2nBnW5gRU1zk7cH8zxYdkTmAKU02wxotiEo7vWZ4CAl2zywz4wtdGQHcONMqReq
 V+Ct+z37udawfs1u4OqsdJEIoE8aq75DlxwWf3kDZhXOdaDf4O5PCzZuvtNR3LJ60944
 T4lvTMvykflxN7OuATIgpGZlf6Ep9rCFMtfzv/uEMRL81uZEGbJeddHaGmbXNaHGC0Z+
 bu9ErSem0P93Fkhb3NpKtRrL17/3oBdbJNg1x3f/oaWui7zR6Qwz5jtuXM9BKgp4QcUq
 unlg==
X-Gm-Message-State: AAQBX9dFsDIjpU+Fago6+weo9JO31bTc5xaDiCl8Z1hyuSLiaiXNXSd/
 +p0/fcvdHBREDp6Q9xZN2fVZNDVIPyhJ1E79RZlHDA==
X-Google-Smtp-Source: AKy350bNbj9mr+wirAgNbqsGFAgijy4C0GEFCQbdPfvqKTZwkSaTaVTTtYNLS0Oe4tmU0D8JeNcLzw==
X-Received: by 2002:a05:6402:7d1:b0:506:c2b2:72f3 with SMTP id
 u17-20020a05640207d100b00506c2b272f3mr12002791edy.28.1682361636439; 
 Mon, 24 Apr 2023 11:40:36 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 y21-20020a170906471500b0094f663bced2sm5787494ejq.33.2023.04.24.11.40.33
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Apr 2023 11:40:34 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-4af3773448fso31398a12.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 11:40:33 -0700 (PDT)
X-Received: by 2002:a05:6402:354f:b0:502:2af:7b1d with SMTP id
 f15-20020a056402354f00b0050202af7b1dmr11568edd.3.1682361633471; Mon, 24 Apr
 2023 11:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <CAAfnVB=5TVKxUmLhNMLMdgAPx7KoSKTsZQtq7Hv36FcP7bmgLA@mail.gmail.com>
 <6fef7bd4-6d02-6de8-e5f0-0ec8f57321f2@collabora.com>
In-Reply-To: <6fef7bd4-6d02-6de8-e5f0-0ec8f57321f2@collabora.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 24 Apr 2023 11:40:21 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkNrWGOqBZa1xUqrVPSz+0BJYgVvVjguXwN8XJ_KWrpKQ@mail.gmail.com>
Message-ID: <CAAfnVBkNrWGOqBZa1xUqrVPSz+0BJYgVvVjguXwN8XJ_KWrpKQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dominik Behr <dbehr@google.com>,
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgMjoyMuKAr1BNIERtaXRyeSBPc2lwZW5rbwo8ZG1pdHJ5
Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Cj4gSGVsbG8gR3VyY2hldGFuLAo+Cj4g
T24gNC8xOC8yMyAwMjoxNywgR3VyY2hldGFuIFNpbmdoIHdyb3RlOgo+ID4gT24gU3VuLCBBcHIg
MTYsIDIwMjMgYXQgNDo1M+KAr0FNIERtaXRyeSBPc2lwZW5rbyA8Cj4gPiBkbWl0cnkub3NpcGVu
a29AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPgo+ID4+IFdlIGhhdmUgbXVsdGlwbGUgVnVsa2Fu
IGNvbnRleHQgdHlwZXMgdGhhdCBhcmUgYXdhaXRpbmcgZm9yIHRoZSBhZGRpdGlvbgo+ID4+IG9m
IHRoZSBzeW5jIG9iamVjdCBEUk0gVUFQSSBzdXBwb3J0IHRvIHRoZSBWaXJ0SU8tR1BVIGtlcm5l
bCBkcml2ZXI6Cj4gPj4KPiA+PiAgMS4gVmVudXMgY29udGV4dAo+ID4+ICAyLiBOYXRpdmUgY29u
dGV4dHMgKHZpcnRpby1mcmVlZHJlbm8sIHZpcnRpby1pbnRlbCwgdmlydGlvLWFtZGdwdSkKPiA+
Pgo+ID4+IE1lc2EgY29yZSBzdXBwb3J0cyBEUk0gc3luYyBvYmplY3QgVUFQSSwgcHJvdmlkaW5n
IFZ1bGthbiBkcml2ZXJzIHdpdGggYQo+ID4+IGdlbmVyaWMgZmVuY2luZyBpbXBsZW1lbnRhdGlv
biB0aGF0IHdlIHdhbnQgdG8gdXRpbGl6ZS4KPiA+Pgo+ID4+IFRoaXMgcGF0Y2ggYWRkcyBpbml0
aWFsIHN5bmMgb2JqZWN0cyBzdXBwb3J0LiBJdCBjcmVhdGVzIGZ1bmRhbWVudCBmb3IgYQo+ID4+
IGZ1cnRoZXIgZmVuY2luZyBpbXByb3ZlbWVudHMuIExhdGVyIG9uIHdlIHdpbGwgd2FudCB0byBl
eHRlbmQgdGhlCj4gPj4gVmlydElPLUdQVQo+ID4+IGZlbmNpbmcgQVBJIHdpdGggcGFzc2luZyBm
ZW5jZSBJRHMgdG8gaG9zdCBmb3Igd2FpdGluZywgaXQgd2lsbCBiZSBhIG5ldwo+ID4+IGFkZGl0
aW9uYWwgVmlydElPLUdQVSBJT0NUTCBhbmQgbW9yZS4gVG9kYXkgd2UgaGF2ZSBzZXZlcmFsIFZp
cnRJTy1HUFUKPiA+PiBjb250ZXh0Cj4gPj4gZHJpdmVycyBpbiB3b3JrcyB0aGF0IHJlcXVpcmUg
VmlydElPLUdQVSB0byBzdXBwb3J0IHN5bmMgb2JqZWN0cyBVQVBJLgo+ID4+Cj4gPj4gVGhlIHBh
dGNoIGlzIGhlYXZpbHkgaW5zcGlyZWQgYnkgdGhlIHN5bmMgb2JqZWN0IFVBUEkgaW1wbGVtZW50
YXRpb24gb2YgdGhlCj4gPj4gTVNNIGRyaXZlci4KPiA+Pgo+ID4KPiA+IFRoZSBjaGFuZ2VzIHNl
ZW0gZ29vZCwgYnV0IEkgd291bGQgcmVjb21tZW5kIGdldHRpbmcgYSBmdWxsIGVuZC10by1lbmQK
PiA+IHNvbHV0aW9uIChpLmUsIHlvdSd2ZSBwcm94aWVkIHRoZSBob3N0IGZlbmNlIHdpdGggdGhl
c2UgY2hhbmdlcyBhbmQgc2hhcmVkCj4gPiB3aXRoIHRoZSBob3N0IGNvbXBvc2l0b3IpIHdvcmtp
bmcgZmlyc3QuICBZb3UnbGwgbmV2ZXIga25vdyB3aGF0IHlvdSdsbAo+ID4gZmluZCBhZnRlciBj
b21wbGV0aW5nIHRoaXMgZXhlcmNpc2UuICBPciBpcyB0aGF0IHRoZSBwbGFuIGFscmVhZHk/Cj4g
Pgo+ID4gVHlwaWNhbGx5LCB5b3Ugd2FudCB0byBsYW5kIHRoZSB1QVBJIGFuZCB2aXJ0aW8gc3Bl
YyBjaGFuZ2VzIGxhc3QuCj4gPiBNZXNhL2dmeHN0cmVhbS92aXJnbHJlbmRlcmVyL2Nyb3N2bSBh
bGwgaGF2ZSB0aGUgYWJpbGl0eSB0byB0ZXN0IG91dAo+ID4gdW5zdGFibGUgdUFQSXMgLi4uCj4K
PiBUaGUgcHJveGllZCBob3N0IGZlbmNlIGlzbid0IGRpcmVjdGx5IHJlbGF0ZWQgdG8gc3luYyBv
YmplY3RzLCB0aG91Z2ggSQo+IHByZXBhcmVkIGNvZGUgc3VjaCB0aGF0IGl0IGNvdWxkIGJlIGV4
dGVuZGVkIHdpdGggYSBwcm94aWVkIGZlbmNlIGxhdGVyCj4gb24sIGJhc2VkIG9uIGEgcHJvdG90
eXBlIHRoYXQgd2FzIG1hZGUgc29tZSB0aW1lIGFnby4KClByb3h5aW5nIHRoZSBob3N0IGZlbmNl
IGlzIHRoZSBub3ZlbCBiaXQuICBJZiB5b3UgaGF2ZSBjb2RlIHRoYXQgZG9lcwp0aGlzLCB5b3Ug
c2hvdWxkIHJlYmFzZS9zZW5kIHRoYXQgb3V0IChldmVuIGFzIGFuIFJGQykgc28gaXQncyBlYXNp
ZXIKdG8gc2VlIGhvdyB0aGUgcGllY2VzIGZpdC4KClJpZ2h0IG5vdywgaWYgeW91J3ZlIG9ubHkg
dGVzdGVkIHN5bmNocm9uaXphdGlvbiBvYmplY3RzIGJldHdlZW4gdGhlCnNhbWUgdmlydGlvLWdw
dSBjb250ZXh0IHRoYXQgc2tpcHMgdGhlIGd1ZXN0IHNpZGUgd2FpdCwgSSB0aGluayB5b3UKY2Fu
IGFscmVhZHkgZG8gdGhhdCB3aXRoIHRoZSBjdXJyZW50IHVBUEkgKHNpbmNlIGlkZWFsbHkgeW91
J2Qgd2FpdCBvbgp0aGUgaG9zdCBzaWRlIGFuZCBjYW4gZW5jb2RlIHRoZSBzeW5jIHJlc291cmNl
IGluIHRoZSBjb21tYW5kIHN0cmVhbSkuCgpBbHNvLCB0cnkgdG8gY29tZSB3aXRoIGEgc2ltcGxl
IHRlc3QgKHNvIHdlIGNhbiBtZWV0IHJlcXVpcmVtZW50cyBoZXJlClthXSkgdGhhdCBzaG93Y2Fz
ZXMgdGhlIG5ldyBmZWF0dXJlL2NhcGFiaWxpdHkuICBBbiBleGFtcGxlIHdvdWxkIGJlCnRoZSB2
aXJ0aW8taW50ZWwgbmF0aXZlIGNvbnRleHQgc2hhcmluZyBhIGZlbmNlIHdpdGggS01TIG9yIGV2
ZW4KV2F5bGFuZC4KClthXSBodHRwczovL2RyaS5mcmVlZGVza3RvcC5vcmcvZG9jcy9kcm0vZ3B1
L2RybS11YXBpLmh0bWwjb3Blbi1zb3VyY2UtdXNlcnNwYWNlLXJlcXVpcmVtZW50cwoKPgo+IFRo
ZSBwcm94aWVkIGhvc3QgZmVuY2Ugc2hvdWxkbid0IHJlcXVpcmUgVUFQSSBjaGFuZ2VzLCBidXQg
b25seQo+IHZpcnRpby1ncHUgcHJvdG8gZXh0ZW5zaW9uLiBOb3JtYWxseSwgYWxsIGluLWZlbmNl
cyBiZWxvbmcgdG8gYSBqb2Incwo+IGNvbnRleHQsIGFuZCB0aHVzLCB3YWl0cyBhcmUgc2tpcHBl
ZCBieSB0aGUgZ3Vlc3Qga2VybmVsLiBIZW5jZSwgZmVuY2UKPiBwcm94eWluZyBpcyBhIHNlcGFy
YXRlIGZlYXR1cmUgZnJvbSBzeW5jIG9iamVjdHMsIGl0IGNhbiBiZSBhZGRlZAo+IHdpdGhvdXQg
c3luYyBvYmplY3RzLgo+Cj4gU3luYyBvYmplY3RzIHByaW1hcmlseSB3YW50ZWQgYnkgbmF0aXZl
IGNvbnRleHQgZHJpdmVycyBiZWNhdXNlIE1lc2EKPiByZWxpZXMgb24gdGhlIHN5bmMgb2JqZWN0
IFVBUEkgcHJlc2VuY2UuIEl0J3Mgb25lIG9mIGRpcmVjdCBibG9ja2VycyBmb3IKPiBJbnRlbCBh
bmQgQU1ER1BVIGRyaXZlcnMsIGJvdGggb2Ygd2hpY2ggaGFzIGJlZW4gdXNpbmcgdGhpcyBzeW5j
IG9iamVjdAo+IFVBUEkgZm9yIGEgZmV3IG1vbnRocyBhbmQgbm93IHdhbnRpbmcgaXQgdG8gbGFu
ZCB1cHN0cmVhbS4KPgo+IC0tCj4gQmVzdCByZWdhcmRzLAo+IERtaXRyeQo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
