Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F22E5D17
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115122; cv=none; b=S8okm6X7ou+QN+3+ngqgtpSxAeU3smuUUvF1oVtKjtTbq/x3N666EB8yK9ZHN6lPanYPLS0AUt8Ls7Dzv7xOrVXvf2E6p6emPUKhHSNRa8v8bRpiYLSx5Ll4+3WaVM/JcoH/SiCgJNXdr652HyamPHK8gLp22nUn/JglLW6XsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115122; c=relaxed/simple;
	bh=Zdzhg1VvkirEy/QlmDB+qd7VezDSX0wFVid7IBJpags=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ng16TcMM2XJLkBLUCcRLEbaTMjzh272rcxHz/e3dqSm5w3S8lTPoV9Oy7a3IlbRG2xSDaTJ5CMABbzXa7qO0MH6E2NaHMjkH05HwoRzY1jErrfHkGTr/ScJKlj+wZPFWB7zWDNmUiCO8pHH37R5mdKdrC9QE5XYy8Ti6RJkQpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehjd8t9e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehjd8t9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772115120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOpbM9M15EuxWd+IWwH8daRCpwecjuZ8you3Hh2pT5s=;
	b=ehjd8t9eFzl02M5O7iRuhO4QlJXa4l7jrGlUHaRRDLeKQBrvP4vz8e8phmuC5RCP6NKVXd
	b5IEzQqUUvVHIIWVRTTBIwhCPSwsMHEhDP3b2C050py/EIzMz2R8CDhdyALooN3DWQw6Vv
	AoddDUek+QmNwUawCTM0ZpGkZrbrY/g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-lTZyu9MlN2GXlmfZ4RZtAg-1; Thu, 26 Feb 2026 09:11:59 -0500
X-MC-Unique: lTZyu9MlN2GXlmfZ4RZtAg-1
X-Mimecast-MFC-AGG-ID: lTZyu9MlN2GXlmfZ4RZtAg_1772115117
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8f5bce308dso70856966b.1
        for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 06:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115117; x=1772719917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOpbM9M15EuxWd+IWwH8daRCpwecjuZ8you3Hh2pT5s=;
        b=TZnggb1s6SOfd9LgicX5PUIFeWj60F5cXbUQCBAdd7JJdGTu6/OP6eXrbzF8hRvXAe
         NwnRp5KGj/1A5R7b/JxiiLLsskp0CJpc6et/b4s0xN9mnc5EC5t6Au8xSSwP/nufoXr4
         36dw+z1HhD+/vw011QoAOusJrLezrHeLmBA8UkOCwGG7WdURbRM0Wujj/ZkxEbWdDKWQ
         PHv7RkdGP2v09j08DJlf7qXIlVA1MhX0G+bf58o2kp3yS9jLrlfNvZOlhEIEsbcYoMyV
         FRVL0EyrCuROLyULZwWJBBunoM+sVYW3+SOpxkpnLZJXuOBpzfXFHpbIAzWRIET5eY9N
         VJlA==
X-Forwarded-Encrypted: i=1; AJvYcCX/RKKNc496Zf09172VP7CSq17pTla6Mde7CRezGPHImtB/lLkJqtFEnTTDjNLw7jnf/SszXE93xDKKzdcKsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEL2Jrd81efGH5VIzQSUHtLNAvYS8m6gG26Cpn72kybtG36MBO
	SUJrX0j/eitZZiHCYoSf9vfytJQEJDpzZMXLsUq65GIdkQ7bxpVxxzxWbiPVnz1KDtnL+DSlmZ8
	FLKaVdHhpuJB10an6sqUYZPZ1PFhTlBDs82DlRqWI3IS0w3XZPXX4+0RFtb/MUlMLSaT7
X-Gm-Gg: ATEYQzwQYDIFZz+a4nfBEWVVYkpVCXk1g5Z8N3bUA6Ad/tCU5NfLXw0Ta4zH8m50xiT
	IuVbQ6//fqe98/yKBp1MpVxmcFWHvGTSNKVt+bdbgc4aMk0K/naBtjqMVOcLVbqrORHkdlzvw4S
	pAzIIcOXxgLZzjUfrUXJsYCPJmmDrO7iTs2xwrBPaN8klBez+ewMO+OCn1hyHFR5fthbCU9vXcz
	WjOHgyDzFjYv0XHFYyLdhO4yy4inBAHKNPy0YPBn2AsCMaxE3XOaQ7HqlRez0t9sVZRctTxdIGb
	xVuavGaxo5bFNokRyClGMuq1ao1mCea0ujpGqK+jU5BpHHfVxRAvtQ8l1We8ZFqqszto+E3VAI0
	WfzuSxc6XjWkfVThtKernaEvZFKvyLXMXrl9laYxyewjgSg==
X-Received: by 2002:a17:907:7fac:b0:b8f:a85c:95c5 with SMTP id a640c23a62f3a-b9356754254mr185007066b.37.1772115116979;
        Thu, 26 Feb 2026 06:11:56 -0800 (PST)
X-Received: by 2002:a17:907:7fac:b0:b8f:a85c:95c5 with SMTP id a640c23a62f3a-b9356754254mr185004466b.37.1772115116395;
        Thu, 26 Feb 2026 06:11:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab137a1sm63798266b.2.2026.02.26.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:11:55 -0800 (PST)
Date: Thu, 26 Feb 2026 09:11:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
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
	Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260226090956-mutt-send-email-mst@kernel.org>
References: <aZRB7Reu/D6HvRcb@fedora>
 <76036b0d-fe61-4d19-a209-65e1a790c107@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <76036b0d-fe61-4d19-a209-65e1a790c107@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nw7-NVZx2uyvDa_tGHZgodVKYTZlFzj0cZKJw7Mr9fU_1772115117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2026 at 03:08:28PM +0100, Harald Mommer wrote:
> Hello Matias,
> 
> On 2/17/26 11:24, Matias Ezequiel Vara Larsen wrote:
> 
> > +static int virtio_can_probe(struct virtio_device *vdev)
> > +{
> ...
> > +	priv->rpkt = devm_kzalloc(&vdev->dev, priv->rpkt_len *
> > +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> > +						GFP_KERNEL);
> ...
> We're here clearly beyond column 80 with something which is not a string or a comment. Elsewhere we are also sometimes beyond column 80 but then only 1 or 2 characters which may or may not be acceptable by the kernel community. No idea. You may re-check the formatting.

it's relaxed recently - does not make sense to uglify code to fit
in 80 chars.

> Besides formatting:
> 
> I compared your actual v10 of the virtio CAN driver against my last v5 and and I saw nothing in your code which may cause a problem. Only learned doing the review this way that at some corners my old v5 code was not this bug free as I thought when I saw some changes. Nothing serious because in some "not expected to happen" corner case code paths but anyway I'll occasionally have to take over some of your changes into an internal project repository here.
> 
> We will see whether this virtio CAN device will be accepted in some near future for integration in the mainline kernel...
> 
> Regards
> Harald

