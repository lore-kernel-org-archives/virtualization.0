Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F73175D53
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135646; cv=none; b=DJrMVotVOrdqkZqCl3MCO6SScZZsaiYKcGHkvAstjm1LELZrP3TLCMJ/zIRNgDLfy5ma5C7PAiHtB49YB7+TZ83SAFKCbkMvBy4bR0VtiImNzpCh/Ss4oi44AgX53WfH2eSrSmmBzir6ox8qqIiRUa/jLitGX5lgzM8qnPKlKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135646; c=relaxed/simple;
	bh=gADRKLw82C+tfxUEYY3hlWKJfxUSp+EMySsSF1+SVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f6zCmgs+thRH1C5oaDEtCCDVOAsHWL0HUICtHJJkU3P+Ve8PXmlqrJ3YXY5Xzii6L4cgMnIteaZYcwHXo9UQPOVXXwiLI9DcAdFae84YUEKr4v2SMZTVw3NsayhhNhaadxR9IVvMcJcPu2rsRrY6+sI92hAyW42If/ktnegBg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqPUBt66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqPUBt66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770135644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhlncAUQMkbq0DxIaSpkvI2sfDCod5hPiXP+UVdbqP8=;
	b=JqPUBt66P4dFqVYxn9ft7jooFglCXdmNOVRT7unGcsodq3nm3sup5bNtdydffIc4rjbrDK
	AriZLKiF/vuZWUktDiH9bhvWsIZUi2OWrsC2WDWSYEflRixu7/Qh9gq3PKkoiSgDc8oD5v
	/yGWaaM8Pa+zz9kyXCeghLBTy9YvAyM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-uUTVG9oAOUOhblcFwa16Hg-1; Tue, 03 Feb 2026 11:20:40 -0500
X-MC-Unique: uUTVG9oAOUOhblcFwa16Hg-1
X-Mimecast-MFC-AGG-ID: uUTVG9oAOUOhblcFwa16Hg_1770135640
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d1a0f7206so4948161a12.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 08:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135639; x=1770740439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhlncAUQMkbq0DxIaSpkvI2sfDCod5hPiXP+UVdbqP8=;
        b=t/5bzNBnNY8SqSFi0LDmGk/J8F6eHurgHbFsTeCKH+ijy5ZSYgQTAX21YGvy91SiOF
         Tog3Yee5x20sa72jEmezXPomWJ1Y1V07ZKWAG+UdGGLMNXx6zGgiLI0G49kH1TNbsN6U
         FhKdXAMPtfklbfB/VPrbM506X5lmcBSWv6KVs6aeVWeKG5LQxlIA2ryKzuxnsGPnsOCO
         Cm5ON6GEo+3sxVGBSW1PE/H/OxkSG/8gaJ6crmWRacdEDy4omlNv2pSusyKxlQIO41xZ
         gGmHZpAscLvNxdC2wbhylA0bg1e7tEAMhNnJA9GFCD54j4rOLijHRP6zGu0OpNT6S+TT
         y5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWj7maqdeVhT1DevYt7wRBiI3b5ukKRoThN0V/I4mCeme/7A+bGx3Q/uc7tqXQfofi+07/YG7lNsj0/jOkdxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzxKAJ/Tp9hHzfYStQdgINuS/9yXeFiQMzJf9zoocpEGrCQuBq
	lAV5EFkKKih89MsZJH56gkDyAyv1CEeQXkTLacqf0ycJltut4sPqnvg1Eic66AYhwexlO1ULXlG
	ga9Tkn2PTcvocv2YTDjN58Ooia9HuRQjEhkC7M3WGe3QBhhMf3ZppGoFYvznBEuimh756
X-Gm-Gg: AZuq6aLMt08BJjojmrwAvPV6dlIUOUGEP4duttGl3Z4AoT94Z+ybfsLVZFu3TOwnuDZ
	29CWs8orPhOj/JzDkSwsCR1h0l0B6AHHwTWt2vvd3rEq7BZmNNeomHOxNxWVUinX1DOVyFoxfve
	vWhlIVAiXzajo8nX9lt+fCEAPC3B9cjj6kNEAtQq9efneT9zIO75bRw7tjHWjfDKRuz9Q+H9U0G
	vouYCr9DjueOYwEcss23ZhETi2Ur6Uusp7xrcCWCkwJq2MwI9HP+RhzrgB+gKp+Ts74DnRqZJmc
	HMVjLpXmVSsEnxE/Sbfv3fggbJwU2x6DmY2U+cmw2yfvZWTuG7ew7iFwb1ZthWgVQnZE7eA8ai+
	3lXOikVhN7rcEe6B8srrB9RFB8rGRF48cLw==
X-Received: by 2002:a05:6402:4413:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-65949bb66d3mr133789a12.15.1770135639542;
        Tue, 03 Feb 2026 08:20:39 -0800 (PST)
X-Received: by 2002:a05:6402:4413:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-65949bb66d3mr133772a12.15.1770135639048;
        Tue, 03 Feb 2026 08:20:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65949fd80a7sm49935a12.14.2026.02.03.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:20:38 -0800 (PST)
Date: Tue, 3 Feb 2026 11:20:35 -0500
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
Message-ID: <20260203111926-mutt-send-email-mst@kernel.org>
References: <aVwGfOlvRqdv5xj7@fedora>
 <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
 <20260203070338-mutt-send-email-mst@kernel.org>
 <5d9645ea-41b8-4904-abbf-3b201183e2fc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5d9645ea-41b8-4904-abbf-3b201183e2fc@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D9__ilGBxVesqLZQIpWmDCf9Jw0F021xGl5fvTJLyO4_1770135640
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 04:18:09PM +0100, Harald Mommer wrote:
> 
> 
> On 2/3/26 13:05, Michael S. Tsirkin wrote:
> > On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> >>
> >>
> >> On 1/9/26 18:23, Francesco Valla wrote:
> >>>> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> >>>> +{
> >>>> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> >>>> +	struct virtio_can_priv *priv = netdev_priv(ndev);
> >>>> +	struct device *dev = &priv->vdev->dev;
> >>>> +	struct virtqueue *vq;
> >>>> +	unsigned int len;
> >>>> +	int err;
> >>>> +
> >>>> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> >>> Nit: consider initializing this above, while declaring it.
> >>
> >> All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> >>
> >> The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
> >>
> >> To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> >>
> >> Solution was: What you see above.
> >>
> >> Regards
> >> Harald
> > 
> > So you reorder it then:
> > 
> > 	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > 	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL]; // priv not initialized, will be done too late in the next line
> > 	struct virtio_can_priv *priv = netdev_priv(ndev); // you see it?
> > 	struct device *dev = &priv->vdev->dev;
> > 	unsigned int len;
> > 	int err;
> > 
> > 
> > and where is the problem?
> 
> The problem is that you use priv here to initialize vq in the line before priv is initialized.


Got it. Ignore the tree thing then. It's a guideline.


> > 
> > On the flip size, this guarantees we will not forget to initialize.
> 
> Static analysis is your friend.

And then someone monkey patches it to = NULL or something else silly.
I prefer correct by construction.

