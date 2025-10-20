Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCF1A00CE
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977052; cv=none; b=ZusIfFptBkt6kD0aPRKix2Y2w6sUyR8RLRYs4eAP4emkVQu4hfTR0qSoSZxiCVv+B3TJeB2gzUvk/YtZnekhquF+uwb254Z1+28y+yJIb8ORDvgs2X20ZIaPxPZgXJ6gSs/tBxqoe9Qi8Q1G/TJ3NHF6pzcYqUEZS1r4Jb0RSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977052; c=relaxed/simple;
	bh=E6TK0/TeyFkFgP3Og8WhXVAZ/nOXUxj2LcaIiVjCt0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dQt81E1orMvS27pgH14Mpl9lYrI9FZSWAgnbMWdz/EQIfnZysV9EEOl8jI6rTALgr2UCsmA8kmzfIdSEldrLvP5MjFGPTQqSwWtm7Y54c0ZVc6IKHCO66z3pkkbb8yp3lj/Hz/fQGdAS+8xgpN58eEK7oaTfG5Zz0QsEU0fIyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgB7Y0Tr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgB7Y0Tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760977049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwmR8e8wVmFugkcuhatIXbUfJ+2hKp6p73SMPj4eo7s=;
	b=XgB7Y0TrOlOd8ZSsUcyGsZ7NGGVaH1GuMLhy1EArQiM3nXIY7GUhtUUmAg37NMl/bUHRcJ
	mSR1wtkFx/ee+dgFWeivH/+pdB/2UJ3kH2hlsuD1YGFkksv3nCFKLzelk8+5zRgDF/e00Z
	CFZkJhR6WyD0DFSfLLf6B44nCJvthq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-o1uMMKXjMFKy_bYuEV_1hA-1; Mon, 20 Oct 2025 12:17:28 -0400
X-MC-Unique: o1uMMKXjMFKy_bYuEV_1hA-1
X-Mimecast-MFC-AGG-ID: o1uMMKXjMFKy_bYuEV_1hA_1760977047
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-470fd49f185so37851985e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 09:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977047; x=1761581847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwmR8e8wVmFugkcuhatIXbUfJ+2hKp6p73SMPj4eo7s=;
        b=q82VY1ezp+IJXMVNlUEzhM0p0FD1qxWlrlaRfnU6ZFJWRa66fZXOB/xPEFe42q6TdO
         /QTVLXHwkB4xqza9niTM3T32q8NmQ9+dyIJS7JdHPLKeBT2FLCMiV6UGfUeaG2MLvBeM
         WuNEhObxlvixGMhyn+DIdVKBYh+CXxqg1USmvIkopZ2C0Y4S3u+SDRLSX3L7+d0XeByl
         2eoPkeDFfUX5Rzc2Zafe5dwW++RY/gkUtdQXNOCFpqQOqWwau8ilRO3U5U0UNrtjcoCA
         1NPdJEhmMuc5paVV0CX/V1WG57RUPj0OLPQRfF+SjvJn5LCp4+HaePKAoS2/BOp4lK17
         LZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXInfVlufu0Ag0xppab3pOERKp0bvTphQu3V5z8CYaLRAFnPvBM9V0WWcSiIZ8RdzmJU+S1TGuO5yXDzsdByw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/PUeXDZgpExEEYFs1vtSztuFD9L8+MVFKWikpKiXEQRnB/JeT
	4RA6Uqj0B9w5I1ieKlTOMnD21FkyYVDIh9xHQTWkCVtjwF3JQUzDZ2TPQCwI4dt3uUHKCh01uDD
	shC0caIX3V/Hu2V3JSyiQ1dUnwENwkLuTPFSFeP9yl6D3Mo8CkIJaekeAijlnnlWh8PeM
X-Gm-Gg: ASbGncvKIpDTF//FxsZiJt7xQelmEAVTmw6CpimGNsd6EDKaxLuV+oHpcJkE4vOe1aJ
	F7i1JBBpTZ5uu6NGWiMuQS2mMBaxJglxaP41taLJqRNdLBZOzVTnhKpUb3wyuEuwoyYGTK6m4/t
	JChZgFnN7qPApMpkp5FRgmoaRGGTFMM8I7L8g456koXJMbCLpRIDkDejQugYRDEds/n+q36L3CM
	+UmjnyeLVUZtOsU6U2CaEl949+QKhrr9UsRGB570zH6S40OWF7CVuOa4j4Oxf0JbBiIBif7xFrV
	Agibi1gQygxGRX1HDq1TAb9ldN1eSxWhswoFn0WwIuqlkZf8WxTleYf6MmJoVZc85oEc
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr104932025e9.22.1760977046854;
        Mon, 20 Oct 2025 09:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNusilfxfBuyuVngG+GxZ6EUWsDDRXTagDB8NASH7BRocXCsuYYBS7524mf8E8ULXgqGoP8g==
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr104931795e9.22.1760977046396;
        Mon, 20 Oct 2025 09:17:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d8b2sm181951825e9.3.2025.10.20.09.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:17:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:17:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20251020121643-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-18-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lqKW-su-RkifccUkvyiGP-CR0Pj5H8bU3HqFYiF99tA_1760977047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 20, 2025 at 03:10:01PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> allow it to be reused by the in order support.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c59e27e2ad68..0f07a6637acb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +				  unsigned int head)
> +{
> +	struct vring_desc_extra *extra = vq->split.desc_extra;
> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;

why split this line?  it's not too long.

> +	unsigned int j;
> +	u32 len, num;
> +

