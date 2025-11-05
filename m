Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF02C0F97
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327079; cv=none; b=GVdusBxhXVEx7nIEq8hc62tg/ZtmNA15yFC1JqNbwAhCdmcq0zV1J4KsftTO6n9tD2VyV2RGEYBFYXyPUjJ7qJlD7U2ZxPK6hQEnJMCHOm0zRdrqgegYJOgk9TUiN4+wCC6+6V8jDjQ5dE+sJ2bHT6zVAriBa/91SLKUSXd9/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327079; c=relaxed/simple;
	bh=LXagqlSMvKmDxH5ta3oYe3mIclEopnmgdrr3vFPfBvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e9nHKNKA7AqytZ8wOYtwoLD/g1BG1LspoSgLokLHuCtn4QclVCm8uZXsgiEixSjFtEL3EdNS7M/qMx3OzjBfBQwz7SD/MNC/jKovafj2kbE4F0eT6wRUZs0+x2OYneM60QtLQAJw9bdr3aGl6Xul7/Eiknoe6jmG9Qc46p1F8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csmGWJq0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csmGWJq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762327076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
	b=csmGWJq0rYnCRBS1D6nkJ6Z1D+h9tboI87rTPdNu13W+EfduQQtGnx6awHD++KIvkdXGsk
	eyyY9Mc14pySUq05PMQz2VPb/JJiEzjfIPksupU6If3ctCO4G/ZLvIqq2N2iGrocbwS2NU
	gHR1kh3XD3X/Zf/BQLuN30CxWkQw6nU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ljLp07I7Niq3fqpjMTltBg-1; Wed, 05 Nov 2025 02:17:55 -0500
X-MC-Unique: ljLp07I7Niq3fqpjMTltBg-1
X-Mimecast-MFC-AGG-ID: ljLp07I7Niq3fqpjMTltBg_1762327074
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so82376295e9.3
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 23:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327074; x=1762931874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
        b=S9pyy2PJ1mjjEPrGQ9Lei43/Ayxv11NZQMyu+5Euyzpu636NtCD1q/FAyAbjQrcpnA
         RAdCs7q9dEyAsWvclU2IqZ8sy5+zdLYBsLHbmILJzD1xhD09smIaI6qE5DbPa1cNYm/b
         TSL1Tq3IfWKuRy/Wf1fenxJRQ+762oa+/TH1HI9BcsQQnKnfWb5QmoEXHiaQ2xHShG3y
         QcFiTDRq/2OfQ1hwdNUmgfIgsyUSCGQvpFUmqnQzgRbe/ohBl48Qfn9hCSUHJxPrhXCu
         KTRpaZpBwkoA6X1B86c7qrhATZDaLVzLd5fWwXflX8/8IIS0ekZtjLE8rYXKT/vScYIw
         yo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7F3VPGr/oziOLU/nuc7r5Y2mksJDpmgAyLzzY5JIeh5+UyOMRNc+haoeRLI7nbEqibm370iLARXlh0WOaVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM+ZKgAm6eCvagALVCd2ytkIkTRnQzeJDoUq4lQlacFj+Lroy3
	F6dTXDw2cHAQrL38WfT/o7dxsCg1GDnMTHux1Bg850Tn20sBOQvPmaSzCYQfZoHQOTzc9lEVjB5
	cBehab1F7/K0RUfcTvFnrdz8EdQMcL9MAETxD5D7so8Mq8uE9B3wl8ZSpPy4rpLFD7a75
X-Gm-Gg: ASbGncvXjU6+FDEXn/MU6UmNstuyx7dnblKZxckwKdujx2LQw/86alKMT64oZRU6Lj7
	IpSRphs2KXCigDae3zRtvGxyq//s+uo1qPivuft33eZJO/GQLliOTf0F3sxiAWIhTuYxyC6Q65D
	UUWHY0tFVDNZg8apSVF+8AbxkM784xsrj8cpoSAmZ5rQ4pJ+fDu8HwQTidQY9vRUDr0pbeE/kfJ
	rX8Z44VEPFkn36qEvDiq/zu7WQM9yL/n3MyapRGxZJs6f/olyMZUqmjmNTEvJhMXkF3ZmN09oSt
	f313a9Jj48ubieoHxll08cQenKm3T0xIBxuYcEQClDQXZGJwMAWgnLb4O+ibyq3FLgc=
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr1745705f8f.58.1762327073617;
        Tue, 04 Nov 2025 23:17:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWIh69cXdbIz7tujC891g3OcIjbNWMGhZSBD4SjmvD0oB/WuNR9hBtdPZG5O4EQq5uitEgNw==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr1745669f8f.58.1762327073093;
        Tue, 04 Nov 2025 23:17:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdae2sm8869350f8f.41.2025.11.04.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:17:52 -0800 (PST)
Date: Wed, 5 Nov 2025 02:17:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net V2] virtio_net: fix alignment for
 virtio_net_hdr_v1_hash
Message-ID: <20251105021637-mutt-send-email-mst@kernel.org>
References: <20251031060551.126-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SIx7iW8VfC6queuiYxgKrzSbckbEYRzehQ2ZnjFBlsU_1762327074
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 31, 2025 at 02:05:51PM +0800, Jason Wang wrote:
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..b673c31569f3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> -        vhdr->hash_hdr.hash_value = 0;
> +	vhdr->hash_hdr.hash_value_lo = 0;
> +	vhdr->hash_hdr.hash_value_hi = 0;
>          vhdr->hash_hdr.hash_report = 0;
>          vhdr->hash_hdr.padding = 0;
>  

BTW is it just me or is old code space-indented here?
We should probably switch it to tabs.

-- 
MST

