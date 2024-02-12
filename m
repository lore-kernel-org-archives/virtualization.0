Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B593C8E1
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725990; cv=none; b=qDSqGfoSv2QIE9AJt26AKxcbua80eWDLK+ZUtph5vt4Ed3DGg32C4EOwWYLACegS//1Nz/2vpPiuYaSLvJhIb9ovarjAkw5ZkVh8fbqyWys8kmPsT8D37l45KLgrBzm+no+MjeuARNb7asF6zirbWfA2nkOhhu//TWoLSqKTLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725990; c=relaxed/simple;
	bh=I4E9R0xwA/wiWRCLjRonNM/vS7VQXnp85joW0SqBSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LV0DlYSR0+txDrmMtb7CJbxrnj0Yo9YyJgvquBD0Y6HbYLnVK6FVuMvmBumakbIV9qAHdvx2DCV1cB1cnq0w6Nojt5ubw6G4zk4SrlVJgOl2d6AUne7RKnP7S8b7LgHez1Gk1pvac2ORvvgbuKEFukyfw9qObpWXMEslBeVvIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZQ6L9py; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZQ6L9py"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D786F40981
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 08:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5CfUfIFmmAF
	for <virtualization@lists.linux-foundation.org>;
	Mon, 12 Feb 2024 08:19:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BACAC40144
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BACAC40144
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MZQ6L9py
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BACAC40144
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 08:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707725986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQjqAVriqfV/RO3Ugjr/Wkmdgl2+6OB2j7bRQwASar0=;
	b=MZQ6L9pyWcV4PWVV07kyLGxGMVyneSplJQ/Ncs4ZQzyDXUUEtApnxG2uSgeOu+Y72GRQuH
	aT0BQ1T5FWo08Tnlx0QcfNmKRHgR8umC8UePVRISSfeSuSaAC6s81N03KnNBQK4da0JBiI
	cahSHPSIuEEwcZEGCUhqr3MWU2gAA1w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-cNdbGXlkMYS92UgYETRxxw-1; Mon, 12 Feb 2024 03:19:45 -0500
X-MC-Unique: cNdbGXlkMYS92UgYETRxxw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b6c2a5fddso198847266b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 00:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707725984; x=1708330784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQjqAVriqfV/RO3Ugjr/Wkmdgl2+6OB2j7bRQwASar0=;
        b=FhuG3jV40Pgel8iJXMSFUAkQxdWDWL+dVZarUqDZ1mC6awj/Mq4/kdEOJbQ0IQhVo6
         8jHhu/YeS9hfDgY1NK9ILeCDpMRuPB4uMxuplBX3agdoBtIaVstow2jjl7ufHVHVkEsX
         S+dCazeUfN0RDEJS5jYZKAgakmOXiIBvoGlfEktVt/JujQ4cx2UP3xvvVdKJZvCsIQpQ
         13B6Awr1q/7Zr3cfmJA4h0wL2V+S1PQqlv06GCRmoL9gPtCmsHAz01BQt6YUWdCspSSx
         1dYNzyrs0855J9VPAR5ZQ7xot8LccjtByzrTOjQaRAl9ThQ3aCQZhmp2T+JgaHzpRawm
         0QJQ==
X-Gm-Message-State: AOJu0Ywn6B4UM7U9MDhrupb6DLb+onV1PwYS6P4B9C6Q6yta82NmFJMr
	ZGmqxZXP4RfoOAJC5zs26wXLtcg6ZETfPUuVBOqpT4bt8m8ayV4Tdi+W5l46pZry+71U3pOsBjo
	slhwVfHw6YLs4YHJwBesgce6IBMYAVKk5Ewbd2/iaL+mVl8N+XzORC9ndpkjwCGplBx1dFUPbVT
	Seyd8=
X-Received: by 2002:a17:907:1188:b0:a3c:36ae:6c96 with SMTP id uz8-20020a170907118800b00a3c36ae6c96mr3303305ejb.42.1707725984258;
        Mon, 12 Feb 2024 00:19:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuv2yXO2qRvX72QX7GYrSJyaiawng8PNwVNQmwh/vWxNOis0v/WxumMQoGvxk2ldmRs+05Kg==
X-Received: by 2002:a17:907:1188:b0:a3c:36ae:6c96 with SMTP id uz8-20020a170907118800b00a3c36ae6c96mr3303297ejb.42.1707725983920;
        Mon, 12 Feb 2024 00:19:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx1DVn3NtyWCcg88vdkQVJynYFJL4yJLZYzIxf6wNZXAsNys5kG0KJHxdzXLkiKNTY0c2SkMtdIsPrNg5Ty0wJyO55poMERFAy91zEcqq/4anzHwO6D9+BXIUUK9sJN+4t0VefznK0qgTkrbDJ0KOvJThNmaXOYnXoxy3LyOyET/LiRBizbFyueBlM8R0Mq5Cla7/c0xqHNLY28w5cU3VgHC4=
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906715600b00a34c07816e3sm3610793ejj.73.2024.02.12.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:19:43 -0800 (PST)
Date: Mon, 12 Feb 2024 03:19:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Message-ID: <20240212031722-mutt-send-email-mst@kernel.org>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> vdpa devices.
> 
> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I don't think failing suspend or resume makes sense though -
e.g. practically failing suspend will just prevent sleeping I think -
why should guest not having driver loaded prevent
system suspend?

there's also state such as features set which does need to be
preserved.

I think the thing to do is to skip invoking suspend/resume callback, and in
fact checking suspend/resume altogether.

> ---
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..ce1882acfc3b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>  	if (!ops->suspend)
>  		return -EOPNOTSUPP;
>  
> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return -EINVAL;
> +
>  	ret = ops->suspend(vdpa);
>  	if (!ret)
>  		v->suspended = true;
> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>  	if (!ops->resume)
>  		return -EOPNOTSUPP;
>  
> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return -EINVAL;
> +
>  	ret = ops->resume(vdpa);
>  	if (!ret)
>  		v->suspended = false;
> -- 
> 2.39.3

