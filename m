Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583E7229B02
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504267; cv=none; b=Pst/vY/p2wc9QaXIIMInZo3AByqHXZoMCTcAP0DzdSfFcnqq+tZ0szJZVEwVyeq4LHnvfRypFULiLr+fYQv5AS8WuqYrBi5B9m6VeOzMF5IS7iCsp3mo25HQ3Pg2LBdqlklTepqpheDgMJBiRDf6bPlfXaQmLTQhFDph4CDHyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504267; c=relaxed/simple;
	bh=0JRxuNmPWg0BXu1gLvztZG/5XmSPd/ecKkcEAz6ETsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itkKI0CUjlIXItfkvyIDrNPR2et0yUUbTC3LKICaP1Ztbr9h9Mg85V31ZFmQDSpjMOLBqb3uaYMXgkKLX5+OSeAjm1h9ajNtp0gqb1uGgDLsun9lYoXHW6QEbuF68EvFp30z2MMWiolsn1lyjLR2LYcMKRSYVvlotvwY0jBvT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQi/7cIA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQi/7cIA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22622ddcc35so32425345ad.2
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742504265; x=1743109065; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzKy/lOEAHXd03F/+5PHR8yNFdtPSdO5sEmGvZ66KuA=;
        b=jQi/7cIAQB3S+pRBftYMk/uAlaeoHyeFtsN8iDatTCUxuRN/CSTm2b9tIcpvGEjvrw
         4zWaEOeBeXCTip8eUXjUys7SdJclI1+ccqYFpae3M6+/kru1Ydnc6fihhTwCrNfdoNf1
         b1RnyatUxrt3Liy34GgU+F3r7JzydYVYPXwMorFetPNFt/KLOp0frxnHh+z3Zcmj0zcj
         diB0vMv0EYLV0h/rkYXAX5k2GtCUep4FqVAjAwvOv2USg0p6ujJ8tPteeMm9QlcwbI7q
         1yRA8yXY/0a1w4goxv2YHHVdQsanIfA94aFPM9vtbYKE2N0yf908bYg6UJr3ujv0qZxp
         j89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504265; x=1743109065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzKy/lOEAHXd03F/+5PHR8yNFdtPSdO5sEmGvZ66KuA=;
        b=GQw/qp0ddPhpUpNgQldty4tOi68ELtMcYANcZMsSyebIhgXOxG+I6LQP7vml75q/zY
         ubAa/stGc6wGJ3ntNgpWXvBC2CZMImSzfApdYBd/8vGcke+wND/xkaxvYBT35h0OM+Ga
         2piLCM1SDuz/u4v5rPCu/TjRBraUCpgb3O9wgvGzHeF9QdxAKdrCh6IAj9bvjPV4kW/O
         Cq2uDY/m8CLkJA7snmz7hwDnaOvDFxy80OgUVKRh/UQvRyzd5q8JNGtLw01SpV/y82pG
         7k1sbUxSwaaiY5U6CWMrghBxN2YcZfvYyDFeTdE5KzEy9g6/nz7V22fetOrKUZD8xkRu
         YXeA==
X-Forwarded-Encrypted: i=1; AJvYcCVrIDk84odEtZOZWG1T5cx7BoWFsAOKyloZpnsCk7WtPBpne71Uc35kKN1WxgPbqQ40+FjAZZw9AioWJzMT6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8zgIkOUgyZMcfCz4wMiItYhEjtyh2vGaJC0JEoJF0knwcImsy
	IR01lU7v56fTVaxkyegvCJmYXcjpAzj0dQuxLQy7RV/ZAvL4DOpZgefVkFKW
X-Gm-Gg: ASbGncuOR5zxBb1dV5QDw4/FVxq/4FzDqACbLRBWrgUgAsrimkb5apNTZ3/R7hC4HC9
	5D4AhdFk9xXIVFd/BjE0I7oTcFYYtdGGWYcBrLl+36ZxwH2tF04uTRzUpPcv3vNOgB1g0G9zYM2
	FRpOhj+hOHg6Y+JI0PnRS3UQeCTomOC0q70r7OSyiquqwhHtrz4lRamX6XK4w8csKX4cffxqBfO
	JAKhp3wR5mo80D0+91RXjmhDxnPI5cerXWd2cd2mGFCbskFOicFR2kDhlue+prsYKLSYqnYDJxn
	SR8xxm0k3GOnTLtwINatggPzoCHnTPVksGO2Y5aUDyWhJMk2rw9TQHPD3WGbshZuHA==
X-Google-Smtp-Source: AGHT+IEdn0605i1cah5WXs7GYx77tApjB5zexLnr8cToDi7Wb0H33V6afUzxrEpTrcHaOiAbfUfReg==
X-Received: by 2002:a17:902:e54d:b0:224:76f:9e44 with SMTP id d9443c01a7336-22780c508c6mr9676135ad.8.1742504265569;
        Thu, 20 Mar 2025 13:57:45 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45e89sm2568245ad.93.2025.03.20.13.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:57:44 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:57:42 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <Z9yBRisP+FtTID34@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>

On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
> On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> >  
> >  	vhost_dev_cleanup(&vsock->dev);
> > +	if (vsock->net)
> > +		put_net(vsock->net);
> 
> put_net() is a deprecated API, you should use put_net_track() instead.
> 

Got it, thanks!

Best,
Bobby
