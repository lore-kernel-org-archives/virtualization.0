Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674A3859EB
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315375; cv=none; b=I6JCy5VNtYhi5r3zKdFmx6/fSzXTEBjFZHyEliN86UpyJ7r6TQmUHeqIStIkCIFOcmJdatbRQp3uEZqcqjFBU1afoqFmCZH2wp+9Qoojz9DuPluEDPxfdu5/lKLvQgbVVgYqD6acTQacWu8TrgM0jmKHEr36HITxkXAWnDC96AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315375; c=relaxed/simple;
	bh=qI4/6zwpPOEe2bAZ5uGOohTd8n97feY+w5pvSvgzafU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s30i1A0D2RL1tn28+MAKCNF2usPNEJEBa+K9YQZr/Au44zwhq31VHrLUYJ2Xe7jARRzF0Ng+LBQEXFMtvy+OF01eY+fRkFCxdtN8PEiEAWK7c2UgmgAAw7YJcWMeclsn4ZPIGsRS5i6swF0pcye+spjEc/F3fZ8a6wZYdCpMd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aequ+Z3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aequ+Z3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786315372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACu9vD6i/DX3GKdaGrdIviPy3rw+7pNVU92uMrfQFmY=;
	b=Aequ+Z3+wBda+HsWrLVpa7LubeaVv12JojQxFt4xV4D+qIbEsV18ASqbrfRUxXXt2cnuy4
	oYbA+nGoamXAAyxybDupM5FVDVrKf4ptbPwG5EsNh6ilm14wdom/mq9CU7wId6z+1aSVSq
	/W7nNOKsI8bdJuJcwkmTi8UpeDTzv2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-yYiC-pPGM-aRs6vLiyGaxg-1; Sun, 09 Aug 2026 18:42:36 -0400
X-MC-Unique: yYiC-pPGM-aRs6vLiyGaxg-1
X-Mimecast-MFC-AGG-ID: yYiC-pPGM-aRs6vLiyGaxg_1786315355
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994aebe932so15928245e9.3
        for <virtualization@lists.linux.dev>; Sun, 09 Aug 2026 15:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786315355; x=1786920155;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACu9vD6i/DX3GKdaGrdIviPy3rw+7pNVU92uMrfQFmY=;
        b=PRiS4YmWhAejtpzkqLIQ1igel3gmVT++LsuuJHMBaXgseqrEvTqbniF7PT4KBEJ573
         fEyYcmAaUP7410MK7tY1UnNaQa6u9ztpRDof/cKpXL4QLja7jHYNUsAWoXVGV6pQ80dP
         QN5iYLjc8UkM65zowzHVBtdXi1ulQgp/0Kfpzo4yqKNmFM1SIZp7Kb0c9cdBm3AFYt4N
         sIG4c3IVzWsKGtcz6winyh+HfAC9LLbgLSt8hYKFjYQzaWnpMImyrVLBC33hN3v60Da1
         6481Tm83sqeyI4rV8Qvnlc/kl+tgPwHA1YPdLDXBATjAqyDaNbGtELlnic30Ioj4rObz
         QYLg==
X-Forwarded-Encrypted: i=1; AHgh+Rpe/eEWTvtWy0CEHC0HWlVD3ZcczMt1bKmZWMcfSknpIfBOxBxJmg41qKFEwaaT22ZnpYdZgg79MtBBaxkIvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA40rPO3T1bbNF7L00GVXhmEpBNLQLXrPYmUwa40d1RFFUodFT
	7mgOU6wEsHTTIIu1w1OY/4jdxnzJJRTRpIy8aS6dXe3AiZYupgNROI2Gqi4hYFIvt15Lox9Sznp
	s/79AQQJu4to5JZm9YrlxXFDgApfVhUEkKaqzbz+zgon8CTYL5QGZGWsbXKaLYpp+KG36
X-Gm-Gg: AR+sD10d5wu0JcFrEYNY/r8AaNF7m4/5z0p4xR5AvMXuCGfMQgzdLRR0/xrGu5dbIC2
	rM6zwLK4PGNVzxVztma+F2MHJuQDg1eDNBmXo3embv2FxUNPJzMfAawDbSdd1dO04/a/s3oWa8a
	UtWYC9xnO9wTTmzlkjTWYqe6RiI33cV4GGeXCLYWymOKpdyMScLEKDn4zJR4tWQyJLMOeEf57OO
	ZdPiq7Xlkd1mBppiZqvPzv3qmPoz3EoSw4viWDJlgDsFvt4Gd35A5js41CJ+iZkDZuQs65+lbW5
	p+YYAsRi7UiSBmqUiyMvQqDiS3cDNDuQN7YG81p9tgqR6hSVeyDFTVZ/AIw7I84xKVUjnEVCbfD
	HUogd58G6uozSX1Mkn7UMYw==
X-Received: by 2002:a05:600c:1c19:b0:499:5220:db3d with SMTP id 5b1f17b1804b1-4995220db75mr447956055e9.16.1786315355167;
        Sun, 09 Aug 2026 15:42:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1c19:b0:499:5220:db3d with SMTP id 5b1f17b1804b1-4995220db75mr447955665e9.16.1786315354716;
        Sun, 09 Aug 2026 15:42:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542858b2sm389073335e9.14.2026.08.09.15.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 15:42:34 -0700 (PDT)
Date: Sun, 9 Aug 2026 18:42:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Feng Liu <feliu@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	nh-open-source@amazon.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 01/12] vdpa: correct the VIRTIO_DEVICE_F_MASK example
 value
Message-ID: <20260809184139-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-2-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260809182010.32931-2-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XqiLsuHXkjf1xrWnZKSj7wfRUbS7_SnBgBIEsSXLe8k_1786315355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 09, 2026 at 06:19:59PM +0000, Alexander Graf wrote:
> The comment above VIRTIO_DEVICE_F_MASK spells the mask out by hand as
> 0xfffffc000fffffff, which was correct while VIRTIO_TRANSPORT_F_END was
> 41. The bound is 42 now, so the macro expands to 0xfffff8000fffffff.
> The comment is the only place we write the expansion out, so someone
> checking a provisioned feature mask against it reads the wrong boundary
> between transport and per-device bits.
> 
> The macro derives its value from the bound and needs no change, so
> correct the comment.


Or better just drop it, we will forget to update when we chaange it
again.

> 
> Fixes: 838bebb4c926 ("virtio: Define feature bit for administration virtqueue")
> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 47c6c3d23f5c..1757a33f298f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -548,7 +548,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>  
>  /*
>   * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
> - * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffff8000fffffff for
>   * all 64bit features. If the features are extended beyond 64 bits, or new
>   * "holes" are reserved for other type of features than per-device, this
>   * macro would have to be updated.

