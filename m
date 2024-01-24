Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F5168A4
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079367; cv=none; b=WA9PxeFIuTIFvO4Zl3tTRKSAhvF/qGYbIchnQns334W103XIn00m0t+6NcUoSELR+Kp/8jycuS9xwBoZx0Wdzm9iHHXocK+oEDlV0cnwhDMMUV0fjzplYKpnCxk5SxITG19c5v9Zf6iomAV0f8rM8slc8GMBVHXKFvVwCieooZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079367; c=relaxed/simple;
	bh=84mheeLIV5OvsgNSnuTzM3cAJRb+GnOYb//jyYOY8Aw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ERD8UbWHEi3rblVTyp13RRGx0oKcWqib34gO94XmVSCUouhYay4W10XlvpKujilkRlbBFlH7CLvQM/eWWBE2bM9HWyMSxSuFsh+x/m5DXrxrL30rS06W9QWL14cyIewpARB6hbz+qVQV9M6dt7Ci/JexGhFai9KxTzYv9hmG4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3992F84DE3
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3992F84DE3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D_sCmTBla0Ih
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 06:56:04 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB4D984E05
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB4D984E05
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.FVw8K_1706079356;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.FVw8K_1706079356)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 14:55:56 +0800
Message-ID: <1706079325.4674435-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/2] virtio: set broken when re-enable vq fails
Date: Wed, 24 Jan 2024 14:55:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20231024034901.29839-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231024034901.29839-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 24 Oct 2023 11:48:59 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> In vp_modern_enable_vq_after_reset, we will do some check to ensure
> that the vq is in reset status. If that fails, the vq is good.
>
> If the vq_active_vp() fails, that means the vq is broken.
> The driver will can not use that vq, this commit sets
> the vq to broken.


Hi Michael,

Is this in your list?

Thanks


>
> Xuan Zhuo (2):
>   virtio_ring: remove unused code
>   virtio: set broken when re-enabling vq fails
>
>  drivers/virtio/virtio_pci_modern.c |  6 +++---
>  drivers/virtio/virtio_ring.c       | 15 ++++++++++-----
>  include/linux/virtio_config.h      |  2 ++
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>
