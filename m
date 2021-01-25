Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ACBC433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 04:40:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE35622472
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 04:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE35622472
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 54CB920503;
	Mon, 25 Jan 2021 04:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNjwDxmHjCYL; Mon, 25 Jan 2021 04:40:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0874C203A2;
	Mon, 25 Jan 2021 04:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DACC5C0FA7;
	Mon, 25 Jan 2021 04:40:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C70A5C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C2AF1203A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvluPO2rqYod
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:40:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by silver.osuosl.org (Postfix) with ESMTPS id 1E7B8204F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:40:47 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id f2so8484501ljp.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 20:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
 b=CfOwQ7limljMA7zl/lIAXVsTIKtNDlhwsicqotNl3TtlKhEjyZeIlEEJtHYW4c2U31
 UY4hC8hbmTVMaTURi/h7AUevTqeIqn+Q1FFnUUJ35BV9ke4apIRUY5I8NbeB8KXYicfU
 +trWj06hwAqSeMB9yfxG8wvJYR9/caMYTWeGkZl5KTSBZfynGCBz84SyjX0hbk7AWcGA
 /222IeHt9HOYYROpDQ0wb25k1uTdAAL1nhrslb3U6So17SP9tJY8mfEDx1CUbEE7qC63
 qpRcjNyJveRtr7uQu1UM1fJCkiAbkBaCmTSnXoAaT+i+isB4hYXJxGmrbyMs7d8MUbF7
 BPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
 b=Kar6TDZgrU9ksp9hsxz9ZgT8B398mr32yrp7zB/VpzwWfQZ8FtprNWIXhNxT5rvezG
 gWIoeiVMughN82O8jyBLTbeKXUOGqUyvWk5xgf2NChYC1r8QCaAILp2Qsb4xD3+ILYwG
 OozEeSxzoDag7TztF1KuAq/3fW5T1xlJS6OlZpTS49GriTx8xdtG1QOYiNxB4SJ6dsA9
 Q7xzF2NaWYbJ+/koutU075LS9933zUIpHJoW2ps4zkKtxblOK9sfi5RT99QtyGqU3dbC
 pUBt0hoPKF0J6ohLwrfP541f5/L/2D5O64OYSPTeT4OyjJJ8xNPcADpbYkr3lmhHVg5r
 aTmQ==
X-Gm-Message-State: AOAM533asVlIK8lRgRxkKTYDsVQB/nxh/5ls0B9QyOzF5yd/qbkJ7WD0
 vTgGyoRohL/+oW9Y7N7h4LpNQ9oterP0ig==
X-Google-Smtp-Source: ABdhPJwcVIfcZhKpz36wBWgY9pEAr1Osy03vWby4EQev/6n4B5mRbyHylHT/8WSUq/UooHKSU12Q8g==
X-Received: by 2002:a17:90a:1c09:: with SMTP id
 s9mr6518112pjs.83.1611549310994; 
 Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
 by smtp.gmail.com with ESMTPSA id x21sm15191515pgi.75.2021.01.24.20.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Subject: Re: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To: Jens Axboe <axboe@kernel.dk>
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <73fd70be-90bc-9c6c-dcbe-7981f8fef4f5@cloud.ionos.com>
Date: Mon, 25 Jan 2021 05:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
Content-Language: en-US
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
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



On 1/25/21 02:24, Jens Axboe wrote:
> On 1/22/21 2:28 AM, Guoqing Jiang wrote:
>> V2 changes:
>> 1. update commit header per Christoph's comment.
>>
>> Hi Jens,
>>
>> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
>> Also update the comment for blk_execute_rq_nowait.
> 
> What's this against? The lightnvm patch doesn't apply.
> 

Sorry for that, will resend against for-5.12/block.

Thanks,
Guoqing
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
