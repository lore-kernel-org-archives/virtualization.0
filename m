Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62A2DF68
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759003245; cv=none; b=liTdzoWEwr0OeOYzmLEy5NDIcvyjvXMbDx0Vquag9rYc3Kv4Kvc7c2vBdJDWUoeZQxLimir38WNveDODSv5itBzmY0U+gQI35MtmKEOD/xZeOzdpH3RnwBvvyLEA5ZKBshQmNY300FrOqoCcQg/Q0Pqc6xs7ThGlywX9TJoNgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759003245; c=relaxed/simple;
	bh=8pW32zcvR4dLYgwXXc+2tBLRJFT0Ej7KOCIhLsjxm6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rfchc/uDETvAypHj3moVxrs4pz+DmDGjsJabGtObPnngqSDJm062dtRUMJU/ZvYMe82bc+kJfS9se59u48+7m+QVsRco9/rxNeb36L2DKTiuOXM1l9zWr0HNgIOXNPVdVkWSs1dvhOPAXMRypxzRdX80WRzb2VSiGvvdbfdr2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoeCAfxj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoeCAfxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759003242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LY7lMslLMdk6bP1H78HvFkKnVR2pPDQHspzHxpFwXrs=;
	b=XoeCAfxjSnw5qQHJrdTAHUVOPhIFinbPeIkxZaiVpkO3/lJBka6MVp7KxqOjd/RnpOH4Xk
	E/hA0/gywuEKB5fyo1D2BznscLOaND6AGxS0zSAigoEMGhpmkt3Y2DXxWiDqH/Y3FNpTtN
	zN14Qr2rjpIkNmuD+p32n0vPl+M+BSY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-iVJXCsrAPKecQ5UOWj-XXg-1; Sat, 27 Sep 2025 16:00:41 -0400
X-MC-Unique: iVJXCsrAPKecQ5UOWj-XXg-1
X-Mimecast-MFC-AGG-ID: iVJXCsrAPKecQ5UOWj-XXg_1759003240
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-41066f050a4so1786906f8f.1
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 13:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759003240; x=1759608040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY7lMslLMdk6bP1H78HvFkKnVR2pPDQHspzHxpFwXrs=;
        b=grRNhBxKkzxsrp+TWkG1DfzMy/w6LuXxlW5npR19Cxn+Qgol/FtZ4yzPG//oB20oxL
         XAakP88deQa12+p+yiOEWvWh5LoqZNdCOz7A9/kn29n9rRdvbnnLxSbxs1PoLfhbf0GO
         /k6CbJJASNJyTGVibVYnQV3INZsFTI2LQrkuIXJO5wwGQpxW1N1/Pc37m8a5OVIZEb+1
         A+N0y3aIAF7tUeUffBa0fWtLVoJx/BUJD3xCbqlPkJLQsXAk1dhW0AwHl0Lp/FNx2yME
         1LD/YwHFh9JtETsiJdWJNI3pcLHlD3Qy3Ek5GWON0rQWJWTH5WFuC60swh5DmWWR1SzB
         0lbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv1qXYS4SFDMFu0sQFhtbs3EZl8fuboes8GTJCltg/ddJrFfaB9wvbHOST5rYagXOPK1iFmPTr+ZciI4yrTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlSfU3lZQnIWmBmQ4Q+7QZM83UEeaaJjJiydGrBYiVZYWbFShX
	5Wm7h4ih454jGbYUS3MVWGND4M526s2VxDynPSz9dgdMRSu6YyIPqrrf5s/8uZLqzkvYH4ozRmc
	06WXDvm690L1LKkw/XeFhr+ccaiqhF3fzw5BbPCRsR+SZdhyDGZqrR/24X33vtcVK95DW
X-Gm-Gg: ASbGncvo5Xi0eCdsLImIcZgHdnWAIhQ7AwxHe09bAqZc0yPa+Cikwr8aey1zcbVK+v3
	W7w05KvX/0I4gsZ7N7IoA+oo88iotUqaPpYgbWiEquhwCV/+ZzinBh07FJPY7q+wEazmzMcshqk
	Cd+Dfk6eC0FinhboE+9S0FoxkmBmAGdelmy4GpzzHlBmn0T5dgZDcYEnPfdLNVxhOzoZ4Dt/0DU
	GIMOZ1HGxBeGf9fJ6PcUs3ZiG/pTXGGTstHaAN1NxUNWK5Ws6jCkI5PcXCVzKO21DuC5/MGhZfw
	bvXYNl8EmH6RnFRQuLpZarAZYRbQoDIwLQ==
X-Received: by 2002:a05:6000:1886:b0:3ee:13ba:e140 with SMTP id ffacd0b85a97d-40e4a8f9a93mr9411607f8f.21.1759003239917;
        Sat, 27 Sep 2025 13:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnV16ZFd5HsrMWSnRhO0C2T0WOBDUOMZTvFfNi7AOVQpV95TyLimypxd7uEYgkUB8lVwvnvw==
X-Received: by 2002:a05:6000:1886:b0:3ee:13ba:e140 with SMTP id ffacd0b85a97d-40e4a8f9a93mr9411592f8f.21.1759003239406;
        Sat, 27 Sep 2025 13:00:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb19fsm12049208f8f.21.2025.09.27.13.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 13:00:38 -0700 (PDT)
Date: Sat, 27 Sep 2025 16:00:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 5/6] vduse: add vq group asid support
Message-ID: <20250927155955-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-6-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250926101432.2251301-6-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F2VAWt7Kcrgl5HEodVdYDCuWfFEt6i074Pe59KBJuyI_1759003240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 26, 2025 at 12:14:31PM +0200, Eugenio Pérez wrote:
> @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
>  	__u16 last_used_idx;
>  };
>  
> +/**
> + * struct vduse_vq_group - virtqueue group

comment does not match struct name.


> + * @group: Index of the virtqueue group
> + * @asid: Address space ID of the group
> + */
> +struct vduse_vq_group_asid {
> +	__u32 group;
> +	__u32 asid;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index

