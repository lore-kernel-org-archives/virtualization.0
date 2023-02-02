Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C0FC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 15:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9323340C93;
	Thu,  2 Feb 2023 15:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9323340C93
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=67VAyORv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnPz6xay6PNX; Thu,  2 Feb 2023 15:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E350440120;
	Thu,  2 Feb 2023 15:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E350440120
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6641C0033;
	Thu,  2 Feb 2023 15:46:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 155D1C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 15:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7B384098F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 15:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7B384098F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=67VAyORv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2h6Iy1qlbZtb
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 15:46:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA74740901
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA74740901
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 15:46:43 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id me3so7137466ejb.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8Gc65aUVwApOeHyeBrWY9LnhCMXXP4ZkreA7OeG+4U=;
 b=67VAyORvNbOtmnWVjQlursOQbEnRpUIb8PQ29AvrnI1ROHyz3Be78spBGFafB30mz6
 wKlDF18QRYFQa5RUBVcuLuF7jvYPaACSnz65hTDC9su12QhMbeMgwsmkkpFLaq8hVuzT
 7ngvN5B8r5K9/2C6qtC+rjJqxpxPPJC1RYheRSddhGmeBCsvd0cF5A2qydhTiJV7cGvq
 v9CbrDoLpItIonop4Vn7OYpk9qjRADcHiMQNgbWTiaqmQU6kHx50EgiolP3kToc0rGyU
 G4VhAQKISk5qG7hnEkVbahol2M4AFU3yyaLilHmzVc+0i2n4SqMTU/cARtECLPEIElkV
 8AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8Gc65aUVwApOeHyeBrWY9LnhCMXXP4ZkreA7OeG+4U=;
 b=NbfJ5a4KTihTl40ArEBln9bx0yoxB1e7+KLCmnUf3KJ8RJj4jvQZ5UBQ+VkCp2IFh2
 BV4SjJlamjG05lzXU3Pc88jVFpu+1eKAoHkRIIQK0E88TXBKHIXt2UemixTckLO9PvWu
 GnXY7MBZLw3/CJCnvLWmQgKCwy/3Reym2havY4Rpg8KAtZ2dzllN1weFPoKAaiEPcTw4
 S49kt12gEo4tMuEVYc5vqu4Lxtbeq2NYwv18CJHpCtRnSbtGJsqMxgR1QoYEHiEfEuRW
 2erSODIOEYlIEiDg1HZ7C4MFUqNpmEaLGkshAo/41dr/I/LGq0L04FhpahOC/HwnD6Ej
 k/VA==
X-Gm-Message-State: AO0yUKWPSGlCOy66DPTSzXL0/pipB6y/Y9F+RZROb2lUtwRrLkZpcdKK
 17LPOwVl0Pu6rEmpW5qCqBjL7g==
X-Google-Smtp-Source: AK7set/vvtOpJuh/J1KX2g79Jkm9KHWdxwyC+o/qD9/dF5IauAW+GhEbTVX1t0WBvGA2i55u+YWKLA==
X-Received: by 2002:a17:907:9c07:b0:88d:ba89:183b with SMTP id
 ld7-20020a1709079c0700b0088dba89183bmr2463211ejc.12.1675352801454; 
 Thu, 02 Feb 2023 07:46:41 -0800 (PST)
Received: from localhost ([86.61.181.4]) by smtp.gmail.com with ESMTPSA id
 t12-20020a1709063e4c00b0088a9e083318sm5477031eji.168.2023.02.02.07.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 07:46:40 -0800 (PST)
Date: Thu, 2 Feb 2023 16:46:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-net: Maintain reverse cleanup order
Message-ID: <Y9va33VLJ/eRPUbW@nanopsycho>
References: <20230202050038.3187-1-parav@nvidia.com>
 <20230202050038.3187-3-parav@nvidia.com>
 <Y9ur9B6CDIwThMN6@nanopsycho>
 <PH0PR12MB5481C0C7E46B5DFF85178792DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481C0C7E46B5DFF85178792DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
Cc: "hawk@kernel.org" <hawk@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

Thu, Feb 02, 2023 at 04:10:56PM CET, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Thursday, February 2, 2023 7:26 AM
>> 
>> Thu, Feb 02, 2023 at 06:00:38AM CET, parav@nvidia.com wrote:
>> >To easily audit the code, better to keep the device stop() sequence to
>> >be mirror of the device open() sequence.
>> >
>> >Signed-off-by: Parav Pandit <parav@nvidia.com>
>> 
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> 
>> If this is not fixing bug (which I believe is the case), you should target it to net-
>> next ([patch net-next] ..).
>> 
>Yes. Right. First one was fix for net-rc, second was for net-next. And 2nd depends on the first to avoid merge conflicts.
>So, I was unsure how to handle it.
>Can you please suggest?

1) Send the fix to -net
2) Wait until -net is merged into -net-next
3) Send the second patch to -net-next

>
>
>> 
>> >---
>> > drivers/net/virtio_net.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> >b7d0b54c3bb0..1f8168e0f64d 100644
>> >--- a/drivers/net/virtio_net.c
>> >+++ b/drivers/net/virtio_net.c
>> >@@ -2279,9 +2279,9 @@ static int virtnet_close(struct net_device *dev)
>> > 	cancel_delayed_work_sync(&vi->refill);
>> >
>> > 	for (i = 0; i < vi->max_queue_pairs; i++) {
>> >+		virtnet_napi_tx_disable(&vi->sq[i].napi);
>> > 		napi_disable(&vi->rq[i].napi);
>> > 		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
>> >-		virtnet_napi_tx_disable(&vi->sq[i].napi);
>> > 	}
>> >
>> > 	return 0;
>> >--
>> >2.26.2
>> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
