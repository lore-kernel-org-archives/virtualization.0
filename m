Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1640EC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 16:48:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F067664F04
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 16:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F067664F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74CD16F5E0;
	Wed, 24 Feb 2021 16:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZQITJP_ROOX; Wed, 24 Feb 2021 16:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01B896F5FF;
	Wed, 24 Feb 2021 16:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6A6DC000A;
	Wed, 24 Feb 2021 16:48:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AE94C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 16:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5707A4ECA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 16:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ypXYFg4vB_D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 16:48:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0574A4ECA6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 16:48:24 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id z13so2668381iox.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1+mpX7zx0n4pKPlEw3hBAnsSTnEgaecbMXBQXh8Z37U=;
 b=bJRnx9a0JrFxWlYgyk2jyiRpJPQJNXNMPWbL5EnUxyVSch3NY812m+zPkaOOeQG9gE
 rs0rCo0fJuj/glleu3wdzyZ1sbMyHYwsV5BHTbcMpvcNSEN1VzYR9JpF1EJFbPokIpRP
 pQFA9x0cFcUm+wj/d9C7MittCB6Pzu9NBrIWj0+f0KwN2z25gJ9NY8wag2SjQO0ua0ev
 ZVb26i7aH9IF/twGU677bbnoqNxjoX/YznSaZOR126/+xhxo8OHS4QMUdKCTDjp0BRQo
 RNRen7wNfFOzqDylSea/+a0RlJ08r6OWvecZNFxJhZUCe5oZYOK06fy2FnZ88SyWM37D
 dX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1+mpX7zx0n4pKPlEw3hBAnsSTnEgaecbMXBQXh8Z37U=;
 b=gER5BAM636QVIDeVELMvqwGHB6VSLFebjLL3SaAGj89WgEke+Vgodo0L1FgEOUCSHF
 4lyg+0DYtt/EBdsmcpadxfVa64nMrHh4IjTvvEb2U3oTBNbwipSKxIRfTtCJE4AqcvfB
 fbzYOKaLT+6xdY1JRcIHBXymRMD+oV6puh7B1s/3rX812KNfWKEPr4tMD+4n0CM3aMRB
 ZAmA5I8zn3xglNbhOA8b7CeVj+gWXHTnSfkAzaHYPweTKaGuTYw+8qtjadKf/UNKpjGk
 BjC2fBdaoSs+yoUFkMHCmIB3D5pWvktKHK4i+KvTeNHPxuHDPux1/fTzpw+eBmSJ8W/a
 6bDQ==
X-Gm-Message-State: AOAM530A0fGPkRrxT5O04xpfI3anZks2HKB1BgAM3OZdBJeTbZYTiIzK
 I+FaXv2snmAV9bDxhfFdGhGdvw==
X-Google-Smtp-Source: ABdhPJwss97019ILy/7qQcv1GNjekopW38KQaiSTkiRj6pTu3XozM6UbMn7yxILO9vbNkFv7yo9ZjA==
X-Received: by 2002:a02:1c49:: with SMTP id c70mr34122809jac.136.1614185303233; 
 Wed, 24 Feb 2021 08:48:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id m15sm1760501ilh.6.2021.02.24.08.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Feb 2021 08:48:22 -0800 (PST)
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
 <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
Date: Wed, 24 Feb 2021 09:48:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
Content-Language: en-US
Cc: snitzer@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bfields@fieldses.org,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, target-devel@vger.kernel.org,
 alim.akhtar@samsung.com, agk@redhat.com, beanhuo@micron.com,
 stanley.chu@mediatek.com, linux-scsi@vger.kernel.org, cang@codeaurora.org,
 tim@cyberelk.net, dgilbert@interlog.com, vbadigan@codeaurora.org,
 richard.peng@oppo.com, jejb@linux.ibm.com, linux-block@vger.kernel.org,
 avri.altman@wdc.com, bp@alien8.de, jaegeuk@kernel.org,
 Kai.Makisara@kolumbus.fi, linux-nfs@vger.kernel.org,
 martin.petersen@oracle.com, baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp,
 chuck.lever@oracle.com, zliua@micron.com, pbonzini@redhat.com,
 davem@davemloft.net, asutoshd@codeaurora.org
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

On 2/24/21 4:53 AM, Stefan Hajnoczi wrote:
> On Mon, Feb 22, 2021 at 01:11:15PM -0800, Chaitanya Kulkarni wrote:
>> The function blk_put_request() is just a wrapper to
>> blk_mq_free_request(), remove the unnecessary wrapper.
>>
>> Any feedback is welcome on this RFC.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  block/blk-core.c                   |  6 ------
>>  block/blk-merge.c                  |  2 +-
>>  block/bsg-lib.c                    |  4 ++--
>>  block/bsg.c                        |  4 ++--
>>  block/scsi_ioctl.c                 |  6 +++---
>>  drivers/block/paride/pd.c          |  2 +-
>>  drivers/block/pktcdvd.c            |  2 +-
>>  drivers/block/virtio_blk.c         |  2 +-
>>  drivers/cdrom/cdrom.c              |  4 ++--
>>  drivers/ide/ide-atapi.c            |  2 +-
>>  drivers/ide/ide-cd.c               |  4 ++--
>>  drivers/ide/ide-cd_ioctl.c         |  2 +-
>>  drivers/ide/ide-devsets.c          |  2 +-
>>  drivers/ide/ide-disk.c             |  2 +-
>>  drivers/ide/ide-ioctls.c           |  4 ++--
>>  drivers/ide/ide-park.c             |  2 +-
>>  drivers/ide/ide-pm.c               |  4 ++--
>>  drivers/ide/ide-tape.c             |  2 +-
>>  drivers/ide/ide-taskfile.c         |  2 +-
>>  drivers/md/dm-mpath.c              |  2 +-
>>  drivers/mmc/core/block.c           | 10 +++++-----
>>  drivers/scsi/scsi_error.c          |  2 +-
>>  drivers/scsi/scsi_lib.c            |  2 +-
>>  drivers/scsi/sg.c                  |  6 +++---
>>  drivers/scsi/st.c                  |  4 ++--
>>  drivers/scsi/ufs/ufshcd.c          |  6 +++---
>>  drivers/target/target_core_pscsi.c |  4 ++--
>>  fs/nfsd/blocklayout.c              |  4 ++--
>>  include/linux/blkdev.h             |  1 -
>>  29 files changed, 46 insertions(+), 53 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fc60ff208497..1754f5e7cc80 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -642,12 +642,6 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
>>  }
>>  EXPORT_SYMBOL(blk_get_request);
>>  
>> -void blk_put_request(struct request *req)
>> -{
>> -	blk_mq_free_request(req);
>> -}
>> -EXPORT_SYMBOL(blk_put_request);
> 
> blk_get_request() still exists after this patch. A "get" API usually has
> a corresponding "put" API. I'm not sure this patch helps the consistency
> and clarity of the code.
> 
> If you do go ahead, please update the blk_get_request() doc comment
> explicitly mentioning that blk_mq_free_request() needs to be called.

Would make sense to rename blk_get_request() to blk_mq_alloc_request()
and then we have API symmetry. The get/put don't make sense when there
are no references involved.

But it's a lot of churn for very little reward, which is always kind
of annoying. Especially for the person that has to carry the patches.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
