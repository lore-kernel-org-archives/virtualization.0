Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629987;
	b=ii6qnatbWwF5N0UzcmbWtNLUoAiIEBNxoofH8Xq6ebZfBW1pi0Of4WaImN43OTuhpEDy
	 n/rO1s834SR9gh5n6/XgC3crD5rOksHQ/4ELfJcwDEtjtv86OC82lYjTY9YjC9AZc0YmN
	 7OHinPwvW0VV/yaJDs3trZBMcgFBspn9Q/iVRHTxKuH13dbN5s5EuSQf2kNh9aZNnMpr8
	 rVXzUl7h1+YRsIOAo1SACmjz4CbmSIQNLGtSA43SHuohkEiNS5f7kkDAlh4ti/SobzQPE
	 EV8M7b4rWxE9AWU8MRrjpE+veFZIV2+XFOsUS1ThDFSzEROoBp+jGrpO3F6WSJVBC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629987;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=R+Af9eWwgldLTUDD7Otvu3vGqJ6bqfzJqODBgc++zE4=;
	b=Tbv6TqhJUl4ub7Xt6V/C8mvgbXCffZcePi3HEQdDEf4U1mfXKWRM8UyAWWZFEnObxYNf
	 SQfZ34hkOdAKK1CsR0/YQRu2gXpXGG87f5VtBG/taFsRV8+kbxpfG/o2A5Tt8HQanAxTX
	 /cTVAfMktjXGRoM6Q4B2OFXO7qPbD+eT1wBs90RRDELYbtVh0SN0pjArHjf2/m/VWhGms
	 TQ0Mg1xdWo4/Q0bpDXe8M560MagPLsS1EBVfLuYL8QXzaSGVHSRfVd3JLKtL/Wwb62iE3
	 yXPK4DAkzeBMZ7GwjWhuPJ0Od12k3FzjD2bKDnop3Oys9GpJDzL1L9PE27fyYtM9n2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GE8M4sfL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82212606A326
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82212606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GE8M4sfL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795629985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+Af9eWwgldLTUDD7Otvu3vGqJ6bqfzJqODBgc++zE4=;
	b=GE8M4sfL0RPyCgV3UfnzuMVnt8sCJaWgJUOk3dtaWJ0mtkV5SJFxSWpAxXC0ewwsvVpQfI
	BZEjO2HVZQSFz7u4X3XVVkOBY8Uap0p7tL4lQH4GFq0jT6qeuoCwVrW4RQ9Bz/DvJE1l/k
	1eJmAGcG6E0lEipcZJhpfkr8Wbet2dA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-2EwCmcnINQK3B_Zv5CkCWA-1; Wed, 25 Nov 2026 18:06:21 +0000
X-MC-Unique: 2EwCmcnINQK3B_Zv5CkCWA-1
X-Mimecast-MFC-AGG-ID: 2EwCmcnINQK3B_Zv5CkCWA_1795629980
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb8ae35aeaso51398205e9.3
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 10:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629980; x=1796234780;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+Af9eWwgldLTUDD7Otvu3vGqJ6bqfzJqODBgc++zE4=;
        b=2DjaafsrXwlgTFo39jT09fnk8o7mGo7fLRvRmPlrYL2j1mWl1ia8Q/8kOAO+LsOeSu
         tGVRKRSAst+06+Sq4DvRH+yeZXe0tfC+znquaHIoeYS0peNAMuRw661aP9sa0nomdFTv
         M2QIH/biqp2qIPs9NaaIHQNQ2QMhBTdy5APo2x7qvQ/651VzG/maa0JX3uXkpErlwBpB
         1H89saUTqHis0CYekNsTJq1ni5K7zFdwUX2QeqE/CgIm1lvaSx5hrR3qfASasHH//tHM
         P7RVj3uLUQAW6hiRVsN8pETbo3kX+sHdM7Xz+zkDlgU/CyOfvZDjh1j81cIFxoamFZOQ
         s1zQ==
X-Forwarded-Encrypted: i=1; AL+hErFBlx5FDdyPv2rfoUIpb3AEA5Nr5ti90CGilTCKN9qVmhXESpHRlM8E60MDcB3rOgHXpCDcDXhKZNB5XEmi/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8qSqEoDxg41wW0gn5e0p3yV5bmPJq30qzG3wYE9eCxIagi+LEZ
	B2eHxJBLYbR/2HIL1h3UteJRaEsr+ydhaukiXDfSlms4hjzeW9Udr1gy5aqa/BGdddMkf2xzuyc
	3A6T6ezt8Q6SDtMS6H8M8A1EXLGfzxBJXpCVNia+VKcq1+Rc/TFTrXgzlMUxNb977uTa7
X-Gm-Gg: AZFdTZd8dYKEL0NUbt59hM6JRf0dfeQxKUrlZAZXbXasfNwXeJcUTIxuog7wmJ1j3B7
	wMkoiQBdjL9374LWRTjVi1WIG8zxkHnaFt6Ly+pnJ7i1nUGroDaJxk5DelsuQFXubVIHPY5LWj/
	fOWr4ro5FhXkSTksol9w8zcNeP/kukI4yVKgI7tYJ2dbJHZXCifldbNacxZUYveW8ZYikO9pzCx
	hFRmSr3Q+eOYxYNAd88a/Ew6Pp/t5Q3DO5b2v7IC0pPFgbmRU4EtQEnoRz8NHy8hOll1dIGLBRY
	JpmGtZtKoBu3h3/5MdIFt6pNQNoMxOOF15FKiUD0CniM+FTmTIhA4WNmsrDOko6HBV91sN0L1Xc
	74VmO/RTQex6WYls39AZryHr0kuDCMMN3KtNeyxvDZCU=
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr424524095e9.31.1795629979920;
        Wed, 25 Nov 2026 10:06:19 -0800 (PST)
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr424523545e9.31.1795629979374;
        Wed, 25 Nov 2026 10:06:19 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm597334515e9.3.2026.11.25.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:06:18 -0800 (PST)
Date: Wed, 25 Nov 2026 13:06:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "chenglong.ma" <longpareto@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Message-ID: <20261125130547-mutt-send-email-mst@kernel.org>
References: <20261125160128.796-1-longpareto@gmail.com>
 <awcNt5C6jkZQLy0M@gremlin>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <awcNt5C6jkZQLy0M@gremlin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w75xteZ0b2mUWyeL-U1oZMsV0dJal_KYt_4KuSOH2OU_1795629980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2026 at 04:38:51PM +0000, Lorenzo Stoakes (ARM) wrote:
> This isn't how you send patches in the kernel...
> 
> See https://docs.kernel.org/process/submitting-patches.html
> 
> This is a v2 of the original patch. It should say [PATCH v2].
> 
> You shouldn't send a respin so quickly.
> 
> On Thu, Nov 26, 2026 at 12:01:28AM +0800, chenglong.ma wrote:
> > Commit bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
> > set VM_IO on the domain file mapping so that
> > vhost_vdpa_va_map() would skip it. Since 99fd6bf43d5d, mm refuses VM_IO
> > on mm-managed mappings: mmap() of the domain file fails with a
> > WARN_ON_ONCE() and -EINVAL, which breaks VDUSE userspace.
> >
> > VDUSE is currently broken in 7.4 because of this. Please treat this as
> > a hotfix for 7.4.
> 
> You should say that it's broken and the patch fixes it in the commit message,
> and leave commentary about it being a hotfix for below the ---.
> 
> >
> > VM_IO is not needed. vduse_domain_set_map() already rejects vhost-vdpa
> > entries backed by the domain file, and the file check in
> > vduse_domain_get_coherent_page() keeps any other entry from being
> > translated as a physical address. A self-referencing mapping now
> > reaches vduse_domain_set_map() and is refused with -EINVAL.
> >
> > Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
> 
> Cc: stable?
> 
> You shouldn't be using VM_IO anywhere.
> 
> > Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
> > Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> You failed to propagate my Reviewed-by tag...
> 
> > Signed-off-by: chenglong.ma <longpareto@gmail.com>
> 
> This Signed-off-by seems invalid, there shouldn't be a '.' there I don't think?
> 
> (Also gmail isn't really recommended for kernel stuff either, they drop a lot of
> kernel mail).
> 
> Anyway, I assume Michael can pick this up and fix it up a bit?

I'd rather see a fixed up patch on list.

> For the patch itself:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> > ---
> >
> > Notes:
> >     Tested on v7.4-rc2 (commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb).
> >
> >     Control, without this patch: mmap() of the VDUSE domain file fails,
> >     with the WARN_ON_ONCE() from 99fd6bf43d5d.
> >
> >     With this patch applied: mmap() of the domain file succeeds, and
> >     importing that mapping through vhost-vdpa is refused by
> >     vduse_domain_set_map() with -EINVAL.
> >
> >     Dynamic tests also confirmed that vduse_domain_get_coherent_page()
> >     refuses to translate entries backed by any file other than the domain
> >     file, and that legitimate coherent vring mappings are still translated.
> >
> >  drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> > index 28a977248a0d..3c6fa18703b4 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -588,7 +588,7 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> >  	struct vduse_iova_domain *domain = file->private_data;
> >
> > -	vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
> > +	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
> >  	vma->vm_private_data = domain;
> >  	vma->vm_ops = &vduse_domain_mmap_ops;
> >
> >
> > base-commit: 44293796526f4343639f87b2acc53811c78b5d54
> > --
> > 2.45.2.windows.1
> >
> 
> --
> Cheers, Lorenzo

