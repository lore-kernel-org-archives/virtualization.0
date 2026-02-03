Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C233CE8C
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120327; cv=none; b=o+9uCzwB/GSxERUm3BgoR2zMYDFQTGYT5gZoIupcRDNJuZefEdFlqFjL4l+zmgi0W9W4APBrvoIdTfAcEu81Ek4KLybAwEgsSiiZmtovzrIyPwkBCRPOZvr+YhL60z04uVsuLcpedKiecv4AGQM6Qs4ud8PFIVEHuQUHTBuAg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120327; c=relaxed/simple;
	bh=eoIReSmvJEuRMVBn5J7KvKvNn+HlzBOykWPjPWnhaHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lEFrzLt23z3p38Il7o+L8SBsxe7mPhfTWcJrL0YOvc4UYMWjwsC9tZAKC8ic7EJqd3AU4sKPmw7jWq+0g7437srB8LkBeIp6jUFfS4f/I6pq5rII5izqUrCvzhX2ul3V5Q1h6MufPbr5V6J1Rz6/d46j9sCg3pheqUdbHlksCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8yDFFbF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8yDFFbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1fWzZQPIc6hPJZu38sl3N1saBNm6B4fuyXwFUKV3TYY=;
	b=F8yDFFbF8z/0W3WjdaUq2zL54N8iqP2roliNTFv7ry/tDefPuKDGYRYjFcOm5dckLQKcB2
	+sgEeqYP3Ua77XJUWEJUSKWzRKl2K9gRkkKsDU+TQrjZGBCPiF10EObnX10KM7GpTlB92C
	bth3nZGfCYZ5JgpW/T9v7H4A13sxP8Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-pgDtnqNEPaWcW42Pnnt8BQ-1; Tue, 03 Feb 2026 07:05:21 -0500
X-MC-Unique: pgDtnqNEPaWcW42Pnnt8BQ-1
X-Mimecast-MFC-AGG-ID: pgDtnqNEPaWcW42Pnnt8BQ_1770120320
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43591aacca2so3629359f8f.1
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 04:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120320; x=1770725120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fWzZQPIc6hPJZu38sl3N1saBNm6B4fuyXwFUKV3TYY=;
        b=Up4Mxjg6Vualf0D05Ip6B1xQoB2gonr/EezqO3st7QMNds1D9KPun59sOTS2ZEKhcl
         dS0A+DgPB4ptT0zNQsimYnruwyAQeLDxeIghwmaRUiRoIf36vSoIycXX0QABflekXr8L
         AAI65hSh/4/1F2752ujHq+BOBgHh+H0m00o/yNBFaEgxMNYIw7Nxteywj1gTPx/5cBgq
         +xmSCXvkamXqnOcoFbB1AEStXqZI71zN1FZj9qqnttIbc6hLKXgCmtDOzDMEUrG96C2Q
         yJ/5wfvNQxITTWS0kSRVZdyOGR1Cpk7ie3shLT4tSzIFCmL3lH7wtJV+f7Zg8AfdOifR
         BYQA==
X-Forwarded-Encrypted: i=1; AJvYcCWGwAIa8DeJ3VgONRslBBhXgQgc0RdJDtCKgG7W12bTNLUgmzARab+io8ceqliVm4b9nJAp2GUPurWtrosZjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP+kqikOWGMOt54JaIbtCMKu7UCfWlVQQwXCix73Q5oyT0TI5J
	hOQx5yA8Zcezwu2/KrUbJcqjff3tqW+Y8wDc5Ln/yYKrgC8jDcwvoorvjlnE5+28z43Toie+FBU
	doFHtdIOpmwwZkhzwsVxFyRYbMcWbIgqxV6E4NQZsfEbx9i2dI42JAELerEVKcIVpOogN
X-Gm-Gg: AZuq6aIDmtsrcF61ssjG6fm1KKgEy1/ms4DtctJdgBcf3dXJQeSmJOJQRwmXf57dxnm
	B5q7iTB+2tfros4lbWJ4WuHQbVF57CodfOc4n4UCZPNkyWM4xGyBwOsBU9jbwGUpG1PWtxplMTu
	nlfoF03MFdGXBkM2QbsgxN/rzIErktwGLMXLS2u6GYDBsI6ZLqK37rOZ3z0kp7YOWGQKqW+wSRT
	kKKEnXZOpwi1TwaFBqqzsM6Hd4BwrCEfOOykX4UksjSemEC7is5u67bbekoRBoMEqHaS2DvaUlG
	2cjkcdsXIwZA/OUa1eblGrhCmrQgGa2Sg1WTAB1N+g2t62vyku7s4OEjF9/Vbsx5wTVrJI9HFEk
	xW1xV2QjjoT/rYz4GfvEM5A0QWXIFVAQAzw==
X-Received: by 2002:a05:6000:430e:b0:435:dd81:4f4c with SMTP id ffacd0b85a97d-435f3a63167mr22066474f8f.9.1770120320356;
        Tue, 03 Feb 2026 04:05:20 -0800 (PST)
X-Received: by 2002:a05:6000:430e:b0:435:dd81:4f4c with SMTP id ffacd0b85a97d-435f3a63167mr22066421f8f.9.1770120319840;
        Tue, 03 Feb 2026 04:05:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354d43sm55930296f8f.43.2026.02.03.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:05:18 -0800 (PST)
Date: Tue, 3 Feb 2026 07:05:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Francesco Valla <francesco@valla.it>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
Message-ID: <20260203070338-mutt-send-email-mst@kernel.org>
References: <aVwGfOlvRqdv5xj7@fedora>
 <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fTi40ui-zNcuCGOY7ROJRjUAxzJ4K9vBD9FSdexs0OE_1770120320
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> 
> 
> On 1/9/26 18:23, Francesco Valla wrote:
> >> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> >> +{
> >> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> >> +	struct virtio_can_priv *priv = netdev_priv(ndev);
> >> +	struct device *dev = &priv->vdev->dev;
> >> +	struct virtqueue *vq;
> >> +	unsigned int len;
> >> +	int err;
> >> +
> >> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > Nit: consider initializing this above, while declaring it.
> 
> All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> 
> The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
> 
> To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> 
> Solution was: What you see above.
> 
> Regards
> Harald

So you reorder it then:

	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
	struct virtio_can_priv *priv = netdev_priv(ndev);
	struct device *dev = &priv->vdev->dev;
	unsigned int len;
	int err;


and where is the problem?

On the flip size, this guarantees we will not forget to initialize.


-- 
MST

