Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469924E4A1
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916309; cv=none; b=qmT232s9HXvM0Infd38d8bRLCrrlxOJ3xmOWgj4h6vcrYW1MMT/38U73sC9QU6sl/ZRlqRtXLHdgcGCSVmoOoFDYafOZlBsUfpk7OvEaHuHrN6GV03S+4SnXRjrvvNmo/7IDHoV1In7b0z4OLpSrLAUwYMz8dnwNVLFb5I1KfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916309; c=relaxed/simple;
	bh=+edz4roaeFYDUhu/iJloVGgjpqHGvC7c3P2vbLyN+/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jDJ1nbT4U/vY7hEwjLlhMvW20VP6BNPzgtaezekE9A009SD/3rKCTO65V7VLghOlwcq7IZ7E2MupPRhUvqF6IgIC1iMEq7rT7Uxsqw72okKI81epUvPHv2E50UHj9JjJUdfSrMQvlfEeC/zYPdm59gJMzNvALo0GS71Tlcm91Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6xB6Hx7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6xB6Hx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786916307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deEjGWQhm2dA68+gnhA68cTQSmkVCK/4uu8LxzANGWM=;
	b=F6xB6Hx7xdTbsJhPYgTyhaW8QuZrrGWRZX3za9QKmROX4GXCUh0I2xzVqZPas0jNyDpZGI
	Mwzc8eSxukDZyAiio/jMpdwD7pL28hlFGIPxSv9WhMkE/qEFU4LivsarW9XQvsE++W4LHQ
	st/bqRwkeSBdSrCfOJDXADt8Gg7biv8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-bzBjXMRqMXOjserc42GAdQ-1; Sun, 16 Aug 2026 17:38:20 -0400
X-MC-Unique: bzBjXMRqMXOjserc42GAdQ-1
X-Mimecast-MFC-AGG-ID: bzBjXMRqMXOjserc42GAdQ_1786916300
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49991beee7aso11424345e9.2
        for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 14:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786916299; x=1787521099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deEjGWQhm2dA68+gnhA68cTQSmkVCK/4uu8LxzANGWM=;
        b=J4ON8uo1wwm/Ur9HuL6Gxhi6n/HpaKIRSFXL0Qc7+5pEVC8cABcV0L5FWTJtbdK7JH
         yAKyofmZA43HkGSIqvlttzDxc9Ru19Y2HWBiV1WzcaoHXMNHi0JOnjsgnuyQvUrDcJ+b
         U0brUn/ObznfSbfHBmmmTV/HV18kYr/6Xi2Rqjw6Lemx9pYd/Tna295upqw1tx0DIKoE
         ZDlaKFoXiEjQfgdWZnq4oHDrURsoVExeRJsBZkWxl5f42tq3d5hRUW7sPDqruD5Fxm0w
         af04h/qBCBGXzbK3qwzpQqlpp5laWQp72EqIWiC2bBGZVv286vKvM0QA9Irfy72N/pV4
         lwjg==
X-Gm-Message-State: AOJu0YxnVNtNA+T+D4NTbSXsX4C+nr0ossF8v/RWZUXW+lMeSUKM5qL0
	0zeKqWgh27gE0iOq1/rOjMUzqpTF0eY+EpR/8d40PO6jOxlsPey6fwl33aho+J7ar+OMWia9zC8
	OnLySG6Zjnjg/dPuwpzYcgjRSU5qfR/TaaUL6UMNgoOlpvmFI6pT7BfihJuhyCb2nv80G
X-Gm-Gg: AR+sD11Xv/xbtUqDXLZvU+7u8EmKnEytsgJQjWPe36FGRlS+65XEhXLF0Hi9Tl6ksCB
	6khqdonnTSTiKqljITOJlYgs7HgHSaHOO9G1mW8CFYIVw3xmPOHiI7aDfY80zq2+CL4k7ncYyGe
	MtSveFSmzbk5YYY0p+B/zQYyUySXPewgBMNzJy75uoV0GMF//4/KH9czrBWY6jPGzBTV9X4mYxu
	kVwx0N7A+pH49K58g7/oOuSZ9EtB7/0sr5a0hjzbXPobwRJ00MMDIFLQrcgOyPvD5IHilXafW78
	9/bzlC9/OPs8aAzKfsP2A1ocRAkAXcPDc50FHcx+IyrNghIK5NMjb3tIu0LuM57nPTrSq9YSLuL
	/ZFw2V5FRLG9koSlrjNMn3Eng
X-Received: by 2002:a05:600c:5754:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49987951a06mr194801755e9.7.1786916299435;
        Sun, 16 Aug 2026 14:38:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5754:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49987951a06mr194801575e9.7.1786916299031;
        Sun, 16 Aug 2026 14:38:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b36370sm188653365e9.4.2026.08.16.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 14:38:18 -0700 (PDT)
Date: Sun, 16 Aug 2026 17:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mirza Ishan Beg <seedandsyntax@gmail.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH] virtio_pci_modern: replace msleep(1) with
 usleep_range(1000, 2000)
Message-ID: <20260816173806-mutt-send-email-mst@kernel.org>
References: <20260816094318.8083-2-seedandsyntax@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260816094318.8083-2-seedandsyntax@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VSxjVNukr03Iyrl3UR763dn0js83dUDItU0W4Swdjes_1786916300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 16, 2026 at 03:13:19PM +0530, Mirza Ishan Beg wrote:
> Replace msleep(1) with usleep_range(1000, 2000) in the queue reset
> loops.
> msleep(1) relies on jiffies and can sleep up to 4-10 ms depending on HZ,
> whereas usleep_range provides predictable microsecond-level delay.
> 
> Signed-off-by: Mirza Ishan Beg <seedandsyntax@gmail.com>

why do we care?

> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 413a8c353463..8e74a813ca97 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -535,10 +535,10 @@ void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
>  	vp_iowrite16(1, &cfg->queue_reset);
>  
>  	while (vp_ioread16(&cfg->queue_reset))
> -		msleep(1);
> +		usleep_range(1000, 2000);
>  
>  	while (vp_ioread16(&cfg->cfg.queue_enable))
> -		msleep(1);
> +		usleep_range(1000, 2000);
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
>  
> -- 
> 2.47.3

