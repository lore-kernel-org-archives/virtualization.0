Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C03FBA7
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189606; cv=none; b=UoXUcZkiXJqkcDeGPZXJTkxklxoi9nZN6beUYUgwNrKfKnahV62HTXTPyHljJLJjDfGtPjgfv71/B261prQZdPtnORupLWnrYCTq4yvm4STnI1MEOTxV2V5lv0pVTaCuUHsi94rjwMIZgBLlDxdvWlC2gUYn+guvg1A2vGhuXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189606; c=relaxed/simple;
	bh=ngodjvfSmvKDAhoSAS0ov5UY/Fa9ubei/Hr0+hJ35YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=El7l4qAG1d8+k0LDU47rtm3wPh1GC4zHL/s6B9dSEaGkdfejuCB5y418ahO8Q6qC/COzSW5frr6yF5IDWX35K0x9T0GaMHtQDTR7fse5L4vwskeI+eqDzXVlaFptEK5OnSQ0GQV/erwQOB8bQZ0OMGW5X3ANd93ZdhQydzx7KX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8iARD+m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8iARD+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781189604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3w9pl/7ybPBlxrBW6E+7z5shAxFcf8N1LcJaLLuo6Cw=;
	b=a8iARD+mWMNFjvjBXLa3YNQxTEqDu8IKTtKSZF31G3RVkBa05Sz+jF+oZriDCp0I0JRETF
	ghPThzZIIb6tMGwDIZOSer+nURvt60O73dj/k/0soB9sJqlLzFIrEYvvx4s9cN9MP2TWyJ
	zZuW7MTvdxGT7ypnKGSuwFQaRLIvM3o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711--ZqLva3WPBKKA4mYgGsGzg-1; Thu, 11 Jun 2026 10:53:23 -0400
X-MC-Unique: -ZqLva3WPBKKA4mYgGsGzg-1
X-Mimecast-MFC-AGG-ID: -ZqLva3WPBKKA4mYgGsGzg_1781189602
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eebc943bfso623462f8f.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189602; x=1781794402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3w9pl/7ybPBlxrBW6E+7z5shAxFcf8N1LcJaLLuo6Cw=;
        b=aVHyHTzr6ysqhBGmIaxwx8YSI4Rw7KmQWVefOtv5vopVd0T0mr48JESN6lWCpKBc7k
         Y9GQCAJM80OqrbfTeX3FrQyRQcbLrXcNFWrbnLYOvD3j3K+MMpID5IM0qrQ7tRB5AbL8
         eiBgdE/5m02/avROqLWisQ9bI0ypP6eOgPiL4HRi5axby8XTSFNjbWUevxm12Uygz3Ta
         yq65nMKhK2LSc5Euz1Y2A8nNnkJRludzK4cqIFdNKGx8hoe1Sx2U1vG4s3ADKB+IqFJv
         5EKRk7Ch4LTOidgJ/lVNRjOVBEh+eYqaEf8wbimQfM3B0cQuaJJ9NqmCKsKusSreJfQ6
         9y9g==
X-Forwarded-Encrypted: i=1; AFNElJ/IuPtayV+dj94YJEK5ARYXhAfdaanL4OjTEsd1MkCmLpKT1wVYz5e30zcMNAjcrWrP2eb2bo6Ue5PoFStvRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIZ+2asQLVqoYEHO8l8vIV1DHOK93ra5dE8KRziPCYlqflOim8
	2GcMWFuWk72+ErPsSg1If/iYlidZaKVt5Nv4rceXueD2qnxeA5mVGv1H3CfrzBNGD78R5iUQ7Cx
	3FMhFJjHZgw4QUNfpYYx6rYWKhMjLj+BnUXCeL4U9RT1lj8YVTa/Pw/J5GREf6GJbypMx
X-Gm-Gg: Acq92OGMOsAjHKG2FH2MOa4r9ih0rnxviScWQyWowVXkMWEAHFnaKhpz+9hkruzrLDF
	ltZEWNiWrv/0AuGcz5Ia/G2Pgk2uRGOHikyyMZMujX3egqEpyXWJCUaDf/jqgQ8PCK5d3cNdzm+
	1zfH1BBJNDyt5JBmp/1cKszcZCpEZsweJfSEL/fp2p4KKSuO3VyLQkSRz6A3/rQow7ZejIVVNij
	TgdAyk4CESBGF9gKmN4+CIWQgIxTZSM/zYVTu3RKS8OLGxmyRxgpp9q4Lgo5cLi+0CLMo93vzwX
	KdtQQuIOsEWYLIfybDqMqHmMpcztjW/6cqO5HgXqOBuF4pRvETp2bbXpgdHGvAerPB0KoF3KewL
	Yq2BbJxh2C/FtQp34J1vYJicyEYbVBdPiNgNlkXdkTQUHwyJ9IrxjKQ==
X-Received: by 2002:a05:6000:2681:b0:45e:f93a:2069 with SMTP id ffacd0b85a97d-46067c22851mr3992585f8f.23.1781189601908;
        Thu, 11 Jun 2026 07:53:21 -0700 (PDT)
X-Received: by 2002:a05:6000:2681:b0:45e:f93a:2069 with SMTP id ffacd0b85a97d-46067c22851mr3992528f8f.23.1781189601380;
        Thu, 11 Jun 2026 07:53:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm76299890f8f.8.2026.06.11.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:53:20 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:53:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
Message-ID: <20260611105251-mutt-send-email-mst@kernel.org>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6DQsgNWd3cYKOujvZ1ykjKiRGn_Zz98spzXXZhHfEh8_1781189602
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:38:04PM +0200, Eugenio Pérez wrote:
> Fix wrong ordering at taking semaphore after spinlock and convert the spinlock
> take and release into guards, so they are not lost after a return.
> 
> This series goes on top of https://lore.kernel.org/lkml/20260610083452.477759-1-eperezma@redhat.com/
> ---
> It would be great if these can be squashed.

ok i figured out the confusion. squashed


> 
> Eugenio Pérez (2):
>   vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
>   vduse: not take the device semaphore while holding vq spinlock
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> --
> 2.54.0

