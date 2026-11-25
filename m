Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629948;
	b=l3N0cS6LzstpcEs//a4Aw9HlIZLg4hb82JsmEKrL4Bn0WIoSXKbKEBCQJqyqNr33owB3
	 A8js6H107IjgDCKem06Yvkkq2dTpLZAk8LvUc5VY+Tefa8b9h+NAJG2yRASde/PZQ+fxm
	 NIfyKqt6rTh+c7lncWcqmk6Ke7sVCWZwnzT+IoRP5sIvuXKzS55xjTA/ktFjr7yAP9CkQ
	 /M8+FNII5fqZuCF8dVgDPdtRrMMmFOlOq3+z01JUtBc0/CtALbFDKN5pFQT4k39y5o0az
	 0ASQw3/UPyLPsst5AdeBAjrs3nW4l+i4u/9I71R3SPAuEaFDjPCBUIMsHVW2cgDOtiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629948;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=eTgM3sm3JbqXraTcQCNo5DpHIoGBnkhb9HOKRAi87kM=;
	b=sk16Z5sJU+H5ddswazwKriVTxNAGKFIJ+FCOIZ+MifvPNSF2aOnYJSCwoYW418kpkw5h
	 BbrLRUflJ1f8ZwOFmp12lllNob9yFSrTEM71aZ9/pb5AM3I0i250RNDds94sR/Tur/dPR
	 JImmOOtsJQoRqr9uQ8hjoMz9X6vjAGBNJJ4FEtymfSO8FwPw8zp9p5u8HTrWzH3pFTwdw
	 i2/V1WfSBylqX9bLnkdRtiaZmM05udn14H40hjwAXtpYwZ48pILKtcI9ynOvWQP5nRsMp
	 qpq5euoqn5jsQL82FTvI19pjpZojVHmB3/HjQ6TFVONaKSdevDOEn3SIt/tXdTQMWNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsTHQXRg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669F606A327
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9669F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsTHQXRg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795629946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTgM3sm3JbqXraTcQCNo5DpHIoGBnkhb9HOKRAi87kM=;
	b=NsTHQXRgklyA1gr7BbHiiLnWkoEtAz8yVlP0o7dxFsog7LccidYpJ1cisA1sL1OVnA6V2X
	zC1fbiee5JqEFz7HI/YNEBYmLktwfVkmEnHG+1sSiw8WnaBMkyf+WY3beniu7PQpwJWkn1
	NjbeZOmq12Yrjoj3SrB5ZUV2TXvDVzA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-KnUozYQAPcKdI16xvfpXmg-1; Wed, 25 Nov 2026 18:05:44 +0000
X-MC-Unique: KnUozYQAPcKdI16xvfpXmg-1
X-Mimecast-MFC-AGG-ID: KnUozYQAPcKdI16xvfpXmg_1795629942
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso43512065e9.0
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 10:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629942; x=1796234742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTgM3sm3JbqXraTcQCNo5DpHIoGBnkhb9HOKRAi87kM=;
        b=GSU5Ii1BXkoJAnt/+vGMwArnKHdLu+LPDuf2nEw/eJL/CL0hOfKvSy4ODpZed9fCoh
         gPfYJ0Hl767xFkb4UTR9Ew0e3exLBvOeiVo3sGwJj39udsh13yQMNO7EZ53hAch+4stC
         YslwvgxTTtMHseSpXn2lyXbUD1Ob7bPVGpjSifpwecXQ6hXmIHS/KYSLyxDX1PVcfecp
         bWuB6njKZXn4UVYTkklDkblKD/zvqwDEXo3wmy6hebF+RZVldsXvqCB/vRm/jS+e095q
         axxhuJzQ22knu5NvbqlqygbOtn5jbygn/TH8n6uZAogQkAZdTy44hqhjUTE7F2UUnKLr
         NHIg==
X-Forwarded-Encrypted: i=1; AL+hErGScwv6ddu3LErxr24zws+7Dqc566B298o8zNVNSNNYqFNw17El4z7rI1OKjCftz6etr79oDppq4c4RvFzsQw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+O4jGKFD1PuIEKFEHdL27onpCPILAoiOy2DxpU5po3xPXny5av
	cIdt8etvd/Cv+3UFOKQE2VtxANdXMxLEipKBx3GAodH3Sw6ihOE9Lt5cmpBv/xzWUhp/PCiztHu
	KpxjOtUaZ6QQwuqQAQZS4sNWka+Z4Irciyaz5x7QSI97sJoybc8o17VnPCS7/L/4XmDmj
X-Gm-Gg: AZFdTZfdH+ZTXX1o3C79w0vt/dZIKVKqO1FXlc+GA/hyi/gtBhOaqj9nZ1D3aHuOnYd
	2ooLNZMQ+4CCA0kd/6dN8sj0Hkg07Pj3D21QfImQGuDF3feprYVGtSKMse1oD0o1GITJAWPYi0y
	3WZziQaaVmqMGHMDz57DyGnaNKBXU6dAHMJs8glYga+t91WzT7KyACOv1V8CNsiuu8gftdBNYlr
	wHxfdIJf98XlsdlhB1cB79zL9UmkYX5F+3okVK2eXvY+iuL/ENm/bCnErg54jklbknYFf3QF6P/
	dZFgMYNIwoOknYI+sOfhE9o1K/GiriZSKt6mv+5djcE1GLSLUs00CGJ9VS+L7LXOtK0ckBFDdVF
	9kcJ45xgWxAPNDdjJXeAQk5vEZpVlkkMr2UjoRp28ofA=
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb887c2cb0mr419593095e9.2.1795629941951;
        Wed, 25 Nov 2026 10:05:41 -0800 (PST)
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb887c2cb0mr419592265e9.2.1795629941333;
        Wed, 25 Nov 2026 10:05:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm840055385e9.14.2026.11.25.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:05:40 -0800 (PST)
Date: Wed, 25 Nov 2026 13:05:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "chenglong.ma" <longpareto@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Message-ID: <20261125130424-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: Gnmq6kXIzJS0oASZepsZQw_kxBbmSYig3k2-PCWISUU_1795629942
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

why cc stable did stable backport the buggy patch?

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
> 
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

