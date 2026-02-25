Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9F363C64
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031176; cv=none; b=us05m98vQbAOZ3unrsv+cLK5FiGUv25S/nc9bL9xMoYBfivjL0zMfP83Fm37nYW5wEuCylSDoxHxbt+tSd773jcliJk5BmjGO6tUunWSM7IppBiKdvt5JLNfr/ZggYbPHJaq0IBwJDp6qMCwnqjBuuhKsdf3TZqN3GeD0sk8AVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031176; c=relaxed/simple;
	bh=AIGu6G9iujcEAVsIP5DLMzpj29TirlF/QSjLuL8Lcj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AIOxnyD0/WChx8GK6iuqmJj+7eaSMGT0/r+nscrkfpT3Fa9POXyMIctV/Xcl17miJrut0I0nTSOACskvhmAX3soV9tBk4QeUkrlbBuakEahsutsbDIkyypAsTbFo1khlqV36aJJSCUlVFW9i2bdSsllTTUF3Z92oy0qCgJuD1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5TkkB2l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5TkkB2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772031174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D10QZ+digOC1iXeyNRdDRk2hXA+8zGrZxyj1PPT8Oxo=;
	b=H5TkkB2l529advuG8Z8SlaTymmEGwiuDGK6xr2W1VlEWWe+ZtkPGRQj40XXQQihPure3aa
	bD8na2nVQHlY7FgDZKK715C3qUgiQp215wbZAE+bEjDyeNffDkhqUr/+1glsnJDLxIYkEG
	65ZAgYOtEb8E3ArjtOZgWndqLBW9Lgc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-i6k9BuGVOKCHCEo4omQ-9A-1; Wed, 25 Feb 2026 09:52:53 -0500
X-MC-Unique: i6k9BuGVOKCHCEo4omQ-9A-1
X-Mimecast-MFC-AGG-ID: i6k9BuGVOKCHCEo4omQ-9A_1772031172
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48372facfedso15057405e9.0
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 06:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031172; x=1772635972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D10QZ+digOC1iXeyNRdDRk2hXA+8zGrZxyj1PPT8Oxo=;
        b=PcwJeRRMBZC6Kz4unrPv8nQm3olRmwJ5lF2HV7QSgimwSKgtRcdqQbO8AuZ8t9jiaW
         fJ8VHD9Yg152aYGfp/uQaqZl5jzcsDxUwEou2pmvbAzfMbCzgDCPWPUomJdN+74wl229
         n/KqKtYEMSTaNtNqZMmZmoRQ3zm7+sY5x38c068tpI73FoV65R1biTkyDPTQAcoSJ0ru
         eNHSNL6uEq4Lbb0KG7toZxC04Fnga7zPb7BxqwBrM6NLfEv3rNx+ahLzr9yYW5NwDsVl
         gXV4BCAQiSbRx4C/2RdDewSX8akBPsopaOsgKKu9BkwgMETKJPwrHeGNCEpKwaabXUWP
         s3yw==
X-Forwarded-Encrypted: i=1; AJvYcCWvHlXsbaGLjiaEfAhUt1wL4toLoSDczpNZ4/tac1tp3JYa7Lci45IEgE3fM2TcABsFa+zfHagOzQ60Zv/2Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6PSHWI3w60dug5fXiwA/LWrqpJWXbEj2/K17qvO1a24+IFtC5
	wBgzTjNtkRZg9hE6aBNenW4eQbGy+/qe31iiWDfhdww3SRDqmzORjk7HRtAr/UqtNdPFElttohA
	jaNAJlokZL4M2459F1ujJEfFLKkwwhNMbG9EAZjjvakW32kXTIDogg/k5vWUK9Qi2R9cy
X-Gm-Gg: ATEYQzwFKREA3gU4j/aHmC3ZrQ2IpoxhvzsI1F0HXJwciKs7IJx//VAIb0kpq030D5m
	povIDa9X9k1qxdTvkVtTDO37w6fhPMy8sQJuEnZ2W1TOLttAZWgBkLjw/CNJBWq/eHlC772xMQW
	297xjJUSgZ/7B4lGOzL9oL8vfr/wFDFWRTSh9nY1e3uremNKVM+U5rp/Kur/opuErYDR/vIJePE
	7qm/+t8lBCG/s+m/PJhTaKj7NMb9GmqsKViGpg5TxyNE0cww7KKMO5vUZwAnRl5/mS7rabArWCC
	bhJDZxmH+FSHCLspIpVgmyv+pLpnzZDl/fvlhuqxxe76rJJYsdzZuifpcnGe/jQQ50erHeoVQSW
	9pNUM+5YzRIb8SuAv4uY1EPJz4Au+4G2F611mPy2MySvPxQ==
X-Received: by 2002:a05:600c:548a:b0:483:a352:b4e4 with SMTP id 5b1f17b1804b1-483bd73638emr69858175e9.6.1772031171666;
        Wed, 25 Feb 2026 06:52:51 -0800 (PST)
X-Received: by 2002:a05:600c:548a:b0:483:a352:b4e4 with SMTP id 5b1f17b1804b1-483bd73638emr69857745e9.6.1772031171191;
        Wed, 25 Feb 2026 06:52:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f19d6sm76376655e9.2.2026.02.25.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:52:50 -0800 (PST)
Date: Wed, 25 Feb 2026 09:52:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, pabeni@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225095100-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <20260225145027.29d666ac@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260225145027.29d666ac@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7reICG7wb_HVfinM3DNLg3tzkS6-Al5AVhAWJ2aHs8k_1772031172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 02:50:27PM +0000, David Laight wrote:
> On Tue, 24 Feb 2026 12:28:50 +0530
> Srujana Challa <schalla@marvell.com> wrote:
> 
> > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > redundant runtime max check.
> > 
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > ---
> >  drivers/net/virtio_net.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index eeefe8abc122..768ad5523dfa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> >  		}
> > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > -			dev_warn(&vdev->dev,
> > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > -		}
> > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> 
> type_max is horrid.
> I did read the later discussion (but it has fallen out of my brain)
> but isn't that check broken and/or backwards anyway?

it is just trying to say "i check at build time that hardware
key size will never exceed NETDEV_RSS_KEY_LEN just because it's not
large enough".

> I'd also question why you are using u8 for a local (I didn't find this
> version of the file), it will generate worse code that [unsigned] int.

that's hardware format. but yes it should be config->max_key_size or
whatever it is.

> 	David
> 
> >  	}
> >  
> >  	return 0;

