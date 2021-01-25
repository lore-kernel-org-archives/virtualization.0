Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12615C433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 04:41:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A58722472
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 04:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A58722472
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23A3486B8B;
	Mon, 25 Jan 2021 04:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHQC37iygC4g; Mon, 25 Jan 2021 04:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6356086B89;
	Mon, 25 Jan 2021 04:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45A6DC0FA7;
	Mon, 25 Jan 2021 04:41:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E15A5C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DDD9F85C2E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ahrEiqKd9KHx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:41:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 681D885C28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:41:47 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id b10so13688935ljp.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 20:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FijkUVA4wtqEzKdrwPNqr5BszwjDE0ObYH72kW/p/Qc=;
 b=ba/PQSHzp1XMXEYfaF8IHUMMLul1kjomGVtf+iR7PS5f0N91qzg13X0RZJ97PPA0Vh
 2RdglhLdiBxokgZLrklGFKw5elkOv9IMkxXL0wir8HcRac0waGN3dSgDWP5u3/F7/Cgi
 zYenYmfFAphreQtQ6crnNkJJn2bJDNx+iWqrZ9M/3gKEPnNx6sQ/UjR6GyJB8zRxqnDY
 8AoCDP3zaCxdj45M0aZ0vmEL3zsal3fLpbCh9fg8FUjTPIm99GyHz5AH1S6u4wgID8kS
 qSTr2uI9gX38rFZ2+qHIncgSSpsuO7n+wVQHBnvHeHyyCbF6tB6X6fJpGBFJ/5ws39Hs
 f7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FijkUVA4wtqEzKdrwPNqr5BszwjDE0ObYH72kW/p/Qc=;
 b=mrTRFd441KkKYxl99+gIB4JN7nuqoF3pjDoWLRpMoiakDNDBR9cDfH1qF+Ocs2YNlf
 YAglq4rle7pITBjU/lRATt/wS0lCoZO6JoTeT0aWfNZOdUkeYO8jVC1SWt0FZuu1ISay
 efmwYynvhamy6wddW5JwAnZlJHMOfxh6ukVW74fpa5nlFjB1WPEEXhGZnRQgDMfJPp6j
 PhvJK7pNL3HgcfVmMcHQFodBRi0bf9Jt5K4gZqXMFNnhuoSjCYuwlafr0Pg4U8ATPJTC
 dcTp382TSSZSDHLWgV066ccD2jd4iI2686rnLsQr9entd75C42241wZrRagpBORq+pj9
 CkCg==
X-Gm-Message-State: AOAM533mWtYCNs3qbrEmh9nolkXjZrBidL9ETKtldUMwzEgehcpdajTi
 yW+yPHyxigROnIIG3Yn9datgJ2nhwrT4+Q==
X-Google-Smtp-Source: ABdhPJwqMLqKBZAD9FxC+3lNxtWNGWUkaLysCeumNlPXimZYcundbTEt00KrsFB9Hb+bWilXVtUrpA==
X-Received: by 2002:a63:d917:: with SMTP id r23mr1043183pgg.126.1611549378270; 
 Sun, 24 Jan 2021 20:36:18 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
 by smtp.gmail.com with ESMTPSA id k64sm14947157pfd.75.2021.01.24.20.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:36:17 -0800 (PST)
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from
 blk_execute_rq
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
 <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <439d415f-6aed-7092-a593-0d2d490652d2@cloud.ionos.com>
Date: Mon, 25 Jan 2021 05:35:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Content-Language: en-US
Cc: linux-block <linux-block@vger.kernel.org>, linux-nfs@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
 target-devel@vger.kernel.org
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



On 1/22/21 10:50, Ulf Hansson wrote:
> On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>> We can remove 'q' from blk_execute_rq as well after the previous change
>> in blk_execute_rq_nowait.
>>
>> And more importantly it never really was needed to start with given
>> that we can trivial derive it from struct request.
>>
>> Cc: linux-scsi@vger.kernel.org
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: linux-ide@vger.kernel.org
>> Cc: linux-mmc@vger.kernel.org
>> Cc: linux-nvme@lists.infradead.org
>> Cc: linux-nfs@vger.kernel.org
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> [...]
> 
>>   drivers/mmc/core/block.c          | 10 +++++-----
> 
> [...]
> 
>  From mmc point of view, please add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> At the moment I don't think this will conflict with any changes to
> mmc, but if that happens let's sort it then...
> 

Thank you! Will resend and add your acked-by.

Guoqing
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
