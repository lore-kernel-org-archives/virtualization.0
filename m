Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CBD53C
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447961; cv=none; b=l4gKV7CWmXImplNDMhEq+XFerQ+YegUa3cdfpHV/3aLhEVKs3oipFAQWC8/QPlhH4yYQO54WVSTbq0/ndH72wUngzIAqJtIeyo7QIsymJnFDeT5E4+rJw5vjpBTfjlex6ht6HWgiB8Iardt1puukdF1+0c44iiA1qPm3kjc9OIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447961; c=relaxed/simple;
	bh=XzcSrF6fIKxM7uXU30UXDlxTAJJTRCFxCufcmNnMhI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CQQwIe9TNN4pgG43CER/6jn74bXd6AUMlQNOKMOyoIjpsCeHR+4zrFP40yAMMUzNmXj/JWVwt/twkgh/x5rMDRCjm2RLCZgWHZUI7QQUAxQqEBS5JlFH8xrLuqGc+JOEMeXNxBlE/2zGGbSlTpXl+8MtGcJuLvV56TUgci4HYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNcOfESn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNcOfESn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731447958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEXKPYAc3peE3acn5QFpQ/umi0YhyN29WLWtIZ8OcXM=;
	b=eNcOfESn609boXvxeyp2fahRFfPqgdMdGSszVRw+QnttggO6YFH1Eewg0jIRwK0GuOA+zQ
	Ny6nKAzmeGpOqXT7nfIOLsz/kFeKreZrudHTrs6xvYWubv9Oc4zz0ueK1fJvVaoj501Wn5
	WlPMDjRYxxsTi7fu1iax3sNkIOsJMlA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-q3o5j0gcNX2k7DMnqhQrng-1; Tue, 12 Nov 2024 16:45:57 -0500
X-MC-Unique: q3o5j0gcNX2k7DMnqhQrng-1
X-Mimecast-MFC-AGG-ID: q3o5j0gcNX2k7DMnqhQrng
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d47127e69so3174946f8f.1
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 13:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731447956; x=1732052756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEXKPYAc3peE3acn5QFpQ/umi0YhyN29WLWtIZ8OcXM=;
        b=TtXlw0RVYfOPhfqLOSwl6LZBwv2QiAInS4wpp/kO2MBWWgLN49jCAwtMxow9E/sWld
         3tOserz/epbFC1BW3xLRpvWsY0uyDWh5wW0ahOqONtxgrYjfwiHi4NclREYCsx75wQ3x
         9EpXMprMqTiV/h7xA1eDDkYUSPDzSrVGaQBPqEdRmRUJYZzoQVgkMVFZRX1FXGIoatgf
         TXzVKwGuhvKgnaUnwLAwOGW1X2mpHUlCJM0bJBsp7cXmsyo3B8fWwqIlvOb7pZdpYkDu
         8Z9eekBqAAgH5qzjE3/PFqimN6hZ4NSlJky9NUJ+Z/2uh3KuNUp3oj7XEkhN5ncMrJrF
         7dJg==
X-Forwarded-Encrypted: i=1; AJvYcCW/sQxA3RofbDvSfu3JQn/iUpm38p6TgExfHFCwFYranE27VCizAST7NHBweOdT4Sh9C6EYxGqElO5j3W+5sA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXrWPQVP2Yt1iZT4Zkdvqs7GNTLdXmeVGfiLF1VbmKC4RfLnLh
	SfV93zOOw7JplPXLRcfjKBkyt0nadODdnpB9v0P86wySU8orDip9UXeMdyn6fNvNPqdveJTJ14V
	8NrmkkVucfDzxR9igzYibqNuHXbJ6tX7c5JGED1GdtZpY4GXlfLF55ArrFtQKgchE
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr14710790f8f.47.1731447955907;
        Tue, 12 Nov 2024 13:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4LGnvjV0VuCH9YfFtTizkXe46PL/o3H5AzRLIPG709DaWPYimrxeFeOhgxLEtRISOMi8Iqg==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr14710779f8f.47.1731447955557;
        Tue, 12 Nov 2024 13:45:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9978c6sm16376608f8f.50.2024.11.12.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:45:54 -0800 (PST)
Date: Tue, 12 Nov 2024 16:45:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Message-ID: <20241112164527-mutt-send-email-mst@kernel.org>
References: <20241111025538.2837-1-jasowang@redhat.com>
 <20241111022931-mutt-send-email-mst@kernel.org>
 <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hj4FI1dT8zrj7-wbZirNBd-wGkRzBxvkiKmpbYs6Y8A_1731447956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 11, 2024 at 04:36:52PM +0800, Jason Wang wrote:
> On Mon, Nov 11, 2024 at 3:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > > There's no need to sync DMA for CPU on mapping errors. So this patch
> > > skips the CPU sync in the error handling path of DMA mapping.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > DMA sync is idempotent.
> > Extra work for slow path.  Why do we bother?
> 
> dma_map_sg() did this, since current virtio hack sg mappings to per
> page mapping, we lose such optimization.
> 
> Actually the path is not necessarily slowpath in some setups like
> swiotlb or VDUSE.
> 
> Thanks

I don't get how it's not a slowpath. Example?

-- 
MST

