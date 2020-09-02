Return-Path: <SRS0=yxq9=CL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E35C433E7
	for <virtualization@archiver.kernel.org>; Wed,  2 Sep 2020 14:02:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E442078E
	for <virtualization@archiver.kernel.org>; Wed,  2 Sep 2020 14:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DEE5OKKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E442078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA50E867F8;
	Wed,  2 Sep 2020 14:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VlkWuKDey4DQ; Wed,  2 Sep 2020 14:02:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2215C85725;
	Wed,  2 Sep 2020 14:02:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE78C0052;
	Wed,  2 Sep 2020 14:02:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74E9DC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 14:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5ADE986791
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 14:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aN+P599jJS+u
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 14:02:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2FA5785725
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 14:02:51 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id r9so5897238ioa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Sep 2020 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ku7e+DesYlsL/c7k5HJw65rc3jrpfmGqzPu51jyJxJY=;
 b=DEE5OKKGh1r8VHsSbRDOHXyr0EY/JZmo9R9NjqSjJKawRaCP4hU7gd7TYcJP/9YZM7
 f9ePonEEbp/l91A6T4zFQxTQLDeZxmy0LMYDoRrMahsz8WSo30cFpFYAnwscMWxFdIlp
 oD8CXLDbgxFmE3UimYbtHYWaCjvm1HLjDP1Jf/oc196Q0dgg3xrDzjQ3BN32QyrfzGEu
 BAA+ZfhsIf58ZQsISLcJD7bVqjEF28U7NRblbSxZYn9AOlHAjsBMyhDBaU/uxguqX2OT
 X2fZVbjEQa6505uyiqaXXm9chdV79wx7RHjRntV/V2w1d3oytjJ926JWuLbQ8ZonRWBw
 7Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ku7e+DesYlsL/c7k5HJw65rc3jrpfmGqzPu51jyJxJY=;
 b=at8d57KbowRSexdnku8DbwP3gs4gghllHf7Odlx5GWJJOTv/vYWcg7xYFe23FbvuKc
 YIN4O6TdG9FBDCK4JTbbLC1hJjfhpmeW/2R/t7YMRtkrdgUqP1qv80WgHOfq5szl5YFN
 xMHqceyXCdCO2atRHCtks+VckScjRDF+alTcrAfdh3ID07E+OVDCJTOqMNH1kCfJDuTT
 FzvlV1fOLuo2epygHhuFNnCDLEPJ962252X0OtGZbIzySUKiWhlV/X1FQxj+/R3BcPAr
 5b+9LeWwVR2igVhFhBHZbx/6bNFRmqkSZUZgkgCSA4bsJQ1nXvhzW3fCai5ROPMZHPhT
 yFSQ==
X-Gm-Message-State: AOAM530zL7l+hwTSYWaYT97TmpgQiI0tNy5Y8bx4dv9oeR5jr15LxPc7
 BM7MseyCALQdUXzsjwvnfU6R8w==
X-Google-Smtp-Source: ABdhPJxFrZXWesZv0xLmVsuUB1MDZ450c11yMQmgXL3dPEcVh+WgJjGeEIGPOaG+O49/dxLkaoYMdQ==
X-Received: by 2002:a05:6602:2043:: with SMTP id
 z3mr3472576iod.93.1599055371125; 
 Wed, 02 Sep 2020 07:02:51 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id s10sm616030ilo.53.2020.09.02.07.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 07:02:50 -0700 (PDT)
Subject: Re: remove revalidate_disk()
To: Christoph Hellwig <hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78d5ab8a-4387-7bfb-6e25-07fd6c1ddc10@kernel.dk>
Date: Wed, 2 Sep 2020 08:02:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
Content-Language: en-US
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
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

On 9/1/20 9:57 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the revalidate_disk() function, which has been a
> really odd duck in the last years.  The prime reason why most people
> use it is because it propagates a size change from the gendisk to
> the block_device structure.  But it also calls into the rather ill
> defined ->revalidate_disk method which is rather useless for the
> callers.  So this adds a new helper to just propagate the size, and
> cleans up all kinds of mess around this area.  Follow on patches
> will eventuall kill of ->revalidate_disk entirely, but ther are a lot
> more patches needed for that.

Applied, thanks.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
