Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A24C32772
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 16:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41BF7409EC;
	Tue, 23 Aug 2022 16:47:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41BF7409EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=P8Rb6AIU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ciE5We6V7fDW; Tue, 23 Aug 2022 16:47:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 943EE40931;
	Tue, 23 Aug 2022 16:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 943EE40931
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 623B8C0032;
	Tue, 23 Aug 2022 16:47:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A53B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 16:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7019960BF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 16:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7019960BF6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=P8Rb6AIU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqrNE2cngnUm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 16:47:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3666B60BF1
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3666B60BF1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 16:47:21 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id s199so16692331oie.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=F8aKSZv1NL2MA13LWlrkZ0pyLx1poLLo5+Y2auoHrrU=;
 b=P8Rb6AIUe0BqjayXQEF1C99U0H8YdtTbPpCkW0bERtLUXN9fooVIer4M3R47yIez/U
 5go1SSUpqQGPaOv6AsSeoRoo8SSXNjtCuLMuvgFbBFBYml0t9Zq+e/kHUBIQ0wfa8LYs
 0fCx1wsNmzKkwaquNleJdBdp/70ylcTVBYNrU8zsojU/8KiNhBozHLIiD/2vU3pbT1wu
 StvBfAQHmAvHRbTuuK1wfmyQdce5xlUhPz7Wu2Sg+hL+upMM0Ba5GeaTuFECDP5vlgsZ
 YyBmWB3oQyTquXWCh6CmFcUYquSC+NBylzyFgiUJ+4/FyXltqM8D6PhNC6TwsFN+ykfp
 1FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=F8aKSZv1NL2MA13LWlrkZ0pyLx1poLLo5+Y2auoHrrU=;
 b=XHUD0nCRE+JE+vOMYgCGtV+3m0pjt+841GTGAwAmzOfWsOSa8ybBHMrlmfW4OXRWyk
 wqYhhzCxYgaTOYWoEFNnh2R0s4JdIJ20paPW/jqfKAVOPYIlrcxlhpf/QliqKyg9mZEo
 Y6ppRIj9lBiinmWGEJedB/cRJjB560I7nGZ1uVNkOeUezp7Lwq55rLQGnboNlghEG4l8
 zNJlhU2b6T3GwlcfWthLjszpPHr/Ev880VKz2/kKDzjGYCToPAvgjBti4EQqMAL566PF
 NhnnoaNLqTOS6LdhpOY6w86AQleTIayJ2xZjKYT4/gqfAZlzRh+tM6J4h1IV5xBhy35O
 Ut+Q==
X-Gm-Message-State: ACgBeo0lteGNKr+WUQkQbDXQBAJDbMH65Yh4GIZhmbjZdNCWWIdhqv/4
 ByBus0DPuwmri0jouLcp+NgEVrCyaQSXVZ0eEtw=
X-Google-Smtp-Source: AA6agR7cQ1HWOR/GP2rtEG15PGZ/r+13Je3nF5uNZRRMMJwUkE+V9G7UTyql1pmHzDQiRGHyVzqd9qmK0bsICHBqrYU=
X-Received: by 2002:a05:6808:238d:b0:344:e5f9:db34 with SMTP id
 bp13-20020a056808238d00b00344e5f9db34mr1650387oib.183.1661273240141; Tue, 23
 Aug 2022 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
 <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
 <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
 <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
 <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
 <cf8cd8da-08d2-5e70-a239-2a67da37c9ea@collabora.com>
 <e9bde303-6474-aa0b-7880-cf7d8b163983@collabora.com>
 <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com>
In-Reply-To: <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 23 Aug 2022 09:47:53 -0700
Message-ID: <CAF6AEGvnqV4ySs6rNWu0pkeSNJMhgN1rvind8dC-nV1Sv3kk8g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, kernel@collabora.com,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
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

T24gVHVlLCBBdWcgMjMsIDIwMjIgYXQgMzowMSBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMi4wOC4yMiB1bSAxOToy
NiBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoKPiA+IE9uIDgvMTYvMjIgMjI6NTUsIERtaXRyeSBP
c2lwZW5rbyB3cm90ZToKPiA+PiBPbiA4LzE2LzIyIDE1OjAzLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOgo+ID4+PiBBbSAxNi4wOC4yMiB1bSAxMzo0NCBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoK
PiA+Pj4+IFtTTklQXQo+ID4+Pj4+IFRoZSBvdGhlciBjb21wbGljYXRpb24gSSBub3RpY2VkIGlz
IHRoYXQgd2UgZG9uJ3Qgc2VlbSB0byBrZWVwIGFyb3VuZAo+ID4+Pj4+IHRoZSBmZCBhZnRlciBp
bXBvcnRpbmcgdG8gYSBHRU0gaGFuZGxlLiAgQW5kIEkgY291bGQgaW1hZ2luZSB0aGF0Cj4gPj4+
Pj4gZG9pbmcgc28gY291bGQgY2F1c2UgaXNzdWVzIHdpdGggdG9vIG1hbnkgZmQncy4gIFNvIEkg
Z3Vlc3MgdGhlIGJlc3QKPiA+Pj4+PiB0aGluZyBpcyB0byBrZWVwIHRoZSBzdGF0dXMgcXVvIGFu
ZCBsZXQgZHJpdmVycyB0aGF0IGNhbm5vdCBtbWFwCj4gPj4+Pj4gaW1wb3J0ZWQgYnVmZmVycyBq
dXN0IGZhaWwgbW1hcD8KPiA+Pj4+IFRoYXQgYWN0dWFsbHkgc2hvdWxkIGJlIGFsbCB0aGUgZHJp
dmVycyBleGNsdWRpbmcgdGhvc2UgdGhhdCB1c2UKPiA+Pj4+IERSTS1TSE1FTSBiZWNhdXNlIG9u
bHkgRFJNLVNITUVNIHVzZXMgZG1hX2J1Zl9tbWFwKCksIHRoYXQncyB3aHkgaXQKPiA+Pj4+IHdv
cmtzIGZvciBQYW5mcm9zdC4gSSdtIHByZXR0eSBzdXJlIG1tYXBpbmcgb2YgaW1wb3J0ZWQgR0VN
cyBkb2Vzbid0Cj4gPj4+PiB3b3JrIGZvciB0aGUgTVNNIGRyaXZlciwgaXNuJ3QgaXQ/Cj4gPj4+
Pgo+ID4+Pj4gSW50ZWwgYW5kIEFNRCBkcml2ZXJzIGRvbid0IGFsbG93IHRvIG1hcCB0aGUgaW1w
b3J0ZWQgZG1hLWJ1ZnMuIEJvdGgKPiA+Pj4+IHJlZnVzZSB0byBkbyB0aGUgbWFwcGluZy4KPiA+
Pj4+Cj4gPj4+PiBBbHRob3VnaCwgQU1ER1BVICJzdWNjZWVkcyIgdG8gZG8gdGhlIG1hcHBpbmcg
dXNpbmcKPiA+Pj4+IEFNREdQVV9HRU1fRE9NQUlOX0dUVCwgYnV0IHRoZW4gdG91Y2hpbmcgdGhl
IG1hcHBpbmcgY2F1c2VzIGJ1cyBmYXVsdCwKPiA+Pj4+IGhlbmNlIG1hcHBpbmcgYWN0dWFsbHkg
ZmFpbHMuIEkgdGhpbmsgaXQgbWlnaHQgYmUgdGhlIEFNREdQVQo+ID4+Pj4gZHJpdmVyL2xpYmRy
bSBidWcsIGhhdmVuJ3QgY2hlY2tlZCB5ZXQuCj4gPj4+IFRoYXQncyB0aGVuIGNlcnRhaW5seSBi
cm9rZW4gc29tZWhvdy4gQW1kZ3B1IHNob3VsZCBuZXJ2ZSBldmVyIGhhdmUKPiA+Pj4gYWxsb3dl
ZCB0byBtbWFwKCkgaW1wb3J0ZWQgRE1BLWJ1ZnMgYW5kIHRoZSBsYXN0IHRpbWUgSSBjaGVjayBp
dCBkaWRuJ3QuCj4gPj4gSSdsbCB0YWtlIGEgY2xvc2VyIGxvb2suIFNvIGZhciBJIGNhbiBvbmx5
IHRlbGwgdGhhdCBpdCdzIGEga2VybmVsCj4gPj4gZHJpdmVyIGlzc3VlIGJlY2F1c2Ugb25jZSBJ
IHJlLWFwcGxpZWQgdGhpcyAiRG9uJ3QgbWFwIGltcG9ydGVkIEdFTXMiCj4gPj4gcGF0Y2gsIEFN
REdQVSBiZWdhbiB0byByZWZ1c2UgbWFwcGluZyBBTURHUFVfR0VNX0RPTUFJTl9HVFQuCj4gPj4K
PiA+Pj4+IFNvIHdlJ3JlIGJhY2sgdG8gdGhlIHBvaW50IHRoYXQgbmVpdGhlciBvZiBEUk0gZHJp
dmVycyBuZWVkIHRvIG1hcAo+ID4+Pj4gaW1wb3J0ZWQgZG1hLWJ1ZnMgYW5kIHRoaXMgd2FzIG5l
dmVyIHRlc3RlZC4gSW4gdGhpcyBjYXNlIHRoaXMgcGF0Y2ggaXMKPiA+Pj4+IHZhbGlkLCBJTU8u
Cj4gPj4gQWN0dWFsbHksIEknbSBub3cgbG9va2luZyBhdCBFdG5hdml2IGFuZCBOb3V2ZWF1IGFu
ZCBzZWVtcyB0aGV5IHNob3VsZAo+ID4+IG1hcCBpbXBvcnRlZCBkbWEtYnVmIHByb3Blcmx5LiBJ
IGtub3cgdGhhdCBwZW9wbGUgcmFuIEFuZHJvaWQgb24KPiA+PiBFdG5hdml2LiBTbyBtYXliZSBk
ZXZpY2VzIHdpdGggYSBzZXBhcmF0ZWQgR1BVL2Rpc3BsYXkgbmVlZCB0byBtYXAKPiA+PiBpbXBv
cnRlZCBkaXNwbGF5IEJPIGZvciBBbmRyb2lkIHN1cHBvcnQuIFdpc2ggc29tZWJvZHkgd2hvIHJh
biBBbmRyb2lkCj4gPj4gb24gb25lIG9mIHRoZXNlIGRldmljZXMgdXNpbmcgdXBzdHJlYW0gZHJp
dmVycyBjb3VsZCBnaXZlIGEgZGVmaW5pdGl2ZQo+ID4+IGFuc3dlci4gSSBtYXkgdHJ5IHRvIHRl
c3QgTm91dmVhdSBsYXRlciBvbi4KPiA+Pgo+ID4gTm91dmVhdStJbnRlbCBjb21ibyBkb2Vzbid0
IHdvcmsgYmVjYXVzZSBvZiBbMV0gdGhhdCBzYXlzOgo+ID4KPiA+ICJSZWZ1c2UgdG8gZmF1bHQg
aW1wb3J0ZWQgcGFnZXMuIFRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgKGlmIGF0IGFsbCkgYnkKPiA+
IHJlZGlyZWN0aW5nIG1tYXAgdG8gdGhlIGV4cG9ydGVyLiIKPiA+Cj4gPiBbMV0KPiA+IGh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE5L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9ib192bS5jI0wxNTQKPiA+Cj4gPiBJbnRlcmVzdGluZ2x5LCBJIG5vdGljZWQgdGhh
dCB0aGVyZSBhcmUgSUdUIHRlc3RzIHdoaWNoIGNoZWNrIHByaW1lCj4gPiBtbWFwaW5nIG9mIE5v
dXZlYXUrSW50ZWwgWzJdIChhZGRlZCA5IHllYXJzIGFnbyksIGJ1dCB0aGV5IGZhaWwgYXMgd2Vs
bCwKPiA+IGFzIGV4cGVjdGVkLiBUaGUgZmFjdCB0aGF0IElHVCBoYXMgc3VjaCB0ZXN0cyBpcyBp
bnRlcmVzdGluZyBiZWNhdXNlIGl0Cj4gPiBzdWdnZXN0cyB0aGF0IHRoZSBtYXBwaW5nIHdvcmtl
ZCBpbiB0aGUgcGFzdC4gSXQncyBhbHNvIHN1cnByaXNpbmcgdGhhdAo+ID4gbm9ib2R5IGNhcmVk
IHRvIGZpeCB0aGUgZmFpbGluZyB0ZXN0cy4gRm9yIHRoZSByZWZlcmVuY2UsIEkgY2hlY2tlZAo+
ID4gdjUuMTggYW5kIHRvZGF5J3MgbGludXgtbmV4dC4KPiA+Cj4gPiBbMl0KPiA+IGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vaWd0LWdwdS10b29scy8tL2Jsb2IvbWFzdGVyL3Rl
c3RzL3ByaW1lX252X3Rlc3QuYyNMMTMyCj4gPgo+ID4gU3RhcnRpbmcgc3VidGVzdDogbnZfd3Jp
dGVfaTkxNV9jcHVfbW1hcF9yZWFkCj4gPiBSZWNlaXZlZCBzaWduYWwgU0lHQlVTLgo+ID4gU3Rh
Y2sgdHJhY2U6Cj4gPiAgICMwIFtmYXRhbF9zaWdfaGFuZGxlcisweDE2M10KPiA+ICAgIzEgW19f
c2lnYWN0aW9uKzB4NTBdCj4gPiAgICMyIFtfX2lndF91bmlxdWVfX19fcmVhbF9tYWluMzU0KzB4
NDA2XQo+ID4gICAjMyBbbWFpbisweDIzXQo+ID4gICAjNCBbX19saWJjX3N0YXJ0X2NhbGxfbWFp
bisweDgwXQo+ID4gICAjNSBbX19saWJjX3N0YXJ0X21haW4rMHg4OV0KPiA+ICAgIzYgW19zdGFy
dCsweDI1XQo+ID4gU3VidGVzdCBudl93cml0ZV9pOTE1X2NwdV9tbWFwX3JlYWQ6IENSQVNIICgw
LDAwNXMpCj4gPgo+ID4gU3RhcnRpbmcgc3VidGVzdDogbnZfd3JpdGVfaTkxNV9ndHRfbW1hcF9y
ZWFkCj4gPiBSZWNlaXZlZCBzaWduYWwgU0lHQlVTLgo+ID4gU3RhY2sgdHJhY2U6Cj4gPiAgICMw
IFtmYXRhbF9zaWdfaGFuZGxlcisweDE2M10KPiA+ICAgIzEgW19fc2lnYWN0aW9uKzB4NTBdCj4g
PiAgICMyIFtfX2lndF91bmlxdWVfX19fcmVhbF9tYWluMzU0KzB4MzNkXQo+ID4gICAjMyBbbWFp
bisweDIzXQo+ID4gICAjNCBbX19saWJjX3N0YXJ0X2NhbGxfbWFpbisweDgwXQo+ID4gICAjNSBb
X19saWJjX3N0YXJ0X21haW4rMHg4OV0KPiA+ICAgIzYgW19zdGFydCsweDI1XQo+ID4gU3VidGVz
dCBudl93cml0ZV9pOTE1X2d0dF9tbWFwX3JlYWQ6IENSQVNIICgwLDAwNHMpCj4gPgo+ID4gSSdt
IGN1cmlvdXMgYWJvdXQgdGhlIEV0bmF2aXYgZHJpdmVyIGJlY2F1c2UgaXQgdXNlcyBvd24gc2ht
ZW0KPiA+IGltcGxlbWVudGF0aW9uIGFuZCBtYXliZSBpdCBoYXMgYSB3b3JraW5nIG1tYXBpbmcg
b2YgaW1wb3J0ZWQgR0VNcyBzaW5jZQo+ID4gaXQgaW1wb3J0cyB0aGUgZG1hLWJ1ZiBwYWdlcyBp
bnRvIEVudGF2aXYgQk8uIEFsdGhvdWdoLCBpdCBzaG91bGQgYmUKPiA+IHJpc2tpbmcgdG8gbWFw
IHBhZ2VzIHVzaW5nIGEgZGlmZmVyZW50IGNhY2hpbmcgYXR0cmlidXRlcyAoV0MpIGZyb20gdGhl
Cj4gPiBleHBvcnRlciwgd2hpY2ggaXMgcHJvaGliaXRlZCBvbiBBUk0gYWQgdGhlbiBvbmUgbWF5
IHRyeSB0byBtYXAgaW1wb3J0ZWQKPiA+IHVkbWFidWYuCj4gPgo+ID4gQXBwYXJlbnRseSwgdGhl
IEludGVsIERHIFRUTSBkcml2ZXIgc2hvdWxkIGJlIGFibGUgdG8gbWFwIGltcG9ydGVkCj4gPiBk
bWEtYnVmIGJlY2F1c2UgaXQgc2V0cyBUVE1fVFRfRkxBR19FWFRFUk5BTF9NQVBQQUJMRS4KPgo+
IEV2ZW4gd2l0aCB0aGF0IGZsYWcgc2V0IGl0IGlzIGlsbGVnYWwgdG8gbWFwIHRoZSBwYWdlcyBk
aXJlY3RseSBieSBhbgo+IGltcG9ydGVyLgo+Cj4gSWYgdGhhdCBldmVyIHdvcmtlZCB0aGVuIHRo
ZSBvbmx5IHJlYWwgc29sdXRpb24gaXMgdG8gcmVkaXJlY3QgbW1hcCgpCj4gY2FsbHMgb24gaW1w
b3J0ZXIgQk9zIHRvIGRtYV9idWZfbW1hcCgpLgoKWWVhaCwgSSB0aGluayB0aGlzIGlzIHRoZSBi
ZXN0IG9wdGlvbi4gIEZvcmNpbmcgdXNlcnNwYWNlIHRvIGhhbmcgb24KdG8gdGhlIGZkIGp1c3Qg
aW4gY2FzZSBzb21lb25lIGNhbGxzIHJlYWRwaXggd291bGQgYmUgcHJldHR5IGhhcnNoLgoKQlIs
Ci1SCgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gT3ZlcmFsbCwgaXQgc3RpbGwg
cXVlc3Rpb25hYmxlIHRvIG1lIHdoZXRoZXIgaXQncyB3b3J0aHdoaWxlIHRvIGFsbG93Cj4gPiB0
aGUgbW1hcGluZyBvZiBpbXBvcnRlZCBHRU1zIHNpbmNlIG9ubHkgUGFuZnJvc3QvTGltYSBjYW4g
ZG8gaXQgb3V0IG9mCj4gPiBhbGwgZHJpdmVycyBhbmQgaC93IHRoYXQgSSB0ZXN0ZWQuIEZlZWxz
IGxpa2UgZHJpdmVycyB0aGF0IGNhbiBkbyB0aGUKPiA+IG1hcHBpbmcgaGF2ZSBpdCBqdXN0IGJl
Y2F1c2UgdGhleSBjYW4gYW5kIG5vdCBiZWNhdXNlIHRoZXkgbmVlZC4KPiA+Cj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
