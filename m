Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBDCC25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 12:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 312D1416F4;
	Tue, 16 Aug 2022 12:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 312D1416F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UHJLCRj6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vTQa8nfP1e06; Tue, 16 Aug 2022 12:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7DF0E404F1;
	Tue, 16 Aug 2022 12:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DF0E404F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F1DC0033;
	Tue, 16 Aug 2022 12:03:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDDFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAC8960F4C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:03:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAC8960F4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=UHJLCRj6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fU8hsNI9jlnZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:03:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D36C60B8A
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D36C60B8A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:03:53 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id y13so18423024ejp.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=qXuUFA6dzcSFji6bQgTrBDhPKkRTpOenjFFFaEBg5kI=;
 b=UHJLCRj6aZC7JExmGfMqmbjBJMSLQus4l90cEIpD6oiFn5t7AIznfp4vmnoBDBuC89
 Co8rtShOazIQ1/pDTdlKWtiDgaw+N7eefL9j3Hq2vAfUThLRyO9Rb7B5ngUEUCtueeNx
 6zSUM4gJc5mS4F3GNo20/DWYfPsbSyNlWwtfn3dACfywQVqDk01eJeq7pEy3b4eVmyg+
 /xLDWvCsTCVL3VwOqW9vNz1sctfDZfporzdWriNN6X7XNFHs3beFmG8e+snUYDmbD7Xt
 ORToYO/CXU5ilyofZPtHvw1MVcO6aMT9wteaJfa84CKp6U5/G52ooNG3LZs/OF+1Fzi1
 DFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=qXuUFA6dzcSFji6bQgTrBDhPKkRTpOenjFFFaEBg5kI=;
 b=tH05eSwcdbU1KamhiscuyR8VTnyI2xnsRl3JoNFyONTNjV4xhP/RRtYQ9+xIDif5pY
 kc5bZdwxXlDYRk9oUPudxl2w8m83yXZbfVRiFM31Sa5i1Dw4fpzI8MSwbXHINPB6zalH
 7d3icBXGTJsc6rSrJdjqrM/VeqWxvlEkRwJFbMDBwD6UFJUJQvuozKURqK3ajLQgSUxG
 ScVS7f3/6JmhU5lmjcEFoul05NVI6hwTDSk72D35b/Uw+/1LfPbCfnbhFEsrvWZ9N71d
 mSIynpvfNY62TXuaIBZ4AUUyjLV2aM4Z0kc2I5bhdB9tN1593mavsxhOe4bviU5dviXC
 pHRA==
X-Gm-Message-State: ACgBeo2ZMZLpJ7U7D3ZmLt4aly95GsMiDViC2RkknwjKCUF72+v6FhQQ
 HEzktAPe7gQhpSAF4v5T+v0=
X-Google-Smtp-Source: AA6agR5153oYV8kafc+i58iRbni/4o0+HJFRM9ywzhXxF6J2iekcXpA4igafMBRomyjZJGm0DD3PGA==
X-Received: by 2002:a17:906:9752:b0:738:364a:4ac with SMTP id
 o18-20020a170906975200b00738364a04acmr8730502ejy.759.1660651432330; 
 Tue, 16 Aug 2022 05:03:52 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 op9-20020a170906bce900b0072b810897desm5209994ejb.105.2022.08.16.05.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Aug 2022 05:03:51 -0700 (PDT)
Message-ID: <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
Date: Tue, 16 Aug 2022 14:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robdclark@gmail.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
Cc: kernel@collabora.com, dri-devel <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Am 16.08.22 um 13:44 schrieb Dmitry Osipenko:
> [SNIP]
>> The other complication I noticed is that we don't seem to keep around
>> the fd after importing to a GEM handle.  And I could imagine that
>> doing so could cause issues with too many fd's.  So I guess the best
>> thing is to keep the status quo and let drivers that cannot mmap
>> imported buffers just fail mmap?
> That actually should be all the drivers excluding those that use
> DRM-SHMEM because only DRM-SHMEM uses dma_buf_mmap(), that's why it
> works for Panfrost. I'm pretty sure mmaping of imported GEMs doesn't
> work for the MSM driver, isn't it?
>
> Intel and AMD drivers don't allow to map the imported dma-bufs. Both
> refuse to do the mapping.
>
> Although, AMDGPU "succeeds" to do the mapping using
> AMDGPU_GEM_DOMAIN_GTT, but then touching the mapping causes bus fault,
> hence mapping actually fails. I think it might be the AMDGPU
> driver/libdrm bug, haven't checked yet.

That's then certainly broken somehow. Amdgpu should nerve ever have 
allowed to mmap() imported DMA-bufs and the last time I check it didn't.

Regards,
Christian.

>
> So we're back to the point that neither of DRM drivers need to map
> imported dma-bufs and this was never tested. In this case this patch is
> valid, IMO.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
