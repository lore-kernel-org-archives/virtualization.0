Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE0C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 14:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F92B416E4;
	Wed, 24 Aug 2022 14:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F92B416E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=k433WZpJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUtMrkWK4DMm; Wed, 24 Aug 2022 14:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53070416DE;
	Wed, 24 Aug 2022 14:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53070416DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03D89C0032;
	Wed, 24 Aug 2022 14:15:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50748C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DD9A60F9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:15:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DD9A60F9D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=k433WZpJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mclXg8gVZIwF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:15:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6028960E2C
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6028960E2C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:15:05 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id ca13so22532787ejb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=3RY0kXIvgqIVojhkrE4Zwlr7wJlH94oU+XFloUi3XjI=;
 b=k433WZpJORtGGgjLBRUCWg89Ct3eMmhhzzPwfTl6//mc8KZmXsfUkvjXK2CPv2G6j9
 FW4/JFsVFe8WZ8qXfiG0G2WUSXJhVho/22M2ZvYonWllG8JjwTj6MhS+/biMgV4nO5Zr
 llPWeve491++YksKYHfxR6w08hbYD3Jv+FtIHtqkeqoTfLN6sUfa2AlD62I2SrAPThJb
 x/pSysLoKr056pSqqIrDP4Zf5umrg7az72DW3OYvoPJOZdkczmoNmarSqM1+dim8Vhiv
 BxZj98y4ZeYDVEzsmdne2xhUZzSQUjC7gSpIH2W4w1Iq4MHPRdAGpb04pB6x8cp2I0OU
 nIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=3RY0kXIvgqIVojhkrE4Zwlr7wJlH94oU+XFloUi3XjI=;
 b=zwAVj+aSbDjVE8BOuTechZogDUJvvN0SYLtwAWf2u7wOPYBQADLFAmxpHiGRNf+Uoc
 kUSemeRGSyUHdVIhbynIQP2fDNPh6i5+HZtZYoday/H5pV5Sn2ENOMMJEUoECLYNLInp
 ZfrgB19r0XKK0KZwdfKKCaoNIdb7S6HwE2nz1QTgE9GMqR6DwpUouy0bcJ3mfzTgGTPe
 9YU6vqy55+adHoB/Gkfvx3TGenJK5eYNHDtlwUjLIEqCOM7+bhF//F823fp5B1q8P36y
 yvC8Hey0MrBjS2ZNXj5xCF4npVkWafDJqWbJauUdgFz6sg3iltPxAbkkOMPF7xUkB4r4
 xrwQ==
X-Gm-Message-State: ACgBeo1mPtE12sBB0Jus2ni1m7J8rEel0E99hkswZIlrSmwBwMtoHnLj
 hzYDKy7rKLLvCZOVkdyGmJ8=
X-Google-Smtp-Source: AA6agR5vl7eAC3d146n4WFT7uLsC77WQL4B00T85StELI9JlyPgaC5TszQICKao2kaYSaa7iVSFw9A==
X-Received: by 2002:a17:907:7256:b0:73d:9c6b:35e2 with SMTP id
 ds22-20020a170907725600b0073d9c6b35e2mr2992627ejc.197.1661350503452; 
 Wed, 24 Aug 2022 07:15:03 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:62ca:57d9:b533:6057?
 ([2a02:908:1256:79a0:62ca:57d9:b533:6057])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a056402051a00b004464c3de6dasm3147684edv.65.2022.08.24.07.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Aug 2022 07:15:02 -0700 (PDT)
Message-ID: <79cf9887-64ad-9cfd-035a-4b6e41b864e0@gmail.com>
Date: Wed, 24 Aug 2022 16:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/9] Move all drivers to a common dma-buf locking
 convention
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Thierry Reding
 <thierry.reding@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Qiang Yu <yuq825@gmail.com>
References: <20220824102248.91964-1-dmitry.osipenko@collabora.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220824102248.91964-1-dmitry.osipenko@collabora.com>
Cc: lima@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, linux-media@vger.kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
dG8gcGF0Y2hlcyAjMi0jNAoKQW0gMjQuMDguMjIgdW0gMTI6MjIgc2NocmllYiBEbWl0cnkgT3Np
cGVua286Cj4gSGVsbG8sCj4KPiBUaGlzIHNlcmllcyBtb3ZlcyBhbGwgZHJpdmVycyB0byBhIGR5
bmFtaWMgZG1hLWJ1ZiBsb2NraW5nIHNwZWNpZmljYXRpb24uCj4gIEZyb20gbm93IG9uIGFsbCBk
bWEtYnVmIGltcG9ydGVycyBhcmUgbWFkZSByZXNwb25zaWJsZSBmb3IgaG9sZGluZwo+IGRtYS1i
dWYncyByZXNlcnZhdGlvbiBsb2NrIGFyb3VuZCBhbGwgb3BlcmF0aW9ucyBwZXJmb3JtZWQgb3Zl
ciBkbWEtYnVmcwo+IGluIGFjY29yZGFuY2UgdG8gdGhlIGxvY2tpbmcgc3BlY2lmaWNhdGlvbi4g
VGhpcyBhbGxvd3MgdXMgdG8gdXRpbGl6ZQo+IHJlc2VydmF0aW9uIGxvY2sgbW9yZSBicm9hZGx5
IGFyb3VuZCBrZXJuZWwgd2l0aG91dCBmZWFyaW5nIG9mIGEgcG90ZW50aWFsCj4gZGVhZGxvY2tz
Lgo+Cj4gVGhpcyBwYXRjaHNldCBwYXNzZXMgYWxsIGk5MTUgc2VsZnRlc3RzLiBJdCB3YXMgYWxz
byB0ZXN0ZWQgdXNpbmcgVmlydElPLAo+IFBhbmZyb3N0LCBMaW1hLCBUZWdyYSwgdWRtYWJ1Ziwg
QU1ER1BVIGFuZCBOb3V2ZWF1IGRyaXZlcnMuIEkgdGVzdGVkIGNhc2VzCj4gb2YgZGlzcGxheStH
UFUsIGRpc3BsYXkrVjRMIGFuZCBHUFUrVjRMIGRtYS1idWYgc2hhcmluZyAod2hlcmUgYXBwcm9w
cmlhdGUpLAo+IHdoaWNoIGNvdmVycyBtYWpvcml0eSBvZiBrZXJuZWwgZHJpdmVycyBzaW5jZSBy
ZXN0IG9mIHRoZSBkcml2ZXJzIHNoYXJlCj4gc2FtZSBvciBzaW1pbGFyIGNvZGUgcGF0aHMuCj4K
PiBDaGFuZ2Vsb2c6Cj4KPiB2MzogLSBGYWN0b3JlZCBvdXQgZG1hX2J1Zl9tbWFwX3VubG9ja2Vk
KCkgYW5kIGF0dGFjaG1lbnQgZnVuY3Rpb25zCj4gICAgICAgIGludG8gYXNlcGFyYXRlIHBhdGNo
ZXMsIGxpa2Ugd2FzIHN1Z2dlc3RlZCBieSBDaHJpc3RpYW4gS8O2bmlnLgo+Cj4gICAgICAtIENv
cnJlY3RlZCBhbmQgZmFjdG9yZWQgb3V0IGRtYS1idWYgbG9ja2luZyBkb2N1bWVudGF0aW9uIGlu
dG8KPiAgICAgICAgYSBzZXBhcmF0ZSBwYXRjaCwgbGlrZSB3YXMgc3VnZ2VzdGVkIGJ5IENocmlz
dGlhbiBLw7ZuaWcuCj4KPiAgICAgIC0gSW50ZWwgZHJpdmVyIGRyb3BwZWQgdGhlIHJlc2VydmF0
aW9uIGxvY2tpbmcgZmV3cyBkYXlzIGFnbyBmcm9tCj4gICAgICAgIGl0cyBCTy1yZWxlYXNlIGNv
ZGUgcGF0aCwgYnV0IHdlIG5lZWQgdGhhdCBsb2NraW5nIGZvciB0aGUgaW1wb3J0ZWQKPiAgICAg
ICAgR0VNcyBiZWNhdXNlIGluIHRoZSBlbmQgdGhhdCBjb2RlIHBhdGggdW5tYXBzIHRoZSBpbXBv
cnRlZCBHRU0uCj4gICAgICAgIFNvIEkgYWRkZWQgYmFjayB0aGUgbG9ja2luZyBuZWVkZWQgYnkg
dGhlIGltcG9ydGVkIEdFTXMsIHVwZGF0aW5nCj4gICAgICAgIHRoZSAiZG1hLWJ1ZiBhdHRhY2ht
ZW50IGxvY2tpbmcgc3BlY2lmaWNhdGlvbiIgcGF0Y2ggYXBwcm9wcmlhdGVseS4KPgo+ICAgICAg
LSBUZXN0ZWQgTm91dmVhdStJbnRlbCBkbWEtYnVmIGltcG9ydC9leHBvcnQgY29tYm8uCj4KPiAg
ICAgIC0gVGVzdGVkIHVkbWFidWYgaW1wb3J0IHRvIGk5MTUvTm91dmVhdS9BTURHUFUuCj4KPiAg
ICAgIC0gRml4ZWQgZmV3IHBsYWNlcyBpbiBFdG5hdml2LCBQYW5mcm9zdCBhbmQgTGltYSBkcml2
ZXJzIHRoYXQgSSBtaXNzZWQKPiAgICAgICAgdG8gc3dpdGNoIHRvIGxvY2tlZCBkbWEtYnVmIHZt
YXBwaW5nIGluIHRoZSBkcm0vZ2VtOiBUYWtlIHJlc2VydmF0aW9uCj4gICAgICAgIGxvY2sgZm9y
IHZtYXAvdnVubWFwIG9wZXJhdGlvbnMiIHBhdGNoLiBJbiBhIHJlc3VsdCBpbnZhbGlkYXRlZCB0
aGUKPiAgICAgICAgQ2hyaXN0aWFuJ3Mgci1iIHRoYXQgaGUgZ2F2ZSB0byB2Mi4KPgo+ICAgICAg
LSBBZGRlZCBsb2NrZWQgZG1hLWJ1ZiB2bWFwL3Z1bm1hcCBmdW5jdGlvbnMgdGhhdCBhcmUgbmVl
ZGVkIGZvciBmaXhpbmcKPiAgICAgICAgdm1hcHBwaW5nIG9mIEV0bmF2aXYsIFBhbmZyb3N0IGFu
ZCBMaW1hIGRyaXZlcnMgbWVudGlvbmVkIGFib3ZlLgo+ICAgICAgICBJIGFjdHVhbGx5IGhhZCB0
aGlzIGNoYW5nZSBzdGFzaGVkIGZvciB0aGUgZHJtLXNobWVtIHNocmlua2VyIHBhdGNoc2V0LAo+
ICAgICAgICBidXQgdGhlbiByZWFsaXplZCB0aGF0IGl0J3MgYWxyZWFkeSBuZWVkZWQgYnkgdGhl
IGRtYS1idWYgcGF0Y2hlcy4KPiAgICAgICAgQWxzbyBpbXByb3ZlZCBteSB0ZXN0cyB0byBiZXR0
ZXIgY292ZXIgdGhlc2UgY29kZSBwYXRocy4KPgo+IHYyOiAtIENoYW5nZWQgbG9ja2luZyBzcGVj
aWZpY2F0aW9uIHRvIGF2b2lkIHByb2JsZW1zIHdpdGggYSBjcm9zcy1kcml2ZXIKPiAgICAgICAg
d3cgbG9ja2luZywgbGlrZSB3YXMgc3VnZ2VzdGVkIGJ5IENocmlzdGlhbiBLw7ZuaWcuIE5vdyB0
aGUgYXR0YWNoL2RldGFjaAo+ICAgICAgICBjYWxsYmFja3MgYXJlIGludm9rZWQgd2l0aG91dCB0
aGUgaGVsZCBsb2NrIGFuZCBleHBvcnRlciBzaG91bGQgdGFrZSB0aGUKPiAgICAgICAgbG9jay4K
Pgo+ICAgICAgLSBBZGRlZCAibG9ja2luZyBjb252ZW50aW9uIiBkb2N1bWVudGF0aW9uIHRoYXQg
ZXhwbGFpbnMgd2hpY2ggZG1hLWJ1Zgo+ICAgICAgICBmdW5jdGlvbnMgYW5kIGNhbGxiYWNrcyBh
cmUgbG9ja2VkL3VubG9ja2VkIGZvciBpbXBvcnRlcnMgYW5kIGV4cG9ydGVycywKPiAgICAgICAg
d2hpY2ggd2FzIHJlcXVlc3RlZCBieSBDaHJpc3RpYW4gS8O2bmlnLgo+Cj4gICAgICAtIEFkZGVk
IGFjayBmcm9tIFRvbWFzeiBGaWdhIHRvIHRoZSBWNEwgcGF0Y2hlcyB0aGF0IGhlIGdhdmUgdG8g
djEuCj4KPiBEbWl0cnkgT3NpcGVua28gKDkpOgo+ICAgIGRtYS1idWY6IEFkZCBfdW5sb2NrZWQg
cG9zdGZpeCB0byBmdW5jdGlvbiBuYW1lcwo+ICAgIGRtYS1idWY6IEFkZCBsb2NrZWQgdmFyaWFu
dCBvZiBkbWFfYnVmX3ZtYXAvdnVubWFwKCkKPiAgICBkcm0vZ2VtOiBUYWtlIHJlc2VydmF0aW9u
IGxvY2sgZm9yIHZtYXAvdnVubWFwIG9wZXJhdGlvbnMKPiAgICBkbWEtYnVmOiBNb3ZlIGRtYV9i
dWZfdm1hcC92dW5tYXBfdW5sb2NrZWQoKSB0byBkeW5hbWljIGxvY2tpbmcKPiAgICAgIHNwZWNp
ZmljYXRpb24KPiAgICBkbWEtYnVmOiBNb3ZlIGRtYV9idWZfbW1hcF91bmxvY2tlZCgpIHRvIGR5
bmFtaWMgbG9ja2luZyBzcGVjaWZpY2F0aW9uCj4gICAgZG1hLWJ1ZjogTW92ZSBkbWEtYnVmIGF0
dGFjaG1lbnQgdG8gZHluYW1pYyBsb2NraW5nIHNwZWNpZmljYXRpb24KPiAgICBkbWEtYnVmOiBE
b2N1bWVudCBkeW5hbWljIGxvY2tpbmcgY29udmVudGlvbgo+ICAgIG1lZGlhOiB2aWRlb2J1ZjI6
IFN0b3AgdXNpbmcgaW50ZXJuYWwgZG1hLWJ1ZiBsb2NrCj4gICAgZG1hLWJ1ZjogUmVtb3ZlIGlu
dGVybmFsIGxvY2sKPgo+ICAgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2RtYS1idWYucnN0ICAg
ICAgICAgIHwgICA2ICsKPiAgIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgICAgICAgICAgICAg
ICAgICAgICB8IDI3NiArKysrKysrKysrKysrKy0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgICB8ICAgNCArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Fy
bWFkYS9hcm1hZGFfZ2VtLmMgICAgICAgICAgIHwgIDE0ICstCj4gICBkcml2ZXJzL2dwdS9kcm0v
ZHJtX2NsaWVudC5jICAgICAgICAgICAgICAgICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9kcm1fZ2VtLmMgICAgICAgICAgICAgICAgICAgICB8ICAyNCArKwo+ICAgZHJpdmVycy9ncHUv
ZHJtL2RybV9nZW1fZG1hX2hlbHBlci5jICAgICAgICAgIHwgICA2ICstCj4gICBkcml2ZXJzL2dw
dS9kcm0vZHJtX2dlbV9mcmFtZWJ1ZmZlcl9oZWxwZXIuYyAgfCAgIDYgKy0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5jICAgICAgICB8ICAgMiArLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2RybV9nZW1fdHRtX2hlbHBlci5jICAgICAgICAgIHwgICA5ICstCj4gICBkcml2
ZXJzL2dwdS9kcm0vZHJtX3ByaW1lLmMgICAgICAgICAgICAgICAgICAgfCAgMTIgKy0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ2VtX3ByaW1lLmMgICB8ICAgNCArLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2dlbS5jICAgICAgIHwgICAyICstCj4g
ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1hYnVmLmMgICAgfCAgIDYgKy0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9vYmplY3QuYyAgICB8ICAxMiAr
Cj4gICAuLi4vZHJtL2k5MTUvZ2VtL3NlbGZ0ZXN0cy9pOTE1X2dlbV9kbWFidWYuYyAgfCAgMjAg
Ky0KPiAgIGRyaXZlcnMvZ3B1L2RybS9saW1hL2xpbWFfc2NoZWQuYyAgICAgICAgICAgICB8ICAg
NCArLQo+ICAgZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9nZW1fZG1hYnVmLmMgICAgIHwg
ICA4ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZHVtcC5jICAgICAg
fCAgIDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9wZXJmY250LmMg
ICB8ICAgNiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfb2JqZWN0LmMgICAgICAgICAg
ICAgIHwgIDE3ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9wcmltZS5jICAgICAgICAg
ICAgICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9nZW0uYyAgICAgICAgICAg
ICAgICAgICB8ICAyNyArLQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdW1lbV9kbWFidWYu
YyAgICAgICAgIHwgIDExICstCj4gICAuLi4vY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItZG1h
LWNvbnRpZy5jICAgfCAgMjYgKy0KPiAgIC4uLi9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVv
YnVmMi1kbWEtc2cuYyB8ICAyMyArLQo+ICAgLi4uL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYy
LXZtYWxsb2MuYyAgICAgIHwgIDE3ICstCj4gICAuLi4vcGxhdGZvcm0vbnZpZGlhL3RlZ3JhLXZk
ZS9kbWFidWYtY2FjaGUuYyAgfCAgMTIgKy0KPiAgIGRyaXZlcnMvbWlzYy9mYXN0cnBjLmMgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxMiArLQo+ICAgZHJpdmVycy94ZW4vZ250ZGV2LWRtYWJ1
Zi5jICAgICAgICAgICAgICAgICAgIHwgIDE0ICstCj4gICBpbmNsdWRlL2RybS9kcm1fZ2VtLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwo+ICAgaW5jbHVkZS9saW51eC9kbWEtYnVm
LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDU3ICsrLS0KPiAgIDMyIGZpbGVzIGNoYW5nZWQs
IDQxMCBpbnNlcnRpb25zKCspLCAyNDIgZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
