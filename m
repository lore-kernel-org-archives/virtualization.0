Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52502C4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D693B60EFE
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D693B60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E7314028A;
	Mon, 16 Aug 2021 16:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqxogZ1wWGi0; Mon, 16 Aug 2021 16:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D3344023B;
	Mon, 16 Aug 2021 16:51:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6C24C0010;
	Mon, 16 Aug 2021 16:51:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44229C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 258B4402C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QHgUHKDIvEj0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:51:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7DA9402A1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 16:51:16 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id w6so27508921oiv.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lkHKKxx6E91blWpox1bXj/LIePIAFS6deUe/aal8ts0=;
 b=2M7PsQmoW0m68H0tIVJvrAROv1UoWp/uy48nnzobRrc03mo4J/lqcPLEQEF1kpJUHw
 HQBa4gX5fuTsQap76AZD/5O7VV8iT7vusfHhUAUKN78fP0BZSnTbz5bFFrpuEHica0IG
 vNOnPFWucI7QTNpQA0kxldWWTEaok+vCXtpMF9OBhganoAYTPaU0jWc3pk2ipYfiP3qw
 KJv7dYM9ZKsD48MEvHmMnjHIhntqyqYB/aLy5wa1Nk3VqVwfnK6sD7DQ+glML2iy7RW5
 8bKOFtNVZE+7XBNUsAmXKRXSN7yXiZDUd4eqzd5A6g+KiYc52tKP/BJj3qVXfxUmmZ/Y
 b/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lkHKKxx6E91blWpox1bXj/LIePIAFS6deUe/aal8ts0=;
 b=EvqDKec//9CUAK0866ebmz/jjGTF7PNYTgPngS49du/BO6ZikASg3VCsHe1Dc5t5VN
 Y5srA6c03m179sz15k3W2Xq05Ipjzt8pEmCrB721k3feQV8N3QnToIx4fXAXBMx1b7oI
 olkSa8W1RDwVYVlY97LUKV6VLc0y80Jz5nhdAZT+7FYx7kDASC1kpAwgThclyeri0bAn
 phNnZFnvA6SzmV2rXko1G+gzAC6Cvfdj9mDz3BX+LOYRFvNWy46dwYKJV/QWIG+4LJTI
 Y2Utg/IKzF1dxKZzHwsloLr2sB1+ItfF8cMwKIVkzFjARvsHdyHEecUkCvnSThKcKlfZ
 Tusw==
X-Gm-Message-State: AOAM533iG+/H+cDrumnZfNfgd1hG1PU5VnW3Wp4heW5rW4/8nPg+EHzw
 L36XVffqYMB6+Kz713VI9d6gNw==
X-Google-Smtp-Source: ABdhPJwPiJZucbHV+gTb5R7I/kfPLblHKKXb+EIub7hcvBOP41sFKxi/Q6epHu0YRXyVvO62JSl/PA==
X-Received: by 2002:a54:4619:: with SMTP id p25mr42850oip.5.1629132675579;
 Mon, 16 Aug 2021 09:51:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id u18sm2018498ooi.40.2021.08.16.09.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 09:51:15 -0700 (PDT)
Subject: Re: add a bvec_virt helper
To: Christoph Hellwig <hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4e321dab-188d-ca0a-a98c-4a587e7b5f27@kernel.dk>
Date: Mon, 16 Aug 2021 10:51:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
Content-Language: en-US
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Ilya Dryomov <idryomov@gmail.com>, linux-um@lists.infradead.org,
 Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>, Phillip Lougher <phillip@squashfs.org.uk>
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

On 8/4/21 3:56 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series adds a bvec_virt helper to return the virtual address of the
> data in bvec to replace the open coded calculation, and as a reminder
> that generall bio/bvec data can be in high memory unless it is caller
> controller or in an architecture specific driver where highmem is
> impossible.

Applied, thanks.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
