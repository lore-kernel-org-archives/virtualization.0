Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2706ECAAD2
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 06:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B39841725;
	Thu,  1 Sep 2022 06:45:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B39841725
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YnX8YJAi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5W_mBXz7XHiB; Thu,  1 Sep 2022 06:45:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B39F541710;
	Thu,  1 Sep 2022 06:45:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B39F541710
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EFFEC0033;
	Thu,  1 Sep 2022 06:45:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E2DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29C01400C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29C01400C8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=YnX8YJAi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mIbleuAk9gP5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 382F3400BB
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 382F3400BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:47 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id b44so21236113edf.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=++zrN/rWVjY3ex9jtOllxTCInKN3pkXs9YkUhtChz5k=;
 b=YnX8YJAiNhDBYXCKbeG4LzILhSuYf6l34DOfoXAV+2BNNiqDejkT1JhCOqk85bbLvM
 zoR2Hcge5b95X53WQMadn1yVJwPDDawbp0y0RILXXbQrJ05xxfQJ9LytnW8uFtfxdomX
 HQxLEqSY0zmbjFH5qo+HIVqX11AzLuaXZXmMVUbkcVJyin2bh3p19cTXD3ijCHkGg3JQ
 QmozsU/gGAP4TCFY028A4kfd3jsdpgVW6S3Vuu6BkOJHrMWqfM1ne9IOHZplONd14kYK
 3KjcL+VdwhlqnsHbUMqkKTTGVJncmoWHNfx6LnxwRuQcifdVoguXtSILMcx3/MwDW/MA
 kCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=++zrN/rWVjY3ex9jtOllxTCInKN3pkXs9YkUhtChz5k=;
 b=PQw0aDzPxnx3iDBr0oLPYQ8WskyeJqI0zwsHkXrJEDXgdEfc+0R5ZgmozikHFVd4ag
 a/hMIOxe4ABX+3I7iRuvE56T8BeKdf90d4B8Asrl7OwSeZ7/qEO9XfwNKA2gD3f6zDjD
 Rm1E50GI+ZCoUfWJjWSCBWMJPG18h3VzMhlFQ3+FmMYHrVple8qhxoYncrR/krXZ6/Pn
 e4Mqdfu20bAy8OOghzNjLHfvyMfuxuBqjlNfsmTWEWHwJ6R+2Pb+1grG4LzwZSEZaS/3
 UF/sRHGZSmjWl0v9o9AuOSiHySkINQMcESgMZkuIJU6z3oz58F+Y9qOmkHy41J6il4Dn
 TqYg==
X-Gm-Message-State: ACgBeo1/lOv+urGDDiOWghY5CGN0D5u+8KceXSg/KEgsSvvkq9IhSv7u
 cVBFl4cB56Xj+yM2gNOPfOQ=
X-Google-Smtp-Source: AA6agR4WM9TvD6ATr67LU+K3A/g1BJohEx6M/gXPe6GWUlzDISRTSlHNurPT278X8F2LNo/Uip9krw==
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id
 s19-20020aa7cb13000000b0044837598c57mr18470629edt.8.1662014745147; 
 Wed, 31 Aug 2022 23:45:45 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ad4.dip0.t-ipconnect.de.
 [79.194.10.212]) by smtp.gmail.com with ESMTPSA id
 gt23-20020a170906f21700b007306a4bc9b4sm8019660ejb.38.2022.08.31.23.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Aug 2022 23:45:44 -0700 (PDT)
Message-ID: <06cad130-4b0d-a894-d444-21b5ee5b5a63@gmail.com>
Date: Thu, 1 Sep 2022 08:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Linaro-mm-sig] [PATCH v4 07/21] drm/omapdrm: Prepare to dynamic
 dma-buf locking specification
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 Qiang Yu <yuq825@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tomi Valkeinen <tomba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-8-dmitry.osipenko@collabora.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220831153757.97381-8-dmitry.osipenko@collabora.com>
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 linux-media@vger.kernel.org
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gUHJlcGFyZSBP
TUFQIERSTSBkcml2ZXIgdG8gdGhlIGNvbW1vbiBkeW5hbWljIGRtYS1idWYgbG9ja2luZyBjb252
ZW50aW9uCj4gYnkgc3RhcnRpbmcgdG8gdXNlIHRoZSB1bmxvY2tlZCB2ZXJzaW9ucyBvZiBkbWEt
YnVmIEFQSSBmdW5jdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRt
aXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vb21h
cGRybS9vbWFwX2dlbV9kbWFidWYuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vb21hcGRybS9vbWFwX2dlbV9kbWFidWYuYyBiL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL29t
YXBfZ2VtX2RtYWJ1Zi5jCj4gaW5kZXggMzkzZjgyZTI2OTI3Li44ZTE5NGRiYzk1MDYgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9nZW1fZG1hYnVmLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vb21hcGRybS9vbWFwX2dlbV9kbWFidWYuYwo+IEBAIC0xMjUsNyAr
MTI1LDcgQEAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvbWFwX2dlbV9wcmltZV9pbXBvcnQoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwKPiAgIAo+ICAgCWdldF9kbWFfYnVmKGRtYV9idWYpOwo+ICAg
Cj4gLQlzZ3QgPSBkbWFfYnVmX21hcF9hdHRhY2htZW50KGF0dGFjaCwgRE1BX1RPX0RFVklDRSk7
Cj4gKwlzZ3QgPSBkbWFfYnVmX21hcF9hdHRhY2htZW50X3VubG9ja2VkKGF0dGFjaCwgRE1BX1RP
X0RFVklDRSk7Cj4gICAJaWYgKElTX0VSUihzZ3QpKSB7Cj4gICAJCXJldCA9IFBUUl9FUlIoc2d0
KTsKPiAgIAkJZ290byBmYWlsX2RldGFjaDsKPiBAQCAtMTQyLDcgKzE0Miw3IEBAIHN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqb21hcF9nZW1fcHJpbWVfaW1wb3J0KHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsCj4gICAJcmV0dXJuIG9iajsKPiAgIAo+ICAgZmFpbF91bm1hcDoKPiAtCWRtYV9idWZfdW5t
YXBfYXR0YWNobWVudChhdHRhY2gsIHNndCwgRE1BX1RPX0RFVklDRSk7Cj4gKwlkbWFfYnVmX3Vu
bWFwX2F0dGFjaG1lbnRfdW5sb2NrZWQoYXR0YWNoLCBzZ3QsIERNQV9UT19ERVZJQ0UpOwo+ICAg
ZmFpbF9kZXRhY2g6Cj4gICAJZG1hX2J1Zl9kZXRhY2goZG1hX2J1ZiwgYXR0YWNoKTsKPiAgIAlk
bWFfYnVmX3B1dChkbWFfYnVmKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
