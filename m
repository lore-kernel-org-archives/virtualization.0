Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA88C25B06
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 23:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33F4B60EA1;
	Thu, 11 Aug 2022 23:04:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33F4B60EA1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tAYpw4CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YsEYK-zZ1bFL; Thu, 11 Aug 2022 23:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1996C60B8B;
	Thu, 11 Aug 2022 23:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1996C60B8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAA20C0033;
	Thu, 11 Aug 2022 23:04:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D55F6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 23:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B65B405B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 23:04:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B65B405B4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=tAYpw4CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JgqmVTvLyIYW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 23:04:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C453740593
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C453740593
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 23:04:04 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id 17so8814295pli.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=XV3d3jsQUJYVJchztvaIBQqSUAMrrh69qI/8EtCuYe4=;
 b=tAYpw4CDkWc6eiIf/KCP+KBGnVlg8ib0fvqDt5ayrPmOQ3UDOO3arWXihLT3hSbZKj
 1pdlYcKzB+T4+SasFbEJMHOq/hP4vIojAIE07EA0aHkak71KSWZBqg5GapGWPMtJLR+T
 GWQhqJ6aYuIolDRFFAQSA5ibYCoyfDyxmshgkCAZsT/x/Gq39TTr0V8mlZWHQNlKK+bo
 VtX3WQYPMJWzrLJmDLGqRrEz1l878YJIcYf9Aei5WQqWVRInY6G8UDjqe/rXnqPky2As
 vI59jAUyB/EIs2MwGoH2eStvS3NW2P0nzF4GRBOzPfpXoAezr8zzT3N5KjemNsHcQkk4
 GAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=XV3d3jsQUJYVJchztvaIBQqSUAMrrh69qI/8EtCuYe4=;
 b=3Cvm/KaJ2Rj0S7p0H4IBJTOb7TDcPHu2xcwjRCC8JHulxTvSaRF4wA5guFfFf16y2r
 hrFKI56ljdVnf2xEN0RlD/VMpM1kAGjMoa43r1eJEklj6oXADIrHssVrvfaUFygsXeoY
 tNjARA0WsYS6mwobIHjbg1aMj/TSzeY/LcqWtjLp2jyAg04hbltE1e7pak72j9EbZFfD
 VaOKHduWiKmeB/vbvG5l+4nFTS9EXwh/ki6OnLXZDpXenVug+PYY8S20DZgaPCwot70V
 S1w0AhuIK4J7zWBUAdEph2VTO+Gqdjqgy05TwbY/gG2wchYlEZzR8JKQf/2ALSFKFq2n
 A1kw==
X-Gm-Message-State: ACgBeo3yubX01sKj08lY0G6S3MEZp+G2ACzQtKQg96JjoAAynwfGMGpQ
 BurhI5QphHvFHLhclNRLdZZppQ==
X-Google-Smtp-Source: AA6agR7c5ZybC8xsrpjrvhBO6n0LEHYhEqXt4UG2OAj9R+Pf2rUxq/CaSStiRwn5gSOKfUmkZxXwJA==
X-Received: by 2002:a17:90a:b00b:b0:1f1:6023:dacd with SMTP id
 x11-20020a17090ab00b00b001f16023dacdmr10643291pjq.184.1660259043795; 
 Thu, 11 Aug 2022 16:04:03 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 w186-20020a627bc3000000b005289ef6db79sm232168pfc.32.2022.08.11.16.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Aug 2022 16:04:03 -0700 (PDT)
Message-ID: <05cfb9dc-c740-5764-35f9-b5636e0577cb@kernel.dk>
Date: Thu, 11 Aug 2022 17:04:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] virtio-blk: Avoid use-after-free on suspend/resume
Content-Language: en-US
To: Shigeru Yoshida <syoshida@redhat.com>, mst@redhat.com, jasowang@redhat.com
References: <20220810160948.959781-1-syoshida@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220810160948.959781-1-syoshida@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com,
 suwan.kim027@gmail.com
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

On 8/10/22 10:09 AM, Shigeru Yoshida wrote:
> +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +
> +	return vq;
> +}

Would probably be cleaner as:

static struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
{
	struct virtio_blk *vblk = hctx->queue->queuedata;

	return &vblk->vqs[hctx->queue_num];
}

dropping the 'vq' variable, and also dropping the inline as the compiler
will work that out anyway.

Apart from that minor nit, looks good to me.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
