Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964E26C389
	for <virtualization@lists.linux.dev>; Sat,  5 Jul 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751681704; cv=none; b=ZCj+OLbN1SI6wI6uE5O7WZIaTqeo5CPxtDtyHJ1NDG+XvkjYFSeoKnIJQkAgFxR0rtxn5nntMyiIV/ows8TFnXKray2kd+ZclV3yCypKGbho8jZFXs9esg3B+0lwLrJ/HHdxoM9P09aGnYd95CHjlbFQhCajOTnMGvvYrX/ca4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751681704; c=relaxed/simple;
	bh=MoeOv5EYR7ND7dvTc6nQZXoheLui3KxYD5UFmlAelPs=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=l66lg7PAEX3cIARXOq4TSO0Kmi3yGyAA+6c3p8ZByV6N9Yq05QSDLXf+ye2cCnXK86QXb3tVYrronXqD7mZS4RFYHeZmklviBdvtppxUY8pmzTY1LURTwyY1ZhG7PW3oKCiB/IJGJOOa69TwOr0L3sXf0zPWmGlzQvKU418Mzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bYvGS6g6rz4x5ql;
	Sat,  5 Jul 2025 10:14:56 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 5652Esw6038063;
	Sat, 5 Jul 2025 10:14:54 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Sat, 5 Jul 2025 10:14:55 +0800 (CST)
Date: Sat, 5 Jul 2025 10:14:55 +0800 (CST)
X-Zmail-TransId: 2afc68688a9f1d0-59690
X-Mailer: Zmail v1.0
Message-ID: <20250705101455762ft5u2uZEb7wz0TROzD52R@zte.com.cn>
In-Reply-To: <879d1fa7-04a5-403c-8d23-76631a67f560@kernel.org>
References: 20250704152047205U11FdEih1MxrmcmAz0Xpp@zte.com.cn,879d1fa7-04a5-403c-8d23-76631a67f560@kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <krzk@kernel.org>
Cc: <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <mst@redhat.com>,
        <eperezma@redhat.com>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdmlydGlvOiBBZGQgbWlzc2luZyBrZXJuZWxkb2MgZm9yIHZpcnRpb19kbWFfYnVmX2F0dGFjaA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5652Esw6038063
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68688AA0.001/4bYvGS6g6rz4x5ql

> > diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/> virtio_dma_buf.c
> > index 3fe1d03b0645..18d261ba5197 100644
> > --- a/drivers/virtio/virtio_dma_buf.c
> > +++ b/drivers/virtio/virtio_dma_buf.c
> > @@ -35,7 +35,16 @@ struct dma_buf *virtio_dma_buf_export
> >  EXPORT_SYMBOL(virtio_dma_buf_export);
> >
> >  /**
> > - * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> > + * virtio_dma_buf_attach - Mandatory attach callback for virtio dma-bufs
>
> Read kernel-doc.rst. Missing ()
>
> > + * @dma_buf: Pointer to the shared dma-buf structure
> > + * @attach: Pointer to the newly created attachment metadata
> > + *
> > + * Description: Implements the standard dma-buf attach operation for > virtio devices.
>
> That's not kerneldoc. Which part of kernel-doc document documents such
> syntax?

Thanks so much for your time and feedback! I’ve made two specific fixes based on your notes:  

Added () to the function name in the kerneldoc comment (e.g., virtio_dma_buf_attach() instead of virtio_dma_buf_attach).
Removed the redundant "Description:" label and simplified the explanation. 

Let me know if you need anything else in the meantime!  

Best regards,
Peng
