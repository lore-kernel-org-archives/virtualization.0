Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787A2C6FD1C
	for <virtualization@archiver.kernel.org>; Sun, 26 Mar 2023 09:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8B7E60A64;
	Sun, 26 Mar 2023 09:19:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8B7E60A64
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gqqvpvRZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vbcTDDbs1Ob; Sun, 26 Mar 2023 09:19:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7622960B8E;
	Sun, 26 Mar 2023 09:19:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7622960B8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43373C0035;
	Sun, 26 Mar 2023 09:19:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEB11C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 09:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A44E81E63
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 09:19:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A44E81E63
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=gqqvpvRZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnuzCKdyVrrz
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 09:19:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78BA481E50
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78BA481E50
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 09:19:31 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id er18so13033273edb.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679822369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHZVFQkvBzOY5c4akiAgaCUw1iB4MGS8We/N4ruh3k8=;
 b=gqqvpvRZ0SdoxCmQqae1KSjIEjDh2PjxWE9UOelHJdAZQNfXsfpIUmhQzlSEEoqf+o
 mfQUctvn6msdbvoegyTomav7T+kjGRO3PRvwcyFXV0AWKAuqXbCTVILx//2bumI7cxGH
 KBI+kaEhRIdAt97A53YpSBEBjoJNNyonkARH4XdfaqZYtZfwdnvQNSF39wUcd7my8HKj
 m/Qtv/qshyPbwYZ1/LnrqlafjseLlHovhJs61rABrFLmZoZ/3APhoBnDgGLBifFPCQ5z
 ezjlApqFuRBYlMEJPbb34cSN6GyqZUfrFT7g8FLDS8hztVQrLVgzQQ3W+yW5jubhPOhh
 l8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679822369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iHZVFQkvBzOY5c4akiAgaCUw1iB4MGS8We/N4ruh3k8=;
 b=Au0Hx5DqUo3FvRa4N9qJN7teYRVWD0CllbLxF2x03xlA6w0ylQSUqCCHrB0fsJ5syx
 mKd1QH4spYHmsrdCYg0Gj/g8hnRC+pD62CZdnZ+hqXNnO9lKrPb72Zfgp5oeDGaoQZzb
 2VTdAVE8Jad5nzEu4LpmPuMwkNLqeFtw9FzuTeiVZ8Om5kY5eycAx1D9ZTdZHpV6FJPj
 b3EaLhRbco/zbfQY8+MxCyLazN5agRUzJGvfGXk6InjgV8KMaJ+5QqOaazlMuwVgF/WF
 f9nlVavOz61UyBdUniA1F3Fubbtzup9RYFQSvSEFWmwbAgaaPvlKaSqirzQi0HbRRhRu
 6Xog==
X-Gm-Message-State: AAQBX9e13NzASmBOLGEsAfWqpZv05J8evpMeLGXYFuNCXDYVQtJQZHX7
 W6TDWX0fJMiSkm31XqnXqvo=
X-Google-Smtp-Source: AKy350YY0uqokPOGnxU+dnpux6gC0xC75d1rTwE9/7vPu2Z8GpOMozFb6sLJdMp92bUZ13hIuhS3MA==
X-Received: by 2002:a17:906:1514:b0:92b:ae6c:23e7 with SMTP id
 b20-20020a170906151400b0092bae6c23e7mr8926676ejd.56.1679822369040; 
 Sun, 26 Mar 2023 02:19:29 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:87fb:f6c5:5d64:ee25?
 ([2a02:908:1256:79a0:87fb:f6c5:5d64:ee25])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a50d658000000b00501d5432f2fsm8382000edj.60.2023.03.26.02.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Mar 2023 02:19:28 -0700 (PDT)
Message-ID: <2631edac-a57e-638d-226c-08ea3d9b6b8d@gmail.com>
Date: Sun, 26 Mar 2023 11:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 01/10] drm/shmem-helper: Switch to reservation lock
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20230314022659.1816246-1-dmitry.osipenko@collabora.com>
 <20230314022659.1816246-2-dmitry.osipenko@collabora.com>
 <6b5644cf-6229-f99b-d429-a45d724493ee@collabora.com>
 <20c88807-8513-a816-aed9-5cd67eb5c1ed@collabora.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20c88807-8513-a816-aed9-5cd67eb5c1ed@collabora.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 kernel@collabora.com, David Airlie <airlied@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, linux-kernel@vger.kernel.org,
 Qiang Yu <yuq825@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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

Am 25.03.23 um 15:58 schrieb Dmitry Osipenko:
> On 3/15/23 16:46, Dmitry Osipenko wrote:
>> On 3/14/23 05:26, Dmitry Osipenko wrote:
>>> @@ -633,7 +605,10 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>>>   		return ret;
>>>   	}
>>>   
>>> +	dma_resv_lock(shmem->base.resv, NULL);
>>>   	ret = drm_gem_shmem_get_pages(shmem);
>>> +	dma_resv_unlock(shmem->base.resv);
>> Intel CI reported locking problem [1] here. It actually was also
>> reported for v12, but I missed that report because of the other noisy
>> reports.
>>
>> [1]
>> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_114671v2/shard-snb5/igt@prime_vgem@sync@rcs0.html
>>
>> The test does the following:
>>
>> 1. creates vgem
>> 2. export it do dmabuf
>> 3. mmaps dmabuf
>>
>> There is an obvious deadlock there. The DRM code assumes that mmap() is
>> unlocked, while for dma-buf it's locked. I'll see how to fix it for v14.
>>
> Christian, there is a deadlock problem in drm_gem_shmem_mmap() once we
> move drm-shmem to use resv lock. The current dma-buf locking policy
> claims that importer holds the lock for mmap(), but DRM code assumes
> that obj->mmap() handles the locking itself and then the same
> obj->mmap() code path is used by both dma-buf DRM and a usual DRM object
> paths. Hence importer -> dma_buf_mmap_internal()[takes the lock] ->
> exporter -> drm_gem_shmem_mmap()[takes the lock] deadlocks.
>
> I was looking at how to fix it and to me the best option is to change
> the dma-buf locking policy, making exporter responsible for handling the
> resv lock. Changing DRM code mmap lockings might be possible too [moving
> locking to drm_gem_mmap_obj()], but will be very messy and doesn't feel
> intuitive.
>
> Want to get yours thoughts on this before sending out the dma-buf mmap()
> policy-change patch. Does the new mmap() locking policy sound good to
> you? Thanks!


IIRC we tried that before and ran into problems.

dma_buf_mmap() needs to swap the backing file of the VMA and for this 
calls fput() on the old file.

This fput() in turn could (in theory) grab the resv lock as well and 
there isn't anything we could do about that.

Just information from the back of my memory, probably best if you double 
check that.

Regards,
Christian.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
