Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3553EECAAD3
	for <virtualization@archiver.kernel.org>; Sun, 11 Sep 2022 18:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7EA0D400C6;
	Sun, 11 Sep 2022 18:00:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EA0D400C6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZOZgXqz/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZjwFwHP_qtCL; Sun, 11 Sep 2022 18:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DBBA4011F;
	Sun, 11 Sep 2022 18:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DBBA4011F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47AACC0032;
	Sun, 11 Sep 2022 18:00:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABC6C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Sep 2022 18:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E15D741E60
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Sep 2022 18:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E15D741E60
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=ZOZgXqz/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sxZzl9_ek0Q3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Sep 2022 18:00:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35A5041E50
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35A5041E50
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Sep 2022 18:00:32 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1280590722dso17831323fac.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Sep 2022 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=lpIz80DghGGwjIn4yGkOwm4Ls4TinTTtzRBXCYSCrDk=;
 b=ZOZgXqz/ArjfoAnB+0jZzRx+rthBH9sr3pdoFE3GNbBzpRISacpgTcE6VOzMyzccAX
 9F1FpqE8Q9dddd8Cf2TyxBRuX3ELEsjZHVa90iPoGZU5Jg753yq3RV4r9MrVb7yfyk7H
 pxaLwQoDIkA0jj3CgMY+swbBn2G7O7395aPkaAtWV5Ss4L6wEF+Vnx6S9tQ0D6vEj33B
 0l5eyMPS0yrXVJ8U9oVTPNTjPPnE1OZDEwadVQ91Ux9Hne8z+Ee9XAbFCKLh1PhOzIT3
 +Ey31t2F9J6sJwOQHUkh7Ht4bITQYO0W1jiAI7jq+S8JemMZve7JEPgInAnkNyGJxhS2
 hhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=lpIz80DghGGwjIn4yGkOwm4Ls4TinTTtzRBXCYSCrDk=;
 b=jO8U8Jr1CyFy8c2d9ci/O7b+c9aQ176RwVbT2pepS2Lj+jlXijUsqfHJ7kdQ0g+HNQ
 xvusCZ0O2Qmxv1+Z2Pf13jVZ6InAab1CPYiP1B6o6vxq84znDZNEdKpauozlOVOP1iFJ
 Sszgj6YWLTBkenNYkqZ5/1D/o8TMRKqO8oIcLywHPolnfpw3RXy92w2TevSAKpha2/DE
 hufbIgWlwY+ynLiH8Rbev8EtEs13FO7lIDXZKJ9f3vS134NYXL6j+qT0npJD6RZvDh6O
 BmAiLAHCGM2aGVsQ9y0FYjm4cCDDYgOkmXUbG4cv2LzGeqJckfUGZNHGliIf+tD+dxCw
 Dhaw==
X-Gm-Message-State: ACgBeo1n363jk7iMpvYdv7eimKk6hEGJYrB2IR2ge4aewfMyQoTwnsnP
 02DVnEQU0aLIskvx0khh2y3yGd8kpDdsQJDent0=
X-Google-Smtp-Source: AA6agR7dMjfSO8Fs6ZPG+miD78AZ0xIGFwEMeQnueiJDM9vQ5cSuGDdWOkeInvxGvtlWlUu5YIafHoVmQClvNOkxNsQ=
X-Received: by 2002:a05:6808:1a9a:b0:34f:b9df:b3 with SMTP id
 bm26-20020a0568081a9a00b0034fb9df00b3mr224200oib.183.1662919230912; Sun, 11
 Sep 2022 11:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
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
 <CAF6AEGvnqV4ySs6rNWu0pkeSNJMhgN1rvind8dC-nV1Sv3kk8g@mail.gmail.com>
 <bab5a55b-cbd3-4119-af39-794e38f5a0ee@collabora.com>
In-Reply-To: <bab5a55b-cbd3-4119-af39-794e38f5a0ee@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Sun, 11 Sep 2022 11:00:21 -0700
Message-ID: <CAF6AEGvdyu8gO-Mjnau8uMwuKNPreEnnUH86WL=LQPcgW_WOEA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: kernel@collabora.com, dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
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

T24gV2VkLCBTZXAgNywgMjAyMiBhdCAzOjI1IEFNIERtaXRyeSBPc2lwZW5rbwo8ZG1pdHJ5Lm9z
aXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Cj4gT24gOC8yMy8yMiAxOTo0NywgUm9iIENs
YXJrIHdyb3RlOgo+ID4gT24gVHVlLCBBdWcgMjMsIDIwMjIgYXQgMzowMSBBTSBDaHJpc3RpYW4g
S8O2bmlnCj4gPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4+
Cj4gPj4gQW0gMjIuMDguMjIgdW0gMTk6MjYgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gPj4+
IE9uIDgvMTYvMjIgMjI6NTUsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+Pj4+IE9uIDgvMTYv
MjIgMTU6MDMsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gPj4+Pj4gQW0gMTYuMDguMjIgdW0g
MTM6NDQgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gPj4+Pj4+IFtTTklQXQo+ID4+Pj4+Pj4g
VGhlIG90aGVyIGNvbXBsaWNhdGlvbiBJIG5vdGljZWQgaXMgdGhhdCB3ZSBkb24ndCBzZWVtIHRv
IGtlZXAgYXJvdW5kCj4gPj4+Pj4+PiB0aGUgZmQgYWZ0ZXIgaW1wb3J0aW5nIHRvIGEgR0VNIGhh
bmRsZS4gIEFuZCBJIGNvdWxkIGltYWdpbmUgdGhhdAo+ID4+Pj4+Pj4gZG9pbmcgc28gY291bGQg
Y2F1c2UgaXNzdWVzIHdpdGggdG9vIG1hbnkgZmQncy4gIFNvIEkgZ3Vlc3MgdGhlIGJlc3QKPiA+
Pj4+Pj4+IHRoaW5nIGlzIHRvIGtlZXAgdGhlIHN0YXR1cyBxdW8gYW5kIGxldCBkcml2ZXJzIHRo
YXQgY2Fubm90IG1tYXAKPiA+Pj4+Pj4+IGltcG9ydGVkIGJ1ZmZlcnMganVzdCBmYWlsIG1tYXA/
Cj4gPj4+Pj4+IFRoYXQgYWN0dWFsbHkgc2hvdWxkIGJlIGFsbCB0aGUgZHJpdmVycyBleGNsdWRp
bmcgdGhvc2UgdGhhdCB1c2UKPiA+Pj4+Pj4gRFJNLVNITUVNIGJlY2F1c2Ugb25seSBEUk0tU0hN
RU0gdXNlcyBkbWFfYnVmX21tYXAoKSwgdGhhdCdzIHdoeSBpdAo+ID4+Pj4+PiB3b3JrcyBmb3Ig
UGFuZnJvc3QuIEknbSBwcmV0dHkgc3VyZSBtbWFwaW5nIG9mIGltcG9ydGVkIEdFTXMgZG9lc24n
dAo+ID4+Pj4+PiB3b3JrIGZvciB0aGUgTVNNIGRyaXZlciwgaXNuJ3QgaXQ/Cj4gPj4+Pj4+Cj4g
Pj4+Pj4+IEludGVsIGFuZCBBTUQgZHJpdmVycyBkb24ndCBhbGxvdyB0byBtYXAgdGhlIGltcG9y
dGVkIGRtYS1idWZzLiBCb3RoCj4gPj4+Pj4+IHJlZnVzZSB0byBkbyB0aGUgbWFwcGluZy4KPiA+
Pj4+Pj4KPiA+Pj4+Pj4gQWx0aG91Z2gsIEFNREdQVSAic3VjY2VlZHMiIHRvIGRvIHRoZSBtYXBw
aW5nIHVzaW5nCj4gPj4+Pj4+IEFNREdQVV9HRU1fRE9NQUlOX0dUVCwgYnV0IHRoZW4gdG91Y2hp
bmcgdGhlIG1hcHBpbmcgY2F1c2VzIGJ1cyBmYXVsdCwKPiA+Pj4+Pj4gaGVuY2UgbWFwcGluZyBh
Y3R1YWxseSBmYWlscy4gSSB0aGluayBpdCBtaWdodCBiZSB0aGUgQU1ER1BVCj4gPj4+Pj4+IGRy
aXZlci9saWJkcm0gYnVnLCBoYXZlbid0IGNoZWNrZWQgeWV0Lgo+ID4+Pj4+IFRoYXQncyB0aGVu
IGNlcnRhaW5seSBicm9rZW4gc29tZWhvdy4gQW1kZ3B1IHNob3VsZCBuZXJ2ZSBldmVyIGhhdmUK
PiA+Pj4+PiBhbGxvd2VkIHRvIG1tYXAoKSBpbXBvcnRlZCBETUEtYnVmcyBhbmQgdGhlIGxhc3Qg
dGltZSBJIGNoZWNrIGl0IGRpZG4ndC4KPiA+Pj4+IEknbGwgdGFrZSBhIGNsb3NlciBsb29rLiBT
byBmYXIgSSBjYW4gb25seSB0ZWxsIHRoYXQgaXQncyBhIGtlcm5lbAo+ID4+Pj4gZHJpdmVyIGlz
c3VlIGJlY2F1c2Ugb25jZSBJIHJlLWFwcGxpZWQgdGhpcyAiRG9uJ3QgbWFwIGltcG9ydGVkIEdF
TXMiCj4gPj4+PiBwYXRjaCwgQU1ER1BVIGJlZ2FuIHRvIHJlZnVzZSBtYXBwaW5nIEFNREdQVV9H
RU1fRE9NQUlOX0dUVC4KPiA+Pj4+Cj4gPj4+Pj4+IFNvIHdlJ3JlIGJhY2sgdG8gdGhlIHBvaW50
IHRoYXQgbmVpdGhlciBvZiBEUk0gZHJpdmVycyBuZWVkIHRvIG1hcAo+ID4+Pj4+PiBpbXBvcnRl
ZCBkbWEtYnVmcyBhbmQgdGhpcyB3YXMgbmV2ZXIgdGVzdGVkLiBJbiB0aGlzIGNhc2UgdGhpcyBw
YXRjaCBpcwo+ID4+Pj4+PiB2YWxpZCwgSU1PLgo+ID4+Pj4gQWN0dWFsbHksIEknbSBub3cgbG9v
a2luZyBhdCBFdG5hdml2IGFuZCBOb3V2ZWF1IGFuZCBzZWVtcyB0aGV5IHNob3VsZAo+ID4+Pj4g
bWFwIGltcG9ydGVkIGRtYS1idWYgcHJvcGVybHkuIEkga25vdyB0aGF0IHBlb3BsZSByYW4gQW5k
cm9pZCBvbgo+ID4+Pj4gRXRuYXZpdi4gU28gbWF5YmUgZGV2aWNlcyB3aXRoIGEgc2VwYXJhdGVk
IEdQVS9kaXNwbGF5IG5lZWQgdG8gbWFwCj4gPj4+PiBpbXBvcnRlZCBkaXNwbGF5IEJPIGZvciBB
bmRyb2lkIHN1cHBvcnQuIFdpc2ggc29tZWJvZHkgd2hvIHJhbiBBbmRyb2lkCj4gPj4+PiBvbiBv
bmUgb2YgdGhlc2UgZGV2aWNlcyB1c2luZyB1cHN0cmVhbSBkcml2ZXJzIGNvdWxkIGdpdmUgYSBk
ZWZpbml0aXZlCj4gPj4+PiBhbnN3ZXIuIEkgbWF5IHRyeSB0byB0ZXN0IE5vdXZlYXUgbGF0ZXIg
b24uCj4gPj4+Pgo+ID4+PiBOb3V2ZWF1K0ludGVsIGNvbWJvIGRvZXNuJ3Qgd29yayBiZWNhdXNl
IG9mIFsxXSB0aGF0IHNheXM6Cj4gPj4+Cj4gPj4+ICJSZWZ1c2UgdG8gZmF1bHQgaW1wb3J0ZWQg
cGFnZXMuIFRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgKGlmIGF0IGFsbCkgYnkKPiA+Pj4gcmVkaXJl
Y3RpbmcgbW1hcCB0byB0aGUgZXhwb3J0ZXIuIgo+ID4+Pgo+ID4+PiBbMV0KPiA+Pj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTkvc291cmNlL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3ZtLmMjTDE1NAo+ID4+Pgo+ID4+PiBJbnRlcmVzdGluZ2x5LCBJIG5vdGljZWQg
dGhhdCB0aGVyZSBhcmUgSUdUIHRlc3RzIHdoaWNoIGNoZWNrIHByaW1lCj4gPj4+IG1tYXBpbmcg
b2YgTm91dmVhdStJbnRlbCBbMl0gKGFkZGVkIDkgeWVhcnMgYWdvKSwgYnV0IHRoZXkgZmFpbCBh
cyB3ZWxsLAo+ID4+PiBhcyBleHBlY3RlZC4gVGhlIGZhY3QgdGhhdCBJR1QgaGFzIHN1Y2ggdGVz
dHMgaXMgaW50ZXJlc3RpbmcgYmVjYXVzZSBpdAo+ID4+PiBzdWdnZXN0cyB0aGF0IHRoZSBtYXBw
aW5nIHdvcmtlZCBpbiB0aGUgcGFzdC4gSXQncyBhbHNvIHN1cnByaXNpbmcgdGhhdAo+ID4+PiBu
b2JvZHkgY2FyZWQgdG8gZml4IHRoZSBmYWlsaW5nIHRlc3RzLiBGb3IgdGhlIHJlZmVyZW5jZSwg
SSBjaGVja2VkCj4gPj4+IHY1LjE4IGFuZCB0b2RheSdzIGxpbnV4LW5leHQuCj4gPj4+Cj4gPj4+
IFsyXQo+ID4+PiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2lndC1ncHUtdG9v
bHMvLS9ibG9iL21hc3Rlci90ZXN0cy9wcmltZV9udl90ZXN0LmMjTDEzMgo+ID4+Pgo+ID4+PiBT
dGFydGluZyBzdWJ0ZXN0OiBudl93cml0ZV9pOTE1X2NwdV9tbWFwX3JlYWQKPiA+Pj4gUmVjZWl2
ZWQgc2lnbmFsIFNJR0JVUy4KPiA+Pj4gU3RhY2sgdHJhY2U6Cj4gPj4+ICAgIzAgW2ZhdGFsX3Np
Z19oYW5kbGVyKzB4MTYzXQo+ID4+PiAgICMxIFtfX3NpZ2FjdGlvbisweDUwXQo+ID4+PiAgICMy
IFtfX2lndF91bmlxdWVfX19fcmVhbF9tYWluMzU0KzB4NDA2XQo+ID4+PiAgICMzIFttYWluKzB4
MjNdCj4gPj4+ICAgIzQgW19fbGliY19zdGFydF9jYWxsX21haW4rMHg4MF0KPiA+Pj4gICAjNSBb
X19saWJjX3N0YXJ0X21haW4rMHg4OV0KPiA+Pj4gICAjNiBbX3N0YXJ0KzB4MjVdCj4gPj4+IFN1
YnRlc3QgbnZfd3JpdGVfaTkxNV9jcHVfbW1hcF9yZWFkOiBDUkFTSCAoMCwwMDVzKQo+ID4+Pgo+
ID4+PiBTdGFydGluZyBzdWJ0ZXN0OiBudl93cml0ZV9pOTE1X2d0dF9tbWFwX3JlYWQKPiA+Pj4g
UmVjZWl2ZWQgc2lnbmFsIFNJR0JVUy4KPiA+Pj4gU3RhY2sgdHJhY2U6Cj4gPj4+ICAgIzAgW2Zh
dGFsX3NpZ19oYW5kbGVyKzB4MTYzXQo+ID4+PiAgICMxIFtfX3NpZ2FjdGlvbisweDUwXQo+ID4+
PiAgICMyIFtfX2lndF91bmlxdWVfX19fcmVhbF9tYWluMzU0KzB4MzNkXQo+ID4+PiAgICMzIFtt
YWluKzB4MjNdCj4gPj4+ICAgIzQgW19fbGliY19zdGFydF9jYWxsX21haW4rMHg4MF0KPiA+Pj4g
ICAjNSBbX19saWJjX3N0YXJ0X21haW4rMHg4OV0KPiA+Pj4gICAjNiBbX3N0YXJ0KzB4MjVdCj4g
Pj4+IFN1YnRlc3QgbnZfd3JpdGVfaTkxNV9ndHRfbW1hcF9yZWFkOiBDUkFTSCAoMCwwMDRzKQo+
ID4+Pgo+ID4+PiBJJ20gY3VyaW91cyBhYm91dCB0aGUgRXRuYXZpdiBkcml2ZXIgYmVjYXVzZSBp
dCB1c2VzIG93biBzaG1lbQo+ID4+PiBpbXBsZW1lbnRhdGlvbiBhbmQgbWF5YmUgaXQgaGFzIGEg
d29ya2luZyBtbWFwaW5nIG9mIGltcG9ydGVkIEdFTXMgc2luY2UKPiA+Pj4gaXQgaW1wb3J0cyB0
aGUgZG1hLWJ1ZiBwYWdlcyBpbnRvIEVudGF2aXYgQk8uIEFsdGhvdWdoLCBpdCBzaG91bGQgYmUK
PiA+Pj4gcmlza2luZyB0byBtYXAgcGFnZXMgdXNpbmcgYSBkaWZmZXJlbnQgY2FjaGluZyBhdHRy
aWJ1dGVzIChXQykgZnJvbSB0aGUKPiA+Pj4gZXhwb3J0ZXIsIHdoaWNoIGlzIHByb2hpYml0ZWQg
b24gQVJNIGFkIHRoZW4gb25lIG1heSB0cnkgdG8gbWFwIGltcG9ydGVkCj4gPj4+IHVkbWFidWYu
Cj4KPiBJIHNlZSBub3cgdGhhdCBFdG5hdml2IHVzZXMgZG1hX2J1Zl9tbWFwKCksIHNvIGl0IHNo
b3VsZCBiZSBva2F5Lgo+Cj4gPj4+IEFwcGFyZW50bHksIHRoZSBJbnRlbCBERyBUVE0gZHJpdmVy
IHNob3VsZCBiZSBhYmxlIHRvIG1hcCBpbXBvcnRlZAo+ID4+PiBkbWEtYnVmIGJlY2F1c2UgaXQg
c2V0cyBUVE1fVFRfRkxBR19FWFRFUk5BTF9NQVBQQUJMRS4KPiA+Pgo+ID4+IEV2ZW4gd2l0aCB0
aGF0IGZsYWcgc2V0IGl0IGlzIGlsbGVnYWwgdG8gbWFwIHRoZSBwYWdlcyBkaXJlY3RseSBieSBh
bgo+ID4+IGltcG9ydGVyLgo+ID4+Cj4gPj4gSWYgdGhhdCBldmVyIHdvcmtlZCB0aGVuIHRoZSBv
bmx5IHJlYWwgc29sdXRpb24gaXMgdG8gcmVkaXJlY3QgbW1hcCgpCj4gPj4gY2FsbHMgb24gaW1w
b3J0ZXIgQk9zIHRvIGRtYV9idWZfbW1hcCgpLgo+ID4KPiA+IFllYWgsIEkgdGhpbmsgdGhpcyBp
cyB0aGUgYmVzdCBvcHRpb24uICBGb3JjaW5nIHVzZXJzcGFjZSB0byBoYW5nIG9uCj4gPiB0byB0
aGUgZmQganVzdCBpbiBjYXNlIHNvbWVvbmUgY2FsbHMgcmVhZHBpeCB3b3VsZCBiZSBwcmV0dHkg
aGFyc2guCj4KPiBBY3R1YWxseSwgSSBwcm9wb3NlZCB0aGlzIGNvdXBsZSBtb250aHMgYWdvIFsx
XS4KPgo+IFsxXSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvNDg3NDgx
Lwo+Cj4gV2hhdCdzIG5vdCBjbGVhciB0byBtZSBpcyBob3cgdXNlcnNwYWNlIGlzIHN1cHBvc2Vk
IHRvIHN5bmMgQ1BVIGFjY2Vzc2VzCj4gZm9yIGltcG9ydGVkIEdFTXMuIEVpdGhlciB1c2Vyc3Bh
Y2UgbmVlZCB0byB1c2UgZG1hX2J1Zl9zeW5jIFVBUEkgZm9yCj4gZG1hYnVmIG9mIGltcG9ydGVk
IEdFTSBvciBpbXBvcnRlciBkcml2ZXIgc2hvdWxkIGRvIHRoYXQsIG9yIHRoZXJlIGlzCj4gc29t
ZSBvdGhlciBvcHRpb24/CgpGb3IgYW55dGhpbmcgaW52b2x2aW5nIHRoZSBHUFUsIHVzZXJzcGFj
ZSBhbHJlYWR5IG5lZWRzIHRvIHN5bmMgYWNjZXNzCihpZS4gR1BVcyBhcmUgYXN5bmNocm9ub3Vz
KS4uIHRoaXMgaXMgZG9uZSB1c2luZyBkcm1fZ2VtX29iamVjdDo6cmVzdgood2hpY2ggY29tZXMg
ZnJvbSBkbWFfYnVmOjpyZXN2KS4uCgpQb3NzaWJseSB3ZSBzaG91bGQgcmVxdWlyZSB0aGF0CmRt
YV9idWZfYmVnaW5fY3B1X2FjY2VzcygpL2RtYV9idWZfZW5kX2NwdV9hY2Nlc3MoKS4uIGJ1dCBp
biBwcmFjdGljZQppZiB0aGUgZ2wvdmsgZHJpdmVyIG5lZWRzIENQVSBhY2Nlc3MgaXQgaXMgdG8g
cmVhZCB0aGUgcmVzdWx0cyBvZiBpdCdzCm93biBHUFUgcmVuZGVyaW5nLiAgRGlzYWxsb3cgdGhh
dCBhbmQgYWxsIG9mIGRlcXAvcGlnbGl0L2V0YyB3aWxsCmJyZWFrIG9uIHN5c3RlbXMgd2hlcmUg
IndpbmRvdyIgc3VyZmFjZXMgYXJlIGRtYS1idWYgaW1wb3J0cyAobGlrZQphbmRyb2lkKSwgd2hp
Y2ggd291bGQgYmUgYSByYXRoZXIgdW5wb3B1bGFyIG91dGNvbWUgOy0pCgpCUiwKLVIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
