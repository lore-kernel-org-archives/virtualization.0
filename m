Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B5C433DB
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 07:01:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840DB224DE
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 07:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840DB224DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0688823115;
	Mon, 25 Jan 2021 07:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1NgZsE7txd1; Mon, 25 Jan 2021 07:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 90BAB2107F;
	Mon, 25 Jan 2021 07:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75D4FC0FA7;
	Mon, 25 Jan 2021 07:01:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5936C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 07:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC30C86B21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 07:01:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Om6buwLOcZmN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 07:01:13 +0000 (UTC)
X-Greylist: delayed 05:37:03 by SQLgrey-1.7.6
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6A3E186B0F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 07:01:13 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 30so8280304pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 23:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yCVXNmnkbukJI6FbnBMkRVDM8J/Lut2yGB3GCl5tMhk=;
 b=mUc+2GmhUCQFtGXsbDdMUePaHUC70SqcjIvNUGzmQAMRmDih05IYA/pLKTv5cpBUJg
 8D4F5NWSJKzdXYHX3tUo/gpur6bsvJgO0jl+aDqenyGk4M3crlQnK9+R3fse9TDvl9Kg
 PDvjAjdRxv7sEQky3VyreBHgThr+GzpCJW1XuWOAUmcO51X0t91JXgwFck88xc5IXzZ7
 kcZMpDwGdq/6TX1yaFTbsmRuAy8Q+Bd9qAymHynKCsDAhhvlHsCRTzF+gutiHWy4k037
 tg1DroGlhRJAHLuCAeOG6dOO/t8s4/8RlUz8Nd7VLJNZUmhsSiwItgtDZcoPgaKB9O6D
 PMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yCVXNmnkbukJI6FbnBMkRVDM8J/Lut2yGB3GCl5tMhk=;
 b=KSiBeQG+ttRYebqXsG5sSpcedDJRXcNVE1LtDm4RzGlimPhIzgAU1HdjzAer5HFE28
 JZNcPjfQf1e/S5enDmdzi+QdSsGH8s2G3mPVXNp5rO7JOfSQ4yvx8ecX/Q7Zh88c8xH3
 kslY7wXLfyZ/6nf3WXZureenbf7HwTlP5ORS5XPNZgAz9o68TCINPr5kSgfJpS9Cp1qg
 2kbGruaKQYpYh4qtwVSqxI4kTV1gQzzGqqU94XgozMQbhiwZV1LCOVPI+p/hxYAP7hPT
 /HQuba1elS6b36GI2XMKnqiellXsKTlYLzrV8tTwmWYMI0UK1sYoxfwezxKU6fKJVJwn
 g3Dg==
X-Gm-Message-State: AOAM533Pb2TO0N7j9dtR0RNQ9p4yy8SZ76WpuGlHqswRD1tZwTxwDRDU
 CRVVyELZDYvl2QZLolm1xmNa7XdaIViXPA==
X-Google-Smtp-Source: ABdhPJxH9fkoQGdpf2yTn0S6RVjDGgTIT95lILem9Ftm+wTQRagGEoMXbOUbGd2ZD+OyyhreIN7wUA==
X-Received: by 2002:a17:902:b285:b029:de:a0a3:f3b9 with SMTP id
 u5-20020a170902b285b02900dea0a3f3b9mr336676plr.34.1611550412389; 
 Sun, 24 Jan 2021 20:53:32 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 68sm14877443pfe.33.2021.01.24.20.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:53:31 -0800 (PST)
Subject: Re: [PATCH V3 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <50c4cdb5-b5ea-5431-c319-a6784f33f8b6@kernel.dk>
Date: Sun, 24 Jan 2021 21:53:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
Content-Language: en-US
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org
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

On 1/24/21 9:49 PM, Guoqing Jiang wrote:
> V3 changes:
> 1. rebase with for-5.12/block branch.
> 2. add Ulf's Acked-by.
> 
> V2 changes:
> 1. update commit header per Christoph's comment.
> 
> Hi Jens,
> 
> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
> Also update the comment for blk_execute_rq_nowait.
> 

Applied, thanks.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
