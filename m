Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CE2C25B07
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 22:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E46F60F9B;
	Wed, 10 Aug 2022 22:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E46F60F9B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XQQgJm1U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5co-nWb1DOII; Wed, 10 Aug 2022 22:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C39360FA0;
	Wed, 10 Aug 2022 22:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C39360FA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9E1C0033;
	Wed, 10 Aug 2022 22:04:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A47F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 22:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68622402A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 22:04:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68622402A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=XQQgJm1U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LDD283dtR8vF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 22:04:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2663F40293
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2663F40293
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 22:04:08 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id r6so9024184ilc.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=LVHmCu4K9UsnuouvlrhXtn/06oq9/7k5ucyM1f7Rw3o=;
 b=XQQgJm1UBQXQ7vbWpW5FvKeg56vw8j997xb19oPECATfNsXaTQTfoXR8o50ZVfLHlB
 11XQbz7fph6I+75f2RDOdo6KvZwMSsk8mdbmvFAQ24tnCPWIlIocfTz2f8X+/Nr1kQvT
 C94w5BgMq2xltRQN+5uJLNXJyEUsJQ81SigRxq9euRt+kdSVZNsikS8G0JB6xPDBz0nu
 d6GowoELgNsmySJUpL6m0li5rxrQmtqZ0txluj/GRNrF/ypBF3rWJzO0e04xwQoHa3kv
 /rGj1dpU5X0LAJCvW9dGdRrHAgXA6lsED8XCrB1/uGNCrxto2sGFkgg3jJoqFu/k6eTb
 2Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=LVHmCu4K9UsnuouvlrhXtn/06oq9/7k5ucyM1f7Rw3o=;
 b=LBiGgFe+wKGgBJiS5MYz8wdrJTMM2uDnQlnnNClTusVdGnHEbTl8iASAU6t2Pgru/3
 Xcb56rsUcTGGWZlx8uUBAJx7QZaX0LAaQDjIV00glQuIKrkqPfyuBgW14al3aZKpQW5N
 d6DQ0l0+9sfdOJdEySdK34e1i8xb3m5tvuelvRTrQLOfg1kOlbVEZaPDTqqRef1fgHuE
 OLl++fnPUNbD3OHwC2YABAXXiLY4JDILDsRQQm9RJZSAUzCK5qvcFKeuOSzfrcStkw6A
 OB+EoPirw3Zn9ixleOS7u4mMpns7hdw1D3cu7oE2Gg8sQs3R6631RsOsWxoOACrANz/2
 sXhg==
X-Gm-Message-State: ACgBeo3qXPR17EUuKCXD1NDFAyT6qG8bHHgB3vBrFW4+px+4HhVq/3cZ
 MxCFRqJbTcbyuwd4qsMr1+R9aXLaSQTa4DvaVI8=
X-Google-Smtp-Source: AA6agR5IBVRyhpKnR2zLMwE90gqNpEfsaXgxYOLxLujMWj6Uon5RNfqf7xcFnsKA6FfgJ4Di+5Cyp7A/pP3pJkReSK4=
X-Received: by 2002:a92:8747:0:b0:2da:cf0d:b615 with SMTP id
 d7-20020a928747000000b002dacf0db615mr13120670ilm.168.1660169047109; Wed, 10
 Aug 2022 15:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
In-Reply-To: <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 10 Aug 2022 15:03:55 -0700
Message-ID: <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
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

T24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgMTI6MjYgUE0gRG1pdHJ5IE9zaXBlbmtvCjxkbWl0cnku
b3NpcGVua29AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4KPiBPbiA4LzEwLzIyIDE4OjA4LCBSb2Ig
Q2xhcmsgd3JvdGU6Cj4gPiBPbiBXZWQsIEF1ZyAxMCwgMjAyMiBhdCA0OjQ3IEFNIERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4gd3JvdGU6Cj4gPj4KPiA+PiBPbiBXZWQsIEp1bCAwNiwg
MjAyMiBhdCAxMDowMjowN0FNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gPj4+IE9u
IDcvNi8yMiAwMDo0OCwgUm9iIENsYXJrIHdyb3RlOgo+ID4+Pj4gT24gVHVlLCBKdWwgNSwgMjAy
MiBhdCA0OjUxIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
d3JvdGU6Cj4gPj4+Pj4KPiA+Pj4+PiBBbSAwMS4wNy4yMiB1bSAxMTowMiBzY2hyaWViIERtaXRy
eSBPc2lwZW5rbzoKPiA+Pj4+Pj4gRHJpdmVycyB0aGF0IHVzZSBkcm1fZ2VtX21tYXAoKSBhbmQg
ZHJtX2dlbV9tbWFwX29iaigpIGhlbHBlcnMgZG9uJ3QKPiA+Pj4+Pj4gaGFuZGxlIGltcG9ydGVk
IGRtYS1idWZzIHByb3Blcmx5LCB3aGljaCByZXN1bHRzIGluIG1hcHBpbmcgb2Ygc29tZXRoaW5n
Cj4gPj4+Pj4+IGVsc2UgdGhhbiB0aGUgaW1wb3J0ZWQgZG1hLWJ1Zi4gT24gTlZJRElBIFRlZ3Jh
IHdlIGdldCBhIGhhcmQgbG9ja3VwIHdoZW4KPiA+Pj4+Pj4gdXNlcnNwYWNlIHdyaXRlcyB0byB0
aGUgbWVtb3J5IG1hcHBpbmcgb2YgYSBkbWEtYnVmIHRoYXQgd2FzIGltcG9ydGVkIGludG8KPiA+
Pj4+Pj4gVGVncmEncyBEUk0gR0VNLgo+ID4+Pj4+Pgo+ID4+Pj4+PiBNYWpvcml0eSBvZiBEUk0g
ZHJpdmVycyBwcm9oaWJpdCBtYXBwaW5nIG9mIHRoZSBpbXBvcnRlZCBHRU0gb2JqZWN0cy4KPiA+
Pj4+Pj4gTWFwcGluZyBvZiBpbXBvcnRlZCBHRU1zIHJlcXVpcmUgc3BlY2lhbCBjYXJlIGZyb20g
dXNlcnNwYWNlIHNpbmNlIGl0Cj4gPj4+Pj4+IHNob3VsZCBzeW5jIGRtYS1idWYgYmVjYXVzZSBt
YXBwaW5nIGNvaGVyZW5jeSBvZiB0aGUgZXhwb3J0ZXIgZGV2aWNlIG1heQo+ID4+Pj4+PiBub3Qg
bWF0Y2ggdGhlIERSTSBkZXZpY2UuIExldCdzIHByb2hpYml0IHRoZSBtYXBwaW5nIGZvciBhbGwg
RFJNIGRyaXZlcnMKPiA+Pj4+Pj4gZm9yIGNvbnNpc3RlbmN5Lgo+ID4+Pj4+Pgo+ID4+Pj4+PiBT
dWdnZXN0ZWQtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4Lmlu
dGVsLmNvbT4KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnku
b3NpcGVua29AY29sbGFib3JhLmNvbT4KPiA+Pj4+Pgo+ID4+Pj4+IEknbSBwcmV0dHkgc3VyZSB0
aGF0IHRoaXMgaXMgdGhlIHJpZ2h0IGFwcHJvYWNoLCBidXQgaXQncyBjZXJ0YWlubHkgbW9yZQo+
ID4+Pj4+IHRoYW4gcG9zc2libGUgdGhhdCBzb21lYm9keSBhYnVzZWQgdGhpcyBhbHJlYWR5Lgo+
ID4+Pj4KPiA+Pj4+IEkgc3VzcGVjdCB0aGF0IHRoaXMgaXMgYWJ1c2VkIGlmIHlvdSBydW4gZGVx
cCBjdHMgb24gYW5kcm9pZC4uIGllLiBhbGwKPiA+Pj4+IHdpbnN5cyBidWZmZXJzIGFyZSBkbWEt
YnVmIGltcG9ydHMgZnJvbSBncmFsbG9jLiAgQW5kIHRoZW4gd2hlbiB5b3UKPiA+Pj4+IGhpdCBy
ZWFkcGl4Li4uCj4gPj4+Pgo+ID4+Pj4gWW91IG1pZ2h0IG9ubHkgaGl0IHRoaXMgaW4gc2NlbmFy
aW9zIHdpdGggc2VwYXJhdGUgZ3B1IGFuZCBkaXNwbGF5IChvcgo+ID4+Pj4gZEdQVStpR1BVKSBi
ZWNhdXNlIHNlbGYtaW1wb3J0cyBhcmUgaGFuZGxlZCBkaWZmZXJlbnRseSBpbgo+ID4+Pj4gZHJt
X2dlbV9wcmltZV9pbXBvcnRfZGV2KCkuLiBhbmQgbWF5YmUgbm90IGluIGNhc2VzIHdoZXJlIHlv
dSBlbmQgdXAKPiA+Pj4+IHdpdGggYSBibGl0IGZyb20gdGlsZWQvY29tcHJlc3NlZCB0byBsaW5l
YXIuLiBtYXliZSB0aGF0IG5hcnJvd3MgdGhlCj4gPj4+PiBzY29wZSBlbm91Z2ggdG8ganVzdCBm
aXggaXQgaW4gdXNlcnNwYWNlPwo+ID4+Pgo+ID4+PiBHaXZlbiB0aGF0IHRoYXQgb25seSBkcml2
ZXJzIHdoaWNoIHVzZSBEUk0tU0hNRU0gcG90ZW50aWFsbHkgY291bGQndmUKPiA+Pj4gbWFwIGlt
cG9ydGVkIGRtYS1idWZzIChQYW5mcm9zdCwgTGltYSkgYW5kIHRoZXkgYWxyZWFkeSBkb24ndCBh
bGxvdyB0bwo+ID4+PiBkbyB0aGF0LCBJIHRoaW5rIHdlJ3JlIGdvb2QuCj4gPj4KPiA+PiBTbyBj
YW4gSSBoYXZlIGFuIGFjayBmcm9tIFJvYiBoZXJlIG9yIGFyZSB0aGVyZSBzdGlsbCBxdWVzdGlv
bnMgdGhhdCB0aGlzCj4gPj4gbWlnaHQgZ28gYm9vbT8KPiA+Pgo+ID4+IERtaXRyeSwgc2luY2Ug
eW91IGhhdmUgYSBidW5jaCBvZiBwYXRjaGVzIG1lcmdlZCBub3cgSSB0aGluayB3b3VsZCBhbHNv
IGJlCj4gPj4gZ29vZCB0byBnZXQgY29tbWl0IHJpZ2h0cyBzbyB5b3UgY2FuIGRyaXZlIHRoaXMg
bW9yZSB5b3Vyc2VsZi4gSSd2ZSBhc2tlZAo+ID4+IERhbmllbCBTdG9uZSB0byBoZWxwIHlvdSBv
dXQgd2l0aCBnZXR0aW5nIHRoYXQuCj4gPgo+ID4gSSAqdGhpbmsqIHdlJ2QgYmUgb2sgd2l0aCB0
aGlzIG9uIG1zbSwgbW9zdGx5IGp1c3QgYnkgZHVtYiBsdWNrLgo+ID4gQmVjYXVzZSB0aGUgZG1h
LWJ1ZidzIHdlIGltcG9ydCB3aWxsIGJlIHNlbGYtaW1wb3J0LiAgSSdtIGxlc3Mgc3VyZQo+ID4g
YWJvdXQgcGFuZnJvc3QgKHNyYy9wYW5mcm9zdC9saWIvcGFuX2JvLmMgZG9lc24ndCBzZWVtIHRv
IGhhdmUgYQo+ID4gc3BlY2lhbCBwYXRoIGZvciBpbXBvcnRlZCBkbWEtYnVmcyBlaXRoZXIsIGFu
ZCBpbiB0aGF0IGNhc2UgdGhleSB3b24ndAo+ID4gYmUgc2VsZi1pbXBvcnRzLi4gYnV0IEkgZ3Vl
c3Mgbm8gb25lIGhhcyB0cmllZCB0byBydW4gYW5kcm9pZCBjdHMgb24KPiA+IHBhbmZyb3N0KS4K
Pgo+IFRoZSBsYXN0IHRpbWUgSSB0cmllZCB0byBtbWFwIGRtYS1idWYgaW1wb3J0ZWQgdG8gUGFu
ZnJvc3QgZGlkbid0IHdvcmsKPiBiZWNhdXNlIFBhbmZyb3N0IGRpZG4ndCBpbXBsZW1lbnQgc29t
ZXRoaW5nIG5lZWRlZCBmb3IgdGhhdC4gSSdsbCBuZWVkCj4gdG8gdGFrZSBhIGxvb2sgYWdhaW4g
YmVjYXVzZSBjYW4ndCByZWNhbGwgd2hhdCBpdCB3YXMuCj4KPiA+IFdoYXQgYWJvdXQgc29tZXRo
aW5nIGxlc3MgZHJhc3RpYyB0byBzdGFydCwgbGlrZSAoYXBvbG9naWVzIGZvcgo+ID4gaGFuZC1l
ZGl0ZWQgcGF0Y2gpOgo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dl
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+ID4gaW5kZXggODZkNjcwYzcxMjg2Li5m
YzllYzQyZmEwYWIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4gPiBAQCAtMTAzNCw2ICsxMDM0LDEw
IEBAIGludCBkcm1fZ2VtX21tYXBfb2JqKHN0cnVjdCBkcm1fZ2VtX29iamVjdAo+ID4gKm9iaiwg
dW5zaWduZWQgbG9uZyBvYmpfc2l6ZSwKPiA+ICB7Cj4gPiAgICAgICAgIGludCByZXQ7Cj4gPgo+
ID4gKyAgICAgICBXQVJOX09OX09OQ0Uob2JqLT5pbXBvcnRfYXR0YWNoKTsKPgo+IFRoaXMgd2ls
bCBoYW5nIE5WSURJQSBUZWdyYSwgd2hpY2ggaXMgd2hhdCB0aGlzIHBhdGNoIGZpeGVkIGluaXRp
YWxseS4KPiBJZiBuZWl0aGVyIG9mIHVwc3RyZWFtIERSTSBkcml2ZXJzIG5lZWQgdG8gbWFwIGlt
cG9ydGVkIGRtYS1idWZzIGFuZAo+IG5ldmVyIG5lZWRlZCwgdGhlbiB3aHkgZG8gd2UgbmVlZCB0
aGlzPwoKb2gsIHRlZ3JhIGlzbid0IHVzaW5nIHNobWVtIGhlbHBlcnM/ICBJIGFzc3VtZWQgaXQg
d2FzLiAgV2VsbCBteSBwb2ludAp3YXMgdG8gbWFrZSBhIG1vcmUgdGFyZ2V0ZWQgZmFpbCBvbiB0
ZWdyYSwgYW5kIGEgV0FSTl9PTiBmb3IgZXZlcnlvbmUKZWxzZSB0byBtYWtlIGl0IGNsZWFyIHRo
YXQgd2hhdCB0aGV5IGFyZSBkb2luZyBpcyB1bmRlZmluZWQgYmVoYXZpb3IuCkJlY2F1c2Ugc28g
ZmFyIGV4aXN0aW5nIHVzZXJzcGFjZSAob3Igd2VsbCwgcGFuZnJvc3QgYW5kIGZyZWVkcmVubyBh
dApsZWFzdCwgdGhvc2UgYXJlIHRoZSB0d28gSSBrbm93IG9yIGNoZWNrZWQpIGRvbid0IG1ha2Ug
c3BlY2lhbCBjYXNlcwpmb3IgbW1hcCdpbmcgYWdhaW5zdCB0aGUgZG1hYnVmIGZkIGFnYWluc3Qg
dGhlIGRtYWJ1ZiBmZCBpbnN0ZWFkIG9mCnRoZSBkcm0gZGV2aWNlIGZkLgoKSSAqdGhpbmsqIGl0
IHNob3VsZCB3b3JrIG91dCB0aGF0IHdlIGRvbid0IGhpdCB0aGlzIHBhdGggd2l0aApmcmVlZHJl
bm8gYnV0IG9uIGFuZHJvaWQgSSBjYW4ndCByZWFsbHkgZ3VhcmFudGVlIG9yIHByb3ZlIGl0LiAg
U28KeW91ciBwYXRjaCB3b3VsZCBwb3RlbnRpYWxseSBicmVhayBleGlzdGluZyB3b3JraW5nIHVz
ZXJzcGFjZS4gIE1heWJlCml0IGlzIHVzZXJzcGFjZSB0aGF0IGlzbid0IHBvcnRhYmxlIChidXQg
T1RPSCBpdCBpc24ndCBsaWtlIHlvdSBhcmUKZ29pbmcgdG8gYmUgdXNpbmcgZnJlZWRyZW5vIG9u
IHRlZ3JhKS4gIFNvIHdoeSBkb24ndCB5b3UgZ28gZm9yIGEgbW9yZQp0YXJnZXRlZCBmaXggdGhh
dCBvbmx5IHJldHVybnMgYW4gZXJyb3Igb24gaHcgd2hlcmUgdGhpcyBpcwpwcm9ibGVtYXRpYz8K
CkJSLAotUgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
