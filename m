Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEE5C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 14:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EFB860D94;
	Wed, 11 May 2022 14:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vIsOaGhFg7rg; Wed, 11 May 2022 14:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0493F60BEB;
	Wed, 11 May 2022 14:24:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB2F7C0039;
	Wed, 11 May 2022 14:24:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7931C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2C1641833
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fP2vSdE8b2Uc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:24:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73D2B415FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:24:33 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id a21so2792375edb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=HUH8tlT8lXb3CWmwqvN7Ydrh8IaXMTb4spsD3mLnS/M=;
 b=jivEDiDmye/lS2mIg5KIOd28OXyk0tDDk1D9yKGnX3e7kdSIn9gpcF88poaTeqO8gN
 KYPbfd15Gq17qIsUtNd9VRmIF3hmjexpQymV6U0TSPh63o5u5v+vhm198WOrns1zGWS5
 y6DnGlfigABwDrjDTHGczff9WESSOKgJrcl4MXZjydmZm8Kkz6/VzfspBtLcBsun7Ctf
 d8Q1EtgS9P2wCO5uJQ8glu5y/MTD34sss/qe8vupZMHlBA+27LcqVitWOqXWhjnZbtPb
 hSZq6kZEIQ2BgV2IIKt1I2Y0urCQk0NrAJrMr3oQoRYyGhD9xBRaFOZRlVBi/HqUxOvk
 U+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HUH8tlT8lXb3CWmwqvN7Ydrh8IaXMTb4spsD3mLnS/M=;
 b=p5SGcPLK7flUWQ21LTiDk5+C41amQint/pP6GM4Ex+VCdo3hpRVrfWdGOIC18/PhQB
 5vZPrgBl81MKmv4Xi/fuk7J0DC1Pe6SpyCtIiKBTaF2Bfiux3rOj9ab1u/cpxP8YILta
 jeTTNxHyGYinhzGGIFKRXyqihAt8LCXF9268GEOLowkJsz97+C0DTJ2601FslJyInrL2
 E41nCshRViwEAXXLEjvVL1T6q4pzI1n8Y3U9WcUlRb7ZXrY0FNEcR41VNogQCSutOOPT
 rOOhZ8vZhjR4zRKPF6+vFJG5lebpc2hqCOxOPkwrNTIw0S84wAk09AWVYj1moGmmCWf4
 eAbg==
X-Gm-Message-State: AOAM532EHq0BZfgxceXt36pmoPhu/cUdMDKJqh0iPRS/jV2bFzBU1R/g
 zIn3jQ2ciFNbtC42/DZomYo=
X-Google-Smtp-Source: ABdhPJwOtFlq1WvW0FIuRkxOJG81MM65TGKej/9Xy0UZB1RQWBaSIHnO89v4XF1WhilLEyiZ/4Pteg==
X-Received: by 2002:a05:6402:1f0b:b0:427:b390:2020 with SMTP id
 b11-20020a0564021f0b00b00427b3902020mr29095143edb.70.1652279071366; 
 Wed, 11 May 2022 07:24:31 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:9503:dbd2:a019:fe23?
 ([2a02:908:1256:79a0:9503:dbd2:a019:fe23])
 by smtp.gmail.com with ESMTPSA id
 ot17-20020a170906ccd100b006f3ef214e3bsm973652ejb.161.2022.05.11.07.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 07:24:30 -0700 (PDT)
Message-ID: <56787b70-fb64-64da-6006-d3aa3ed59d12@gmail.com>
Date: Wed, 11 May 2022 16:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Daniel Stone
 <daniel@fooishbar.org>, David Airlie <airlied@linux.ie>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>, Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Dmitry Osipenko <digetx@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
References: <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
 <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
 <YmlYHNlcmNMfOeyy@phenom.ffwll.local>
 <8f932ab0-bb72-8fea-4078-dc59e9164bd4@collabora.com>
 <YnI3lE0TxLfZaQjE@phenom.ffwll.local>
 <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
 <YnOHAh9I1ds4+1J+@phenom.ffwll.local>
 <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
 <YnkaUk0mZNuPsZ5r@phenom.ffwll.local>
 <4d08b382-0076-1ea2-b565-893d50b453cb@collabora.com>
 <YnuziJDmXVR09UzP@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YnuziJDmXVR09UzP@phenom.ffwll.local>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Am 11.05.22 um 15:00 schrieb Daniel Vetter:
> On Tue, May 10, 2022 at 04:39:53PM +0300, Dmitry Osipenko wrote:
>> [SNIP]
>> Since vmapping implies implicit pinning, we can't use a separate lock in
>> drm_gem_shmem_vmap() because we need to protect the
>> drm_gem_shmem_get_pages(), which is invoked by drm_gem_shmem_vmap() to
>> pin the pages and requires the dma_resv_lock to be locked.
>>
>> Hence the problem is:
>>
>> 1. If dma-buf importer holds the dma_resv_lock and invokes
>> dma_buf_vmap() -> drm_gem_shmem_vmap(), then drm_gem_shmem_vmap() shall
>> not take the dma_resv_lock.
>>
>> 2. Since dma-buf locking convention isn't specified, we can't assume
>> that dma-buf importer holds the dma_resv_lock around dma_buf_vmap().
>>
>> The possible solutions are:
>>
>> 1. Specify the dma_resv_lock convention for dma-bufs and make all
>> drivers to follow it.
>>
>> 2. Make only DRM drivers to hold dma_resv_lock around dma_buf_vmap().
>> Other non-DRM drivers will get the lockdep warning.
>>
>> 3. Make drm_gem_shmem_vmap() to take the dma_resv_lock and get deadlock
>> if dma-buf importer holds the lock.
>>
>> ...
> Yeah this is all very annoying.

Ah, yes that topic again :)

I think we could relatively easily fix that by just defining and 
enforcing that the dma_resv_lock must have be taken by the caller when 
dma_buf_vmap() is called.

A two step approach should work:
1. Move the call to dma_resv_lock() into the dma_buf_vmap() function and 
remove all lock taking from the vmap callback implementations.
2. Move the call to dma_resv_lock() into the callers of dma_buf_vmap() 
and enforce that the function is called with the lock held.

It shouldn't be that hard to clean up. The last time I looked into it my 
main problem was that we didn't had any easy unit test for it.

Regards,
Christian.

>
>> There are actually very few drivers in kernel that use dma_buf_vmap()
>> [1], so perhaps it's not really a big deal to first try to define the
>> locking and pinning convention for the dma-bufs? At least for
>> dma_buf_vmap()? Let me try to do this.
>>
>> [1] https://elixir.bootlin.com/linux/v5.18-rc6/C/ident/dma_buf_vmap
> Yeah looking through the code there's largely two classes of drivers that
> need vmap:
>
> - display drivers that need to do cpu upload (usb, spi, i2c displays).
>    Those generally set up the vmap at import time or when creating the
>    drm_framebuffer object (e.g. see
>    drm_gem_cma_prime_import_sg_table_vmap()), because that's really the
>    only place where you can safely do that without running into locking
>    inversion issues sooner or later
>
> - lots of other drivers (and shmem helpers) seem to do dma_buf_vmap just
>    because they can, but only actually ever use vmap on native objects,
>    never on imported objects. Or at least I think so.
>
> So maybe another approach here:
>
> 1. In general drivers which need a vmap need to set that up at dma_buf
> import time - the same way we pin the buffers at import time for
> non-dynamic importers because that's the only place where across all
> drivers it's ok to just take dma_resv_lock.
>
> 2. We remove the "just because we can" dma_buf_vmap support from
> helpers/drivers - the paths all already can cope with NULL since
> dma_buf_vmap can fail. vmap will only work on native objects, not imported
> ones.
>
> 3. If there is any driver using shmem helpers that absolutely needs vmap
> to also work on imported it needs a special import function (like cma
> helpers) which sets up the vmap at import time.
>
> So since this is all very tricky ... what did I miss this time around?
>
>> I envision that the extra dma_resv_locks for dma-bufs potentially may
>> create unnecessary bottlenecks for some drivers if locking isn't really
>> necessary by a specific driver, so drivers will need to keep this in
>> mind. On the other hand, I don't think that any of the today's drivers
>> will notice the additional resv locks in practice.
> Nah I don't think the extra locking will ever create a bottleneck,
> especially not for vmap. Generally vmap is a fallback or at least cpu
> operation, so at that point you're already going very slow.
> -Daniel

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
