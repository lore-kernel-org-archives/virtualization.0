Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FEEEB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 14:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C32240353;
	Thu,  6 Jul 2023 14:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C32240353
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20221208.gappssmtp.com header.i=@kernel-dk.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=FMqh2Cmz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FvFD8xFAwXYg; Thu,  6 Jul 2023 14:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5400F4024A;
	Thu,  6 Jul 2023 14:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5400F4024A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23AB7C0071;
	Thu,  6 Jul 2023 14:03:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0816C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7CFC821CB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7CFC821CB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20221208.gappssmtp.com
 header.i=@kernel-dk.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=FMqh2Cmz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WU0UrXsImwbV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:03:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88D588219E
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88D588219E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 14:03:55 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-656bc570a05so152197b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688652235; x=1691244235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WhSDI9mp0MYKeqY0tJX7SergTVTmGv0F/ckbyNmGNLQ=;
 b=FMqh2CmzOm6XDjJjezWBlN875lQ5T+a7DnklQNymtU9D+p4Vamdg/lVJcXx5LK9wQB
 KMF3m7xyChwczs3gSrW0hfYLg6AHUOPg2tw1QHIcglCDiKzSYTOIQrtnMYep6XtsjIep
 DxJJ6tEz23KWKTCsBzXv4e2DMZK0tudoGmt64Vn23mE4w14gdIX8FajdCS/c+EBdj4BM
 OLhNcMy3ZYtdTw3gnyRZjxn7tMXpguxXzPohD9RzlAV02/2dZlziCIX9IP1zVTQgKS/1
 HI6e6TX7bpBdHRlpwO53EfTwR3UPufykmkpeAJRybBh5mzEiKnBBl2q/GqPD8Ytlw/Gs
 lsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688652235; x=1691244235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhSDI9mp0MYKeqY0tJX7SergTVTmGv0F/ckbyNmGNLQ=;
 b=FiYZ1Jz1VZHYD7T+7cFPwFfQWNfOrQrtHpKHfDPzdJJL6m4uhxGBw8ozavtVPaLIH3
 CJWY+nvEXHRtbdizLkjBwDE9W3EOhsaRE5Vhd3w+ccFajnglFTCqgFRp6q49c1spG1mP
 a0/+/1rTG3mfG0zcq2sc958fhv6fiQmlcHya2ZrzkaEPSAr0YUw5KMVThhV7CEb35BLo
 T+reAw0+lVCGDaf3XHkUM0BP7nQawNI3BzeOmLPbVRvOwORuvujmimt1FAcFWmqEf1qB
 PLnDB/WOp3n0rfEXFxlSUaxaNJj/iWz76cwIPvercEIBcPbdmlQ/W3HvPKkOOF84SgVH
 v1lA==
X-Gm-Message-State: ABy/qLYquXEN2C891aiPWFxfd/gf7c4jaXSEOmMBqPIoduY4nnC2R8tI
 1wef6Ey29LuguJgtjntJLB2ZBg==
X-Google-Smtp-Source: APBJJlHWx70FxXddJLp/svv44qJ/lHFgMni3NpkbFoqzcjvrqGi64yR8YRM3ydyDuI4xKaOrlEAb7Q==
X-Received: by 2002:a05:6a20:7495:b0:12d:2abe:549a with SMTP id
 p21-20020a056a20749500b0012d2abe549amr2182854pzd.6.1688652234613; 
 Thu, 06 Jul 2023 07:03:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b0063b898b3502sm1322987pfa.153.2023.07.06.07.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 07:03:53 -0700 (PDT)
Message-ID: <ec9b55b5-c64c-3ea4-9f39-128cd2e0a8ac@kernel.dk>
Date: Thu, 6 Jul 2023 08:03:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Fix max/min warnings in virtio_net, amd/display, and
 io_uring
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Yang Rong <yangrong@vivo.com>
References: <20230706021102.2066-1-yangrong@vivo.com>
 <CADnq5_MSkJf=-QMPYNQp03=6mbb+OEHnPFW0=WKiS0VMc6ricQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADnq5_MSkJf=-QMPYNQp03=6mbb+OEHnPFW0=WKiS0VMc6ricQ@mail.gmail.com>
Cc: Max Tseng <Max.Tseng@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jun Lei <Jun.Lei@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Airlie <airlied@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 Alvin Lee <Alvin.Lee2@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Harry Wentland <harry.wentland@amd.com>,
 opensource.kernel@vivo.com, Leo Li <sunpeng.li@amd.com>,
 Cruise Hung <cruise.hung@amd.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>, luhongfei@vivo.com,
 "David S. Miller" <davem@davemloft.net>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 7/6/23 7:58?AM, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 3:37?AM Yang Rong <yangrong@vivo.com> wrote:
>>
>> The files drivers/net/virtio_net.c, drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c, and io_uring/io_uring.c were modified to fix warnings.
>> Specifically, the opportunities for max() and min() were utilized to address the warnings.
> 
> Please split this into 3 patches, one for each component.

Don't bother with the io_uring one, code is far more readable as-is.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
