Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100717;
	b=UXti+gK06tKfdbbWBdrs1KAZ71pDMrtbYYcR458AtMzjFXsdN0/fQe1fUKiAhMmzKpbo
	 eZlyBN24RE4OJYnEvlomWh+C3EJZj6I5XUy7Ed2UzbIBYahhFHNHMrXzq9O95kgY4Z5QN
	 U4B9FlH8eTHJUsWVfSOyKj+xszJ8LKe4LLAHXuXQh4Gf/fXHWo7urj7ZWm7EWjvIJ1qRp
	 r+2QkEQoyfoSnSO73tnoaMohWIb9KwmlPMnVNM+Zb0bTdJNVAZuHIe9PXHagyCfe+RDS5
	 kFMyLZDlGi9fcdgK7MORt8BRhasTEyijr2EAMny1w+1ILnKlE/AdWIVehkCowY3VP0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100717;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=spt+LTiguL4KmAUcPGeJcG5Yzgnq0jWw4kdGv4eWDHc+TLqRkIfsVJPz7cShjaPkfEKn
	 2x77UcFuXpIZYDM3p4dg/lPSB8+Gu77REZIdPfuHUH7OmZaF5t10S8HOzrPn9x+wUYoJh
	 Q5SIVND3GVvo1vfPlRpA/fTgEM8qn2UqWFifkmWgFduBxKymrFymKmN9EmbBT+tySXhuN
	 xLg25k/sJcUaA5zuwEbCjVNk2Thv9q4C8/v6x8rxWH8gDwsgukw2FDjFsHIAyOJHreS5Q
	 JM4Jng7+o2BXEC404XCUuteA4qjv9A/MVtbOYFoiMdCFexH1rLYgPrrvuSBSBVfJVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cj27tBem;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20525606A331
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20525606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cj27tBem
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=cj27tBemFKjHc9fbRKQFoJigFreEwUype77zkSNad/Mw1sSzV1any7UU7/Er9NfbDmhjeL
	dIonnrEr2ICh/VSowh0cwEJgJbjf9V2tDYXF3oyx++zYsrJnqyPNBWw+xRmLorXW6OFwu3
	ZlQLcFeN3muhBQgCnZPEXHMRhrPQYdI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-GpsQvWijP9i8OlRJ-Y8xmQ-1; Thu, 19 Nov 2026 10:05:14 -0500
X-MC-Unique: GpsQvWijP9i8OlRJ-Y8xmQ-1
X-Mimecast-MFC-AGG-ID: GpsQvWijP9i8OlRJ-Y8xmQ_1795100713
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49034831bb3so1611290f8f.1
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 07:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100713; x=1795705513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
        b=UHXl7Aag2gSy0x9VSEA3WdiwB33o38sx2UoinH76oF4p1DWtGX0Bn3AYkfde+UM7Fu
         eiaXS/EHGp+q4vNlmrBMySLrgyqZTfzZleBr7xgwndbXa/2CVTEBqV5D4XeGNzg9+MjF
         pf+mGmxFh5KVBlree2SJnMYlfAUw3ofClxTTbVNKK6+L34WStPGT8UjziUNTz/R06Yod
         UtFPEMA4Lt2G5kd2PfjSLj6QO6akO+KiK/jFFXI++GF9g3kwV5hBUfjA7OjMwaj6Iul5
         CA1Sl3bD5gEgDqjiP8WafCeD0EhPtPpKsyPoTZbO/soxFB13O/oYLlYeyD0FsDKceXH+
         Hu8g==
X-Forwarded-Encrypted: i=1; AL+hErGn2W3juJ4VRJQh/Ij8bp22woUMLbFPEYai4jssels2Z9uw47hIgR5t5pK7W0UnhKuw4TNIKKDAvlrQA3wmBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+okrY07gkM4zaxtvB6YFz8cRcWoh9xZicFstu5hXek56B6yLg
	iRgxxRKkN5bscqRSD77XzHORPp71B1nop0Mj+eXi4JpMsloEMpHdP6IH8EM25z1M1iwcHH4vq6h
	hnRB0k0DaLNdYTtj6RZIj9FuIM9ZFgxDKhaETeHVgmBY5aYNmFYLuLZfyXbyYbDGIng8l
X-Gm-Gg: AZFdTZdZV6UFwnzmSuayM8K+OjraicACH2w2sgJbpe+fPZfrcGbxUs51C829cCAiVzI
	A9EWrknidLhV91eGO5IEabolRvE7ykGr00g6rxYsCkPW4RdxNFD1DKxDYsYXS07V3LM6Bu/OYud
	mvdJ/Flh/zfOpZGEBMcAU4OQVcbnCWJwavnG7Agt+gF0Y6GLSmgN/2fUohRpPQFjwffVROwtGaz
	lhLFZM6aggq1AZeQ6fNJcYK7faczvQtPNlvjVMZ14RSrTMHo/Su78IMrvRWhW/58eStemACJ61/
	c4XIuiDIQNizlxKq10Gwtr6SwJ6jDRMEsL4tcpNrmAttmwKVNlzQCPAP+w95Z+apWgz+6TAaNoT
	bn05bIgkqHVSc5DDEvuYvhN/FpmbLP3ZmNDKmZwq6/A==
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686361f8f.28.1795100713215;
        Thu, 19 Nov 2026 07:05:13 -0800 (PST)
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686266f8f.28.1795100712535;
        Thu, 19 Nov 2026 07:05:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm61225f8f.59.2026.11.19.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:05:11 -0800 (PST)
Date: Thu, 19 Nov 2026 10:05:05 -0500
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
Message-ID: <20261119100450-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: zqRNp4bKPO_ykuTLNQ4LvLK3aL9RFhvI_eORt1yeuZo_1795100713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2026 at 09:05:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only validates the request and sets the VMA flags, operations and page
> protection.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


feel free to merge with rest of this.

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

