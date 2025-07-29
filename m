Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AA1C3C04
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783011; cv=none; b=Di/3ZIstVWzu/ggxYLGcrHzjGTPg0+WN6ClZdBAWXqgRBXWIBAbY6uJ0EqCj7tuPWv8g3QLDwy/L5EUup/zBd4w9rxRhhszim1A7anGnEas7dH+EPcFDNnkqp9zBgakwvrWgsHJ7cpLzE0fKkhtcIx+Iv1rt7xvZ+YXhT929Rf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783011; c=relaxed/simple;
	bh=zs5ODgjq88Dh/p97NrIETQcV4sqEQTVPW1IHpVCIj5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Tah7iUa+PV3xYLxActLfQk7f0eRVGTjTGkTpBr7dzgkfb+gA5lXabyc/sUakMz43AGWQBdzpPqtF5iUGPuBq7KWhCXjqKVXHUp7apvJtrg5lCjqjgi7j+88vjnuF0qD1rDKgW1kN1MoB7Kd7ybdlcJHmI5OCFBf1rth47aJipmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXNIE86Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXNIE86Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753783007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9Q72PwGeVTj3y8z/xg+PR9uIGfJgkCfjcqVd6z2uJw=;
	b=cXNIE86Zcy7SZMXeY209e6lf4p+0ZiAe5fbXpyXJNVDwgHEcKCCM9qGYKQ5Zofdgt7dREU
	IgE4pqFEoN5/+3uEZe/CMrYmWNvWIr0WC/d002sxwqk50mzhULDBny5D5Kw4r64YidCh7R
	UQVcxy4VzLvzzOMXo/5NbVaJlxOBY4w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Ij11pgccMMWcDE7oEaUW5Q-1; Tue, 29 Jul 2025 05:56:46 -0400
X-MC-Unique: Ij11pgccMMWcDE7oEaUW5Q-1
X-Mimecast-MFC-AGG-ID: Ij11pgccMMWcDE7oEaUW5Q_1753783005
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae9bf1c5947so69652366b.0
        for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 02:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783005; x=1754387805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9Q72PwGeVTj3y8z/xg+PR9uIGfJgkCfjcqVd6z2uJw=;
        b=ScOLkQJrGfdWdsYu4NvDEqUm+0E3NpDPvxdAX8uPtXpbv4CTYl1gidNHV7M8AUj8DZ
         T85pafW/qbgm8TEwbJzIorTOesIUzyrApmPE2Wy3xvf4W+i1jw+VWBB6gfSrzAnFsPdR
         FzmS2CjgUjih8a1oSVEjd5zvMrX68dXmwZ+Y4FqfQnZxBHQn5iktqskOQKPn598Hu361
         y2zlEPnjkLzRcvL+h8iFiOdOtZEkr9LgH+6wuTiQLBTzet/HENivFL51bNVUz+9ikw35
         unc3rMuNn/YIj7X0WMG82PpgD3HbX9h5QJCzr6En2XAECokM3u40Uxppb/wq9vjuuRjz
         iLxg==
X-Forwarded-Encrypted: i=1; AJvYcCUqgQ+qalhs1nyt516I47RLtzMPIyT76TRuJJfI06s+rPKocAsXwcOuml+eG7367AnTcLF4RjZcP1cFmTmeJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPTLZJkbANF+2mdI3pkgNjvFBobqj5fCIU9e2XMSA4tpyrKdde
	9DdmkBYN3GUGVH+ixAdTsvIrNn/HjHaKZ90d3TLYCbnyk0wFn8pQH56y8DYb8EwiD3wfOuw/vcD
	TMw3iR2riLj2wW7/c1hau42q9uSiRqiph77VI08TokK2lAJ81CrBhPQ8TELyFqcoSsjha
X-Gm-Gg: ASbGncvnCeJe1hbXRLE3zk8bdaj8SDX7HGyYKMLgqyXz69+EzLS9jVcFtrLcVuy12Ou
	dLAF3bRAfTceBLB3C8xkllcltHgoRQ3zjpr0eG/xAmDOUnNdSLS4XutRnOUFqyfAmM4n4hiK7Rk
	1IxAMVeRh9ARIs0FUjZ9OuYMOsJ9gXYlOthCZ27ZzDP2Rga4uvj02dzA4TGwrOYzX6QFRiiWLYj
	h6wCIQqzvd3xFG5PjvBRtyna15bNnNhFcsQzbpxTs/HsShX1pyVSCl3eXfZsH3yYjHZGhdEeKTh
	4ZHbcEF9kO2QdTxYPHXC5jbU9gkF4odGanmh58wxSE1RLr8SpGy88//U2cFAp5CL/XHq2jd2w+R
	eKfpzd+EXp6wQTsM=
X-Received: by 2002:a17:907:3da1:b0:af2:4690:9df3 with SMTP id a640c23a62f3a-af7bfd85f30mr309160566b.14.1753783004779;
        Tue, 29 Jul 2025 02:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGikTxgu8BzOOJSc5KnbVu6iBWvoq2vv43KLwCvZ/Y6ueWN7/Ah83jj2TRypRMINdlKpJ2KOA==
X-Received: by 2002:a17:907:3da1:b0:af2:4690:9df3 with SMTP id a640c23a62f3a-af7bfd85f30mr309159366b.14.1753783004396;
        Tue, 29 Jul 2025 02:56:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500addc6asm4421025a12.53.2025.07.29.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:56:43 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:56:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, JAEHOON KIM <jhkim@linux.ibm.com>, 
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
Message-ID: <6yp7ww6misiazdkeumkklrds2e7s3cmgf42lafvukhhqtopby4@ex6h5km4hq5y>
References: <20250729073916.80647-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250729073916.80647-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b6sQWmzYj3O5AHwTKSuETQBTNUjtG5H-r8twGrgCfyM_1753783005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 29, 2025 at 03:39:16PM +0800, Jason Wang wrote:
>Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
>vq->nheads to store the number of batched used buffers per used elem
>but it forgets to initialize the vq->nheads to NULL in
>vhost_dev_init() this will cause kfree() that would try to free it
>without be allocated if SET_OWNER is not called.
>
>Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
>Reported-by: Breno Leitao <leitao@debian.org>
>Fixes: 7918bb2d19c9 ("vhost: basic in order support")
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a4873d116df1..b4dfe38c7008 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -615,6 +615,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 		vq->log = NULL;
> 		vq->indirect = NULL;
> 		vq->heads = NULL;
>+		vq->nheads = NULL;
> 		vq->dev = dev;
> 		mutex_init(&vq->mutex);
> 		vhost_vq_reset(dev, vq);
>-- 
>2.39.5
>

