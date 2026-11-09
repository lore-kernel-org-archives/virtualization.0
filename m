Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229611;
	b=VurpK7hDFaLDSp+YwZgaSqlj5mTj4xgmM7RMXpXpzsMi8qep/39qEPiixlZ+GBucmB9o
	 rL7glWG75UbNo9Bv0Ppp5YQxKSVMsSC6/wPzEbw0CZLNjG0YG06hs4wkvtgBcOeAMwnRq
	 KhHGgqad38Yx9pnhfxoPVzEVZ0UUspA6sRFNk/Hn2wPQtmrBocniB2E6aNorG/BZiS8dz
	 ZPimKZgf0suIWilIO7VRTS1yYcF7L2lyAfdBAl65CASLJmM72fOhQqXCOpbIAu80aQtSI
	 ZCPUoRSdBQ811W4GNFvye8yGHZQjkIjzyyoHZ4YADspnOrp8aSpEheEFuetdczXtbqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229611;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
	b=s3Rq7sA7CaEefMMgnNkmQAtP/9CsEz2UAltjXhu2sJI0YqjjhNaDSz2MsHsgHoqMex2u
	 FuBAAgUgAMy7BVknwIwiElGRimO2WIhB0oe/r+QQrjlHB8FqUBqXV3iEUj/HMnWKm62iD
	 rHMw7PpRXloCEbexhBjS7dNetxrsN7TeHXAVXDEo83CVIGS9++DGXXV940aF9u+3h6d6Y
	 q8rtDLnhPG4ZvknudIrmiujjfzEcZROdxMiZdv4KSAji1jIz/S8GliPBr5j1/gy7oio+I
	 kiswsbL19NVcOhXvOYFmPpd6hUrHHYCRDL9vJf42UVehQFb6tYLDNS7mpLUh21KR66Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UXmcXJOt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA0606A336
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 13:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CDA0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UXmcXJOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794229610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
	b=UXmcXJOtilHFjGvwez6rO6q+AbZFLoTde0Y511FZa8Lb1Ab7Lbiewhz5vCV0eEA7Nz7xDA
	A34uvJHDfl2e8bxZcRRR4hqBGi7MDd+AImCsbElrXtnX9MNkW6wqAu+HeVd0jcVCzvVv/X
	0mIn02WplMqjvTFwaiUbo3BrR6zDdRM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-R9dhMviaPBmYaObykCA6Ww-1; Mon, 09 Nov 2026 08:06:48 -0500
X-MC-Unique: R9dhMviaPBmYaObykCA6Ww-1
X-Mimecast-MFC-AGG-ID: R9dhMviaPBmYaObykCA6Ww_1794229607
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4163a5400eso88521566b.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 05:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229607; x=1794834407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
        b=idjUhbV2POBrAfWK+vVA4umygd5q162iNHGgj/Hy3mhvTDbvSKO3nso5npMIXASwDo
         hi3WPnGi6hUZLsQjakZNv1ImXmPrfpM5hp5W6lZ0NLR/CR0wFp3prKNuK+Kza/82XBzE
         c89g/IpLkru7p+bnyLLD2rkZagQvUmUaNGOSncQGswc1KO39MblOfcgYZREaAc1qYpCl
         +WRFD0tNw1ufCSvGLsZyelaO9AAvTrAFzxfikWGVX/wcMs89sJxqFT2Td0baTHAsbO/Z
         8GuJJ8lQZ7GNId9uyXdOS8PgHuYcynprKL/xw/INDePEfJvtdPoNSu3qY4cfQxggaSy6
         QUNA==
X-Forwarded-Encrypted: i=1; AL+hErGcN4Ps3VzEAKJoo4LKzL0JE9xMXRCfRLmjRGRlWAStdUAGSR9nb+qpcYd4BvW5R+OwrjW8x3YD5HqRc2bzZQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Y2wJpAaL7LF+7vip5arCDEbeNxxNsGcHyPd0vkQ6iGBKJf03L
	uQ0DNaEcIF3eqsI2GAwGuDrJoBOd5nnR5CSdeE56mFbPn26E8h1VT4c12bnriXGHvwM7jY0Cs6r
	L4hMBKpb/C12xY0ESJYrDw6jP/x1e7Xl5SwaMEICvUK0jD4S97/v/BgGymEJB5cmkI4hB
X-Gm-Gg: AYBFou3NaUhJ6dYyPWfxPXxUlqq8upQvw5EWTObfKrYApnfOmJs//ywieY79yTTped4
	bTK2fnPy8ucasgNPBubMVugIHyFBU2WAhzIwLSoR2/kV2CSzoc5O4UwyDVsy4HgzetCH3U36VZc
	wgi2I1mY8mVy9iRi48llxKoTJhqCrhoLSenbzyKTpWu2E+mlVZzIqdJ1iG7qJAPqSAdhw3oZEGR
	ulNIi0Ji7ZThin4KibAsN9brYgIbNIXkZ5gpWpnCwUiqqKmJ6qO93XwocNFVdOWvi1hnHz6m/O7
	Pu3sgErqk/CvUX8LwuvNcIP5R5QyFv88+WdKqtWHlaeYsIOli0kEbpQrvGvr73IUMU84/Ys8fS0
	ekzEiHbgL/UtPpU/894pTvtFYIuExgz5fkFmMANTK
X-Received: by 2002:a17:907:18c3:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c4d6db5760cmr321582066b.18.1794229607388;
        Mon, 09 Nov 2026 05:06:47 -0800 (PST)
X-Received: by 2002:a17:907:18c3:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c4d6db5760cmr321574566b.18.1794229606674;
        Mon, 09 Nov 2026 05:06:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f9384csm168299566b.13.2026.11.09.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:06:45 -0800 (PST)
Date: Mon, 9 Nov 2026 08:06:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Cochran <richardcochran@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] vhost-vdpa: convert mmap hook to mmap_prepare
Message-ID: <20261109080616-mutt-send-email-mst@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: arF0X7a53-XqeYezYQY58rM3ScH-EY6ybugHPJj0_Tg_1794229607
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2026 at 09:05:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only validates the request and sets the VMA flags, operations and page
> protection.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Who's merging this, me?
> ---
>  drivers/vhost/vdpa.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d90719171..993b2d7c8927 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1573,19 +1573,19 @@ static const struct vm_operations_struct vhost_vdpa_vm_ops = {
>  	.fault = vhost_vdpa_fault,
>  };
>  
> -static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
> +static int vhost_vdpa_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct vhost_vdpa *v = vma->vm_file->private_data;
> +	struct vhost_vdpa *v = desc->file->private_data;
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct vdpa_notification_area notify;
> -	unsigned long index = vma->vm_pgoff;
> +	unsigned long index = desc->pgoff;
>  
> -	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +	if (vma_desc_size(desc) != PAGE_SIZE)
>  		return -EINVAL;
> -	if ((vma->vm_flags & VM_SHARED) == 0)
> +	if (!vma_desc_test(desc, VMA_SHARED_BIT))
>  		return -EINVAL;
> -	if (vma->vm_flags & VM_READ)
> +	if (vma_desc_test(desc, VMA_READ_BIT))
>  		return -EINVAL;
>  	if (!ops->get_vq_notification)
>  		return -ENOTSUPP;
> @@ -1598,12 +1598,13 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if (notify.addr & (PAGE_SIZE - 1))
>  		return -EINVAL;
> -	if (vma->vm_end - vma->vm_start != notify.size)
> +	if (vma_desc_size(desc) != notify.size)
>  		return -ENOTSUPP;
>  
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &vhost_vdpa_vm_ops;
> +	desc->page_prot = pgprot_noncached(desc->page_prot);
> +	vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> +			   VMA_DONTDUMP_BIT);
> +	desc->vm_ops = &vhost_vdpa_vm_ops;
>  	return 0;
>  }
>  #endif /* CONFIG_MMU */
> @@ -1615,7 +1616,7 @@ static const struct file_operations vhost_vdpa_fops = {
>  	.write_iter	= vhost_vdpa_chr_write_iter,
>  	.unlocked_ioctl	= vhost_vdpa_unlocked_ioctl,
>  #ifdef CONFIG_MMU
> -	.mmap		= vhost_vdpa_mmap,
> +	.mmap_prepare	= vhost_vdpa_mmap_prepare,
>  #endif /* CONFIG_MMU */
>  	.compat_ioctl	= compat_ptr_ioctl,
>  };
> 
> -- 
> 2.56.0

