Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB82D8766
	for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192968; cv=none; b=mx7fuAsJ/f0gzN7kedDvL43nJ/6bgs7nUG+2N2c7P2y7Fs8erDYmfGw6Jyo2hcpKuParuQvKdYbIxHtNL7NvXWbnoqt7YWny5HciXFWziRqkQhxOh6hjn/yU3eUVeY/za4Nc506ickA0ldYF9Af471wRQx4GPwGgG4ccbbbLZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192968; c=relaxed/simple;
	bh=ysK3LJORetfqe2m6QiMRCxCJNBHvLtrt2UrUawZ1XbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B5CzADXioUEtZDS1k+B81nP8JbSJEDDZLLymQ0fguuMOgYHHgViFALTq+gsXI7Qtbxs2Sfv0GaDD1RPKnNJ/dj3evovnVNziPoBazzx36wF2zSEsKtvr10C16rMA8cJ2qoFJ8zBeDjgf3p/jAkBRQ4AHmQ5r6DAug9Ot1jkO4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8l6Lnqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8l6Lnqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753192964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMsmk24wS4yO9z8lRswa+OHxPzX/WLAHQmwdnAHVCQQ=;
	b=b8l6LnqttsqQULRyVzU9Ca7C4Oo23FIAg1WWsEZEQ6DFhDRpiiZTUEgo69IKddaZ0cDS5N
	o+c2Q0K2OIJjWHYAy/oL99K86ViccwqcMzY/14s6orvfFD6PlW6OxPTBWcNono6wz+cqQW
	JRDq96N9N07nYPLq+0f9uZ72xYCGwYI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-OCL2p6G7MN25FyEILz_AQg-1; Tue, 22 Jul 2025 10:02:42 -0400
X-MC-Unique: OCL2p6G7MN25FyEILz_AQg-1
X-Mimecast-MFC-AGG-ID: OCL2p6G7MN25FyEILz_AQg_1753192961
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso32898915e9.1
        for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 07:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192961; x=1753797761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMsmk24wS4yO9z8lRswa+OHxPzX/WLAHQmwdnAHVCQQ=;
        b=c89NVBff9yu36SVLgaDctNb1u0dHKMWIgm858ggWiOSRRtRFbClnOyTZoy2EYC6SRn
         72CIZ0CF6HW7RDXOCz34MTU22ZKIiz7aTVh4VeRN3JEkA8BAICP/dknYLglYWs0OncDc
         e/7u9rOLqBsfELzJw1y7LxOfhTLFe6TAddpZ40HNNh+DVGVx7gUbFUhvT5FhXL8JJXr3
         KV2EFK8qBpHJhcXxFQqk6gyFpi5P8/YGx6XlL6xKm6WZXN6D63n/y4TJsIoqlVg/7xse
         EOQfLxc8+1a6rbFav+UBSvO4oQwdzggcSxREJTtbBdLm+Z40TmkHTEi4VFHqKK2bdDRz
         FDNg==
X-Forwarded-Encrypted: i=1; AJvYcCXYEPGFMfLLxugCBKFzNglxZiSXiPllfQc32QJAorl3xmAfZDwqmX4slKMJBJ8r4xJ4wvleycZFJsHQWS1R/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYitF28u0D0D4P00uquWiwMh09Ir7ydlI+Nq1Yzzi8+cIW/7VB
	LaP/iW14+lY0Vr1WbRPESA6PZiNYherbfeC/WhrYJKQ9+Xl6CmMrqpBnRnijmaIqDI1+D8IXvhH
	zBkb+93ZhbyB6T3PcrlQNh9adodZmck80EfSWMACFMLPcmhrwUwWeJpB4N9uzVIE/seF1JV32Z0
	feN/A=
X-Gm-Gg: ASbGncubu/mN0KQIzWcua0l+6lBOWjJJuY9T1UyDSRuihUtgno3lcMJM6v2+OL0aOGZ
	4WsRanVnR7gh/Mno6FEGF4kC00X4ziQoMf71GPtcmLATCBn1MHyOpsbyEln8xtDQz36jFH+/Vee
	MhA4yxK4m33xMSmHy5x8iIPdxif1vCJmzsVB03avIm4Hz5e49BV7iQSjSM3s4D6xitztW4RwuXG
	8PcZ3d5nnyvZmDlAvYokoEKjdbzt2y9cUnR94ZkAXQt5e2rQtW0o5hMlOwrQsipiOAmiGQSKzcN
	ONjI5sp4Ek0GbEw3Eg7wT7j8wXbzpdnvqYA=
X-Received: by 2002:a05:6000:288b:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b60e51bb18mr20665651f8f.44.1753192960712;
        Tue, 22 Jul 2025 07:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUumw18vsojS8d7RLLYLqcCC4C+084hSxa3aZSAolLXdq+v6zn7t9vvSh5JY0kbpz3zyRebQ==
X-Received: by 2002:a05:6000:288b:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b60e51bb18mr20665426f8f.44.1753192958410;
        Tue, 22 Jul 2025 07:02:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm196540625e9.26.2025.07.22.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:02:37 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:02:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
Message-ID: <20250722100213-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org>
 <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _32yNsTMRJSYoNM87jZUprTz9J58r5CFcYabLH5Z6yI_1753192961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 18, 2025 at 06:09:35PM +0800, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 5:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > > Virtio core switches from DMA device to mapping token, let's do that
> > > as well for vDPA.
> >
> > Pls switch to imperative mood.
> >
> > And add explanation about what is going on and why please.
> 
> I think this has been explained in patch [PATCH V4 6/9] virtio:
> introduce map ops in virtio core?
> 
> """
> For the device or transport that doesn't do DMA,
> they can implement their own mapping logic without the need to trick
> DMA core. In this case the map_token is opaque to the virtio core that
> will be passed back to the transport or device specific map
> operations. For other devices, DMA API will still be used, so map
> token will still be the dma device to minimize the changeset and
> performance impact.
> """
> 
> >
> > At least, document what are the actual types stored here.
> 
> It is opaque to the virtio core and will be used as a token to be
> passed back when the virtio core wants to map/unmap a buffer. So it
> doesn't have a type.
> 
> > I checked and it looks like vduse actually returns struct device * here, too?
> 
> It's just a token, vduse can return anything that can be used to
> identify an iova domain. For example, it can return a pointer to
> iova_domain which will also work. If you prefer to use iova domain, I
> can change to use that in the next version.

iova domain sounds better than void*.

> > So why do we need this, why lose all type safety?
> 
> If you worry about the case that assumes map_token as dma device in
> virtio core. I can keep both map_token and dma_device and make the
> mutually exclusive, then:
> 
> - when transport reports dma device, use DMA API
> - when transport reports map token, use map ops
> 
> Does this work for you?
> 
> Thanks

