Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F0DC4320A
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 16:31:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE4A60243
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 16:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFE4A60243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9801460AE6;
	Thu,  5 Aug 2021 16:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eQ71vjElNPMm; Thu,  5 Aug 2021 16:31:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1325660871;
	Thu,  5 Aug 2021 16:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0C8CC0010;
	Thu,  5 Aug 2021 16:31:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FEAEC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D84C404CD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SlDcjZ8LP_aR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:31:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86F1C404B4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:31:12 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id l19so10225163pjz.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 09:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hHUTsKDnxap0EiJI1vbHiNIpoH+R0H2TboThtqpCWSc=;
 b=qp2c4iX3pjW+yypBBMUPwW65hadEpXF/1U6lfgx7q3dU7FJNV2hSX5jQJdjiaglW2K
 LIPr7gS/1pDmJCd2LZfid5XhpfpTSEI5Ft7nWoJnoyMUdEJg59QwyvL042VU0SQK0hOI
 NkjwhjJ/gDnSqQap3EDISuL2lVPxebg6/qM9dvRx+EXxKwlQhjW8eRvg4dIQ6e6o795n
 nI2ApkQT3A13PAP8R9PLzHoTth08mmo9cj55K0HezzZ3ZSSwvN+Axf0FqhLth4XUpirR
 s+J7MGGndXS3XqOX/J4NkvkMcH8/qQS4omB5tmPKIDU3vt9GZgqqp7x4DF1g6iqZEefd
 FsEw==
X-Gm-Message-State: AOAM532w9AqB+H+Lmg28RCnc5RIH2KgJi68Yirc07Bfdh38fhF7YkQzt
 Xz9Ztvdm8OCbVBOPo+r5uiw=
X-Google-Smtp-Source: ABdhPJyCuisk5RzZy6da7AsZoR/DaZLZHn4oZn9ITXuwK2Rjv1pBKXahTV8aXSruiOZbF6hVQSA8vQ==
X-Received: by 2002:a17:90a:9f91:: with SMTP id
 o17mr15924247pjp.29.1628181071870; 
 Thu, 05 Aug 2021 09:31:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:1:93c2:eaf5:530d:627d])
 by smtp.gmail.com with ESMTPSA id r4sm6334361pjo.46.2021.08.05.09.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 09:31:10 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH 10/15] sd: use bvec_virt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-11-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8b487c0f-71be-19d6-249c-9cd1ba228548@acm.org>
Date: Thu, 5 Aug 2021 09:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-11-hch@lst.de>
Content-Language: en-US
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Ilya Dryomov <idryomov@gmail.com>, linux-um@lists.infradead.org,
 Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>
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

On 8/4/21 2:56 AM, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b8d55af763f9..5b5b8266e142 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -886,7 +886,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>   	cmd->cmnd[0] = UNMAP;
>   	cmd->cmnd[8] = 24;
>   
> -	buf = page_address(rq->special_vec.bv_page);
> +	buf = bvec_virt(&rq->special_vec);
>   	put_unaligned_be16(6 + 16, &buf[0]);
>   	put_unaligned_be16(16, &buf[2]);
>   	put_unaligned_be64(lba, &buf[8]);

The patch description is not correct. The above patch involves a 
functional change while the patch description suggests that no 
functionality has been changed.

Although the above patch looks fine to me, why has page_address() been 
changed into bvec_virt() in the sd driver? My understanding is that the 
sd driver always sets bv_offset to zero.

Thanks,

Bart.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
