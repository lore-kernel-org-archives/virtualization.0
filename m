Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692949;
	b=aHiSejPVmxty5MiuMU5FCBsiQe2DXMI7rWt2KyeBhDUyzw11KT4KXlXZmhjffmge9lzi
	 /TcALGK3bx1RZfDQXQywezoFJoNLWqmObFA5zOXJe7lII+5NmRKHEVls5SITFhLfma+Sg
	 T9+XHF6OFZPHpllw3t8qWr0OvWHm1Hfz/wKkI1AiFF2Gf7CJfdYIhAe/nUE3xBW7cQjDu
	 fJOpZ3914beJ/5qlz8xY1BlBvY8AUuNbp3sYkSC4l8B5DeRbtug6ArQNu5MLuO9TpIgZf
	 LYAR3kdCrSgQUkZ1f0HtKHz+ZaQHI+qNicnKO8yvCAvgS5wtaQS8VakKYVSCkZUkxlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692949;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=sfLMCaYmX3YFPpOD2Miw2+oapHdFlsXdhHabFRbBu7k=;
	b=Js9feJjRbrXyjsiHVxfPtM/h1XSPIx+UTp7GyVNMGA97M8ATXmkbvLYlfVZgRIaS8bPC
	 QbxvR0Yley4G5izHRYpoSgSgf6gJPu0Y/ZwV1OEwAKy4bGIsQv0luIMa4byZAMhg0oqvP
	 6bRTjmUA/lgo6xavH0Sly3puXuZ3G3zmRFWzn1RKruDvwYokKj4sffsQ80R9e/2hbaBRk
	 klJx9kWcnsKpLvg12LWVxvzatTv4kFsIqJfdPchDjpuSAwLaaymS+EzYcw8eqFaBgejUN
	 YXW5uC98KGQ6p0QxOe/DjdAJTIB49zZqzuxKpzkRGxtvJmlxvRkRq7b0XkJZOcwPqGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40667606A32C
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40667606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90D7068B05; Tue,  3 Nov 2026 09:02:23 +0100 (CET)
Date: Tue, 3 Nov 2026 09:02:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: hch@lst.de, mst@redhat.com, jasowangio@gmail.com,
	virtualization@lists.linux.dev, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, dlemoal@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in
 batched completion
Message-ID: <20261103080223.GA3975@lst.de>
References: <20261027150654.GA14436@lst.de> <2026102810270846959TfFOThssBqrSo1PlP9X@zte.com.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026102810270846959TfFOThssBqrSo1PlP9X@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 28, 2026 at 10:27:08AM +0800, shao.mingyin@zte.com.cn wrote:
> I looked into adding blktests coverage, and there is a structural
> problem. blktests cannot issue REQ_OP_ZONE_APPEND from userspace: fio's
> --zone_append goes through the io_uring_cmd NVMe passthrough path, so it
> never reaches the driver's zone-append completion, and zbdioctl has no
> append operation. blktests has no zone-append test today for the same
> reason.

Right.

> That does not fit blktests, which is a block-layer test suite driven
> from userspace. Two options as I see it:
> 
>   1. an XFS reproducer (e.g. xfstests) - the one that actually
>      exercises the append completion path, or
>   2. a blktests zbd test that covers a zoned virtio-blk with poll
>      queues, which would not reach the append part itself.
> 
> I am happy to write either, or to leave it if you think the coverage
> is not worth the churn. Which do you prefer?

We do have some blktests test that use a file system in the zbd
category (zbd/009, zbd/010, zbd/014) so I think we could do this in
blktests.  I.e. do a blktest that tests zoned polled I/O if we're
on a zoned device that support polling.

