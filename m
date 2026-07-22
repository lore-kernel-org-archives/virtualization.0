Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41751367B7E;
	Wed, 22 Jul 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756519; cv=none; b=LXH7lZpfQl/YoFB1wHx9MEzNYiez5hpxH8ulGmcL5G3Hg0s3zJg2V6XzeKcdTe5ZTF9h0kxPBOM55orQ+YFYz32Y/m2mCEvK5JSS5b5SOHeyU2i1SYaTrdUQbqu+iZiI0qxpJKUBbHv11pJpYMOn/FBtvnOYjP7sZW5+3xAy1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756519; c=relaxed/simple;
	bh=JHrNG0stqT3vK7t8UorMtDpmI0P24mpvO+ZxB6H4wfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isKMw8nLKOkEBNwLXTBQfNZA1k41SziM52z6hVW6CDR0aHT4d6LvQM9YkrVedATW/+xR9bd5xTKZ7EQSJc9jetedqrm85rRD4AXNye/vfJM2HViFuXw55wLivOi1NRy8iaraJgTE9Hr7rI5S94CWXv3bnalri+OkAR97/rg3EEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDt2MUic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDt2MUic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8201F000E9;
	Wed, 22 Jul 2026 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756517;
	bh=9qVG3+dHTaNyTap80hFFEZLeBns5/en0IKN6qYD4piM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDt2MUicJrbMNxbnMtOBdA9o/e2z95C6JedXpvhOoIHQ3o+aNu3w+r6YZwJ8Gs5sg
	 tkpOX5WKFv5ZSSB1QDAow+cKq+nZA2ePfvr71fbHBRj/eHmAhuU/5aPcNF/B8bj5e1
	 UGYfmcghkOacGIC1uKsNn1lxZ4wZowY0MkP/93KchgcZ9kWKHi6T3USIRNV6aGsjeX
	 RLO+IkjKtYuOx5aB6dPVVCzls4RaVFX1U9DGSfSuBUtdbhvFpbQ++Aeruv15oScpcE
	 qFHcvYlwrIDy8lHMPXTRmFAnnU9YzkOwGn7PBGz7tYBRwmLzZ1KU7iZyfFQ5dRjwxE
	 l3kGw65QaZXfw==
Date: Wed, 22 Jul 2026 22:41:53 +0100
From: Will Deacon <will@kernel.org>
To: weimin xiong <15927021679@163.com>
Cc: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH v1 2/2] iommu/virtio: Reject short event buffers
Message-ID: <amE5Id5R6tGuIlRg@willie-the-truck>
References: <20260714025914.193580-1-15927021679@163.com>
 <20260714025914.193580-3-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714025914.193580-3-15927021679@163.com>

On Tue, Jul 14, 2026 at 10:59:14AM +0800, weimin xiong wrote:
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
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 4c91a82d2..4b7f0dcfa 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -635,7 +635,7 @@ static void viommu_event_handler(struct virtqueue *vq)
>  	struct viommu_dev *viommu = vq->vdev->priv;
>  
>  	while ((evt = virtqueue_get_buf(vq, &len)) != NULL) {
> -		if (len > sizeof(*evt)) {
> +		if (len != sizeof(*evt)) {
>  			dev_err(viommu->dev,
>  				"invalid event buffer (len %u != %zu)\n",
>  				len, sizeof(*evt));

See Jean-Phillipe's previous reply to an identical patch:

https://lore.kernel.org/all/6800BE0812AF0897+20260706083148.788991-1-raoxu@uniontech.com/

Will
