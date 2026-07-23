Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6747043B;
	Thu, 23 Jul 2026 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807091; cv=none; b=oisRnEAGH8/tUKlZsiAm5d7Mms6fTmjEWOMNOhbeNXFvj+ZGdPNBM4ykdyaosW4IdTxOeyD8aQNXbo7jFKtb4wI7YzU78ZGln7AIW/tRfuf3S+KEe0BEXvX6ayzxJrwYSJtib76261jYOcyiStyCB0bJLVu9QUNEFoYFDeqxpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807091; c=relaxed/simple;
	bh=WaXOcfAdGEomxE5YrdzpaeuD8s/7It6i+qJ65A9ovrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdJ3FWS0iUkS1thm/AzfJSmC1km4OweNuv3MUsfeqiu2vcprYHkM9833QFtwqMqjaejzV5wTdVqHFOFbab8q3cY5DeixwlRQj8hmLc5lVwLJcwghtGTTH72YYpdZ7sDUKEk3UJNKmc58Jb2x6aqLGE1hC+LNKIHQhpXPHGm0dTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF981F000E9;
	Thu, 23 Jul 2026 11:44:48 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:44:45 +0100
From: Will Deacon <will@kernel.org>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Xiong Weimin <xiongweimin@kylinos.cn>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iommu/virtio: Reject short event buffers
Message-ID: <amH-rdeANAtyXhDi@willie-the-truck>
References: <20260716012157.88769-2-xiongwm2026@163.com>
 <20260723095103.1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723095103.1-xiongweimin@kylinos.cn>

On Thu, Jul 23, 2026 at 09:54:09AM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> viommu_event_handler() only rejects event buffers that are larger than
> struct viommu_event. A short buffer is also invalid, but the handler
> would still read evt->head and, for fault events, the rest of evt->fault.
> 
> Require the used length to match the event buffer size before looking at
> the event contents.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't know why you keep sending this without first responding to the
feedback you already received:

https://lore.kernel.org/all/20260709095518.GA1752964@myrica/

Will
