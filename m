Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA61953B0
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515455; cv=none; b=sOMb33YzpNOLzC9Z4yP5VOrof2AlE0TGVwna8/1EwdqMpiNTYFxSbJnxnnnUv+mbx1VbTtmP0h9KZX2o+bq2p2TxdpUGCFCcS7pwXJiF7oPUXDVYfVjZQHFix1WnRZyb9k0hr+F2GGgAfjIWSjwIH/ouSXn83JWqI0021oblziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515455; c=relaxed/simple;
	bh=+VwoTw4/VSWSO5vEZar5LeS4B0UPhnVHwbXKzFqkOnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pNyC+0X0X2ub6lpbk3iVCVncKnFdncwlURx0CP503+L4727zIBdxEOCY7y5SxHyIXjYuu8iCfAoZgxfcxi9/tL6n1/QC05w4lMSoXveE9lZpnuiwphLuDuY8tmWsZIcnFqiFmmsHxkmni5M/y7lOSTycBkWCOfF+gpukuJiLyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFnCgFQr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFnCgFQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722515452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxhE1NPgVuOO/n6fsUwjPWz/ezblDpX/qadlR9lwo2s=;
	b=NFnCgFQr16wOHKpQDpwrjgg3X6YzdNMt8mac9zLAiNb7b+ZQNfPJlDW48seYCVagIu4s7/
	qxAQLImyzfAjB7pi93u/60NzfU5B+LPuRAs/8AQlKaQUCPHudEfLTUraBLA1vjt0zCiP/V
	tQohzm8M5ZxswjU2rET8s7LZQkuBwpg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-yQbaFXeaP9C3n3ZqLEF44Q-1; Thu, 01 Aug 2024 08:30:50 -0400
X-MC-Unique: yQbaFXeaP9C3n3ZqLEF44Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7ab81eea72so593307066b.2
        for <virtualization@lists.linux.dev>; Thu, 01 Aug 2024 05:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515449; x=1723120249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxhE1NPgVuOO/n6fsUwjPWz/ezblDpX/qadlR9lwo2s=;
        b=PacfBspHXHHanZ3XGlX9w6zljx8ovaUkUROs4373hfwQYv6ZZQXhW/EtECTndtw+Yt
         cEqnznTa9kBLlZKS/GxRL5xl4XnCtQrcE+yMgR8RunlUcBaEZqspVfmlxg0t8dYRLydk
         ZMOALx3KGPENqe3MnqndxNp8mRK11T6/lVBaA0/xPuFQ8I6pUf+LKOzLB5/whU0XWOht
         SbVBBMVU16l0UI7BqfaRKFJI/N6aUl3pOtcgMQi5ivp9byYtrMnPEQ6Uhx6po0CbshTW
         RCues+0T6lGysMNcs/CTH1tE2RdAQuQbUI8/7s3gy3MbN87hBqDXSqwePT7C7b2HHTo3
         WTRg==
X-Forwarded-Encrypted: i=1; AJvYcCWRdNzQ+wFhTFYqVB51xDNVX/X6FXJa0Uz8ph/Quc2ySjVOCHTBmhbj5CTeVxnX7iOwgFWFjJfILAQ4gLYJ9IPl5GrR7CS9KnEY3ENujKg=
X-Gm-Message-State: AOJu0YwtLqctzepcWmwVC4sb/FY+ocPRIlqaM7clcIA/lVyxylIFSLZ7
	nU+VtOcQcn2x3jtHQ+AcptzCvF77zUH7c0mgXMbdln065bBa8Zw/+ebajJLXwc0+bEzVriqbkGz
	rwRbPA10kv3bq7yUYJ4gr1mA1FJ20NjwQ7lFTxEm0wt19hVzQwKfiLYv8KwrL6Q3J
X-Received: by 2002:a17:906:7956:b0:a7a:b8f1:fd69 with SMTP id a640c23a62f3a-a7dc4e4ae17mr350266b.18.1722515449192;
        Thu, 01 Aug 2024 05:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiuSk/hmqqH204m75ZyS9JWIgO4b9X57Vmo7qnnG08z26nbF6SQ7ZvDrhI/u5K/Gz7A/xUsQ==
X-Received: by 2002:a17:906:7956:b0:a7a:b8f1:fd69 with SMTP id a640c23a62f3a-a7dc4e4ae17mr346766b.18.1722515448416;
        Thu, 01 Aug 2024 05:30:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90251sm910073566b.143.2024.08.01.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:30:47 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:30:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v3 2/2] virtio-net: unbreak vq resizing when
 coalescing is not negotiated
Message-ID: <20240801082947-mutt-send-email-mst@kernel.org>
References: <20240801122739.49008-1-hengqi@linux.alibaba.com>
 <20240801122739.49008-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240801122739.49008-3-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 01, 2024 at 08:27:39PM +0800, Heng Qi wrote:
> Don't break the resize action if the vq coalescing feature
> named VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated.
> 
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> v2->v3:
>   - Break out the feature check and the fix into separate patches.
> 
> v1->v2:
>   - Rephrase the subject.
>   - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> 
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b1176be8fcfd..2b566d893ea3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3749,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
>  							       vi->intr_coal_tx.max_usecs,
>  							       vi->intr_coal_tx.max_packets);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;
>  		}
>  
> @@ -3764,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  							       vi->intr_coal_rx.max_usecs,
>  							       vi->intr_coal_rx.max_packets);
>  			mutex_unlock(&vi->rq[i].dim_lock);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;


This needs a comment.


>  		}
>  	}
> -- 
> 2.32.0.3.g01195cf9f

