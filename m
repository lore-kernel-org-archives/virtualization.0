Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A97C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 12:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C6C141C2D;
	Thu,  2 Feb 2023 12:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C6C141C2D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Wp6u18Mf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BeDEgmeYBsnu; Thu,  2 Feb 2023 12:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC8ED41C2C;
	Thu,  2 Feb 2023 12:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC8ED41C2C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8257EC0032;
	Thu,  2 Feb 2023 12:23:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABD95C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 865FC81F9B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:23:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 865FC81F9B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Wp6u18Mf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Df1t6FX3EHbw
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7EF781F99
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7EF781F99
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:23:25 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id dr8so5341912ejc.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 04:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RzzoO+rs1yXQRPvL9/DBCfoe2p63/8FVWLt7JufeGPU=;
 b=Wp6u18MfkGKleo4qBH7fw+Tkwy04f5VJQ+N9Jk3MqDbKmGmPdfCW7gagGQok8MunBu
 11DsDXSkV2TDlsM7VfdwXUFDqc6bkJheMyrlhRsWwAAZ3j+Y8PAf3p8qecPHBhqBnkc1
 favuuW7ARTeSNfMvVAYLiAQFxNf9pMySRkSLuIbSwCf1+xDdexoKiauKclkeOdqtjO+r
 lJDxDRhf3bNwx7+WIIs0fvZ3hGPGxAA8VtziC1GMCpUXJlp4fpKL5KlZZev2olf4DFq0
 CYicwjkQHTzmHi6hn4N9C1Rwy8Ot2rLCBKctwiDpnMg3tgtefZXsQ4ejPcCA1f3V2P3P
 t+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzzoO+rs1yXQRPvL9/DBCfoe2p63/8FVWLt7JufeGPU=;
 b=FGrfCh+AxPh42S7v3rp3QzkX36stwo/b9U438JgR/PQ6yXHH9DRch/Xrp8lSUlxv2R
 IOxU6YT3WtRxX1Y1Ls/ln8XxtveHV6XeSvws+BGz8Zh/IxcXafY7pq4s4Nv2eYK6umHT
 HMwY5ESqfKqLsLSklHdR58n2dLGQIg5+SPVPc9NnXdGC+QjnI8w3sVWNeaCkzzMYYGOx
 XRF/imZrwDjcF5GFHDPlkkIBigolpWecNtI1EaRoMzeJ/pADkNqN0DJRXXCCTae/ZclG
 Bf9wlpcvut6g42QExPvV2hirzYOU6ol0Mbd2xZAf4vVfXCIsGAEYjF/K6ABAOQEpISTk
 AbXg==
X-Gm-Message-State: AO0yUKV/xHk1B/YCEvQCAcXfj8/Pes/lu8XtHOUzoBtVS/Zkks6m0oWG
 cjMhHaBXStZuDXRmRUVO8OMvHw==
X-Google-Smtp-Source: AK7set+QuCGLAunyF8fXIbKSPCwmnjLycgzyZOx1URHO0SiCMyRsSdh+z5/KbEGvJ6v/8OKQmXx2ww==
X-Received: by 2002:a17:907:8dcd:b0:88d:5fd1:3197 with SMTP id
 tg13-20020a1709078dcd00b0088d5fd13197mr6933340ejc.50.1675340603570; 
 Thu, 02 Feb 2023 04:23:23 -0800 (PST)
Received: from localhost ([86.61.181.4]) by smtp.gmail.com with ESMTPSA id
 b18-20020a170906709200b0087bd2ebe474sm10084967ejk.208.2023.02.02.04.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 04:23:22 -0800 (PST)
Date: Thu, 2 Feb 2023 13:23:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 1/2] virtio-net: Keep stop() to follow mirror sequence of
 open()
Message-ID: <Y9urOpSJfCquaaI9@nanopsycho>
References: <20230202050038.3187-1-parav@nvidia.com>
 <20230202050038.3187-2-parav@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230202050038.3187-2-parav@nvidia.com>
Cc: hawk@kernel.org, daniel@iogearbox.net, mst@redhat.com,
 netdev@vger.kernel.org, ast@kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Thu, Feb 02, 2023 at 06:00:37AM CET, parav@nvidia.com wrote:
>Cited commit in fixes tag frees rxq xdp info while RQ NAPI is
>still enabled and packet processing may be ongoing.
>
>Follow the mirror sequence of open() in the stop() callback.
>This ensures that when rxq info is unregistered, no rx
>packet processing is ongoing.
>
>Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
