Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BC3CF6C
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753415; cv=none; b=HVD4Zkz4ldvUU40icr/sFV9Hnf+cb8SuZlL4zcESdXsw2eAEUKe7ZsxCa2O2jg+O7NXJSitLdf4IbgTwl9IQPDw1LseCAhnMnAfYE5ycxnj818qtLOpmUkfmEpV3rffBAL97lm1Ms0ytqPmwI94RnV3eC0LD6dibApooEeaFik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753415; c=relaxed/simple;
	bh=i+CWSXjieb9+g3XNqpNF8tfttfF6GckHkqIIP8N1CSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GeoABGIlf9NisBA5oNSrIJljDBhaDsnOfqFsWjIHtY622qKwh+3URGXXXBwrb25Dgm3uZznj6LADeI4aaht6xtpOv7WHUWgaRHzzWF9DkeJ+Ck6dv4CnDUfEGnOxzU9fHU7rbVnI+CX2gqtoA/pVhnmbViTKZBix0jAbKsR/FHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZsaIpsP; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZsaIpsP"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A35761315
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 15:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYiijqYtUUup
	for <virtualization@lists.linux-foundation.org>;
	Mon, 12 Feb 2024 15:56:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6B61B611D3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B61B611D3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZsaIpsP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B61B611D3
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707753411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80GrjE91srg+UL67pV7wExMUIzc8aRkIezP7bk9CD6k=;
	b=CZsaIpsPY7QjUUQ3TO6DmAGdIwDnPSN92RvjZfjrr8QsDWMJNURnai0H7GfQZCFinOu0cS
	JvBbUD21QPM36mFH+9TAnkU8rpYTJghQeBejGRAoViJSMiOiLETgtjhoX7UfvEYuwjKFc3
	eBQRAK3jbdMCL3ldsuYiho1DsvYjPz4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-C50RMf9vPS--JVYy6lSncA-1; Mon, 12 Feb 2024 10:56:49 -0500
X-MC-Unique: C50RMf9vPS--JVYy6lSncA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3cdd79d960so19330066b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 07:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753408; x=1708358208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80GrjE91srg+UL67pV7wExMUIzc8aRkIezP7bk9CD6k=;
        b=BbYk30GGasw2nFtQtjhBJ+aJpgOq9ecO/JBjL5dvGCbuZT2m+0+4IqH6vjrRu8uITh
         HEx63RgYOg+nu5wD4iJNydR8dnDcPg06djh5OWW3HT3OaB0yHO0KeMVttt2i0QlenhLp
         J8vn2yyCbdzOzt7mWZSDgfzHm8UNqGmtg5+UnjGvK688igacbWhrqDS6GMb2raizGYe2
         pk8SETIgJ+2wVNZsjIaoK3u+bSK4Y8cj+QOao6mW0GQokWOrJ8OoRX2JjPaNogQKtjfQ
         JklOnvRsi2xLNjC30S8itbHqEuOJ8LbkoTzBwdZC5UGh70QCQRkM1bc52Byu+w9q/kCW
         WZSQ==
X-Gm-Message-State: AOJu0Yzkmoz3a70uIlPOlr7P4NbSWc6VvwFYJNX8nA6nT1+w7DZ1lMRB
	C/t7kViMt4dkXfgWKa2dgLf9tXUB9y0V0Q7Rn8ttl97PLOa6+nUftGvwm3o+RO5pb8nnpwYIkgA
	/cOrOKiAu9i0psXrKoqDVzsEO56HJ+Zz6/ev5rmHrf/0RkS5vzn3fNP5YpdRkI6SV0sUbqcb3Iw
	jIzKw=
X-Received: by 2002:a17:906:dd2:b0:a3c:d159:cb27 with SMTP id p18-20020a1709060dd200b00a3cd159cb27mr1049465eji.72.1707753408724;
        Mon, 12 Feb 2024 07:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyKF1R8d6gAgnYz0NnbDP75czUwW1lB9zvvmzVavx3OhAr2ygTGmn4J2bxDaU9fm51Qb++4g==
X-Received: by 2002:a17:906:dd2:b0:a3c:d159:cb27 with SMTP id p18-20020a1709060dd200b00a3cd159cb27mr1049449eji.72.1707753408300;
        Mon, 12 Feb 2024 07:56:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe7XGBQb9gJA94EmQMG/iEZxuM39xO8CoJr7ldFc2kcTVE8KHBgtrE3eutSTFm7JQHbvX9iTEf7oH2wHP+x50U3qEUtf9y+yIGzwicMdnos0Ajy5B0RkbgH+3QtYAQIz4VOwQG8Bjkrqrx01U0yvf1aV9xDHw7GjOMxDUatXoFIizfsH/rT2Y+eU/Fr4VOBJ5qiyl+5so/SD4yLKeWsp9cSvY=
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id gv20-20020a170906f11400b00a3c9bd8e1c9sm330563ejb.76.2024.02.12.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:56:47 -0800 (PST)
Date: Mon, 12 Feb 2024 10:56:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Message-ID: <20240212105604-mutt-send-email-mst@kernel.org>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org>
 <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 09:56:31AM -0500, Steven Sistare wrote:
> On 2/12/2024 3:19 AM, Michael S. Tsirkin wrote:
> > On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> >> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> >> vdpa devices.
> >>
> >> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > I don't think failing suspend or resume makes sense though -
> > e.g. practically failing suspend will just prevent sleeping I think -
> > why should guest not having driver loaded prevent system suspend?
> 
> Got it, my fix is too heavy handed.
> 
> > there's also state such as features set which does need to be
> > preserved.
> > 
> > I think the thing to do is to skip invoking suspend/resume callback
> 
> OK.
> 
> >  and in
> > fact checking suspend/resume altogether.
> 
> Currently ops->suspend, vhost_vdpa_can_suspend(), and VHOST_BACKEND_F_SUSPEND
> are equivalent.  Hence if !ops->suspend, then then the driver does not support
> it, and indeed may break if suspend is used, so system suspend must be blocked,
> AFAICT.  Yielding:

If DRIVER_OK is not set then there's nothing to be done for migration.
So callback not needed.


>     vhost_vdpa_suspend()
>         if (!ops->suspend)
>             return -EOPNOTSUPP;
> 
>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>             return 0;
> 
> - Steve
> 
> >> ---
> >>  drivers/vhost/vdpa.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index bc4a51e4638b..ce1882acfc3b 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
> >>  	if (!ops->suspend)
> >>  		return -EOPNOTSUPP;
> >>  
> >> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >> +		return -EINVAL;
> >> +
> >>  	ret = ops->suspend(vdpa);
> >>  	if (!ret)
> >>  		v->suspended = true;
> >> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >>  	if (!ops->resume)
> >>  		return -EOPNOTSUPP;
> >>  
> >> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >> +		return -EINVAL;
> >> +
> >>  	ret = ops->resume(vdpa);
> >>  	if (!ret)
> >>  		v->suspended = false;
> >> -- 
> >> 2.39.3
> > 

