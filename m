Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB5AC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 23:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5757660FCC;
	Wed, 10 Aug 2022 23:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5757660FCC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iXu8D1jJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeyVPOF7GdYc; Wed, 10 Aug 2022 23:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB2F160F32;
	Wed, 10 Aug 2022 23:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB2F160F32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 966FCC0033;
	Wed, 10 Aug 2022 23:19:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 902C0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 23:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 592E9410C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 23:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 592E9410C1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=iXu8D1jJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BX5assC1rzTL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 23:19:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A439C410A1
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A439C410A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 23:19:18 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id o2so13441234iof.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=l5p5bclQFAlMwZmWlO8t1SaK7xuragzMNLu8+SffqhU=;
 b=iXu8D1jJDH9R43xBAlDVHcczSFbbeceeaMs+vdM3ROkUuHlsfkvvIZAcW19okAr2K3
 xE3/M2JLwF8VAZLWtwXzUXB12t8mT9Z/vayYB6PlkW6M1Y3xLyjL1PraTGc1n78Wigci
 F9flaSw6/OnQjmgwMncTHnWBIqYq2Xi0Ow6NEmAtEF5j5FHI4L8GnZzkyZT0bz7RNUOH
 LHhD/uRzrsEUGx0X4W2xZZYn5MFuBjuc2z+/KA0qJkwp4NZwNtzZbblg07DPdyIKTXX0
 9UjqS+uM5iR9Yb0Phc/Voha3j60LENKZ03eavcdc9bZ30bEEtdHnLv3vCUeCrATxQMVO
 8tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=l5p5bclQFAlMwZmWlO8t1SaK7xuragzMNLu8+SffqhU=;
 b=l7kxIz1KAJLM4IELdy5gFcjYw5kXt5/S9MMdm1e1vM+ZUdo28oygyTjpz24lK7dDKi
 egcIfzXACVLSIhDWeJ7QvR9P9krlab3WHWy18mP1SwMFVAtnY1G+o1g0NdiVR9YhQyLa
 6mVXMtEOg6x1fFfRhTP4OjSeq6jy/bEX6DKq+ri1FUH569oPA7+EJDb2Gp7YkUncqhdr
 BvvYlsUFsuLjkeiLcUCyWYKeXGNsFghtpczoDoi+BB9RwcoBnb9i5aSYwpMeED5K4zeT
 UwWsCCrHe13pgzo9ojlHJYq0VFhXzITSQRPczg6mDj2AxIxfXPsUSg6SgxcLaOS+ISh/
 aiDA==
X-Gm-Message-State: ACgBeo1/afBdxMkfWUt6k4TSoUx7zo5XsCtIboYDw5xkCOdTrEY+7ZDw
 zeeQk4Ohb7+7nm4Fl9SQIGLP6kla7268CzVZJyQ=
X-Google-Smtp-Source: AA6agR7JzmvJ4XVRV58axL/tiNu8bHxsGLOSNYpNcG405gbAjtRKdBV0w34FaH4DoBiVQ9D2yCc0XM3fNmlllCh51DY=
X-Received: by 2002:a05:6638:1353:b0:342:9bfb:7382 with SMTP id
 u19-20020a056638135300b003429bfb7382mr13826837jad.129.1660173557556; Wed, 10
 Aug 2022 16:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
 <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
In-Reply-To: <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 10 Aug 2022 16:19:05 -0700
Message-ID: <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: kernel@collabora.com, dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-tegra@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

T24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgMzoyMyBQTSBEbWl0cnkgT3NpcGVua28KPGRtaXRyeS5v
c2lwZW5rb0Bjb2xsYWJvcmEuY29tPiB3cm90ZToKPgo+IE9uIDgvMTEvMjIgMDE6MDMsIFJvYiBD
bGFyayB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDEwLCAyMDIyIGF0IDEyOjI2IFBNIERtaXRyeSBP
c2lwZW5rbwo+ID4gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPiB3cm90ZToKPiA+Pgo+
ID4+IE9uIDgvMTAvMjIgMTg6MDgsIFJvYiBDbGFyayB3cm90ZToKPiA+Pj4gT24gV2VkLCBBdWcg
MTAsIDIwMjIgYXQgNDo0NyBBTSBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+IHdyb3Rl
Ogo+ID4+Pj4KPiA+Pj4+IE9uIFdlZCwgSnVsIDA2LCAyMDIyIGF0IDEwOjAyOjA3QU0gKzAzMDAs
IERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+Pj4+PiBPbiA3LzYvMjIgMDA6NDgsIFJvYiBDbGFy
ayB3cm90ZToKPiA+Pj4+Pj4gT24gVHVlLCBKdWwgNSwgMjAyMiBhdCA0OjUxIEFNIENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gPj4+Pj4+Pgo+ID4+
Pj4+Pj4gQW0gMDEuMDcuMjIgdW0gMTE6MDIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gPj4+
Pj4+Pj4gRHJpdmVycyB0aGF0IHVzZSBkcm1fZ2VtX21tYXAoKSBhbmQgZHJtX2dlbV9tbWFwX29i
aigpIGhlbHBlcnMgZG9uJ3QKPiA+Pj4+Pj4+PiBoYW5kbGUgaW1wb3J0ZWQgZG1hLWJ1ZnMgcHJv
cGVybHksIHdoaWNoIHJlc3VsdHMgaW4gbWFwcGluZyBvZiBzb21ldGhpbmcKPiA+Pj4+Pj4+PiBl
bHNlIHRoYW4gdGhlIGltcG9ydGVkIGRtYS1idWYuIE9uIE5WSURJQSBUZWdyYSB3ZSBnZXQgYSBo
YXJkIGxvY2t1cCB3aGVuCj4gPj4+Pj4+Pj4gdXNlcnNwYWNlIHdyaXRlcyB0byB0aGUgbWVtb3J5
IG1hcHBpbmcgb2YgYSBkbWEtYnVmIHRoYXQgd2FzIGltcG9ydGVkIGludG8KPiA+Pj4+Pj4+PiBU
ZWdyYSdzIERSTSBHRU0uCj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+PiBNYWpvcml0eSBvZiBEUk0gZHJp
dmVycyBwcm9oaWJpdCBtYXBwaW5nIG9mIHRoZSBpbXBvcnRlZCBHRU0gb2JqZWN0cy4KPiA+Pj4+
Pj4+PiBNYXBwaW5nIG9mIGltcG9ydGVkIEdFTXMgcmVxdWlyZSBzcGVjaWFsIGNhcmUgZnJvbSB1
c2Vyc3BhY2Ugc2luY2UgaXQKPiA+Pj4+Pj4+PiBzaG91bGQgc3luYyBkbWEtYnVmIGJlY2F1c2Ug
bWFwcGluZyBjb2hlcmVuY3kgb2YgdGhlIGV4cG9ydGVyIGRldmljZSBtYXkKPiA+Pj4+Pj4+PiBu
b3QgbWF0Y2ggdGhlIERSTSBkZXZpY2UuIExldCdzIHByb2hpYml0IHRoZSBtYXBwaW5nIGZvciBh
bGwgRFJNIGRyaXZlcnMKPiA+Pj4+Pj4+PiBmb3IgY29uc2lzdGVuY3kuCj4gPj4+Pj4+Pj4KPiA+
Pj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9t
QGxpbnV4LmludGVsLmNvbT4KPiA+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVu
a28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+IEkn
bSBwcmV0dHkgc3VyZSB0aGF0IHRoaXMgaXMgdGhlIHJpZ2h0IGFwcHJvYWNoLCBidXQgaXQncyBj
ZXJ0YWlubHkgbW9yZQo+ID4+Pj4+Pj4gdGhhbiBwb3NzaWJsZSB0aGF0IHNvbWVib2R5IGFidXNl
ZCB0aGlzIGFscmVhZHkuCj4gPj4+Pj4+Cj4gPj4+Pj4+IEkgc3VzcGVjdCB0aGF0IHRoaXMgaXMg
YWJ1c2VkIGlmIHlvdSBydW4gZGVxcCBjdHMgb24gYW5kcm9pZC4uIGllLiBhbGwKPiA+Pj4+Pj4g
d2luc3lzIGJ1ZmZlcnMgYXJlIGRtYS1idWYgaW1wb3J0cyBmcm9tIGdyYWxsb2MuICBBbmQgdGhl
biB3aGVuIHlvdQo+ID4+Pj4+PiBoaXQgcmVhZHBpeC4uLgo+ID4+Pj4+Pgo+ID4+Pj4+PiBZb3Ug
bWlnaHQgb25seSBoaXQgdGhpcyBpbiBzY2VuYXJpb3Mgd2l0aCBzZXBhcmF0ZSBncHUgYW5kIGRp
c3BsYXkgKG9yCj4gPj4+Pj4+IGRHUFUraUdQVSkgYmVjYXVzZSBzZWxmLWltcG9ydHMgYXJlIGhh
bmRsZWQgZGlmZmVyZW50bHkgaW4KPiA+Pj4+Pj4gZHJtX2dlbV9wcmltZV9pbXBvcnRfZGV2KCku
LiBhbmQgbWF5YmUgbm90IGluIGNhc2VzIHdoZXJlIHlvdSBlbmQgdXAKPiA+Pj4+Pj4gd2l0aCBh
IGJsaXQgZnJvbSB0aWxlZC9jb21wcmVzc2VkIHRvIGxpbmVhci4uIG1heWJlIHRoYXQgbmFycm93
cyB0aGUKPiA+Pj4+Pj4gc2NvcGUgZW5vdWdoIHRvIGp1c3QgZml4IGl0IGluIHVzZXJzcGFjZT8K
PiA+Pj4+Pgo+ID4+Pj4+IEdpdmVuIHRoYXQgdGhhdCBvbmx5IGRyaXZlcnMgd2hpY2ggdXNlIERS
TS1TSE1FTSBwb3RlbnRpYWxseSBjb3VsZCd2ZQo+ID4+Pj4+IG1hcCBpbXBvcnRlZCBkbWEtYnVm
cyAoUGFuZnJvc3QsIExpbWEpIGFuZCB0aGV5IGFscmVhZHkgZG9uJ3QgYWxsb3cgdG8KPiA+Pj4+
PiBkbyB0aGF0LCBJIHRoaW5rIHdlJ3JlIGdvb2QuCj4gPj4+Pgo+ID4+Pj4gU28gY2FuIEkgaGF2
ZSBhbiBhY2sgZnJvbSBSb2IgaGVyZSBvciBhcmUgdGhlcmUgc3RpbGwgcXVlc3Rpb25zIHRoYXQg
dGhpcwo+ID4+Pj4gbWlnaHQgZ28gYm9vbT8KPiA+Pj4+Cj4gPj4+PiBEbWl0cnksIHNpbmNlIHlv
dSBoYXZlIGEgYnVuY2ggb2YgcGF0Y2hlcyBtZXJnZWQgbm93IEkgdGhpbmsgd291bGQgYWxzbyBi
ZQo+ID4+Pj4gZ29vZCB0byBnZXQgY29tbWl0IHJpZ2h0cyBzbyB5b3UgY2FuIGRyaXZlIHRoaXMg
bW9yZSB5b3Vyc2VsZi4gSSd2ZSBhc2tlZAo+ID4+Pj4gRGFuaWVsIFN0b25lIHRvIGhlbHAgeW91
IG91dCB3aXRoIGdldHRpbmcgdGhhdC4KPiA+Pj4KPiA+Pj4gSSAqdGhpbmsqIHdlJ2QgYmUgb2sg
d2l0aCB0aGlzIG9uIG1zbSwgbW9zdGx5IGp1c3QgYnkgZHVtYiBsdWNrLgo+ID4+PiBCZWNhdXNl
IHRoZSBkbWEtYnVmJ3Mgd2UgaW1wb3J0IHdpbGwgYmUgc2VsZi1pbXBvcnQuICBJJ20gbGVzcyBz
dXJlCj4gPj4+IGFib3V0IHBhbmZyb3N0IChzcmMvcGFuZnJvc3QvbGliL3Bhbl9iby5jIGRvZXNu
J3Qgc2VlbSB0byBoYXZlIGEKPiA+Pj4gc3BlY2lhbCBwYXRoIGZvciBpbXBvcnRlZCBkbWEtYnVm
cyBlaXRoZXIsIGFuZCBpbiB0aGF0IGNhc2UgdGhleSB3b24ndAo+ID4+PiBiZSBzZWxmLWltcG9y
dHMuLiBidXQgSSBndWVzcyBubyBvbmUgaGFzIHRyaWVkIHRvIHJ1biBhbmRyb2lkIGN0cyBvbgo+
ID4+PiBwYW5mcm9zdCkuCj4gPj4KPiA+PiBUaGUgbGFzdCB0aW1lIEkgdHJpZWQgdG8gbW1hcCBk
bWEtYnVmIGltcG9ydGVkIHRvIFBhbmZyb3N0IGRpZG4ndCB3b3JrCj4gPj4gYmVjYXVzZSBQYW5m
cm9zdCBkaWRuJ3QgaW1wbGVtZW50IHNvbWV0aGluZyBuZWVkZWQgZm9yIHRoYXQuIEknbGwgbmVl
ZAo+ID4+IHRvIHRha2UgYSBsb29rIGFnYWluIGJlY2F1c2UgY2FuJ3QgcmVjYWxsIHdoYXQgaXQg
d2FzLgo+ID4+Cj4gPj4+IFdoYXQgYWJvdXQgc29tZXRoaW5nIGxlc3MgZHJhc3RpYyB0byBzdGFy
dCwgbGlrZSAoYXBvbG9naWVzIGZvcgo+ID4+PiBoYW5kLWVkaXRlZCBwYXRjaCk6Cj4gPj4+Cj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9nZW0uYwo+ID4+PiBpbmRleCA4NmQ2NzBjNzEyODYuLmZjOWVjNDJmYTBhYiAxMDA2
NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+ID4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4gPj4+IEBAIC0xMDM0LDYgKzEwMzQsMTAgQEAgaW50IGRy
bV9nZW1fbW1hcF9vYmooc3RydWN0IGRybV9nZW1fb2JqZWN0Cj4gPj4+ICpvYmosIHVuc2lnbmVk
IGxvbmcgb2JqX3NpemUsCj4gPj4+ICB7Cj4gPj4+ICAgICAgICAgaW50IHJldDsKPiA+Pj4KPiA+
Pj4gKyAgICAgICBXQVJOX09OX09OQ0Uob2JqLT5pbXBvcnRfYXR0YWNoKTsKPiA+Pgo+ID4+IFRo
aXMgd2lsbCBoYW5nIE5WSURJQSBUZWdyYSwgd2hpY2ggaXMgd2hhdCB0aGlzIHBhdGNoIGZpeGVk
IGluaXRpYWxseS4KPiA+PiBJZiBuZWl0aGVyIG9mIHVwc3RyZWFtIERSTSBkcml2ZXJzIG5lZWQg
dG8gbWFwIGltcG9ydGVkIGRtYS1idWZzIGFuZAo+ID4+IG5ldmVyIG5lZWRlZCwgdGhlbiB3aHkg
ZG8gd2UgbmVlZCB0aGlzPwo+ID4KPiA+IG9oLCB0ZWdyYSBpc24ndCB1c2luZyBzaG1lbSBoZWxw
ZXJzPyAgSSBhc3N1bWVkIGl0IHdhcy4gIFdlbGwgbXkgcG9pbnQKPiA+IHdhcyB0byBtYWtlIGEg
bW9yZSB0YXJnZXRlZCBmYWlsIG9uIHRlZ3JhLCBhbmQgYSBXQVJOX09OIGZvciBldmVyeW9uZQo+
ID4gZWxzZSB0byBtYWtlIGl0IGNsZWFyIHRoYXQgd2hhdCB0aGV5IGFyZSBkb2luZyBpcyB1bmRl
ZmluZWQgYmVoYXZpb3IuCj4gPiBCZWNhdXNlIHNvIGZhciBleGlzdGluZyB1c2Vyc3BhY2UgKG9y
IHdlbGwsIHBhbmZyb3N0IGFuZCBmcmVlZHJlbm8gYXQKPiA+IGxlYXN0LCB0aG9zZSBhcmUgdGhl
IHR3byBJIGtub3cgb3IgY2hlY2tlZCkgZG9uJ3QgbWFrZSBzcGVjaWFsIGNhc2VzCj4gPiBmb3Ig
bW1hcCdpbmcgYWdhaW5zdCB0aGUgZG1hYnVmIGZkIGFnYWluc3QgdGhlIGRtYWJ1ZiBmZCBpbnN0
ZWFkIG9mCj4gPiB0aGUgZHJtIGRldmljZSBmZC4KPgo+IEl0J3Mgbm90IGNsZWFyIHRvIG1lIHdo
YXQgYmFkIEFuZHJvaWQgZG9lcyBmb3JtIHlvdXJzIGNvbW1lbnRzLiBEb2VzIGl0Cj4gZXhwb3J0
IGRtYS1idWYgZnJvbSBHUFUgYW5kIHRoZW4gaW1wb3J0IGl0IHRvIEdQVT8gSWYgeWVzLCB0aGVu
IERSTSBjb3JlCj4gaGFzIGEgY2hlY2sgZm9yIHRoZSBzZWxmLWltcG9ydGluZyBbMV0uCj4KPiBb
MV0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZl
cnMvZ3B1L2RybS9kcm1fcHJpbWUuYyNMOTE4Cj4KPiBJZiB5b3UncmUgbWVhbmluZyBzb21ldGhp
bmcgZWxzZSwgdGhlbiBwbGVhc2UgZXhwbGFpbiBpbiBhIG1vcmUgZGV0YWlscy4KClNvLCBhbmRy
b2lkL2dyYWxsb2MgYWxsb2NhdGVzIGJ1ZmZlcnMgZXh0ZXJuYWxseSB0byB0aGUgZHJpdmVyIGFu
ZAppbXBvcnRzIHRoZW0gaW50byBkcml2ZXIuICAoQW5kIHRoYXQgc2VlbXMgdG8gbm90IGp1c3Qg
YmUgd2luZG93CnN1cmZhY2VzLCBidXQgaW4gY2FzZXMgcmFuZG9tIHRleHR1cmVzLCBldGMpCgpJ
biB0aGUgbm9ybWFsIGNhc2UgdGhlc2Ugc2hvdWxkIGJlIGFsbG9jYXRlZCBmcm9tIGRybS9tc20g
c28gaXQgc2hvdWxkCmhpdCBbMV0uLiB0aGlzIGlzIHRoZSAiZHVtYiBsdWNrIiBJIG1lbnRpb25l
ZCBlYXJsaWVyLiAgQnV0IEknbSBub3QKY29uZmlkZW50IGVub3VnaCB0byBzYXkgdGhhdCB0aGVy
ZSBpcyBubyBvdGhlciBjYXNlLgoKPgo+ID4gSSAqdGhpbmsqIGl0IHNob3VsZCB3b3JrIG91dCB0
aGF0IHdlIGRvbid0IGhpdCB0aGlzIHBhdGggd2l0aAo+ID4gZnJlZWRyZW5vIGJ1dCBvbiBhbmRy
b2lkIEkgY2FuJ3QgcmVhbGx5IGd1YXJhbnRlZSBvciBwcm92ZSBpdC4gIFNvCj4gPiB5b3VyIHBh
dGNoIHdvdWxkIHBvdGVudGlhbGx5IGJyZWFrIGV4aXN0aW5nIHdvcmtpbmcgdXNlcnNwYWNlLiAg
TWF5YmUKPiA+IGl0IGlzIHVzZXJzcGFjZSB0aGF0IGlzbid0IHBvcnRhYmxlIChidXQgT1RPSCBp
dCBpc24ndCBsaWtlIHlvdSBhcmUKPiA+IGdvaW5nIHRvIGJlIHVzaW5nIGZyZWVkcmVubyBvbiB0
ZWdyYSkuICBTbyB3aHkgZG9uJ3QgeW91IGdvIGZvciBhIG1vcmUKPiA+IHRhcmdldGVkIGZpeCB0
aGF0IG9ubHkgcmV0dXJucyBhbiBlcnJvciBvbiBodyB3aGVyZSB0aGlzIGlzCj4gPiBwcm9ibGVt
YXRpYz8KPgo+IFRoYXQncyB3aGF0IHRoZSBmaXJzdCB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2ggZGlk
IGFuZCBDaHJpc3RpYW4gc3VnZ2VzdGVkCj4gdGhhdCBpdCdzIG5vdCBhIGdvb2QgYXBwcm9hY2gu
IEluIGZhY3QgaXQgc2hvdWxkIGJlIG5vdCBvbmx5IFRlZ3JhIHRoYXQKPiBoYXMgYSBicm9rZW4g
ZG1hLWJ1ZiBtYXBwaW5nLCBidXQgYXBwYXJlbnRseSBPTUFQIGRyaXZlciB0b28uCgpIbW0sIEkg
Z3Vlc3MgSSdtIGEgYml0IG1vcmUgY29uc2VydmF0aXZlIHdoZW4gaXQgY29tZXMgdG8gcG90ZW50
aWFsbHkKYnJlYWtpbmcgdXNlcnNwYWNlLgoKQlIsCi1SCgo+Cj4gLS0KPiBCZXN0IHJlZ2FyZHMs
Cj4gRG1pdHJ5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
