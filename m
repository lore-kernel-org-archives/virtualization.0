Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE742B9C7
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562361; cv=none; b=mk3fZn7D4IkPg/highJy/i65sPjSFdTVsxfmfCwcBrfgzuN8YY59F8DQjhzpEa+9P20uw607Ec2MJA5h1we2KLvxH4Sxo/5RyF3hWdapH9YMs9hdx/PAeQ+/wz56JPBXXhXVDK2ctXthHKreOkVwh9lihgmPqoUh64o8lKXCuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562361; c=relaxed/simple;
	bh=VszgEr7MX9Bl2vPJIeDpBUVK8TMsj9COmPwntop6Txk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oiSKxsNe99eM6lXr9sdMCeA/TTW2hWNGTtmjdA7Tl77pgBuOQk4qATGM4UwMsWD21JXTAzEPbsyd0ncgq3KBTC4zkDOih7YFBH/Z8LfFlyi55xMSVTdlwYTTLGNUk/M7nEhOu1wZAdBhuRhgh+COEi+Af1cozGpSIzq3PCCfxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euL7Hdq7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euL7Hdq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AHCuV/Z0bFdLFjkd4awKH8RSgNzsfw23wSDckJ9Dcr0=;
	b=euL7Hdq7GvUtkj8veJZEBK6X8Fo87chEIc6BLAYVwqmEAQqVWSIlHvhpyI64oRl4jeCDzC
	jKxWI3xmaUpqCo/QJbUuqkdB4ltIJqYE83LX21kI5cLoIokJ1JxXMx2flaN1w34+zCq+Cv
	HsFHVdyHI8hspsYSwS1PQpMhzABgRx0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GRJE_3t7MHWfOpxGtsVsrQ-1; Mon, 08 Apr 2024 03:45:57 -0400
X-MC-Unique: GRJE_3t7MHWfOpxGtsVsrQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416661bb85bso3601405e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 00:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562356; x=1713167156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHCuV/Z0bFdLFjkd4awKH8RSgNzsfw23wSDckJ9Dcr0=;
        b=FvKn+6CUBxz0qcZiqF10eVePoE6b3VPalol/Uemfa9UpNz61lOuv4slxzNdLxdUglj
         Ea4t6tnd0a9rP0pqleM5rqVYnbQJ6StJHflyniaJJikL0PkCAYpuVxeooHHkvu+/WUGY
         FEJbpSIX7rXHkGk4YNByHIRvnLaifOlCzp9efFLXVsU4lSZpgixGfbQe/I4fmPpn8syc
         g1EDJ44DrLOm2h5vrIgGcGUwLbA7uG1Q710MCKtGmCeEyIW9Zvp5bAjHYJNpMUrv9lRy
         R3fSsNPSB56/4WPpMg/lurTpuosW/ycNG5KMewJpEa0zdFPw0AxvoO4MfUpvI1HzA4I5
         SZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNcZJC5rZJHl79vgsxli3JJF16/oHUT77hY1VGgYp37ZFQ+Fm3DZDj4k+9kWgLOxbDlazpjiJgiQLXV4oDO91aV8SqkXhTOBG1i/yTSx0=
X-Gm-Message-State: AOJu0YwqBKOma1INufog8LlLb8ZvmYu/chX0mrB1inNQJufyD1cMM2ER
	XJFyesGSEBR+AtJsvWLQBs04JRYRwD33Alj/nI8MSNSJp4W9ECer6d87YOYiHaCzBbFGaoJkAbF
	UkmvMzfUkcwLBKgiLc968MLMVKXM/DPt4xRhUwe8X2qZuG+TLbc1+f6X9u3/DKzaW
X-Received: by 2002:a05:6000:1817:b0:343:9a9e:2ca5 with SMTP id m23-20020a056000181700b003439a9e2ca5mr6186007wrh.31.1712562356158;
        Mon, 08 Apr 2024 00:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELDNHAY++9+xbR5gGN9G3+TeVZ9hnW4qxcSDfW5yXkfKb3mXnJpHEKB2eSV6DN9J3ftBWvlg==
X-Received: by 2002:a05:6000:1817:b0:343:9a9e:2ca5 with SMTP id m23-20020a056000181700b003439a9e2ca5mr6185983wrh.31.1712562355622;
        Mon, 08 Apr 2024 00:45:55 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b00345aa92fa1dsm2219980wrs.117.2024.04.08.00.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:45:55 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:45:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: Re: [PATCH v2 0/6] virtiofs: fix the warning for ITER_KVEC dio
Message-ID: <20240408034514-mutt-send-email-mst@kernel.org>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240228144126.2864064-1-houtao@huaweicloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 10:41:20PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the warning related to an abnormal size
> parameter of kmalloc() in virtiofs. The warning occurred when attempting
> to insert a 10MB sized kernel module kept in a virtiofs with cache
> disabled. As analyzed in patch #1, the root cause is that the length of
> the read buffer is no limited, and the read buffer is passed directly to
> virtiofs through out_args[0].value. Therefore patch #1 limits the
> length of the read buffer passed to virtiofs by using max_pages. However
> it is not enough, because now the maximal value of max_pages is 256.
> Consequently, when reading a 10MB-sized kernel module, the length of the
> bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
> try to allocate 2MB from memory subsystem. The request for 2MB of
> physically contiguous memory significantly stress the memory subsystem
> and may fail indefinitely on hosts with fragmented memory. To address
> this, patch #2~#5 use scattered pages in a bio_vec to replace the
> kmalloc-allocated bounce buffer when the length of the bounce buffer for
> KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
> allocation of the bounce buffer and sg array in virtiofs is that
> GFP_ATOMIC is used even when the allocation occurs in a kworker context.
> Therefore the last patch uses GFP_NOFS for the allocation of both sg
> array and bounce buffer when initiated by the kworker. For more details,
> please check the individual patches.
> 
> As usual, comments are always welcome.
> 
> Change Log:

Bernd should I just merge the patchset as is?
It seems to fix a real problem and no one has the
time to work on a better fix .... WDYT?


> v2:
>   * limit the length of ITER_KVEC dio by max_pages instead of the
>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
>     dio being consistent with other rw operations.
>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
>     backed by scattered pages when the length of the bounce buffer for
>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
>     fragmented memory, the KVEC_ITER dio can be handled normally by
>     virtiofs. (Bernd Schubert)
>   * merge the GFP_NOFS patch [1] into this patch-set and use
>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
>     (Benjamin Coddington)
> 
> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
> 
> Hou Tao (6):
>   fuse: limit the length of ITER_KVEC dio by max_pages
>   virtiofs: move alloc/free of argbuf into separated helpers
>   virtiofs: factor out more common methods for argbuf
>   virtiofs: support bounce buffer backed by scattered pages
>   virtiofs: use scattered bounce buffer for ITER_KVEC dio
>   virtiofs: use GFP_NOFS when enqueuing request through kworker
> 
>  fs/fuse/file.c      |  12 +-
>  fs/fuse/virtio_fs.c | 336 +++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 296 insertions(+), 52 deletions(-)
> 
> -- 
> 2.29.2

