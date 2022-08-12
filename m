Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF03AC25B0E
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 15:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FBDB83DF8;
	Fri, 12 Aug 2022 15:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FBDB83DF8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=FGZzrzAm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGeq6V-dHTbi; Fri, 12 Aug 2022 15:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 877A083DF0;
	Fri, 12 Aug 2022 15:02:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 877A083DF0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51FD6C0033;
	Fri, 12 Aug 2022 15:02:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C264FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 15:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83CD9605EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 15:01:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83CD9605EA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=FGZzrzAm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id STY-9BGx8VCI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 15:01:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AEF5605B1
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AEF5605B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 15:01:56 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id g15so1029262iob.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=fFuoNXojTyZBhITwfY3HSSwwf07NNvFdh9I4FLMCELc=;
 b=FGZzrzAmz7xD4RA4VHluwmkiD3F2uePphL1xjVdsJ3GhjlcBiOZtb+SkrBPX5Iaum/
 AL8LpzbmUA+aU+ZNLAJ4zO62b725uyUg7lFjZOZ6PNoYaazOFUwTInWceQZ+9WZHWA2x
 bvvfp5NAeGogvH9JosTO80P7YZ66uJj6T6L1QNm/wv3IjKxdaAUp1Ho5rvFTDqa7HU3h
 27Ebqx+qWL6b7QbvDRG+ddIl6SPzJqFfAynfoo6F71Vg6/wA7kepzF8R7by9vSC0Fyhb
 CP/KtHEdsyHtw1ynFlWRrVIFudbfoXKjf5bLxIz+VyhKbQOq7LUECzSUCiLZHXdtXLDX
 cI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=fFuoNXojTyZBhITwfY3HSSwwf07NNvFdh9I4FLMCELc=;
 b=mbY7PdjWTgcflTw83FCx7YejAJxf3BaJrwdKYtUYXIjYpbYuLpgPhq/PONrLEza87h
 RkVafPg4ehZIIhdselqgKBwXNIR/VrbtDJx3ZP/FESCGCOlwIjLxGZEb7y0fjTTNKXjx
 p9+kOYbnhXfXNN8ZRBu5dUhi7bbFPJcj1qw6dZqeCfI8Lce069Zrs+HEv18PoKkapoNP
 sX3s3Uae0A+Sz/qx1EG9AzD4nHpkHGLCiPUj9FQSvRwS/zdWBn/BTKj56T7BPKPQtNWx
 pc+OEvaCsgOMlCIDvZGzEQ2UM25TIcEWqodh5aJDZTDm1WhbA4nVggmaUki46KnJzeRa
 17zA==
X-Gm-Message-State: ACgBeo1+8eN6M9mURjiELtSx4Mn10qUclHvU4DQjMdA7Euqf9kxYZFeh
 pIWK7BY5LHJ+6fXNLk2Mo75KnGygzcITiosv0/A=
X-Google-Smtp-Source: AA6agR5ROixpXWc2V2obN6+BACQm8lqAZVdAg9IyTZLBom1FQlCWofee8yj6lhWNvoQf5GcwigLflWEssMoEkaPktQ8=
X-Received: by 2002:a05:6602:1cf:b0:5e9:74e7:6b01 with SMTP id
 w15-20020a05660201cf00b005e974e76b01mr1684235iot.127.1660316515970; Fri, 12
 Aug 2022 08:01:55 -0700 (PDT)
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
 <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
 <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
In-Reply-To: <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 12 Aug 2022 08:01:44 -0700
Message-ID: <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
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

T24gRnJpLCBBdWcgMTIsIDIwMjIgYXQgNzo1NyBBTSBSb2IgQ2xhcmsgPHJvYmRjbGFya0BnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBBdWcgMTIsIDIwMjIgYXQgNDoyNiBBTSBEbWl0cnkg
T3NpcGVua28KPiA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+ID4KPiA+
IE9uIDgvMTEvMjIgMDI6MTksIFJvYiBDbGFyayB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMTAs
IDIwMjIgYXQgMzoyMyBQTSBEbWl0cnkgT3NpcGVua28KPiA+ID4gPGRtaXRyeS5vc2lwZW5rb0Bj
b2xsYWJvcmEuY29tPiB3cm90ZToKPiA+ID4+Cj4gPiA+PiBPbiA4LzExLzIyIDAxOjAzLCBSb2Ig
Q2xhcmsgd3JvdGU6Cj4gPiA+Pj4gT24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgMTI6MjYgUE0gRG1p
dHJ5IE9zaXBlbmtvCj4gPiA+Pj4gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPiB3cm90
ZToKPiA+ID4+Pj4KPiA+ID4+Pj4gT24gOC8xMC8yMiAxODowOCwgUm9iIENsYXJrIHdyb3RlOgo+
ID4gPj4+Pj4gT24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgNDo0NyBBTSBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+IHdyb3RlOgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gT24gV2VkLCBKdWwg
MDYsIDIwMjIgYXQgMTA6MDI6MDdBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+ID4g
Pj4+Pj4+PiBPbiA3LzYvMjIgMDA6NDgsIFJvYiBDbGFyayB3cm90ZToKPiA+ID4+Pj4+Pj4+IE9u
IFR1ZSwgSnVsIDUsIDIwMjIgYXQgNDo1MSBBTSBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+IHdyb3RlOgo+ID4gPj4+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+Pj4gQW0gMDEu
MDcuMjIgdW0gMTE6MDIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gPiA+Pj4+Pj4+Pj4+IERy
aXZlcnMgdGhhdCB1c2UgZHJtX2dlbV9tbWFwKCkgYW5kIGRybV9nZW1fbW1hcF9vYmooKSBoZWxw
ZXJzIGRvbid0Cj4gPiA+Pj4+Pj4+Pj4+IGhhbmRsZSBpbXBvcnRlZCBkbWEtYnVmcyBwcm9wZXJs
eSwgd2hpY2ggcmVzdWx0cyBpbiBtYXBwaW5nIG9mIHNvbWV0aGluZwo+ID4gPj4+Pj4+Pj4+PiBl
bHNlIHRoYW4gdGhlIGltcG9ydGVkIGRtYS1idWYuIE9uIE5WSURJQSBUZWdyYSB3ZSBnZXQgYSBo
YXJkIGxvY2t1cCB3aGVuCj4gPiA+Pj4+Pj4+Pj4+IHVzZXJzcGFjZSB3cml0ZXMgdG8gdGhlIG1l
bW9yeSBtYXBwaW5nIG9mIGEgZG1hLWJ1ZiB0aGF0IHdhcyBpbXBvcnRlZCBpbnRvCj4gPiA+Pj4+
Pj4+Pj4+IFRlZ3JhJ3MgRFJNIEdFTS4KPiA+ID4+Pj4+Pj4+Pj4KPiA+ID4+Pj4+Pj4+Pj4gTWFq
b3JpdHkgb2YgRFJNIGRyaXZlcnMgcHJvaGliaXQgbWFwcGluZyBvZiB0aGUgaW1wb3J0ZWQgR0VN
IG9iamVjdHMuCj4gPiA+Pj4+Pj4+Pj4+IE1hcHBpbmcgb2YgaW1wb3J0ZWQgR0VNcyByZXF1aXJl
IHNwZWNpYWwgY2FyZSBmcm9tIHVzZXJzcGFjZSBzaW5jZSBpdAo+ID4gPj4+Pj4+Pj4+PiBzaG91
bGQgc3luYyBkbWEtYnVmIGJlY2F1c2UgbWFwcGluZyBjb2hlcmVuY3kgb2YgdGhlIGV4cG9ydGVy
IGRldmljZSBtYXkKPiA+ID4+Pj4+Pj4+Pj4gbm90IG1hdGNoIHRoZSBEUk0gZGV2aWNlLiBMZXQn
cyBwcm9oaWJpdCB0aGUgbWFwcGluZyBmb3IgYWxsIERSTSBkcml2ZXJzCj4gPiA+Pj4+Pj4+Pj4+
IGZvciBjb25zaXN0ZW5jeS4KPiA+ID4+Pj4+Pj4+Pj4KPiA+ID4+Pj4+Pj4+Pj4gU3VnZ2VzdGVk
LWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+
Cj4gPiA+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9z
aXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4gPiA+Pj4+Pj4+Pj4KPiA+ID4+Pj4+Pj4+PiBJJ20gcHJl
dHR5IHN1cmUgdGhhdCB0aGlzIGlzIHRoZSByaWdodCBhcHByb2FjaCwgYnV0IGl0J3MgY2VydGFp
bmx5IG1vcmUKPiA+ID4+Pj4+Pj4+PiB0aGFuIHBvc3NpYmxlIHRoYXQgc29tZWJvZHkgYWJ1c2Vk
IHRoaXMgYWxyZWFkeS4KPiA+ID4+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+PiBJIHN1c3BlY3QgdGhhdCB0
aGlzIGlzIGFidXNlZCBpZiB5b3UgcnVuIGRlcXAgY3RzIG9uIGFuZHJvaWQuLiBpZS4gYWxsCj4g
PiA+Pj4+Pj4+PiB3aW5zeXMgYnVmZmVycyBhcmUgZG1hLWJ1ZiBpbXBvcnRzIGZyb20gZ3JhbGxv
Yy4gIEFuZCB0aGVuIHdoZW4geW91Cj4gPiA+Pj4+Pj4+PiBoaXQgcmVhZHBpeC4uLgo+ID4gPj4+
Pj4+Pj4KPiA+ID4+Pj4+Pj4+IFlvdSBtaWdodCBvbmx5IGhpdCB0aGlzIGluIHNjZW5hcmlvcyB3
aXRoIHNlcGFyYXRlIGdwdSBhbmQgZGlzcGxheSAob3IKPiA+ID4+Pj4+Pj4+IGRHUFUraUdQVSkg
YmVjYXVzZSBzZWxmLWltcG9ydHMgYXJlIGhhbmRsZWQgZGlmZmVyZW50bHkgaW4KPiA+ID4+Pj4+
Pj4+IGRybV9nZW1fcHJpbWVfaW1wb3J0X2RldigpLi4gYW5kIG1heWJlIG5vdCBpbiBjYXNlcyB3
aGVyZSB5b3UgZW5kIHVwCj4gPiA+Pj4+Pj4+PiB3aXRoIGEgYmxpdCBmcm9tIHRpbGVkL2NvbXBy
ZXNzZWQgdG8gbGluZWFyLi4gbWF5YmUgdGhhdCBuYXJyb3dzIHRoZQo+ID4gPj4+Pj4+Pj4gc2Nv
cGUgZW5vdWdoIHRvIGp1c3QgZml4IGl0IGluIHVzZXJzcGFjZT8KPiA+ID4+Pj4+Pj4KPiA+ID4+
Pj4+Pj4gR2l2ZW4gdGhhdCB0aGF0IG9ubHkgZHJpdmVycyB3aGljaCB1c2UgRFJNLVNITUVNIHBv
dGVudGlhbGx5IGNvdWxkJ3ZlCj4gPiA+Pj4+Pj4+IG1hcCBpbXBvcnRlZCBkbWEtYnVmcyAoUGFu
ZnJvc3QsIExpbWEpIGFuZCB0aGV5IGFscmVhZHkgZG9uJ3QgYWxsb3cgdG8KPiA+ID4+Pj4+Pj4g
ZG8gdGhhdCwgSSB0aGluayB3ZSdyZSBnb29kLgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gU28gY2Fu
IEkgaGF2ZSBhbiBhY2sgZnJvbSBSb2IgaGVyZSBvciBhcmUgdGhlcmUgc3RpbGwgcXVlc3Rpb25z
IHRoYXQgdGhpcwo+ID4gPj4+Pj4+IG1pZ2h0IGdvIGJvb20/Cj4gPiA+Pj4+Pj4KPiA+ID4+Pj4+
PiBEbWl0cnksIHNpbmNlIHlvdSBoYXZlIGEgYnVuY2ggb2YgcGF0Y2hlcyBtZXJnZWQgbm93IEkg
dGhpbmsgd291bGQgYWxzbyBiZQo+ID4gPj4+Pj4+IGdvb2QgdG8gZ2V0IGNvbW1pdCByaWdodHMg
c28geW91IGNhbiBkcml2ZSB0aGlzIG1vcmUgeW91cnNlbGYuIEkndmUgYXNrZWQKPiA+ID4+Pj4+
PiBEYW5pZWwgU3RvbmUgdG8gaGVscCB5b3Ugb3V0IHdpdGggZ2V0dGluZyB0aGF0Lgo+ID4gPj4+
Pj4KPiA+ID4+Pj4+IEkgKnRoaW5rKiB3ZSdkIGJlIG9rIHdpdGggdGhpcyBvbiBtc20sIG1vc3Rs
eSBqdXN0IGJ5IGR1bWIgbHVjay4KPiA+ID4+Pj4+IEJlY2F1c2UgdGhlIGRtYS1idWYncyB3ZSBp
bXBvcnQgd2lsbCBiZSBzZWxmLWltcG9ydC4gIEknbSBsZXNzIHN1cmUKPiA+ID4+Pj4+IGFib3V0
IHBhbmZyb3N0IChzcmMvcGFuZnJvc3QvbGliL3Bhbl9iby5jIGRvZXNuJ3Qgc2VlbSB0byBoYXZl
IGEKPiA+ID4+Pj4+IHNwZWNpYWwgcGF0aCBmb3IgaW1wb3J0ZWQgZG1hLWJ1ZnMgZWl0aGVyLCBh
bmQgaW4gdGhhdCBjYXNlIHRoZXkgd29uJ3QKPiA+ID4+Pj4+IGJlIHNlbGYtaW1wb3J0cy4uIGJ1
dCBJIGd1ZXNzIG5vIG9uZSBoYXMgdHJpZWQgdG8gcnVuIGFuZHJvaWQgY3RzIG9uCj4gPiA+Pj4+
PiBwYW5mcm9zdCkuCj4gPiA+Pj4+Cj4gPiA+Pj4+IFRoZSBsYXN0IHRpbWUgSSB0cmllZCB0byBt
bWFwIGRtYS1idWYgaW1wb3J0ZWQgdG8gUGFuZnJvc3QgZGlkbid0IHdvcmsKPiA+ID4+Pj4gYmVj
YXVzZSBQYW5mcm9zdCBkaWRuJ3QgaW1wbGVtZW50IHNvbWV0aGluZyBuZWVkZWQgZm9yIHRoYXQu
IEknbGwgbmVlZAo+ID4gPj4+PiB0byB0YWtlIGEgbG9vayBhZ2FpbiBiZWNhdXNlIGNhbid0IHJl
Y2FsbCB3aGF0IGl0IHdhcy4KPiA+IFVwZDogSSByZS1jaGVja2VkIFBhbmZyb3N0IHVzaW5nIHRv
ZGF5J3MgbGludXgtbmV4dCBhbmQgbWFwcGluZyBvZgo+ID4gaW1wb3J0ZWQgZG1hLWJ1ZiB3b3Jr
cywgSSBtYXBwZWQgaW1wb3J0ZWQgYnVmIGZyb20gdmlkZW8gZGVjb2Rlci4KPiA+IEFwcGFyZW50
bHkgcHJldmlvdXNseSBJIGhhZCBzb21lIGxvY2FsIGtlcm5lbCBjaGFuZ2UgdGhhdCBicm9rZSB0
aGUgbWFwcGluZy4KPiA+Cj4gPiA+Pj4+PiBXaGF0IGFib3V0IHNvbWV0aGluZyBsZXNzIGRyYXN0
aWMgdG8gc3RhcnQsIGxpa2UgKGFwb2xvZ2llcyBmb3IKPiA+ID4+Pj4+IGhhbmQtZWRpdGVkIHBh
dGNoKToKPiA+ID4+Pj4+Cj4gPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiA+ID4+Pj4+IGluZGV4IDg2ZDY3
MGM3MTI4Ni4uZmM5ZWM0MmZhMGFiIDEwMDY0NAo+ID4gPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9nZW0uYwo+ID4gPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+
ID4gPj4+Pj4gQEAgLTEwMzQsNiArMTAzNCwxMCBAQCBpbnQgZHJtX2dlbV9tbWFwX29iaihzdHJ1
Y3QgZHJtX2dlbV9vYmplY3QKPiA+ID4+Pj4+ICpvYmosIHVuc2lnbmVkIGxvbmcgb2JqX3NpemUs
Cj4gPiA+Pj4+PiAgewo+ID4gPj4+Pj4gICAgICAgICBpbnQgcmV0Owo+ID4gPj4+Pj4KPiA+ID4+
Pj4+ICsgICAgICAgV0FSTl9PTl9PTkNFKG9iai0+aW1wb3J0X2F0dGFjaCk7Cj4gPiA+Pj4+Cj4g
PiA+Pj4+IFRoaXMgd2lsbCBoYW5nIE5WSURJQSBUZWdyYSwgd2hpY2ggaXMgd2hhdCB0aGlzIHBh
dGNoIGZpeGVkIGluaXRpYWxseS4KPiA+ID4+Pj4gSWYgbmVpdGhlciBvZiB1cHN0cmVhbSBEUk0g
ZHJpdmVycyBuZWVkIHRvIG1hcCBpbXBvcnRlZCBkbWEtYnVmcyBhbmQKPiA+ID4+Pj4gbmV2ZXIg
bmVlZGVkLCB0aGVuIHdoeSBkbyB3ZSBuZWVkIHRoaXM/Cj4gPiA+Pj4KPiA+ID4+PiBvaCwgdGVn
cmEgaXNuJ3QgdXNpbmcgc2htZW0gaGVscGVycz8gIEkgYXNzdW1lZCBpdCB3YXMuICBXZWxsIG15
IHBvaW50Cj4gPiA+Pj4gd2FzIHRvIG1ha2UgYSBtb3JlIHRhcmdldGVkIGZhaWwgb24gdGVncmEs
IGFuZCBhIFdBUk5fT04gZm9yIGV2ZXJ5b25lCj4gPiA+Pj4gZWxzZSB0byBtYWtlIGl0IGNsZWFy
IHRoYXQgd2hhdCB0aGV5IGFyZSBkb2luZyBpcyB1bmRlZmluZWQgYmVoYXZpb3IuCj4gPiA+Pj4g
QmVjYXVzZSBzbyBmYXIgZXhpc3RpbmcgdXNlcnNwYWNlIChvciB3ZWxsLCBwYW5mcm9zdCBhbmQg
ZnJlZWRyZW5vIGF0Cj4gPiA+Pj4gbGVhc3QsIHRob3NlIGFyZSB0aGUgdHdvIEkga25vdyBvciBj
aGVja2VkKSBkb24ndCBtYWtlIHNwZWNpYWwgY2FzZXMKPiA+ID4+PiBmb3IgbW1hcCdpbmcgYWdh
aW5zdCB0aGUgZG1hYnVmIGZkIGFnYWluc3QgdGhlIGRtYWJ1ZiBmZCBpbnN0ZWFkIG9mCj4gPiA+
Pj4gdGhlIGRybSBkZXZpY2UgZmQuCj4gPiA+Pgo+ID4gPj4gSXQncyBub3QgY2xlYXIgdG8gbWUg
d2hhdCBiYWQgQW5kcm9pZCBkb2VzIGZvcm0geW91cnMgY29tbWVudHMuIERvZXMgaXQKPiA+ID4+
IGV4cG9ydCBkbWEtYnVmIGZyb20gR1BVIGFuZCB0aGVuIGltcG9ydCBpdCB0byBHUFU/IElmIHll
cywgdGhlbiBEUk0gY29yZQo+ID4gPj4gaGFzIGEgY2hlY2sgZm9yIHRoZSBzZWxmLWltcG9ydGlu
ZyBbMV0uCj4gPiA+Pgo+ID4gPj4gWzFdCj4gPiA+PiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9kcm1fcHJpbWUuYyNMOTE4Cj4g
PiA+Pgo+ID4gPj4gSWYgeW91J3JlIG1lYW5pbmcgc29tZXRoaW5nIGVsc2UsIHRoZW4gcGxlYXNl
IGV4cGxhaW4gaW4gYSBtb3JlIGRldGFpbHMuCj4gPiA+Cj4gPiA+IFNvLCBhbmRyb2lkL2dyYWxs
b2MgYWxsb2NhdGVzIGJ1ZmZlcnMgZXh0ZXJuYWxseSB0byB0aGUgZHJpdmVyIGFuZAo+ID4gPiBp
bXBvcnRzIHRoZW0gaW50byBkcml2ZXIuICAoQW5kIHRoYXQgc2VlbXMgdG8gbm90IGp1c3QgYmUg
d2luZG93Cj4gPiA+IHN1cmZhY2VzLCBidXQgaW4gY2FzZXMgcmFuZG9tIHRleHR1cmVzLCBldGMp
Cj4gPiA+Cj4gPiA+IEluIHRoZSBub3JtYWwgY2FzZSB0aGVzZSBzaG91bGQgYmUgYWxsb2NhdGVk
IGZyb20gZHJtL21zbSBzbyBpdCBzaG91bGQKPiA+ID4gaGl0IFsxXS4uIHRoaXMgaXMgdGhlICJk
dW1iIGx1Y2siIEkgbWVudGlvbmVkIGVhcmxpZXIuICBCdXQgSSdtIG5vdAo+ID4gPiBjb25maWRl
bnQgZW5vdWdoIHRvIHNheSB0aGF0IHRoZXJlIGlzIG5vIG90aGVyIGNhc2UuCj4gPiA+Cj4gPiA+
Pgo+ID4gPj4+IEkgKnRoaW5rKiBpdCBzaG91bGQgd29yayBvdXQgdGhhdCB3ZSBkb24ndCBoaXQg
dGhpcyBwYXRoIHdpdGgKPiA+ID4+PiBmcmVlZHJlbm8gYnV0IG9uIGFuZHJvaWQgSSBjYW4ndCBy
ZWFsbHkgZ3VhcmFudGVlIG9yIHByb3ZlIGl0LiAgU28KPiA+ID4+PiB5b3VyIHBhdGNoIHdvdWxk
IHBvdGVudGlhbGx5IGJyZWFrIGV4aXN0aW5nIHdvcmtpbmcgdXNlcnNwYWNlLiAgTWF5YmUKPiA+
ID4+PiBpdCBpcyB1c2Vyc3BhY2UgdGhhdCBpc24ndCBwb3J0YWJsZSAoYnV0IE9UT0ggaXQgaXNu
J3QgbGlrZSB5b3UgYXJlCj4gPiA+Pj4gZ29pbmcgdG8gYmUgdXNpbmcgZnJlZWRyZW5vIG9uIHRl
Z3JhKS4gIFNvIHdoeSBkb24ndCB5b3UgZ28gZm9yIGEgbW9yZQo+ID4gPj4+IHRhcmdldGVkIGZp
eCB0aGF0IG9ubHkgcmV0dXJucyBhbiBlcnJvciBvbiBodyB3aGVyZSB0aGlzIGlzCj4gPiA+Pj4g
cHJvYmxlbWF0aWM/Cj4gPiA+Pgo+ID4gPj4gVGhhdCdzIHdoYXQgdGhlIGZpcnN0IHZlcnNpb25z
IG9mIHRoZSBwYXRjaCBkaWQgYW5kIENocmlzdGlhbiBzdWdnZXN0ZWQKPiA+ID4+IHRoYXQgaXQn
cyBub3QgYSBnb29kIGFwcHJvYWNoLiBJbiBmYWN0IGl0IHNob3VsZCBiZSBub3Qgb25seSBUZWdy
YSB0aGF0Cj4gPiA+PiBoYXMgYSBicm9rZW4gZG1hLWJ1ZiBtYXBwaW5nLCBidXQgYXBwYXJlbnRs
eSBPTUFQIGRyaXZlciB0b28uCj4gPiA+Cj4gPiA+IEhtbSwgSSBndWVzcyBJJ20gYSBiaXQgbW9y
ZSBjb25zZXJ2YXRpdmUgd2hlbiBpdCBjb21lcyB0byBwb3RlbnRpYWxseQo+ID4gPiBicmVha2lu
ZyB1c2Vyc3BhY2UuCj4gPgo+ID4gSWYgc3VjaCB1c2Vyc3BhY2UgZXhpc3RzLCB0aGVuIG9mIGNv
dXJzZSB0aGUgbWFwcGluZyBzaG91bGQgY29udGludWUgdG8KPiA+IHdvcmsuIFN0aWxsIHdpbGwg
YmUgZ3JlYXQgdG8ga25vdyB3aGF0IHRoYXQgdXNlcnBzYWNlIGlzLgo+Cj4gRGVmaW5pdGVseSBl
eGlzdGluZyBtZXNhIGRvZXMgbm90IGhhdmUgYSBzcGVjaWFsIG1tYXAgcGF0aCBmb3IKPiBpbXBv
cnRlZCBkbWEtYnVmcyAoYm90aCBpbiB0aGUgY2FzZSBvZiBwYW5mcm9zdCBhbmQgZnJlZWRyZW5v
LCBJCj4gZGlkbid0IGNoZWNrIGFueSBvdGhlcnMpLiAgVGhlIG9ubHkgcXVlc3Rpb24gaXMgd2hl
dGhlciB0aGVyZSBpcyBhCj4gY2FzZSB3aGVyZSBzb21lIGFwcC90ZXN0L2V0YyBpbXBvcnRzIGEg
Zm9yZWlnbiBkbWEtYnVmIGZkIGFuZCB0aGVuCj4gZG9lcyBzb21ldGhpbmcgdGhhdCB3b3VsZCB0
cmlnZ2VyIG1tYXAnaW5nLCBsaWtlIHJlYWRwaXguCgpUaGUgb3RoZXIgY29tcGxpY2F0aW9uIEkg
bm90aWNlZCBpcyB0aGF0IHdlIGRvbid0IHNlZW0gdG8ga2VlcCBhcm91bmQKdGhlIGZkIGFmdGVy
IGltcG9ydGluZyB0byBhIEdFTSBoYW5kbGUuICBBbmQgSSBjb3VsZCBpbWFnaW5lIHRoYXQKZG9p
bmcgc28gY291bGQgY2F1c2UgaXNzdWVzIHdpdGggdG9vIG1hbnkgZmQncy4gIFNvIEkgZ3Vlc3Mg
dGhlIGJlc3QKdGhpbmcgaXMgdG8ga2VlcCB0aGUgc3RhdHVzIHF1byBhbmQgbGV0IGRyaXZlcnMg
dGhhdCBjYW5ub3QgbW1hcAppbXBvcnRlZCBidWZmZXJzIGp1c3QgZmFpbCBtbWFwPwoKQlIsCi1S
Cgo+IEJSLAo+IC1SCj4KPiA+IEFscmlnaHQsIGxldCdzIGtlZXAgdGhlIGRtYS1idWYgbWFwcGlu
ZyBhcy1pcyBmb3Igbm93LiBJJ2xsIGZpeCBqdXN0IHRoZQo+ID4gVGVncmEgZHJpdmVyIHRoZW4u
Cj4gPgo+ID4gLS0KPiA+IEJlc3QgcmVnYXJkcywKPiA+IERtaXRyeQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
