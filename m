Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625051;
	b=cVkSqyFO8t8CGdn+dWOjWDRh1mc/tWTOGvMbsOE7GTlXdcvyeGj9fz9FgQgrY9MXdCFF
	 aWFARQWqojVwXnyOZ8o+cI7iSClFjs/XD9zNZTCtLbHvOiIiPrYi9uLO+mCupadAoKV5/
	 SKESJ3wXOKRrOTwo+cxkbxVlnGwqnHxPyFx4DcyWSIAzFQ7oxI6OwGOhDOzUQSs30fvBP
	 TRr8x7JoBkLnj5gtVQrYAEwhZp3kJiRVwW3xczhTPmO4f03mgPJXtddh3/M3tZZ8Ka6gO
	 /WCIJvCOzJQPH3/S/NLjUvUXtrmnUpeKdFEgiYCvq/2z2K2NjKoDJYdVfKbGfjwdF/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625051;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=j9wc/WBD4TeIiWhN9HbMNb3tvnxBQeG77ywCTfXJ2nc=;
	b=bv9toX7UK24g4w8Dffcy4cz+Xr5kx1vWBQ/dSpmMFSvosis/FXdCKB9S5kmb0uDYqRuC
	 4RoKIM/PjdjihK/JDjuM8Oxzrsi4cP6I5psa+B0OAjIXpL+Qs1RpmenhTa1XbwD3DCTcG
	 7AKacQzB1AhCxpsWSZOEP2m8LojigkxdBBHR+pquchYLvVmNuzK1IxyhAW5rMxOURAU6u
	 5YX37U/ls8ZX4EJRj0cIg56/B/YlgTBIEfYMEsz7E9MI/2Ey7szfcHsW3ulCeHaBbZqrd
	 QjBNSy1S0bsnYvuBDMAZTaivTMmcoBUAy03aSC/kJ6CeFFm3POoPC5jlTjbHWqj2pjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W57zIl43;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9C606A321
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W57zIl43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795625050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9wc/WBD4TeIiWhN9HbMNb3tvnxBQeG77ywCTfXJ2nc=;
	b=W57zIl43sOJmcRg+AzgoUwa0Wmvc7FUiWn+u4UuSmZ3wGeo4XAozErg9VmYgiFkxGbGQBb
	h8eOZX8RkT220wQj92Fp4bakdw0qnyd76OtxUnAcXtSwEPO/yyOYoGk8ypIh9dtvnpKb57
	LFswNIMTAqiICccu4snr7jfHHh/1eKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-h4s-kNO0PVOF3gg4dt63NQ-1; Wed,
 25 Nov 2026 16:44:04 +0000
X-MC-Unique: h4s-kNO0PVOF3gg4dt63NQ-1
X-Mimecast-MFC-AGG-ID: h4s-kNO0PVOF3gg4dt63NQ_1795625043
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BF801955E96;
	Wed, 25 Nov 2026 16:44:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96F791800550;
	Wed, 25 Nov 2026 16:44:02 +0000 (UTC)
Date: Wed, 25 Nov 2026 11:44:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_blk: add support for FUA writes
Message-ID: <20261125164401.GD10456@shajnocz.csb>
References: <20261125083947.263216-1-afaria@redhat.com>
 <20261125083947.263216-3-afaria@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261125083947.263216-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Vt4D94f7wvivW-C-WYxy9QDAvpVO-UDnPDzMfvEXn_Q_1795625043
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2026 at 08:39:47AM +0000, Alberto Faria wrote:
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index bb137e4797633..70890974b6e56 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -45,6 +45,7 @@ struct vdpasim_dev_attr {
>  	u32 nas;
>  
>  	void (*work_fn)(struct vdpasim *vdpasim);
> +	int (*validate_features)(u64 features);

This is okay for now. Possible future changes:
- It may be necessary to split validate_features() into
  validate_device_features() and validate_driver_features(). This is
  because the device can advertise all possible features even though
  drivers may not be allowed to enable all of them simultaneously.
- A struct vdpasim *vdpasim argument will probably be needed for checks
  that depend on the device itself.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

