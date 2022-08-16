Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD737C25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 22:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E8060B61;
	Tue, 16 Aug 2022 22:18:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26E8060B61
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QjZzfuK0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UDykydW3jsf; Tue, 16 Aug 2022 22:18:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77E2E60B83;
	Tue, 16 Aug 2022 22:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77E2E60B83
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32482C0032;
	Tue, 16 Aug 2022 22:18:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D77ADC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1DC8827BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1DC8827BB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=QjZzfuK0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFu9p35laa3u
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E8D0827C5
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E8D0827C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:00 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id 10so5922313iou.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=YxrdumqftQLuRvBgXAJJEgX9wQwha5D/4zqqNT0e1YQ=;
 b=QjZzfuK0Zlo4t04FKNLTefuSQnZ9+HZ3DwKYubYesaUySBjgCRIAgpB2/k6doilgNW
 oimpktTtdI+MjpvnMmpb7SIKa+YtonjR64laPdMvNWrAMbFR4ytDX9RkmYr/HLSYCCsk
 a2W1iU1LUEIgBmycSKNu06se+qCb/ul7uYqJlhCjN74guTSwusnuWG5qd7yQKLam4pP9
 afIkc+HqaDzr2VGl8RaoTpPc8JyCt61BSk16Jtv/OsZ+q4ogwrc0ky1pY3PXk9p0usv0
 dNiNclJUS5QpdITT1zO279vbdx8nVMyRxP9TPda0l71ZeaqfQdSkVuZqvk4DZC++kVwl
 Ht4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=YxrdumqftQLuRvBgXAJJEgX9wQwha5D/4zqqNT0e1YQ=;
 b=wIGlHtnDaXcleLbX0LxEgu20zau2HE0lY5P638juNDWwMOGnEunrOFnA2pUm0uPCXH
 gG/EiRDLTCi5bj1uz7qwEx0nJlkzCmT4uS8iotdYizcUDjkfkDmTx8bRhYcooGsA6HAO
 XvyJuhsXgtJ9Sb8CYkGZF2+wMjqkO8KcTD91Gohgox/nKpOAkHQ2NFUHQwtBalrdzv3k
 utPlljnH4QFPthW8lNJ25//SXu+LMS3EdOtcZVxhI2P+OAr55yLW0llrVZfKLFUM6qDn
 Q7DXdpweQl/OO8mczmAbDpqo2kr4w1khjD1eoQ8v0ktP7eoN94IRbJNO5JwqR/yxCmKx
 mLwA==
X-Gm-Message-State: ACgBeo3e0G9Dmr+l0qo+cWhn5QEoBEgw5VI/VdgvLbrSyNbuyYKv775X
 yt9Qf2+jrUPCVPkoGIIAYt8aAD/IqfWuwx6EV44=
X-Google-Smtp-Source: AA6agR4pb56KxC9qGZLF8Hd47U5KQrzKaP5h2spSlahS8WFzewStJOWVSsWoWPfpCXdSLGYIvet+nPfW4JcViJyo+eI=
X-Received: by 2002:a05:6602:26c7:b0:67b:72ef:b87b with SMTP id
 g7-20020a05660226c700b0067b72efb87bmr9900643ioo.175.1660688279329; Tue, 16
 Aug 2022 15:17:59 -0700 (PDT)
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
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
In-Reply-To: <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 16 Aug 2022 15:18:31 -0700
Message-ID: <CAF6AEGs4oQ-E30Uha0-So0t7qoZ6mQg-0suLBfSqoGm+VnHiWw@mail.gmail.com>
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

T24gVHVlLCBBdWcgMTYsIDIwMjIgYXQgNDo0NSBBTSBEbWl0cnkgT3NpcGVua28KPGRtaXRyeS5v
c2lwZW5rb0Bjb2xsYWJvcmEuY29tPiB3cm90ZToKPgo+IE9uIDgvMTIvMjIgMTg6MDEsIFJvYiBD
bGFyayB3cm90ZToKPiA+IE9uIEZyaSwgQXVnIDEyLCAyMDIyIGF0IDc6NTcgQU0gUm9iIENsYXJr
IDxyb2JkY2xhcmtAZ21haWwuY29tPiB3cm90ZToKPiA+Pgo+ID4+IE9uIEZyaSwgQXVnIDEyLCAy
MDIyIGF0IDQ6MjYgQU0gRG1pdHJ5IE9zaXBlbmtvCj4gPj4gPGRtaXRyeS5vc2lwZW5rb0Bjb2xs
YWJvcmEuY29tPiB3cm90ZToKPiA+Pj4KPiA+Pj4gT24gOC8xMS8yMiAwMjoxOSwgUm9iIENsYXJr
IHdyb3RlOgo+ID4+Pj4gT24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgMzoyMyBQTSBEbWl0cnkgT3Np
cGVua28KPiA+Pj4+IDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPj4+
Pj4KPiA+Pj4+PiBPbiA4LzExLzIyIDAxOjAzLCBSb2IgQ2xhcmsgd3JvdGU6Cj4gPj4+Pj4+IE9u
IFdlZCwgQXVnIDEwLCAyMDIyIGF0IDEyOjI2IFBNIERtaXRyeSBPc2lwZW5rbwo+ID4+Pj4+PiA8
ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+
IE9uIDgvMTAvMjIgMTg6MDgsIFJvYiBDbGFyayB3cm90ZToKPiA+Pj4+Pj4+PiBPbiBXZWQsIEF1
ZyAxMCwgMjAyMiBhdCA0OjQ3IEFNIERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4gd3Jv
dGU6Cj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IE9uIFdlZCwgSnVsIDA2LCAyMDIyIGF0IDEwOjAy
OjA3QU0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+Pj4+Pj4+Pj4+IE9uIDcvNi8y
MiAwMDo0OCwgUm9iIENsYXJrIHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+IE9uIFR1ZSwgSnVsIDUsIDIw
MjIgYXQgNDo1MSBBTSBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
IHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiBBbSAwMS4wNy4yMiB1bSAxMTow
MiBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoKPiA+Pj4+Pj4+Pj4+Pj4+IERyaXZlcnMgdGhhdCB1
c2UgZHJtX2dlbV9tbWFwKCkgYW5kIGRybV9nZW1fbW1hcF9vYmooKSBoZWxwZXJzIGRvbid0Cj4g
Pj4+Pj4+Pj4+Pj4+PiBoYW5kbGUgaW1wb3J0ZWQgZG1hLWJ1ZnMgcHJvcGVybHksIHdoaWNoIHJl
c3VsdHMgaW4gbWFwcGluZyBvZiBzb21ldGhpbmcKPiA+Pj4+Pj4+Pj4+Pj4+IGVsc2UgdGhhbiB0
aGUgaW1wb3J0ZWQgZG1hLWJ1Zi4gT24gTlZJRElBIFRlZ3JhIHdlIGdldCBhIGhhcmQgbG9ja3Vw
IHdoZW4KPiA+Pj4+Pj4+Pj4+Pj4+IHVzZXJzcGFjZSB3cml0ZXMgdG8gdGhlIG1lbW9yeSBtYXBw
aW5nIG9mIGEgZG1hLWJ1ZiB0aGF0IHdhcyBpbXBvcnRlZCBpbnRvCj4gPj4+Pj4+Pj4+Pj4+PiBU
ZWdyYSdzIERSTSBHRU0uCj4gPj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4gTWFqb3JpdHkg
b2YgRFJNIGRyaXZlcnMgcHJvaGliaXQgbWFwcGluZyBvZiB0aGUgaW1wb3J0ZWQgR0VNIG9iamVj
dHMuCj4gPj4+Pj4+Pj4+Pj4+PiBNYXBwaW5nIG9mIGltcG9ydGVkIEdFTXMgcmVxdWlyZSBzcGVj
aWFsIGNhcmUgZnJvbSB1c2Vyc3BhY2Ugc2luY2UgaXQKPiA+Pj4+Pj4+Pj4+Pj4+IHNob3VsZCBz
eW5jIGRtYS1idWYgYmVjYXVzZSBtYXBwaW5nIGNvaGVyZW5jeSBvZiB0aGUgZXhwb3J0ZXIgZGV2
aWNlIG1heQo+ID4+Pj4+Pj4+Pj4+Pj4gbm90IG1hdGNoIHRoZSBEUk0gZGV2aWNlLiBMZXQncyBw
cm9oaWJpdCB0aGUgbWFwcGluZyBmb3IgYWxsIERSTSBkcml2ZXJzCj4gPj4+Pj4+Pj4+Pj4+PiBm
b3IgY29uc2lzdGVuY3kuCj4gPj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4gU3VnZ2VzdGVk
LWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+
Cj4gPj4+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5v
c2lwZW5rb0Bjb2xsYWJvcmEuY29tPgo+ID4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiBJJ20g
cHJldHR5IHN1cmUgdGhhdCB0aGlzIGlzIHRoZSByaWdodCBhcHByb2FjaCwgYnV0IGl0J3MgY2Vy
dGFpbmx5IG1vcmUKPiA+Pj4+Pj4+Pj4+Pj4gdGhhbiBwb3NzaWJsZSB0aGF0IHNvbWVib2R5IGFi
dXNlZCB0aGlzIGFscmVhZHkuCj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+PiBJIHN1c3BlY3Qg
dGhhdCB0aGlzIGlzIGFidXNlZCBpZiB5b3UgcnVuIGRlcXAgY3RzIG9uIGFuZHJvaWQuLiBpZS4g
YWxsCj4gPj4+Pj4+Pj4+Pj4gd2luc3lzIGJ1ZmZlcnMgYXJlIGRtYS1idWYgaW1wb3J0cyBmcm9t
IGdyYWxsb2MuICBBbmQgdGhlbiB3aGVuIHlvdQo+ID4+Pj4+Pj4+Pj4+IGhpdCByZWFkcGl4Li4u
Cj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+PiBZb3UgbWlnaHQgb25seSBoaXQgdGhpcyBpbiBz
Y2VuYXJpb3Mgd2l0aCBzZXBhcmF0ZSBncHUgYW5kIGRpc3BsYXkgKG9yCj4gPj4+Pj4+Pj4+Pj4g
ZEdQVStpR1BVKSBiZWNhdXNlIHNlbGYtaW1wb3J0cyBhcmUgaGFuZGxlZCBkaWZmZXJlbnRseSBp
bgo+ID4+Pj4+Pj4+Pj4+IGRybV9nZW1fcHJpbWVfaW1wb3J0X2RldigpLi4gYW5kIG1heWJlIG5v
dCBpbiBjYXNlcyB3aGVyZSB5b3UgZW5kIHVwCj4gPj4+Pj4+Pj4+Pj4gd2l0aCBhIGJsaXQgZnJv
bSB0aWxlZC9jb21wcmVzc2VkIHRvIGxpbmVhci4uIG1heWJlIHRoYXQgbmFycm93cyB0aGUKPiA+
Pj4+Pj4+Pj4+PiBzY29wZSBlbm91Z2ggdG8ganVzdCBmaXggaXQgaW4gdXNlcnNwYWNlPwo+ID4+
Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IEdpdmVuIHRoYXQgdGhhdCBvbmx5IGRyaXZlcnMgd2hpY2gg
dXNlIERSTS1TSE1FTSBwb3RlbnRpYWxseSBjb3VsZCd2ZQo+ID4+Pj4+Pj4+Pj4gbWFwIGltcG9y
dGVkIGRtYS1idWZzIChQYW5mcm9zdCwgTGltYSkgYW5kIHRoZXkgYWxyZWFkeSBkb24ndCBhbGxv
dyB0bwo+ID4+Pj4+Pj4+Pj4gZG8gdGhhdCwgSSB0aGluayB3ZSdyZSBnb29kLgo+ID4+Pj4+Pj4+
Pgo+ID4+Pj4+Pj4+PiBTbyBjYW4gSSBoYXZlIGFuIGFjayBmcm9tIFJvYiBoZXJlIG9yIGFyZSB0
aGVyZSBzdGlsbCBxdWVzdGlvbnMgdGhhdCB0aGlzCj4gPj4+Pj4+Pj4+IG1pZ2h0IGdvIGJvb20/
Cj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IERtaXRyeSwgc2luY2UgeW91IGhhdmUgYSBidW5jaCBv
ZiBwYXRjaGVzIG1lcmdlZCBub3cgSSB0aGluayB3b3VsZCBhbHNvIGJlCj4gPj4+Pj4+Pj4+IGdv
b2QgdG8gZ2V0IGNvbW1pdCByaWdodHMgc28geW91IGNhbiBkcml2ZSB0aGlzIG1vcmUgeW91cnNl
bGYuIEkndmUgYXNrZWQKPiA+Pj4+Pj4+Pj4gRGFuaWVsIFN0b25lIHRvIGhlbHAgeW91IG91dCB3
aXRoIGdldHRpbmcgdGhhdC4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+IEkgKnRoaW5rKiB3ZSdkIGJl
IG9rIHdpdGggdGhpcyBvbiBtc20sIG1vc3RseSBqdXN0IGJ5IGR1bWIgbHVjay4KPiA+Pj4+Pj4+
PiBCZWNhdXNlIHRoZSBkbWEtYnVmJ3Mgd2UgaW1wb3J0IHdpbGwgYmUgc2VsZi1pbXBvcnQuICBJ
J20gbGVzcyBzdXJlCj4gPj4+Pj4+Pj4gYWJvdXQgcGFuZnJvc3QgKHNyYy9wYW5mcm9zdC9saWIv
cGFuX2JvLmMgZG9lc24ndCBzZWVtIHRvIGhhdmUgYQo+ID4+Pj4+Pj4+IHNwZWNpYWwgcGF0aCBm
b3IgaW1wb3J0ZWQgZG1hLWJ1ZnMgZWl0aGVyLCBhbmQgaW4gdGhhdCBjYXNlIHRoZXkgd29uJ3QK
PiA+Pj4+Pj4+PiBiZSBzZWxmLWltcG9ydHMuLiBidXQgSSBndWVzcyBubyBvbmUgaGFzIHRyaWVk
IHRvIHJ1biBhbmRyb2lkIGN0cyBvbgo+ID4+Pj4+Pj4+IHBhbmZyb3N0KS4KPiA+Pj4+Pj4+Cj4g
Pj4+Pj4+PiBUaGUgbGFzdCB0aW1lIEkgdHJpZWQgdG8gbW1hcCBkbWEtYnVmIGltcG9ydGVkIHRv
IFBhbmZyb3N0IGRpZG4ndCB3b3JrCj4gPj4+Pj4+PiBiZWNhdXNlIFBhbmZyb3N0IGRpZG4ndCBp
bXBsZW1lbnQgc29tZXRoaW5nIG5lZWRlZCBmb3IgdGhhdC4gSSdsbCBuZWVkCj4gPj4+Pj4+PiB0
byB0YWtlIGEgbG9vayBhZ2FpbiBiZWNhdXNlIGNhbid0IHJlY2FsbCB3aGF0IGl0IHdhcy4KPiA+
Pj4gVXBkOiBJIHJlLWNoZWNrZWQgUGFuZnJvc3QgdXNpbmcgdG9kYXkncyBsaW51eC1uZXh0IGFu
ZCBtYXBwaW5nIG9mCj4gPj4+IGltcG9ydGVkIGRtYS1idWYgd29ya3MsIEkgbWFwcGVkIGltcG9y
dGVkIGJ1ZiBmcm9tIHZpZGVvIGRlY29kZXIuCj4gPj4+IEFwcGFyZW50bHkgcHJldmlvdXNseSBJ
IGhhZCBzb21lIGxvY2FsIGtlcm5lbCBjaGFuZ2UgdGhhdCBicm9rZSB0aGUgbWFwcGluZy4KPiA+
Pj4KPiA+Pj4+Pj4+PiBXaGF0IGFib3V0IHNvbWV0aGluZyBsZXNzIGRyYXN0aWMgdG8gc3RhcnQs
IGxpa2UgKGFwb2xvZ2llcyBmb3IKPiA+Pj4+Pj4+PiBoYW5kLWVkaXRlZCBwYXRjaCk6Cj4gPj4+
Pj4+Pj4KPiA+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiA+Pj4+Pj4+PiBpbmRleCA4NmQ2NzBjNzEyODYu
LmZjOWVjNDJmYTBhYiAxMDA2NDQKPiA+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJt
X2dlbS5jCj4gPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+ID4+Pj4+
Pj4+IEBAIC0xMDM0LDYgKzEwMzQsMTAgQEAgaW50IGRybV9nZW1fbW1hcF9vYmooc3RydWN0IGRy
bV9nZW1fb2JqZWN0Cj4gPj4+Pj4+Pj4gKm9iaiwgdW5zaWduZWQgbG9uZyBvYmpfc2l6ZSwKPiA+
Pj4+Pj4+PiAgewo+ID4+Pj4+Pj4+ICAgICAgICAgaW50IHJldDsKPiA+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+ICsgICAgICAgV0FSTl9PTl9PTkNFKG9iai0+aW1wb3J0X2F0dGFjaCk7Cj4gPj4+Pj4+Pgo+
ID4+Pj4+Pj4gVGhpcyB3aWxsIGhhbmcgTlZJRElBIFRlZ3JhLCB3aGljaCBpcyB3aGF0IHRoaXMg
cGF0Y2ggZml4ZWQgaW5pdGlhbGx5Lgo+ID4+Pj4+Pj4gSWYgbmVpdGhlciBvZiB1cHN0cmVhbSBE
Uk0gZHJpdmVycyBuZWVkIHRvIG1hcCBpbXBvcnRlZCBkbWEtYnVmcyBhbmQKPiA+Pj4+Pj4+IG5l
dmVyIG5lZWRlZCwgdGhlbiB3aHkgZG8gd2UgbmVlZCB0aGlzPwo+ID4+Pj4+Pgo+ID4+Pj4+PiBv
aCwgdGVncmEgaXNuJ3QgdXNpbmcgc2htZW0gaGVscGVycz8gIEkgYXNzdW1lZCBpdCB3YXMuICBX
ZWxsIG15IHBvaW50Cj4gPj4+Pj4+IHdhcyB0byBtYWtlIGEgbW9yZSB0YXJnZXRlZCBmYWlsIG9u
IHRlZ3JhLCBhbmQgYSBXQVJOX09OIGZvciBldmVyeW9uZQo+ID4+Pj4+PiBlbHNlIHRvIG1ha2Ug
aXQgY2xlYXIgdGhhdCB3aGF0IHRoZXkgYXJlIGRvaW5nIGlzIHVuZGVmaW5lZCBiZWhhdmlvci4K
PiA+Pj4+Pj4gQmVjYXVzZSBzbyBmYXIgZXhpc3RpbmcgdXNlcnNwYWNlIChvciB3ZWxsLCBwYW5m
cm9zdCBhbmQgZnJlZWRyZW5vIGF0Cj4gPj4+Pj4+IGxlYXN0LCB0aG9zZSBhcmUgdGhlIHR3byBJ
IGtub3cgb3IgY2hlY2tlZCkgZG9uJ3QgbWFrZSBzcGVjaWFsIGNhc2VzCj4gPj4+Pj4+IGZvciBt
bWFwJ2luZyBhZ2FpbnN0IHRoZSBkbWFidWYgZmQgYWdhaW5zdCB0aGUgZG1hYnVmIGZkIGluc3Rl
YWQgb2YKPiA+Pj4+Pj4gdGhlIGRybSBkZXZpY2UgZmQuCj4gPj4+Pj4KPiA+Pj4+PiBJdCdzIG5v
dCBjbGVhciB0byBtZSB3aGF0IGJhZCBBbmRyb2lkIGRvZXMgZm9ybSB5b3VycyBjb21tZW50cy4g
RG9lcyBpdAo+ID4+Pj4+IGV4cG9ydCBkbWEtYnVmIGZyb20gR1BVIGFuZCB0aGVuIGltcG9ydCBp
dCB0byBHUFU/IElmIHllcywgdGhlbiBEUk0gY29yZQo+ID4+Pj4+IGhhcyBhIGNoZWNrIGZvciB0
aGUgc2VsZi1pbXBvcnRpbmcgWzFdLgo+ID4+Pj4+Cj4gPj4+Pj4gWzFdCj4gPj4+Pj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX3ByaW1lLmMjTDkxOAo+ID4+Pj4+Cj4gPj4+Pj4gSWYgeW91J3JlIG1lYW5pbmcgc29tZXRo
aW5nIGVsc2UsIHRoZW4gcGxlYXNlIGV4cGxhaW4gaW4gYSBtb3JlIGRldGFpbHMuCj4gPj4+Pgo+
ID4+Pj4gU28sIGFuZHJvaWQvZ3JhbGxvYyBhbGxvY2F0ZXMgYnVmZmVycyBleHRlcm5hbGx5IHRv
IHRoZSBkcml2ZXIgYW5kCj4gPj4+PiBpbXBvcnRzIHRoZW0gaW50byBkcml2ZXIuICAoQW5kIHRo
YXQgc2VlbXMgdG8gbm90IGp1c3QgYmUgd2luZG93Cj4gPj4+PiBzdXJmYWNlcywgYnV0IGluIGNh
c2VzIHJhbmRvbSB0ZXh0dXJlcywgZXRjKQo+ID4+Pj4KPiA+Pj4+IEluIHRoZSBub3JtYWwgY2Fz
ZSB0aGVzZSBzaG91bGQgYmUgYWxsb2NhdGVkIGZyb20gZHJtL21zbSBzbyBpdCBzaG91bGQKPiA+
Pj4+IGhpdCBbMV0uLiB0aGlzIGlzIHRoZSAiZHVtYiBsdWNrIiBJIG1lbnRpb25lZCBlYXJsaWVy
LiAgQnV0IEknbSBub3QKPiA+Pj4+IGNvbmZpZGVudCBlbm91Z2ggdG8gc2F5IHRoYXQgdGhlcmUg
aXMgbm8gb3RoZXIgY2FzZS4KPiA+Pj4+Cj4gPj4+Pj4KPiA+Pj4+Pj4gSSAqdGhpbmsqIGl0IHNo
b3VsZCB3b3JrIG91dCB0aGF0IHdlIGRvbid0IGhpdCB0aGlzIHBhdGggd2l0aAo+ID4+Pj4+PiBm
cmVlZHJlbm8gYnV0IG9uIGFuZHJvaWQgSSBjYW4ndCByZWFsbHkgZ3VhcmFudGVlIG9yIHByb3Zl
IGl0LiAgU28KPiA+Pj4+Pj4geW91ciBwYXRjaCB3b3VsZCBwb3RlbnRpYWxseSBicmVhayBleGlz
dGluZyB3b3JraW5nIHVzZXJzcGFjZS4gIE1heWJlCj4gPj4+Pj4+IGl0IGlzIHVzZXJzcGFjZSB0
aGF0IGlzbid0IHBvcnRhYmxlIChidXQgT1RPSCBpdCBpc24ndCBsaWtlIHlvdSBhcmUKPiA+Pj4+
Pj4gZ29pbmcgdG8gYmUgdXNpbmcgZnJlZWRyZW5vIG9uIHRlZ3JhKS4gIFNvIHdoeSBkb24ndCB5
b3UgZ28gZm9yIGEgbW9yZQo+ID4+Pj4+PiB0YXJnZXRlZCBmaXggdGhhdCBvbmx5IHJldHVybnMg
YW4gZXJyb3Igb24gaHcgd2hlcmUgdGhpcyBpcwo+ID4+Pj4+PiBwcm9ibGVtYXRpYz8KPiA+Pj4+
Pgo+ID4+Pj4+IFRoYXQncyB3aGF0IHRoZSBmaXJzdCB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2ggZGlk
IGFuZCBDaHJpc3RpYW4gc3VnZ2VzdGVkCj4gPj4+Pj4gdGhhdCBpdCdzIG5vdCBhIGdvb2QgYXBw
cm9hY2guIEluIGZhY3QgaXQgc2hvdWxkIGJlIG5vdCBvbmx5IFRlZ3JhIHRoYXQKPiA+Pj4+PiBo
YXMgYSBicm9rZW4gZG1hLWJ1ZiBtYXBwaW5nLCBidXQgYXBwYXJlbnRseSBPTUFQIGRyaXZlciB0
b28uCj4gPj4+Pgo+ID4+Pj4gSG1tLCBJIGd1ZXNzIEknbSBhIGJpdCBtb3JlIGNvbnNlcnZhdGl2
ZSB3aGVuIGl0IGNvbWVzIHRvIHBvdGVudGlhbGx5Cj4gPj4+PiBicmVha2luZyB1c2Vyc3BhY2Uu
Cj4gPj4+Cj4gPj4+IElmIHN1Y2ggdXNlcnNwYWNlIGV4aXN0cywgdGhlbiBvZiBjb3Vyc2UgdGhl
IG1hcHBpbmcgc2hvdWxkIGNvbnRpbnVlIHRvCj4gPj4+IHdvcmsuIFN0aWxsIHdpbGwgYmUgZ3Jl
YXQgdG8ga25vdyB3aGF0IHRoYXQgdXNlcnBzYWNlIGlzLgo+ID4+Cj4gPj4gRGVmaW5pdGVseSBl
eGlzdGluZyBtZXNhIGRvZXMgbm90IGhhdmUgYSBzcGVjaWFsIG1tYXAgcGF0aCBmb3IKPiA+PiBp
bXBvcnRlZCBkbWEtYnVmcyAoYm90aCBpbiB0aGUgY2FzZSBvZiBwYW5mcm9zdCBhbmQgZnJlZWRy
ZW5vLCBJCj4gPj4gZGlkbid0IGNoZWNrIGFueSBvdGhlcnMpLiAgVGhlIG9ubHkgcXVlc3Rpb24g
aXMgd2hldGhlciB0aGVyZSBpcyBhCj4gPj4gY2FzZSB3aGVyZSBzb21lIGFwcC90ZXN0L2V0YyBp
bXBvcnRzIGEgZm9yZWlnbiBkbWEtYnVmIGZkIGFuZCB0aGVuCj4gPj4gZG9lcyBzb21ldGhpbmcg
dGhhdCB3b3VsZCB0cmlnZ2VyIG1tYXAnaW5nLCBsaWtlIHJlYWRwaXguCj4gPgo+ID4gVGhlIG90
aGVyIGNvbXBsaWNhdGlvbiBJIG5vdGljZWQgaXMgdGhhdCB3ZSBkb24ndCBzZWVtIHRvIGtlZXAg
YXJvdW5kCj4gPiB0aGUgZmQgYWZ0ZXIgaW1wb3J0aW5nIHRvIGEgR0VNIGhhbmRsZS4gIEFuZCBJ
IGNvdWxkIGltYWdpbmUgdGhhdAo+ID4gZG9pbmcgc28gY291bGQgY2F1c2UgaXNzdWVzIHdpdGgg
dG9vIG1hbnkgZmQncy4gIFNvIEkgZ3Vlc3MgdGhlIGJlc3QKPiA+IHRoaW5nIGlzIHRvIGtlZXAg
dGhlIHN0YXR1cyBxdW8gYW5kIGxldCBkcml2ZXJzIHRoYXQgY2Fubm90IG1tYXAKPiA+IGltcG9y
dGVkIGJ1ZmZlcnMganVzdCBmYWlsIG1tYXA/Cj4KPiBUaGF0IGFjdHVhbGx5IHNob3VsZCBiZSBh
bGwgdGhlIGRyaXZlcnMgZXhjbHVkaW5nIHRob3NlIHRoYXQgdXNlCj4gRFJNLVNITUVNIGJlY2F1
c2Ugb25seSBEUk0tU0hNRU0gdXNlcyBkbWFfYnVmX21tYXAoKSwgdGhhdCdzIHdoeSBpdAo+IHdv
cmtzIGZvciBQYW5mcm9zdC4gSSdtIHByZXR0eSBzdXJlIG1tYXBpbmcgb2YgaW1wb3J0ZWQgR0VN
cyBkb2Vzbid0Cj4gd29yayBmb3IgdGhlIE1TTSBkcml2ZXIsIGlzbid0IGl0PwoKSG1tLCBJIHdv
dWxkIGhhdmUgZXhwZWN0ZWQgaXQgdG8gd29yaywgYXQgbGVhc3QgcHJpb3IgdG8gdGhlIG1hbmds
aW5nCmRlYnVnIHRoaW5nIGRhbnZldCBhZGRlZC4KCkFjdHVhbGx5LCBJIHN1c3BlY3Qgd2l0aCB0
aGUgbWFuZ2xpbmcgZW5hYmxlZCwgYWxsIHNvcnRzIG9mIHRoaW5ncwp3b3VsZCBmYWxsIGFwYXJ0
LCBJJ20gbm90IHNlZWluZyBob3cgdGhpbmdzIGxpa2Ugc2dfcGh5cygpIGNvbnRpbnVlIHRvCndv
cmsuICBCdXQgbm90IHN1cmUgaWYgd2UgaGF2ZSB0aGF0IGVuYWJsZWQgaW4gYW55dGhpbmcgdGhh
dCBpcwpnZXR0aW5nIGFuZHJvaWQgQ1RTIHJ1biBvbiBpdC4KCkJSLAotUgoKPiBJbnRlbCBhbmQg
QU1EIGRyaXZlcnMgZG9uJ3QgYWxsb3cgdG8gbWFwIHRoZSBpbXBvcnRlZCBkbWEtYnVmcy4gQm90
aAo+IHJlZnVzZSB0byBkbyB0aGUgbWFwcGluZy4KPgo+IEFsdGhvdWdoLCBBTURHUFUgInN1Y2Nl
ZWRzIiB0byBkbyB0aGUgbWFwcGluZyB1c2luZwo+IEFNREdQVV9HRU1fRE9NQUlOX0dUVCwgYnV0
IHRoZW4gdG91Y2hpbmcgdGhlIG1hcHBpbmcgY2F1c2VzIGJ1cyBmYXVsdCwKPiBoZW5jZSBtYXBw
aW5nIGFjdHVhbGx5IGZhaWxzLiBJIHRoaW5rIGl0IG1pZ2h0IGJlIHRoZSBBTURHUFUKPiBkcml2
ZXIvbGliZHJtIGJ1ZywgaGF2ZW4ndCBjaGVja2VkIHlldC4KPgo+IFNvIHdlJ3JlIGJhY2sgdG8g
dGhlIHBvaW50IHRoYXQgbmVpdGhlciBvZiBEUk0gZHJpdmVycyBuZWVkIHRvIG1hcAo+IGltcG9y
dGVkIGRtYS1idWZzIGFuZCB0aGlzIHdhcyBuZXZlciB0ZXN0ZWQuIEluIHRoaXMgY2FzZSB0aGlz
IHBhdGNoIGlzCj4gdmFsaWQsIElNTy4KPgo+IC0tCj4gQmVzdCByZWdhcmRzLAo+IERtaXRyeQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
