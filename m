Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D033F7
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658332; cv=none; b=Z6pCLUXLeryeFASozbdSrFYT1QI6m05BKKuMEXzh7igWHtQSjaHv0OdlwebUIiN7Fr364wc8TZKYkfEZbYpBBS/D5ZUZI/XlKNBP7AdKluRNuGOMvAvU+xH3asKhjEGynaErGuwRWY8L+buWjC6J+j4r0WOmeq2PCAY6Q+fF7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658332; c=relaxed/simple;
	bh=oogjLwTgHPDKdJboP9zTfcvNz3yggXEeinlMPoQL/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XGtv1+owbcsNf0HU6g7hhBwojRV0C4QFGh81+0NDEKpyYbpBz4ToUanAjnVdar/MR5C+F83/uB0yKZWsmj/lxZoZji2SxXQ9zCHtBekUZLbcXiMzNh8+64qHgIgk6W2GHwdNORULOAX1TFzgYK70vmQ3I25JVH2LyLIwjX/Zwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMtTViKg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMtTViKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717658330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnNgXsFNzCy0InHxHbl/oFWafRsx14xzXtW04Ib8MOQ=;
	b=NMtTViKgqPqk5pDscvP59PByZEdFQgokcPf0if1V3ejQHExOQFuNMdiH65uNkB8qti1nGK
	IN/ePNstsx3WYP/YM8d62NkDExdNiDQ8ThQFqbZbkkqWew36GlnKHgAILt0CGeW4ro7vJb
	iMCJUKpSRDQUycd/fXHuiMhTgK8v0nY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-7BjzEijfNeeCmq6bxEVNbw-1; Thu, 06 Jun 2024 03:18:46 -0400
X-MC-Unique: 7BjzEijfNeeCmq6bxEVNbw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6a4615420bso18866866b.3
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 00:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658324; x=1718263124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnNgXsFNzCy0InHxHbl/oFWafRsx14xzXtW04Ib8MOQ=;
        b=tw2rDCvHJ4EwphRzdQJa1AvvjpBbqLq2JtYHDv2vv2mzy1B0EXbD/ajih5klKFdnQ6
         6Fdf3WYIRDIAPJAZr48BcVP/dFaHgZ5B4mid6G74dLvcRqzDl28hwEhSqLSkGAyduuyq
         0IZpaXb8fufm4dAVahXJNCif6mNHwHda7DobI7zT9/OrujkRYqHCe+5BVHQVtfkpHgdQ
         k7XxOv4IOCko8FlgYhGXilpVmrHnOq2YFay64kfamgtgpl+GY+d2tnoeQjCeCpszIJ+K
         5oL1RYaYyQmbnQfBXkMcOkC7Wp89ytA19/aYClnOyA90Ui6SCdgWnWOtPyyJstOYcMWg
         +MPw==
X-Forwarded-Encrypted: i=1; AJvYcCU6SXPHVmsqUtAia6AliKyFNK//SnJtbF/IbtwFaoXFBxaXHlc27zrx19j34EnLvGp+m414eoi1jlVwqugyrZM5c2ii4Xuvt2uLrioOM4A=
X-Gm-Message-State: AOJu0YwF4MaOuk8I1XLLklMR/liMGKFhHnZnykE0K3MkZzyS66EbhuTq
	5aY1j3zrjBGMKRANG/aRmgZpsDWDCnZFUZj9YmBhRJUeWh0xP0LuBlkust5OvXKWAllGppxyRBx
	X1p7Ym/qVkFpa1AEBNCaKETzL5cwFgUqHpnNp8nSP9/FR1sSe5FZwmNY5f9M/0BMHzQJG78ni
X-Received: by 2002:a17:906:f28f:b0:a68:dff5:b153 with SMTP id a640c23a62f3a-a699f67ecddmr302761366b.33.1717658324223;
        Thu, 06 Jun 2024 00:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ0hybjvC9Ghsz91IEElthfbzx3nnHI0CBKidzNm5YHGJFz2dGcO4+FDkQheBagmgGj19jFA==
X-Received: by 2002:a17:906:f28f:b0:a68:dff5:b153 with SMTP id a640c23a62f3a-a699f67ecddmr302758766b.33.1717658323740;
        Thu, 06 Jun 2024 00:18:43 -0700 (PDT)
Received: from redhat.com ([2.55.59.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581716sm54728666b.19.2024.06.06.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:18:43 -0700 (PDT)
Date: Thu, 6 Jun 2024 03:18:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: cuitao <cuitao@kylinos.cn>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to
 complete the memory initialization.
Message-ID: <20240606031810-mutt-send-email-mst@kernel.org>
References: <20240605135245.14921-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240605135245.14921-1-cuitao@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 09:52:45PM +0800, cuitao wrote:
> Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating it,
> without the need for an additional memset call.
> 
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  tools/virtio/linux/kernel.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 6702008f7f5c..9e401fb7c215 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
>  
>  static inline void *kzalloc(size_t s, gfp_t gfp)
>  {
> -	void *p = kmalloc(s, gfp);
> -
> -	memset(p, 0, s);
> -	return p;
> +	return kmalloc(s, gfp | __GFP_ZERO);
>  }


Why do we care? It's just here to make things compile. The simpler the
better.

>  static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
> -- 
> 2.25.1

