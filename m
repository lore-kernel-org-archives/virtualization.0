Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65317C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D3A6103C
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3D3A6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B50C981D65;
	Wed, 27 Oct 2021 20:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJCmTxsSYSzO; Wed, 27 Oct 2021 20:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8763080CF2;
	Wed, 27 Oct 2021 20:16:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC4AC0019;
	Wed, 27 Oct 2021 20:16:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 601EEC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4296181D5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5K97fpdnlsH8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B29580CF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:23 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id i14so5172233ioa.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=LjqtuKqFcXICmEO8DHfW9oWVMqViCZUkTv+u2qOQRJE=;
 b=KuMjthfzFhs0jK3AOFpblR8xZlZVm6q0z4TLSnjUhqXDXOi4Ll6dDA2+z6kI+9lIYa
 w5P2ygcPS4qczrFtKPmS7Ccg4ws2sZpgU26vVHDpHsS8/uOcARKoqvAxOEUM/hbqiHaK
 zhEzcjDMEOZhMNyCQLQCK0YCLJwL9q0v6xK5BynD6Y6gSFi+noyloZUHcltMIac7N9Fq
 XTELJqnhHRsSs4NTmmZkKQ8kGQyqA7+O9hqu0dZ7Ncho0W+bOpvSwg8oly13QvVjJsiq
 s4win3Lo+0ss2ww17hLS4GwWuO28c+/ewZMhfksh0fuXQC86RNsY9yt6UvmIs5zGieHX
 4xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=LjqtuKqFcXICmEO8DHfW9oWVMqViCZUkTv+u2qOQRJE=;
 b=Xbw7j4s4TO7eDwb35YWfzjepqBIwOyEwdn07Qu4Emv9f5Tge01UfCoe0meF3N4emqn
 zs+waUO8hvZW2TV8rWTBmLV+B/YHP1zE8X9PVUvCGiU0NV5+7RHDuzZ+LGFZKY/LbSg4
 hTfOpinvslhG2fJgCUNk+vG1oW4Q8DIiYmT31TrgaaGwoBhqOd6Z5LFgq9NRAJy1yZJ1
 FBNJLd83udkYPKI9VcgV/qrAvUEvLe17F78//CL12QUy1RGX0MljjgMtnVOd7JdhRWYA
 ygW6UJ478uDx3OHjIIb9SfEsuanou+IYLlndWk/LdrIQ7aKhVhbiaGuheT8ekFhPsfXh
 nn+g==
X-Gm-Message-State: AOAM530qYUerJA0y7xaUJc56P4iVB3nK9AS1Fk7Syak+VSeaWYq08zj1
 s7A1rBTaTTWo5dyKk+hz5QURXw==
X-Google-Smtp-Source: ABdhPJzjKGWTU7Qj+ZS/+X6wIjVKvNDsihkCZ+0ht8OW7V4lQgdI5hSbFvSWgvIzOVN/9L+2pQ/5LQ==
X-Received: by 2002:a02:8484:: with SMTP id f4mr15430jai.140.1635365782499;
 Wed, 27 Oct 2021 13:16:22 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id j15sm513419ile.65.2021.10.27.13.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 13:16:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kwolf@redhat.com, hch@lst.de, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, Xie Yongji <xieyongji@bytedance.com>, josef@toxicpanda.com
In-Reply-To: <20211026144015.188-1-xieyongji@bytedance.com>
References: <20211026144015.188-1-xieyongji@bytedance.com>
Subject: Re: [PATCH v3 0/4] Add blk_validate_block_size() helper for drivers
 to validate block size
Message-Id: <163536578184.77381.1471415825529034425.b4-ty@kernel.dk>
Date: Wed, 27 Oct 2021 14:16:21 -0600
MIME-Version: 1.0
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org
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

On Tue, 26 Oct 2021 22:40:11 +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than
> page size yet, so driver needs to validate the block size
> before setting it. Now this validation is done in device drivers
> with some duplicated codes. This series tries to add a block
> layer helper for it and makes loop driver, nbd driver and
> virtio-blk driver use it.
> 
> [...]

Applied, thanks!

[1/4] block: Add a helper to validate the block size
      commit: 570b1cac477643cbf01a45fa5d018430a1fddbce
[2/4] nbd: Use blk_validate_block_size() to validate block size
      commit: c4318d6cd038472d13e08a54a9035863c8c160bd
[3/4] loop: Use blk_validate_block_size() to validate block size
      commit: af3c570fb0df422b4906ebd11c1bf363d89961d5
[4/4] virtio-blk: Use blk_validate_block_size() to validate block size
      commit: 57a13a5b8157d9a8606490aaa1b805bafe6c37e1

Best regards,
-- 
Jens Axboe


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
