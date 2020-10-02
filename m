Return-Path: <SRS0=l9dZ=DJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF0C4363D
	for <virtualization@archiver.kernel.org>; Fri,  2 Oct 2020 11:30:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE9A206DC
	for <virtualization@archiver.kernel.org>; Fri,  2 Oct 2020 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cebDEAs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE9A206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F347C872E3;
	Fri,  2 Oct 2020 11:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAv0Fgwp6gmj; Fri,  2 Oct 2020 11:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 32481872D5;
	Fri,  2 Oct 2020 11:30:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18DC7C0889;
	Fri,  2 Oct 2020 11:30:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCE90C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 11:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C3DD686AE6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 11:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F0J1zMUQyIXG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 11:30:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2211786AE1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 11:30:27 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id ly6so190319ejb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Oct 2020 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3Yv1p91kdY6MztMHEbXAX2LIhnqCDycHHWK1s9rlIpk=;
 b=cebDEAs7j0BDWj7XygZm8zBV9UtA+AAQH7jIMa3COVQavNGQ+xmaBn9oMoiStb2f2h
 KWrSq2RIjXarUg9cmmsx6e/IvJprHToa4zB4n03/MjsEDUWHyGrhyxSqnN4QN74MCEWv
 F+qLVD6ryJnlLP8vbzJLsvM8pEx84IxEmpnoZ+bibT8IC2fY5x+WMqpAPumoMtkcL/45
 G/iif/RHXgdKh9DArmcH/vzWsL81H6c2t9CDpNdYmjQRRguBB4YtWane1V8BhhhBxe0I
 Nh4niqMUMOyIDFLfEGby2I/PFheLBfKCxpKk74E4KKaHjYLHDqqOJLGfJFBDuUwVEuK6
 mzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=3Yv1p91kdY6MztMHEbXAX2LIhnqCDycHHWK1s9rlIpk=;
 b=D8zK8KlnGVMjQyqlLBrMzaEoM3ShMhV/vo8VLK5WuXyjdsliSnNQIOHVv5CYAHwPEr
 7U08TmCfrIlj1DPocpmdB8Rn/ZjTNaAaDA4lEwZQ9F29LGMHDcDJ+JKZ6ZV8Jjr7lpdg
 m9ljDS+1MpkMWy6y1Y9frCKjC3fiSSJn/qI/IY27QA+AioaLSxe6kKOjW/PfO6xBtxhS
 gpFgOAMr8K4XBr9Aq5UFMCGgb8oQL8wdTLwxlJ+BIQzu8aQMj9ETWlG0+2AbjxqbA3Hg
 ZQMmrkLH8w05r06YClUyUM+VgzeE4advxWNcu2+VOYcgHk3Rt+stJRYm/eymteB+K202
 ykZQ==
X-Gm-Message-State: AOAM531KjWJ/e/s/CvDevtGaTDtIkIG8WaDjY7JuDnCFvr6nHj3oSkqW
 aFvlMPzzSLLSuw1vGfFvWnsL6hr8WJeWDg==
X-Google-Smtp-Source: ABdhPJxApAPeHRcp+JFrWFCuy4bAcO8RMtt2ySgmt8bQlcWwipN6gyDihDz/j48Bs0NqfRAKqlXWUA==
X-Received: by 2002:a17:906:c7d5:: with SMTP id
 dc21mr1070990ejb.308.1601638225441; 
 Fri, 02 Oct 2020 04:30:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id jp3sm968602ejb.125.2020.10.02.04.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 04:30:24 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] drm/ttm: Add ttm_kmap_obj_to_dma_buf_map() for
 type conversion
To: Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200929151437.19717-1-tzimmermann@suse.de>
 <20200929151437.19717-3-tzimmermann@suse.de>
 <8fad0114-064a-4ed5-c21d-d1b4294de0a1@amd.com>
 <2614314a-81f7-4722-c400-68d90e48e09a@suse.de>
 <8a84f62b-33f3-f44c-52af-c859a0e0d1fb@gmail.com>
 <07972ada-9135-3743-a86b-487f610c509f@suse.de>
 <b569b7e3-68f0-edcc-c8f4-170e9042d348@gmail.com>
 <20200930094712.GW438822@phenom.ffwll.local>
 <8479d0aa-3826-4f37-0109-55daca515793@amd.com>
 <CAKMK7uH0U36NG8w98i0x6HVGeogiwnYDRiKquLW-8znLa7-0yg@mail.gmail.com>
 <20201002095830.GH438822@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f6dcba12-8be8-b867-ac9b-a1ba50567fca@gmail.com>
Date: Fri, 2 Oct 2020 13:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002095830.GH438822@phenom.ffwll.local>
Content-Language: en-US
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 Dave Airlie <airlied@linux.ie>, Nouveau Dev <nouveau@lists.freedesktop.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Wilson,
 Chris" <chris@chris-wilson.co.uk>, Melissa Wen <melissa.srw@gmail.com>,
 "Anholt, Eric" <eric@anholt.net>, Huang Rui <ray.huang@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Herring <robh@kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, lima@lists.freedesktop.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Steven Price <steven.price@arm.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Ben Skeggs <bskeggs@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 Maxime Ripard <mripard@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
 "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>,
 Sean Paul <sean@poorly.run>, apaneers@amd.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Qinglang Miao <miaoqinglang@huawei.com>, Kukjin Kim <kgene@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMDIuMTAuMjAgdW0gMTE6NTggc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFdlZCwgU2Vw
IDMwLCAyMDIwIGF0IDAyOjUxOjQ2UE0gKzAyMDAsIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4+IE9u
IFdlZCwgU2VwIDMwLCAyMDIwIGF0IDI6MzQgUE0gQ2hyaXN0aWFuIEvDtm5pZwo+PiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPj4+IEFtIDMwLjA5LjIwIHVtIDExOjQ3IHNjaHJp
ZWIgRGFuaWVsIFZldHRlcjoKPj4+PiBPbiBXZWQsIFNlcCAzMCwgMjAyMCBhdCAxMDozNDozMUFN
ICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAzMC4wOS4yMCB1bSAxMDox
OSBzY2hyaWViIFRob21hcyBaaW1tZXJtYW5uOgo+Pj4+Pj4gSGkKPj4+Pj4+Cj4+Pj4+PiBBbSAz
MC4wOS4yMCB1bSAxMDowNSBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+Pj4+Pj4gQW0gMjku
MDkuMjAgdW0gMTk6NDkgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoKPj4+Pj4+Pj4gSGkgQ2hy
aXN0aWFuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEFtIDI5LjA5LjIwIHVtIDE3OjM1IHNjaHJpZWIgQ2hy
aXN0aWFuIEvDtm5pZzoKPj4+Pj4+Pj4+IEFtIDI5LjA5LjIwIHVtIDE3OjE0IHNjaHJpZWIgVGhv
bWFzIFppbW1lcm1hbm46Cj4+Pj4+Pj4+Pj4gVGhlIG5ldyBoZWxwZXIgdHRtX2ttYXBfb2JqX3Rv
X2RtYV9idWYoKSBleHRyYWN0cyBhZGRyZXNzIGFuZCBsb2NhdGlvbgo+Pj4+Pj4+Pj4+IGZyb20g
YW5kIGluc3RhbmNlIG9mIFRUTSdzIGttYXBfb2JqIGFuZCBpbml0aWFsaXplcyBzdHJ1Y3QgZG1h
X2J1Zl9tYXAKPj4+Pj4+Pj4+PiB3aXRoIHRoZXNlIHZhbHVlcy4gSGVscGZ1bCBmb3IgVFRNLWJh
c2VkIGRyaXZlcnMuCj4+Pj4+Pj4+PiBXZSBjb3VsZCBjb21wbGV0ZWx5IGRyb3AgdGhhdCBpZiB3
ZSB1c2UgdGhlIHNhbWUgc3RydWN0dXJlIGluc2lkZSBUVE0gYXMKPj4+Pj4+Pj4+IHdlbGwuCj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQWRkaXRpb25hbCB0byB0aGF0IHdoaWNoIGRyaXZlciBpcyBnb2lu
ZyB0byB1c2UgdGhpcz8KPj4+Pj4+Pj4gQXMgRGFuaWVsIG1lbnRpb25lZCwgaXQncyBpbiBwYXRj
aCAzLiBUaGUgVFRNLWJhc2VkIGRyaXZlcnMgd2lsbAo+Pj4+Pj4+PiByZXRyaWV2ZSB0aGUgcG9p
bnRlciB2aWEgdGhpcyBmdW5jdGlvbi4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSSBkbyB3YW50IHRvIHNl
ZSBhbGwgdGhhdCBiZWluZyBtb3JlIHRpZ2h0bHkgaW50ZWdyYXRlZCBpbnRvIFRUTSwgYnV0Cj4+
Pj4+Pj4+IG5vdCBpbiB0aGlzIHNlcmllcy4gVGhpcyBvbmUgaXMgYWJvdXQgZml4aW5nIHRoZSBi
b2Nocy1vbi1zcGFyYzY0Cj4+Pj4+Pj4+IHByb2JsZW0gZm9yIGdvb2QuIFBhdGNoIDcgYWRkcyBh
biB1cGRhdGUgdG8gVFRNIHRvIHRoZSBEUk0gVE9ETyBsaXN0Lgo+Pj4+Pj4+IEkgc2hvdWxkIGhh
dmUgYXNrZWQgd2hpY2ggZHJpdmVyIHlvdSB0cnkgdG8gZml4IGhlcmUgOikKPj4+Pj4+Pgo+Pj4+
Pj4+IEluIHRoaXMgY2FzZSBqdXN0IGtlZXAgdGhlIGZ1bmN0aW9uIGluc2lkZSBib2NocyBhbmQg
b25seSBmaXggaXQgdGhlcmUuCj4+Pj4+Pj4KPj4+Pj4+PiBBbGwgb3RoZXIgZHJpdmVycyBjYW4g
YmUgZml4ZWQgd2hlbiB3ZSBnZW5lcmFsbHkgcHVtcCB0aGlzIHRocm91Z2ggVFRNLgo+Pj4+Pj4g
RGlkIHlvdSB0YWtlIGEgbG9vayBhdCBwYXRjaCAzPyBUaGlzIGZ1bmN0aW9uIHdpbGwgYmUgdXNl
ZCBieSBWUkFNCj4+Pj4+PiBoZWxwZXJzLCBub3V2ZWF1LCByYWRlb24sIGFtZGdwdSBhbmQgcXhs
LiBJZiB3ZSBkb24ndCBwdXQgaXQgaGVyZSwgd2UKPj4+Pj4+IGhhdmUgdG8gZHVwbGljYXRlIHRo
ZSBmdW5jdGlvbmFsaXR5IGluIGVhY2ggaWYgdGhlc2UgZHJpdmVycy4gQm9jaHMKPj4+Pj4+IGl0
c2VsZiB1c2VzIFZSQU0gaGVscGVycyBhbmQgZG9lc24ndCB0b3VjaCB0aGUgZnVuY3Rpb24gZGly
ZWN0bHkuCj4+Pj4+IEFoLCBvayBjYW4gd2UgaGF2ZSB0aGF0IHRoZW4gb25seSBpbiB0aGUgVlJB
TSBoZWxwZXJzPwo+Pj4+Pgo+Pj4+PiBBbHRlcm5hdGl2ZSB5b3UgY291bGQgZ28gYWhlYWQgYW5k
IHVzZSBkbWFfYnVmX21hcCBpbiB0dG1fYm9fa21hcF9vYmoKPj4+Pj4gZGlyZWN0bHkgYW5kIGRy
b3AgdGhlIGhhY2sgd2l0aCB0aGUgVFRNX0JPX01BUF9JT01FTV9NQVNLLgo+Pj4+Pgo+Pj4+PiBX
aGF0IEkgd2FudCB0byBhdm9pZCBpcyB0byBoYXZlIGFub3RoZXIgY29udmVyc2lvbiBmdW5jdGlv
biBpbiBUVE0gYmVjYXVzZQo+Pj4+PiB3aGF0IGhhcHBlbnMgaGVyZSBpcyB0aGF0IHdlIGFscmVh
ZHkgY29udmVydCBmcm9tIHR0bV9idXNfcGxhY2VtZW50IHRvCj4+Pj4+IHR0bV9ib19rbWFwX29i
aiBhbmQgdGhlbiB0byBkbWFfYnVmX21hcC4KPj4+PiBIbSBJJ20gbm90IHJlYWxseSBzZWVpbmcg
aG93IHRoYXQgaGVscHMgd2l0aCBhIGdyYWR1YWwgY29udmVyc2lvbiBvZgo+Pj4+IGV2ZXJ5dGhp
bmcgb3ZlciB0byBkbWFfYnVmX21hcCBhbmQgYXNzb3J0ZWQgaGVscGVycyBmb3IgYWNjZXNzPyBU
aGVyZSdzCj4+Pj4gdG9vIG1hbnkgcGxhY2VzIGluIHR0bSBkcml2ZXJzIHdoZXJlIGlzX2lvbWVt
IGFuZCByZWxhdGVkIHN0dWZmIGlzIHVzZWQgdG8KPj4+PiBiZSBhYmxlIHRvIGNvbnZlcnQgaXQg
YWxsIGluIG9uZSBnby4gQW4gaW50ZXJtZWRpYXRlIHN0YXRlIHdpdGggYSBidW5jaCBvZgo+Pj4+
IGNvbnZlcnNpb25zIHNlZW1zIGZhaXJseSB1bmF2b2lkYWJsZSB0byBtZS4KPj4+IEZhaXIgZW5v
dWdoLiBJIHdvdWxkIGp1c3QgaGF2ZSBzdGFydGVkIGJvdHRvbSB1cCBhbmQgbm90IHRvcCBkb3du
Lgo+Pj4KPj4+IEFueXdheSBmZWVsIGZyZWUgdG8gZ28gYWhlYWQgd2l0aCB0aGlzIGFwcHJvYWNo
IGFzIGxvbmcgYXMgd2UgY2FuIHJlbW92ZQo+Pj4gdGhlIG5ldyBmdW5jdGlvbiBhZ2FpbiB3aGVu
IHdlIGNsZWFuIHRoYXQgc3R1ZmYgdXAgZm9yIGdvb2QuCj4+IFllYWggSSBndWVzcyBib3R0b20g
dXAgd291bGQgbWFrZSBtb3JlIHNlbnNlIGFzIGEgcmVmYWN0b3JpbmcuIEJ1dCB0aGUKPj4gbWFp
biBtb3RpdmF0aW9uIHRvIGxhbmQgdGhpcyBoZXJlIGlzIHRvIGZpeCB0aGUgX19tbWlvIHZzIG5v
cm1hbAo+PiBtZW1vcnkgY29uZnVzaW9uIGluIHRoZSBmYmRldiBlbXVsYXRpb24gaGVscGVycyBm
b3Igc3BhcmMgKGFuZAo+PiBhbnl0aGluZyBlbHNlIHRoYXQgbmVlZHMgdGhpcykuIEhlbmNlIHRo
ZSB0b3AgZG93biBhcHByb2FjaCBmb3IKPj4gcm9sbGluZyB0aGlzIG91dC4KPiBPayBJIHN0YXJ0
ZWQgcmV2aWV3aW5nIHRoaXMgYSBiaXQgbW9yZSBpbi1kZXB0aCwgYW5kIEkgdGhpbmsgdGhpcyBp
cyBhIGJpdAo+IHRvbyBtdWNoIG9mIGEgZGUtdG91ci4KPgo+IExvb2tpbmcgdGhyb3VnaCBhbGwg
dGhlIGNhbGxlcnMgb2YgdHRtX2JvX2ttYXAgYWxtb3N0IGV2ZXJ5b25lIG1hcHMgdGhlCj4gZW50
aXJlIG9iamVjdC4gT25seSB2bXdnZnggdXNlcyB0byBtYXAgbGVzcyB0aGFuIHRoYXQuIEFsc28s
IGV2ZXJ5b25lIGp1c3QKPiBpbW1lZGlhdGVseSBmb2xsb3dzIHVwIHdpdGggY29udmVydGluZyB0
aGF0IGZ1bGwgb2JqZWN0IG1hcCBpbnRvIGEKPiBwb2ludGVyLgo+Cj4gU28gSSB0aGluayB3aGF0
IHdlIHJlYWxseSB3YW50IGhlcmUgaXM6Cj4gLSBuZXcgZnVuY3Rpb24KPgo+IGludCB0dG1fYm9f
dm1hcChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1h
cCk7Cj4KPiAgICBfdm1hcCBuYW1lIHNpbmNlIHRoYXQncyBjb25zaXN0ZW50IHdpdGggYm90aCBk
bWFfYnVmIGZ1bmN0aW9ucyBhbmQKPiAgICB3aGF0J3MgdXN1YWxseSB1c2VkIHRvIGltcGxlbWVu
dCB0aGlzLiBPdXRzaWRlIG9mIHRoZSB0dG0gd29ybGQga21hcAo+ICAgIHVzdWFsbHkganVzdCBt
ZWFucyBzaW5nbGUtcGFnZSBtYXBwaW5ncyB1c2luZyBrbWFwKCkgb3IgaXQncyBpb21lbQo+ICAg
IHNpYmxpbmcgaW9fbWFwcGluZ19tYXAqIHNvIHJhdGhlciBjb25mdXNpbmcgbmFtZSBmb3IgYSBm
dW5jdGlvbiB3aGljaAo+ICAgIHVzdWFsbHkgaXMganVzdCB1c2VkIHRvIHNldCB1cCBhIHZtYXAg
b2YgdGhlIGVudGlyZSBidWZmZXIuCj4KPiAtIGEgaGVscGVyIHdoaWNoIGNhbiBiZSB1c2VkIGZv
ciB0aGUgZHJtX2dlbV9vYmplY3RfZnVuY3Mgdm1hcC92dW5tYXAKPiAgICBmdW5jdGlvbnMgZm9y
IGFsbCB0dG0gZHJpdmVycy4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gbWFrZSB0aGlzIGZ1bGx5Cj4g
ICAgZ2VuZXJpYyBiZWNhdXNlIGEpIHdlIG5vdyBoYXZlIGRtYV9idWZfbWFwIGFuZCBiKSBkcm1f
Z2VtX29iamVjdCBpcwo+ICAgIGVtYmVkZGVkIGluIHRoZSB0dG1fYm8sIHNvIHdlIGNhbiB1cGNh
c3QgZm9yIGV2ZXJ5b25lIHdobydzIGJvdGggYSB0dG0KPiAgICBhbmQgZ2VtIGRyaXZlci4KPgo+
ICAgIFRoaXMgaXMgbWF5YmUgYSBnb29kIGZvbGxvdy11cCwgc2luY2UgaXQgc2hvdWxkIGFsbG93
IHVzIHRvIGRpdGNoIHF1aXRlCj4gICAgYSBiaXQgb2YgdGhlIHZyYW0gaGVscGVyIGNvZGUgZm9y
IHRoaXMgbW9yZSBnZW5lcmljIHN0dWZmLiBJIGFsc28gbWlnaHQKPiAgICBoYXZlIG1pc3NlZCBz
b21lIHNwZWNpYWwtY2FzZXMgaGVyZSwgYnV0IGZyb20gYSBxdWljayBsb29rIGV2ZXJ5dGhpbmcK
PiAgICBqdXN0IHBpbnMgdGhlIGJ1ZmZlciB0byB0aGUgY3VycmVudCBsb2NhdGlvbiBhbmQgdGhh
dCdzIGl0Lgo+Cj4gICAgQWxzbyB0aGlzIG9idmlvdXNseSByZXF1aXJlcyBDaHJpc3RpYW4ncyBn
ZW5lcmljIHR0bV9ib19waW4gcmV3b3JrCj4gICAgZmlyc3QuCj4KPiAtIHJvbGwgdGhlIGFib3Zl
IG91dCB0byBkcml2ZXJzLgo+Cj4gQ2hyaXN0aWFuL1Rob21hcywgdGhvdWdodHMgb24gdGhpcz8K
CkNhbGxpbmcgdGhpcyB2bWFwIGluc3RlYWQgb2Yga21hcCBjZXJ0YWlubHkgbWFrZXMgc2Vuc2Uu
CgpOb3QgMTAwJSBzdXJlIGFib3V0IHRoZSBnZW5lcmljIGhlbHBlcnMsIGJ1dCBpdCBzb3VuZHMg
bGlrZSB0aGlzIHNob3VsZCAKaW5kZWVkIGxvb2sgcmF0aGVyIGNsZWFuIGluIHRoZSBlbmQuCgpD
aHJpc3RpYW4uCgo+Cj4gSSB0aGluayBmb3IgdGhlIGltbWVkaWF0ZSBuZWVkIG9mIHJvbGxpbmcg
dGhpcyBvdXQgZm9yIHZyYW0gaGVscGVycyBhbmQKPiBmYmRldiBjb2RlIHdlIHNob3VsZCBiZSBh
YmxlIHRvIGRvIHRoaXMsIGJ1dCBqdXN0IHBvc3Rwb25lIHRoZSBkcml2ZXIgd2lkZQo+IHJvbGwt
b3V0IGZvciBub3cuCj4KPiBDaGVlcnMsIERhbmllbAo+Cj4+IC1EYW5pZWwKPj4KPj4+IENocmlz
dGlhbi4KPj4+Cj4+Pj4gLURhbmllbAo+Pj4+Cj4+Pj4+IFRoYW5rcywKPj4+Pj4gQ2hyaXN0aWFu
Lgo+Pj4+Pgo+Pj4+Pj4gQmVzdCByZWdhcmRzCj4+Pj4+PiBUaG9tYXMKPj4+Pj4+Cj4+Pj4+Pj4g
UmVnYXJkcywKPj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4KPj4+Pj4+Pj4gQmVzdCByZWdhcmRz
Cj4+Pj4+Pj4+IFRob21hcwo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gUmVnYXJkcywKPj4+Pj4+Pj4+IENo
cmlzdGlhbi4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1l
cm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4gICAg
ICBpbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
KysrCj4+Pj4+Pj4+Pj4gICAgICBpbmNsdWRlL2xpbnV4L2RtYS1idWYtbWFwLmggIHwgMjAgKysr
KysrKysrKysrKysrKysrKysKPj4+Pj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5z
ZXJ0aW9ucygrKQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJt
L3R0bS90dG1fYm9fYXBpLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCj4+Pj4+Pj4+
Pj4gaW5kZXggYzk2YTI1ZDU3MWM4Li42MmQ4OWYwNWE4MDEgMTAwNjQ0Cj4+Pj4+Pj4+Pj4gLS0t
IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19hcGkuaAo+Pj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUv
ZHJtL3R0bS90dG1fYm9fYXBpLmgKPj4+Pj4+Pj4+PiBAQCAtMzQsNiArMzQsNyBAQAo+Pj4+Pj4+
Pj4+ICAgICAgI2luY2x1ZGUgPGRybS9kcm1fZ2VtLmg+Cj4+Pj4+Pj4+Pj4gICAgICAjaW5jbHVk
ZSA8ZHJtL2RybV9oYXNodGFiLmg+Cj4+Pj4+Pj4+Pj4gICAgICAjaW5jbHVkZSA8ZHJtL2RybV92
bWFfbWFuYWdlci5oPgo+Pj4+Pj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLWJ1Zi1tYXAuaD4K
Pj4+Pj4+Pj4+PiAgICAgICNpbmNsdWRlIDxsaW51eC9rcmVmLmg+Cj4+Pj4+Pj4+Pj4gICAgICAj
aW5jbHVkZSA8bGludXgvbGlzdC5oPgo+Pj4+Pj4+Pj4+ICAgICAgI2luY2x1ZGUgPGxpbnV4L3dh
aXQuaD4KPj4+Pj4+Pj4+PiBAQCAtNDg2LDYgKzQ4NywyOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
KnR0bV9rbWFwX29ial92aXJ0dWFsKHN0cnVjdAo+Pj4+Pj4+Pj4+IHR0bV9ib19rbWFwX29iaiAq
bWFwLAo+Pj4+Pj4+Pj4+ICAgICAgICAgIHJldHVybiBtYXAtPnZpcnR1YWw7Cj4+Pj4+Pj4+Pj4g
ICAgICB9Cj4+Pj4+Pj4+Pj4gICAgICArLyoqCj4+Pj4+Pj4+Pj4gKyAqIHR0bV9rbWFwX29ial90
b19kbWFfYnVmX21hcAo+Pj4+Pj4+Pj4+ICsgKgo+Pj4+Pj4+Pj4+ICsgKiBAa21hcDogQSBzdHJ1
Y3QgdHRtX2JvX2ttYXBfb2JqIHJldHVybmVkIGZyb20gdHRtX2JvX2ttYXAuCj4+Pj4+Pj4+Pj4g
KyAqIEBtYXA6IFJldHVybnMgdGhlIG1hcHBpbmcgYXMgc3RydWN0IGRtYV9idWZfbWFwCj4+Pj4+
Pj4+Pj4gKyAqCj4+Pj4+Pj4+Pj4gKyAqIENvbnZlcnRzIHN0cnVjdCB0dG1fYm9fa21hcF9vYmog
dG8gc3RydWN0IGRtYV9idWZfbWFwLiBJZiB0aGUgbWVtb3J5Cj4+Pj4+Pj4+Pj4gKyAqIGlzIG5v
dCBtYXBwZWQsIHRoZSByZXR1cm5lZCBtYXBwaW5nIGlzIGluaXRpYWxpemVkIHRvIE5VTEwuCj4+
Pj4+Pj4+Pj4gKyAqLwo+Pj4+Pj4+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgdHRtX2ttYXBfb2Jq
X3RvX2RtYV9idWZfbWFwKHN0cnVjdCB0dG1fYm9fa21hcF9vYmoKPj4+Pj4+Pj4+PiAqa21hcCwK
Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9idWZfbWFw
ICptYXApCj4+Pj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4+PiArICAgIGJvb2wgaXNfaW9tZW07Cj4+Pj4+
Pj4+Pj4gKyAgICB2b2lkICp2YWRkciA9IHR0bV9rbWFwX29ial92aXJ0dWFsKGttYXAsICZpc19p
b21lbSk7Cj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+ICsgICAgaWYgKCF2YWRkcikKPj4+Pj4+Pj4+
PiArICAgICAgICBkbWFfYnVmX21hcF9jbGVhcihtYXApOwo+Pj4+Pj4+Pj4+ICsgICAgZWxzZSBp
ZiAoaXNfaW9tZW0pCj4+Pj4+Pj4+Pj4gKyAgICAgICAgZG1hX2J1Zl9tYXBfc2V0X3ZhZGRyX2lv
bWVtKG1hcCwgKHZvaWQgX19mb3JjZSBfX2lvbWVtICopdmFkZHIpOwo+Pj4+Pj4+Pj4+ICsgICAg
ZWxzZQo+Pj4+Pj4+Pj4+ICsgICAgICAgIGRtYV9idWZfbWFwX3NldF92YWRkcihtYXAsIHZhZGRy
KTsKPj4+Pj4+Pj4+PiArfQo+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+PiAgICAgIC8qKgo+Pj4+Pj4+
Pj4+ICAgICAgICogdHRtX2JvX2ttYXAKPj4+Pj4+Pj4+PiAgICAgICAqCj4+Pj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi1tYXAuaCBiL2luY2x1ZGUvbGludXgvZG1h
LWJ1Zi1tYXAuaAo+Pj4+Pj4+Pj4+IGluZGV4IGZkMWFiYTU0NWZkZi4uMmU4YmJlY2I1MDkxIDEw
MDY0NAo+Pj4+Pj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi1tYXAuaAo+Pj4+Pj4+
Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi1tYXAuaAo+Pj4+Pj4+Pj4+IEBAIC00NSw2
ICs0NSwxMiBAQAo+Pj4+Pj4+Pj4+ICAgICAgICoKPj4+Pj4+Pj4+PiAgICAgICAqICAgIGRtYV9i
dWZfbWFwX3NldF92YWRkcigmbWFwLiAweGRlYWRiZWFmKTsKPj4+Pj4+Pj4+PiAgICAgICAqCj4+
Pj4+Pj4+Pj4gKyAqIFRvIHNldCBhbiBhZGRyZXNzIGluIEkvTyBtZW1vcnksIHVzZSBkbWFfYnVm
X21hcF9zZXRfdmFkZHJfaW9tZW0oKS4KPj4+Pj4+Pj4+PiArICoKPj4+Pj4+Pj4+PiArICogLi4g
Y29kZS1ibG9jazo6IGMKPj4+Pj4+Pj4+PiArICoKPj4+Pj4+Pj4+PiArICogICAgZG1hX2J1Zl9t
YXBfc2V0X3ZhZGRyX2lvbWVtKCZtYXAuIDB4ZGVhZGJlYWYpOwo+Pj4+Pj4+Pj4+ICsgKgo+Pj4+
Pj4+Pj4+ICAgICAgICogVGVzdCBpZiBhIG1hcHBpbmcgaXMgdmFsaWQgd2l0aCBlaXRoZXIgZG1h
X2J1Zl9tYXBfaXNfc2V0KCkgb3IKPj4+Pj4+Pj4+PiAgICAgICAqIGRtYV9idWZfbWFwX2lzX251
bGwoKS4KPj4+Pj4+Pj4+PiAgICAgICAqCj4+Pj4+Pj4+Pj4gQEAgLTExOCw2ICsxMjQsMjAgQEAg
c3RhdGljIGlubGluZSB2b2lkIGRtYV9idWZfbWFwX3NldF92YWRkcihzdHJ1Y3QKPj4+Pj4+Pj4+
PiBkbWFfYnVmX21hcCAqbWFwLCB2b2lkICp2YWRkcikKPj4+Pj4+Pj4+PiAgICAgICAgICBtYXAt
PmlzX2lvbWVtID0gZmFsc2U7Cj4+Pj4+Pj4+Pj4gICAgICB9Cj4+Pj4+Pj4+Pj4gICAgICArLyoq
Cj4+Pj4+Pj4+Pj4gKyAqIGRtYV9idWZfbWFwX3NldF92YWRkcl9pb21lbSAtIFNldHMgYSBkbWEt
YnVmIG1hcHBpbmcgc3RydWN0dXJlIHRvCj4+Pj4+Pj4+Pj4gYW4gYWRkcmVzcyBpbiBJL08gbWVt
b3J5Cj4+Pj4+Pj4+Pj4gKyAqIEBtYXA6ICAgICAgICBUaGUgZG1hLWJ1ZiBtYXBwaW5nIHN0cnVj
dHVyZQo+Pj4+Pj4+Pj4+ICsgKiBAdmFkZHJfaW9tZW06ICAgIEFuIEkvTy1tZW1vcnkgYWRkcmVz
cwo+Pj4+Pj4+Pj4+ICsgKgo+Pj4+Pj4+Pj4+ICsgKiBTZXRzIHRoZSBhZGRyZXNzIGFuZCB0aGUg
SS9PLW1lbW9yeSBmbGFnLgo+Pj4+Pj4+Pj4+ICsgKi8KPj4+Pj4+Pj4+PiArc3RhdGljIGlubGlu
ZSB2b2lkIGRtYV9idWZfbWFwX3NldF92YWRkcl9pb21lbShzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1h
cCwKPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCBfX2lvbWVtICp2
YWRkcl9pb21lbSkKPj4+Pj4+Pj4+PiArewo+Pj4+Pj4+Pj4+ICsgICAgbWFwLT52YWRkcl9pb21l
bSA9IHZhZGRyX2lvbWVtOwo+Pj4+Pj4+Pj4+ICsgICAgbWFwLT5pc19pb21lbSA9IHRydWU7Cj4+
Pj4+Pj4+Pj4gK30KPj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4gICAgICAvKioKPj4+Pj4+Pj4+PiAg
ICAgICAqIGRtYV9idWZfbWFwX2lzX2VxdWFsIC0gQ29tcGFyZXMgdHdvIGRtYS1idWYgbWFwcGlu
ZyBzdHJ1Y3R1cmVzCj4+Pj4+Pj4+Pj4gZm9yIGVxdWFsaXR5Cj4+Pj4+Pj4+Pj4gICAgICAgKiBA
bGhzOiAgICBUaGUgZG1hLWJ1ZiBtYXBwaW5nIHN0cnVjdHVyZQo+Pj4+Pj4+Pj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4+Pj4+IGRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKPj4+Pj4+Pj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmRyaS1kZXZlbCZhbXA7ZGF0YT0wMiU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFt
ZC5jb20lN0M0NzJjM2Q2NTVhNjE0MTFkZWI2NzA4ZDg2NTI1ZDFiOCU3QzNkZDg5NjFmZTQ4ODRl
NjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczNzA1NjA0Mzg5NjUwMTMmYW1wO3NkYXRh
PUhkSE9BJTJGMVZjSVglMkY3WXRmWVRpQXFZRXZ3N0FnJTJGUyUyQnhTNVZ3SktPdjV5MCUzRCZh
bXA7cmVzZXJ2ZWQ9MAo+Pj4+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+Pj4+Pj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4+Pj4+PiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+Pj4+PiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVz
a3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDEl
N0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3QzQ3MmMzZDY1NWE2MTQxMWRlYjY3MDhkODY1
MjVkMWI4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM3
MDU2MDQzODk2NTAxMyZhbXA7c2RhdGE9SCUyQjVIS0NzVHJrc1JWMkV5RWlGR1NUeVM3OWpzV0Nt
SmltU01vSll1c3g4JTNEJmFtcDtyZXNlcnZlZD0wCj4+Pj4+Pj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4+PiBkcmktZGV2ZWwgbWFpbGluZyBs
aXN0Cj4+Pj4+Pj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+Pj4+IGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmRyaS1kZXZl
bCZhbXA7ZGF0YT0wMiU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0M0NzJjM2Q2
NTVhNjE0MTFkZWI2NzA4ZDg2NTI1ZDFiOCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzczNzA1NjA0Mzg5NjUwMTMmYW1wO3NkYXRhPUhkSE9BJTJGMVZjSVgl
MkY3WXRmWVRpQXFZRXZ3N0FnJTJGUyUyQnhTNVZ3SktPdjV5MCUzRCZhbXA7cmVzZXJ2ZWQ9MAo+
Pj4+Pj4+Cj4+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+Pj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+Pj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NjaHJpc3RpYW4ua29l
bmlnJTQwYW1kLmNvbSU3QzQ3MmMzZDY1NWE2MTQxMWRlYjY3MDhkODY1MjVkMWI4JTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM3MDU2MDQzODk2NTAxMyZh
bXA7c2RhdGE9SCUyQjVIS0NzVHJrc1JWMkV5RWlGR1NUeVM3OWpzV0NtSmltU01vSll1c3g4JTNE
JmFtcDtyZXNlcnZlZD0wCj4+Cj4+IC0tIAo+PiBEYW5pZWwgVmV0dGVyCj4+IFNvZnR3YXJlIEVu
Z2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgo+PiBodHRwOi8vYmxvZy5mZndsbC5jaAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
