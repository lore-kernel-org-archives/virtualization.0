Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871742F617F
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115675; cv=none; b=U8XeA3kreRki4n3b2AWhGjeY/WgUxhYlrEEcG+0uS86XaZrk2P/M7W4JGflhR1htF0vobG+bAEnZTNXxrSN0zNlW/NX8SYsKV4nUDvetdeiqsmxdUmG+uV5HPBwodB8iM3I69lzq00JOjHoEEqRELz3wcSkc8m64PszwzY75HrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115675; c=relaxed/simple;
	bh=mRoOw6VYyiiTS1YBHJ5D9LVd2pT+NRtpTb+npro7BDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p265ync5/FWTdSNkuJxksDeVeTZhA2xJA6y/3TpZbW5ImTe5oPQxIDjWhXszL784HTqiFQFpeKHHz3tS5L/A+sB4OMDzRIUzvlZrsRlIT3ZLHcKnjIcm53XE5KYtq6McLr51MWTm+tjdi25KSCEmktImAgqG+A8XEjVxuwI5cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnQ16SZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnQ16SZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770115673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie6mxjNs4nfKhcvDWOucpJYRrzrcGs6LSUHOCzj9ABU=;
	b=YnQ16SZAvh4H81ruOkJV3TUPjfiJPEysSgFe7LmBBfP6yZF/7CPejcfwM0TevQHdTrlz2G
	C/9h3pzqEsIQr0CDt6HgOdSrPLlJWBCC2kwwkfsxEpYx0pQSkuL4lWHtL7EEtrUiiw4I0i
	+bxJa8lm+lD1K0Tzc2kew/Uaj8RuzmU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-sa9k5iceMcyWbpqGp9ig3w-1; Tue, 03 Feb 2026 05:47:50 -0500
X-MC-Unique: sa9k5iceMcyWbpqGp9ig3w-1
X-Mimecast-MFC-AGG-ID: sa9k5iceMcyWbpqGp9ig3w_1770115669
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806a27aa31so51104745e9.2
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 02:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115669; x=1770720469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie6mxjNs4nfKhcvDWOucpJYRrzrcGs6LSUHOCzj9ABU=;
        b=k+FojSjZ8xHLJUQicIYWz42hKCqsHpgal9e3Br8oiwX9Fco9fT/dyg4tyoDQSLkkYw
         SE8ZBXTnBdEJficBE5+t4hTQwuU2mPrLjhapMr8IQt+nNf8A6tQH9aSZGFPuzGpu6Xdu
         dKQ8YKS1Sdc6VtiOLdaJBdx/Tcz+h76AvczvInjiZ5y3pITP+hi6xJkWpE+H+v8/ztyw
         TTqevMoVZ2cArJAqnG+unRcJ8XDj5H7+Pz7cbX8T0c5+qAl3D3CiCToTmJi+2G6mSaGh
         lr4yuV+5hBLA5IrcesXH3zILXpFzz1RebBzX3POYfOMuKjGwR+Py1YITZghMZWP+VqSE
         TmLA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1Ev8f3eeE7F48H9tsHglHHxvOAiHugioZHk8hNwtdurmujVcbffJZwCuTfSy9DT7Ed+MA9cft+AfJMcQYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfKToydScUs9BCFZE7kKOylQGv8l8gn29p4Ujej0J/57VG+t8N
	fhHi190ltWvKBLU3wJISp2OOyef2O0NGas831JtufxugEMrZs6lCDYI+hkA9xpMJTUZk7JglLxh
	2jhHf6gH8+WO1/zAy5qMGp9XhVAkglJH4I+eiqEJQKN+XCqfIJfwxPMlMmtltZ38ZJzzj
X-Gm-Gg: AZuq6aILCsPL6QYETVJkMXAOK85roLHAi5a55A1DZ6CvEgEzwP+STwaVPPA7bjM9ddt
	yQiMuUZF3CUTN+eIDy+p6w1SCwgqvs1fTHgGAChGCJjZ7xFu745s+1NTv1WuysY1PDCz8wrLBIY
	jeQQEFXx9UwOBgI2qzn1butwHZ4sXB9ABM55UsuNS2mA7++ItXumiwYcuqzm4l00qONn+3RQG8w
	8mw2SXRUZ4370aYDrKo93MqU+Lct+VxyxZwsajJQs3evlDhXKm3lhFj5+SV6M0G7+rrYfu+lSr+
	snzRnPRh8le5xwJ5qRVJkcScAIfp+vbgmXIYlejKZc7ejgxRCY4g4ZMQu3D7hsyk7y4gAw7YauP
	aDnQg7WoFDnjNkbItJPt1Galq0In40/GoJg==
X-Received: by 2002:a05:600c:138d:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-482db493a03mr225030745e9.24.1770115669127;
        Tue, 03 Feb 2026 02:47:49 -0800 (PST)
X-Received: by 2002:a05:600c:138d:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-482db493a03mr225030365e9.24.1770115668670;
        Tue, 03 Feb 2026 02:47:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512e0edsm59162025e9.7.2026.02.03.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:47:47 -0800 (PST)
Date: Tue, 3 Feb 2026 05:47:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260203054152-mutt-send-email-mst@kernel.org>
References: <20260202224835.559538-1-arnd@kernel.org>
 <20260202224835.559538-2-arnd@kernel.org>
 <20260203050216-mutt-send-email-mst@kernel.org>
 <fb0a4664-4509-4a50-b717-4ce842ab2a6a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fb0a4664-4509-4a50-b717-4ce842ab2a6a@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PLJOwtxLKtUnAEGOiNrhLcB6d8tCsYaega7QpIKsNsw_1770115669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 11:39:43AM +0100, Arnd Bergmann wrote:
> On Tue, Feb 3, 2026, at 11:22, Michael S. Tsirkin wrote:
> > On Mon, Feb 02, 2026 at 11:48:08PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> These two ioctls are incompatible on 32-bit x86 userspace, because
> >> the data structures are shorter than they are on 64-bit.
> >> 
> >> Add a proper .compat_ioctl handler for x86 that reads the structures
> >> with the smaller padding before calling the internal handlers.
> >> 
> >> Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
> >> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> The code is directly copied from the native ioctl handler, but I
> >> did not test this with actual x86-32 userspace, so please review
> >> carefully.
> >
> > More importantly, I'm not applying this until it's tested)
> 
> Sure
> 
> > ifndef CONFIG_COMPAT around the structs will make it clearer
> > they are only for this purpose.
> >
> >> + * i386 has different alignment constraints than x86_64,
> >
> > why i386 specifically? many architectures have CONFIG_COMPAT
> > and it looks like all of them will have the issue.
> 
> No, the weird alignment rules are only on arc, csky, m68k,
> microblaze, nios2, openrisc, sh and x86-32. Out of those,
> x86 is hte only one that currently has a 64-bit version
> (arc and micrblaze 64-bit support never made it upstream,
> sh64 was removed since there were no products).
> 
> All the other architectures with compat support (arm,
> powerpc, mips, sparc, riscv) have the same alignment rules
> for 32-bit and 64-bit builds and align all integers naturally.


Oh interesting. But the code is compiled for
and generates useless code for all CONFIG_COMPAT right now.

The ifdef you need is COMPAT_FOR_U64_ALIGNMENT then, I think.





> >> + * so there are only 3 bytes of padding instead of 7.
> >> + */
> >> +struct compat_vduse_iotlb_entry {
> >> +	compat_u64 offset;
> >> +	compat_u64 start;
> >> +	compat_u64 last;
> >> +	__u8 perm;
> >> +	__u8 padding[__alignof__(compat_u64) - 1];
> >
> > Was surprised to learn __alignof__ can be used to size
> > arrays. This is the first use of this capability in the kernel.
> >
> > I think the point of all this is that compat_vduse_iotlb_entry
> > will be 4 byte aligned now? Very well. But why do we bother
> > with specifying the hidden padding? compilers adds exactly
> > this amount anyway. Just plan compat_u64 will do the trick.
> 
> Right, I could remove the padding field here, since this is
> just used to document the size of the otherwise implied
> padding.
> 
> The patch I used to find the issue originally adds explicit
> padding to all uapi structures with implied padding, so I
> did the smae thing here.
> 
> >> +#define COMPAT_VDUSE_IOTLB_GET_FD	_IOWR(VDUSE_BASE, 0x10, struct compat_vduse_iotlb_entry)
> >> +
> >> +struct compat_vduse_vq_info {
> >> +	__u32 index;
> >> +	__u32 num;
> >> +	compat_u64 desc_addr;
> >> +	compat_u64 driver_addr;
> >> +	compat_u64 device_addr;
> >> +	union {
> >> +		struct vduse_vq_state_split split;
> >> +		struct vduse_vq_state_packed packed;
> >> +	};
> >> +	__u8 ready;
> >> +	__u8 padding[__alignof__(compat_u64) - 1];
> >> +} __uapi_arch_align;
> >
> > it's a global variable? I'm not aware of this trick. What is this doing?
> 
> My mistake, that should not have been here.
> 
> >> @@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops = {
> >>  	.write_iter	= vduse_dev_write_iter,
> >>  	.poll		= vduse_dev_poll,
> >>  	.unlocked_ioctl	= vduse_dev_ioctl,
> >> -	.compat_ioctl	= compat_ptr_ioctl,
> >> +	.compat_ioctl	= PTR_IF(IS_ENABLED(CONFIG_COMPAT), vduse_dev_compat_ioctl),
> >
> > Too funky IMHO. Everyone uses ifdef around this, let's do the same.
> 
> Sure. I only used this because you asked for fewer #ifdefs in
> my v1 patch.

It's less the amount of ifdefs more them being placed strategically.
sorry about being unclear.

> If I use an #ifdef around this one, I also have
> to add one around the function definition.

and the structs, preferably.

> In that case, I'd
> probably change it back to the x86 check there, and use
> 
> #if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
>       .compat_ioctl = vduse_dev_compat_ioctl,
> #else
>       .compat_ioctl = compat_ptr_ioctl.
> #endif
> 
>       Arnd

