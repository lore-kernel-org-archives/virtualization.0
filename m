Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7E3C25B07
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 15:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC2F040142;
	Wed, 10 Aug 2022 15:08:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC2F040142
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WSpLVtuz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWEVBS8-KGsU; Wed, 10 Aug 2022 15:08:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D546404C0;
	Wed, 10 Aug 2022 15:08:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D546404C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2861EC0033;
	Wed, 10 Aug 2022 15:08:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B039EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 15:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B04580B23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 15:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B04580B23
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=WSpLVtuz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-rzLAlkLuPA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 15:08:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE9F681491
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE9F681491
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 15:08:28 +0000 (UTC)
Received: by mail-io1-xd2f.google.com with SMTP id e69so12370039iof.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=P8TXeNV+7zskV8fKSSy2utDBKNnP7PwHXswFotxFdK0=;
 b=WSpLVtuzfN5igBK8LD8eFpSXdWpwPBUjySGUljTob+BUjSVxKylVO7RDdomFHBrH8B
 jFvSm6eJkbuw5XlkXEaQGHqaatqFW7VEHvQAgl1jx/b4vTlpmCgEO1Qm8HA4U7lvAWQz
 hl9+/qx0cuemGM39X4lyM6r8ab9sNmDaCXYI4YSZ3LCprskOPyFHh/RssVwnfQZPDzqO
 Dt7JO4n6bBN3S9C7384h/zV3UT7z6ZhdOy5pwVMYj9KZH0aqWiaP+i0IXHscoTLQs7Yc
 nYna+23vqtrzY1+2tePKwaKhoZQfRuUZCvsnjEqlMgQYHg6C3dhyFZV/kHWkcmGsGcHS
 oI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=P8TXeNV+7zskV8fKSSy2utDBKNnP7PwHXswFotxFdK0=;
 b=LpA23vj2Ogt+Y5tFx8Wc/MdT8ZEg+Cmpyw1kPAjmdu7Fpd/pxhSH69YlZk+UNmyPMq
 tTmIo+POrLKJ3cZDKOvojzqdOxSeV9h7BhPEsV4baPsVXjiWUa0URSR4Q132P1gB8NSk
 iXBsMSsg1pGnOFjfSeP9Ole3vVFyh4gc7wujCE4u7wYZzBWItZEwQoy/y71nSCHbLKZ9
 GZ7gaFmOehstVfv2ndPyh/NG3Hy/xqov9//pJXcoT1WGDSyRB5mx7pa/L7ljf4epIQY8
 GxZ0PkmorWSabDWze54YtVu9LypwJRkVI9fBQlSqdxyKWRpAD9zcM5sG7GjAR0zPz+dJ
 PiEA==
X-Gm-Message-State: ACgBeo17eh3XgpsMjw1qJSEzfPSj6maBfWkOsylZ8UHJDBZhxSTqmXht
 QhpYDkZ/hp1SjeBjd8H+LAyp2JjhtA6YJ9ftmL4=
X-Google-Smtp-Source: AA6agR74RZvvSswze2RlPU2jPG2C0znVnnazQXl+qZfN9DPU4Mu2uILtC9LaOZUSLAH9emrDZl1TfXxVIUeu5/kSLNk=
X-Received: by 2002:a05:6602:26c7:b0:67b:72ef:b87b with SMTP id
 g7-20020a05660226c700b0067b72efb87bmr11903368ioo.175.1660144107634; Wed, 10
 Aug 2022 08:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
In-Reply-To: <YvOav/vF2awVWIu0@phenom.ffwll.local>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 10 Aug 2022 08:08:15 -0700
Message-ID: <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robdclark@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Emil Velikov <emil.l.velikov@gmail.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 linux-tegra@vger.kernel.org, 
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Cc: Daniel Vetter <daniel@ffwll.ch>
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

T24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgNDo0NyBBTSBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+IHdyb3RlOgo+Cj4gT24gV2VkLCBKdWwgMDYsIDIwMjIgYXQgMTA6MDI6MDdBTSArMDMw
MCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+ID4gT24gNy82LzIyIDAwOjQ4LCBSb2IgQ2xhcmsg
d3JvdGU6Cj4gPiA+IE9uIFR1ZSwgSnVsIDUsIDIwMjIgYXQgNDo1MSBBTSBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+ID4gPj4KPiA+ID4+IEFtIDAx
LjA3LjIyIHVtIDExOjAyIHNjaHJpZWIgRG1pdHJ5IE9zaXBlbmtvOgo+ID4gPj4+IERyaXZlcnMg
dGhhdCB1c2UgZHJtX2dlbV9tbWFwKCkgYW5kIGRybV9nZW1fbW1hcF9vYmooKSBoZWxwZXJzIGRv
bid0Cj4gPiA+Pj4gaGFuZGxlIGltcG9ydGVkIGRtYS1idWZzIHByb3Blcmx5LCB3aGljaCByZXN1
bHRzIGluIG1hcHBpbmcgb2Ygc29tZXRoaW5nCj4gPiA+Pj4gZWxzZSB0aGFuIHRoZSBpbXBvcnRl
ZCBkbWEtYnVmLiBPbiBOVklESUEgVGVncmEgd2UgZ2V0IGEgaGFyZCBsb2NrdXAgd2hlbgo+ID4g
Pj4+IHVzZXJzcGFjZSB3cml0ZXMgdG8gdGhlIG1lbW9yeSBtYXBwaW5nIG9mIGEgZG1hLWJ1ZiB0
aGF0IHdhcyBpbXBvcnRlZCBpbnRvCj4gPiA+Pj4gVGVncmEncyBEUk0gR0VNLgo+ID4gPj4+Cj4g
PiA+Pj4gTWFqb3JpdHkgb2YgRFJNIGRyaXZlcnMgcHJvaGliaXQgbWFwcGluZyBvZiB0aGUgaW1w
b3J0ZWQgR0VNIG9iamVjdHMuCj4gPiA+Pj4gTWFwcGluZyBvZiBpbXBvcnRlZCBHRU1zIHJlcXVp
cmUgc3BlY2lhbCBjYXJlIGZyb20gdXNlcnNwYWNlIHNpbmNlIGl0Cj4gPiA+Pj4gc2hvdWxkIHN5
bmMgZG1hLWJ1ZiBiZWNhdXNlIG1hcHBpbmcgY29oZXJlbmN5IG9mIHRoZSBleHBvcnRlciBkZXZp
Y2UgbWF5Cj4gPiA+Pj4gbm90IG1hdGNoIHRoZSBEUk0gZGV2aWNlLiBMZXQncyBwcm9oaWJpdCB0
aGUgbWFwcGluZyBmb3IgYWxsIERSTSBkcml2ZXJzCj4gPiA+Pj4gZm9yIGNvbnNpc3RlbmN5Lgo+
ID4gPj4+Cj4gPiA+Pj4gU3VnZ2VzdGVkLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhl
bGxzdHJvbUBsaW51eC5pbnRlbC5jb20+Cj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9z
aXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KPiA+ID4+Cj4gPiA+PiBJJ20g
cHJldHR5IHN1cmUgdGhhdCB0aGlzIGlzIHRoZSByaWdodCBhcHByb2FjaCwgYnV0IGl0J3MgY2Vy
dGFpbmx5IG1vcmUKPiA+ID4+IHRoYW4gcG9zc2libGUgdGhhdCBzb21lYm9keSBhYnVzZWQgdGhp
cyBhbHJlYWR5Lgo+ID4gPgo+ID4gPiBJIHN1c3BlY3QgdGhhdCB0aGlzIGlzIGFidXNlZCBpZiB5
b3UgcnVuIGRlcXAgY3RzIG9uIGFuZHJvaWQuLiBpZS4gYWxsCj4gPiA+IHdpbnN5cyBidWZmZXJz
IGFyZSBkbWEtYnVmIGltcG9ydHMgZnJvbSBncmFsbG9jLiAgQW5kIHRoZW4gd2hlbiB5b3UKPiA+
ID4gaGl0IHJlYWRwaXguLi4KPiA+ID4KPiA+ID4gWW91IG1pZ2h0IG9ubHkgaGl0IHRoaXMgaW4g
c2NlbmFyaW9zIHdpdGggc2VwYXJhdGUgZ3B1IGFuZCBkaXNwbGF5IChvcgo+ID4gPiBkR1BVK2lH
UFUpIGJlY2F1c2Ugc2VsZi1pbXBvcnRzIGFyZSBoYW5kbGVkIGRpZmZlcmVudGx5IGluCj4gPiA+
IGRybV9nZW1fcHJpbWVfaW1wb3J0X2RldigpLi4gYW5kIG1heWJlIG5vdCBpbiBjYXNlcyB3aGVy
ZSB5b3UgZW5kIHVwCj4gPiA+IHdpdGggYSBibGl0IGZyb20gdGlsZWQvY29tcHJlc3NlZCB0byBs
aW5lYXIuLiBtYXliZSB0aGF0IG5hcnJvd3MgdGhlCj4gPiA+IHNjb3BlIGVub3VnaCB0byBqdXN0
IGZpeCBpdCBpbiB1c2Vyc3BhY2U/Cj4gPgo+ID4gR2l2ZW4gdGhhdCB0aGF0IG9ubHkgZHJpdmVy
cyB3aGljaCB1c2UgRFJNLVNITUVNIHBvdGVudGlhbGx5IGNvdWxkJ3ZlCj4gPiBtYXAgaW1wb3J0
ZWQgZG1hLWJ1ZnMgKFBhbmZyb3N0LCBMaW1hKSBhbmQgdGhleSBhbHJlYWR5IGRvbid0IGFsbG93
IHRvCj4gPiBkbyB0aGF0LCBJIHRoaW5rIHdlJ3JlIGdvb2QuCj4KPiBTbyBjYW4gSSBoYXZlIGFu
IGFjayBmcm9tIFJvYiBoZXJlIG9yIGFyZSB0aGVyZSBzdGlsbCBxdWVzdGlvbnMgdGhhdCB0aGlz
Cj4gbWlnaHQgZ28gYm9vbT8KPgo+IERtaXRyeSwgc2luY2UgeW91IGhhdmUgYSBidW5jaCBvZiBw
YXRjaGVzIG1lcmdlZCBub3cgSSB0aGluayB3b3VsZCBhbHNvIGJlCj4gZ29vZCB0byBnZXQgY29t
bWl0IHJpZ2h0cyBzbyB5b3UgY2FuIGRyaXZlIHRoaXMgbW9yZSB5b3Vyc2VsZi4gSSd2ZSBhc2tl
ZAo+IERhbmllbCBTdG9uZSB0byBoZWxwIHlvdSBvdXQgd2l0aCBnZXR0aW5nIHRoYXQuCgpJICp0
aGluayogd2UnZCBiZSBvayB3aXRoIHRoaXMgb24gbXNtLCBtb3N0bHkganVzdCBieSBkdW1iIGx1
Y2suCkJlY2F1c2UgdGhlIGRtYS1idWYncyB3ZSBpbXBvcnQgd2lsbCBiZSBzZWxmLWltcG9ydC4g
IEknbSBsZXNzIHN1cmUKYWJvdXQgcGFuZnJvc3QgKHNyYy9wYW5mcm9zdC9saWIvcGFuX2JvLmMg
ZG9lc24ndCBzZWVtIHRvIGhhdmUgYQpzcGVjaWFsIHBhdGggZm9yIGltcG9ydGVkIGRtYS1idWZz
IGVpdGhlciwgYW5kIGluIHRoYXQgY2FzZSB0aGV5IHdvbid0CmJlIHNlbGYtaW1wb3J0cy4uIGJ1
dCBJIGd1ZXNzIG5vIG9uZSBoYXMgdHJpZWQgdG8gcnVuIGFuZHJvaWQgY3RzIG9uCnBhbmZyb3N0
KS4KCldoYXQgYWJvdXQgc29tZXRoaW5nIGxlc3MgZHJhc3RpYyB0byBzdGFydCwgbGlrZSAoYXBv
bG9naWVzIGZvcgpoYW5kLWVkaXRlZCBwYXRjaCk6CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKaW5kZXggODZkNjcwYzcx
Mjg2Li5mYzllYzQyZmEwYWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwpAQCAtMTAzNCw2ICsxMDM0LDEwIEBAIGlu
dCBkcm1fZ2VtX21tYXBfb2JqKHN0cnVjdCBkcm1fZ2VtX29iamVjdAoqb2JqLCB1bnNpZ25lZCBs
b25nIG9ial9zaXplLAogewogICAgICAgIGludCByZXQ7CgorICAgICAgIFdBUk5fT05fT05DRShv
YmotPmltcG9ydF9hdHRhY2gpOworCiAgICAgICAgLyogQ2hlY2sgZm9yIHZhbGlkIHNpemUuICov
CiAgICAgICAgaWYgKG9ial9zaXplIDwgdm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0KQogICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2dlbV9zaG1lbV9oZWxwZXIuYwpiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hl
bHBlci5jCmluZGV4IDhhZDBlMDI5OTFjYS4uNjE5MGY1MDE4OTg2IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2dlbV9zaG1lbV9oZWxwZXIuYwpAQCAtNjA5LDE3ICs2MDksOCBAQCBFWFBPUlRfU1lNQk9M
X0dQTChkcm1fZ2VtX3NobWVtX3ZtX29wcyk7CiAgKi8KIGludCBkcm1fZ2VtX3NobWVtX21tYXAo
c3RydWN0IGRybV9nZW1fc2htZW1fb2JqZWN0ICpzaG1lbSwgc3RydWN0CnZtX2FyZWFfc3RydWN0
ICp2bWEpCiB7Ci0gICAgICAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSAmc2htZW0tPmJh
c2U7CiAgICAgICAgaW50IHJldDsKCiAgICAgICAgaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgewot
ICAgICAgICAgICAgICAgLyogRHJvcCB0aGUgcmVmZXJlbmNlIGRybV9nZW1fbW1hcF9vYmooKSBh
Y3F1aXJlZC4qLwotICAgICAgICAgICAgICAgZHJtX2dlbV9vYmplY3RfcHV0KG9iaik7Ci0gICAg
ICAgICAgICAgICB2bWEtPnZtX3ByaXZhdGVfZGF0YSA9IE5VTEw7Ci0KLSAgICAgICAgICAgICAg
IHJldHVybiBkbWFfYnVmX21tYXAob2JqLT5kbWFfYnVmLCB2bWEsIDApOworICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7CiAgICAgICAgfQoKICAgICAgICByZXQgPSBkcm1fZ2VtX3NobWVt
X2dldF9wYWdlcyhzaG1lbSk7CiAgICAgICAgaWYgKHJldCkgewogICAgICAgICAgICAgICAgZHJt
X2dlbV92bV9jbG9zZSh2bWEpOwotLQoyLjM2LjEKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
