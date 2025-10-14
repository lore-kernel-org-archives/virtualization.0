Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689B30F808
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430576; cv=none; b=bPNZ88cISILteNEHxZdUFgr8PI9FcHfSDWNZK+g8wp1y7tuYu7YLpKbLUesQVz+5NSbK6DFRiUu9guUQu1xqXj9Q5SXAMcuGwShLYWFajD7LLCfl9b9kCXJoWwC5Jt4PL2Yw8sFS6f/VrDaXxgeXXBv2WRKz7IRjH5495fxbRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430576; c=relaxed/simple;
	bh=/HuGM/47bIodPOEN9kcu3pwg2q/33WidymgDi6AyiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LYTKi6ia6QPbAU2/KTe7oEGgu1qNxYfEqV5/1uIKfBWoollZwTmcKtY38yKCBgqUd5ZziJ6uhabNblivu0K7g5oBskOd6UcHjL57NHDQwWU/gA58b+zDHKmgWArcihMN7wm8Ficpx1J8/IUqvHyn/M7FX97x48qgs0fTHaTUO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbZ6JExw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbZ6JExw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsUz6hmX3VwPCSslBpSvxo71U4IXbfFNHhR64HdKblQ=;
	b=CbZ6JExwGalHh/W77AyfW8+m6WbjqAy0fuOFdKlshku83+xUo1o5XnMq/jzsgeiy1DaddE
	o9dZl/6bflFhtXfpM0CYbqr/1aY2A8ScG6/G5IKRJlpnf8j38isCBB8pbOe1hcxrA29dOi
	MBa/QecjXiLPaZ8GtriqBHzLBgGDc/c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-jDvUNCvKMZeskt0cZwDNLg-1; Tue, 14 Oct 2025 04:29:31 -0400
X-MC-Unique: jDvUNCvKMZeskt0cZwDNLg-1
X-Mimecast-MFC-AGG-ID: jDvUNCvKMZeskt0cZwDNLg_1760430570
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so4374043f8f.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 01:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430570; x=1761035370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsUz6hmX3VwPCSslBpSvxo71U4IXbfFNHhR64HdKblQ=;
        b=PfpR6AE88LrUtl5ktDi5SGqXVwupuJoApzEZfpqFM5XoBByxSMmxrxhnUYqEpn9Koq
         bN0eqzQUhpE5PS9LuGG6n1Gzi4OMtWkiFA0UTNzUYcaVQOFnB3Oo26+OiZG2YR9dWhJB
         2WUMucBgmdfT54Sg4A3nyKF6EurgiIYo00fUxxx0Fu7xXsDOTaxdbaTw7IJ0WgNK0az+
         FLmql3L8EbdKuaR+hOueN1NcKoRMMGf55Zz+OwG8lUUh2Wy54fD8iBItDUItgsdnHi8y
         d/YEDl4k3l80ojBF7jYuBQ/nfhZZlQFHJj6RTsOeQDs+7UOoyKDQGNW6JJPA/yTxW9a8
         XkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQr98nWW4s5RA/qCG+4U4UWGq0/vYxVHHy/TENMD5P2HLbp8HmaGTkvq9WCY04wuBAsYeiNm6Epf5YhuYdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2HSkqZL18/Pvneh3mBrF4B8XvXqMOuMhOjjUcJzooBgauC7fK
	FruwqcRhn6oRi0qIEwHQd3ZbxIxJR6KRBovBLaZJM4rl/EAcqQqizThX40N5HMN4h4ToJ+81Yrn
	2+zyIU1TZLAGAw9PfiFq+xeNlmQIUyFo+IGYDQYPlRm0BZ3gxj5bmr+t0xdZ9KskSzWTR
X-Gm-Gg: ASbGnctnSicKJjcjNnw1hqoD9Pvn0pDfvj20aO8wMdvL7OaKeBaRZjmEPysMYPH/DH8
	VWxnff+PmC3lupzH0pKMaDTgBQzlNmZy3h/9vtnt2MCcXfvis9EHsPzvM308nAwuDq6P46OnvWu
	HxanlO7TZ4u+8ESEsY3ZHxYA0Vaddfm2U4td3GsK5n+ltj2KZ0c3AerqQb8LbbRECgFSarNgLCz
	rJZeAWzBDgGT5+QS97iL3rzfJd44IHjatzY/BDut6IBsCK887v4dQVm2+EPQEJfEuyem9CtsHfL
	BUxS/ltKFhg/t6TOc38QzVvKgSRfIWrybw==
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-4266e7befe4mr15816885f8f.17.1760430570336;
        Tue, 14 Oct 2025 01:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnpTZe8/dTR/rZB5cDRVDATWu3FS9RUOdcRXVHaoWWz3AZV0WhnIxngSzIEhkjXnqWmVvhFw==
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-4266e7befe4mr15816855f8f.17.1760430569735;
        Tue, 14 Oct 2025 01:29:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e10e8sm22344542f8f.39.2025.10.14.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:29:29 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:29:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251014042459-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251007130622.144762-2-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hQDw2DX8VOT2MXu-kYE2d_WPFRD0OmJe-dau_uZE_Ts_1760430570
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> An userland device implemented through VDUSE could take rtnl forever if
> the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> device if it does not return the buffer in a longer-than-assumible
> timeout.

So now I can't debug qemu with gdb because guest dies :(
Let's not break valid use-cases please.


Instead, solve it in vduse, probably by handling cvq within
kernel.


> A less agressive path can be taken to recover the device, like only
> resetting the control virtqueue.  However, the state of the device after
> this action is taken races, as the vq could be reset after the device
> writes the OK.  Leaving TODO anyway.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..ed68ad69a019 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num = 0, tmp, in_num = 0;
> +	unsigned long end_time;
>  	bool ok;
>  	int ret;
>  
> @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  
>  	/* Spin for a response, the kick causes an ioport write, trapping
>  	 * into the hypervisor, so the request should be handled immediately.
> +	 *
> +	 * Long timeout so a malicious device is not able to lock rtnl forever.
>  	 */
> +	end_time = jiffies + 30 * HZ;
>  	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>  	       !virtqueue_is_broken(vi->cvq)) {
>  		cond_resched();
>  		cpu_relax();
> +
> +		if (time_after(end_time, jiffies)) {
> +			/* TODO Reset vq if possible? */
> +			virtio_break_device(vi->vdev);
> +			break;
> +		}
>  	}
>  
>  unlock:
> -- 
> 2.51.0

