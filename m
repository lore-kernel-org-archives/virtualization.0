Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714627E1
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782807; cv=none; b=eidLSQm8y7UyHaVZByqkihrTFIXkHLn8rwEkZkT3n5SM/66BdL6sD3hJF/SA2ckjGI4vwWbjJZlaCJ/JYy2Q4U8vvWfOc9IQP24XG505424YPjAzS5MjOnGAB2by65g1OtCKCARw20ASVvrWIxZgtyCMUcjZIk8mfAQBs1Ik7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782807; c=relaxed/simple;
	bh=jMnnyoNXxFmFhw7xz0fpCdQOOntpU6lZXJA6WYcxJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ryCwBbvDvUuIk3wvnZ9p198LwV5c8Zc5eI3+Krr9Uw78xmgrFVYz9+/BdEKLNVNUhQ6FTOS9yYXSz7N7Ba1qG8J/bEy5WKUshy9QF5aDwxohI6EvtitTJKt6FQlWA2xyQiNU4Y2ZFacAR/j59yITWnRyGOWPKl1jG4qg8b0smvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqDrnrnf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqDrnrnf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 849E360A5C
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 00:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id an2I4dSW95hN
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 00:06:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B209D60A5A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B209D60A5A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqDrnrnf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B209D60A5A
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 00:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707782803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEkRB5X9nhp6e5CZwbs1ixb2tAsBEKZ2oc5X6L0U38k=;
	b=AqDrnrnfqCG7sgLKp7CdXcufK+T2Mzo4vsZ9vfTJx4BqYkC3up5ec8BSFPejE/vOQxjn2o
	PGS5uF3fumszPeBalomHNoSK+7PufWORhjun9I/U6Awo2OiUwuIN7ECx0nbmK2jQkqjKIR
	JbBZW0HOqsSNptEf0zLQu9w6bM4PoS4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-A1O9pKpJNVOx3YWr2qUSNg-1; Mon, 12 Feb 2024 19:06:41 -0500
X-MC-Unique: A1O9pKpJNVOx3YWr2qUSNg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a382663cfa1so202487066b.3
        for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 16:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782800; x=1708387600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEkRB5X9nhp6e5CZwbs1ixb2tAsBEKZ2oc5X6L0U38k=;
        b=VlxNQ2EcyHWj4C2D7Y6pFbncdFX+XBslaupJO9ehqaMzqVT7V18hO+qWOl5+Dlp0ug
         rto6Np2l2/v+L9Dz2NbA29BKb1CMO+R7KWYyay6i5uIZztv9suOUmbglnblauKw8VgMN
         6tDJzPLqB+NyG2eAstaDVSsbkkMx7bkVLDDyz3DhpmFOI9QlIQ/VpocOhTAGBhWygtfV
         jUy3WRGvm6lj6Ks0vmC+Q7KaUfzzH6eBek/CQiOvit74FrqpxrUa1SFEkQxYKQgrfQTj
         MGbRqDaMcBml+j3pwGRWeTu5IF9iFW3G8mfv2gN0xjZ4jdAJNYKfABVAGqAFXrhWw8/K
         fnhA==
X-Gm-Message-State: AOJu0Yxu9k050rH3lciwmgtDLTXOjPzLAAR+3HptVH+y8QBkYImBiill
	EcfzHM98VyzfItYTj0eQY7R7htSh4JlmIuaO0jfRtwt02bbk5/rNOi+TN5fW27QCNa1YTL1Ykn5
	uFNu1kS43GSvhf4xY5y1zIaOS3OH46D5502gQijKNeXnm7QuSMJntb3WCzxcSQyoqrVNYT7imox
	yxJBA=
X-Received: by 2002:a17:906:3b56:b0:a37:8a2c:316a with SMTP id h22-20020a1709063b5600b00a378a2c316amr5386151ejf.45.1707782800516;
        Mon, 12 Feb 2024 16:06:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7LRdkAWmFp59moKlLNAtUzytroiaAJc4XSzIy0GJCxR+hnxcv59RblAMdZ3n+o+Ek+kgN5Q==
X-Received: by 2002:a17:906:3b56:b0:a37:8a2c:316a with SMTP id h22-20020a1709063b5600b00a378a2c316amr5386139ejf.45.1707782800133;
        Mon, 12 Feb 2024 16:06:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhSLlW6LQbIyotm6kODHZhTnovjWYe6PE+ZAOplUjdM/Yr7vaSf+YlmTBcfVwbT2YrzE5TV8LCjUVbNx6eLUGeW/dexxjI0RwjwbD/eO9GCkWbX/EmfsgEVVGEcqAWL67ESi2jshYKjHTOWOP0YRA5Gbuy9I5PUvVD8lDw2t/I6JdMucqfL7Cv0oFXk0t359G4V1vKFEaLhpkT4UA5QXSxgy8=
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b00a3c66ac5146sm693550ejc.120.2024.02.12.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:06:38 -0800 (PST)
Date: Mon, 12 Feb 2024 19:06:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Message-ID: <20240212190628-mutt-send-email-mst@kernel.org>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org>
 <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
 <20240212105604-mutt-send-email-mst@kernel.org>
 <e3515937-7d36-4167-84dc-a9c1721249cc@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e3515937-7d36-4167-84dc-a9c1721249cc@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 11:37:12AM -0500, Steven Sistare wrote:
> On 2/12/2024 10:56 AM, Michael S. Tsirkin wrote:
> > On Mon, Feb 12, 2024 at 09:56:31AM -0500, Steven Sistare wrote:
> >> On 2/12/2024 3:19 AM, Michael S. Tsirkin wrote:
> >>> On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> >>>> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> >>>> vdpa devices.
> >>>>
> >>>> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>
> >>> I don't think failing suspend or resume makes sense though -
> >>> e.g. practically failing suspend will just prevent sleeping I think -
> >>> why should guest not having driver loaded prevent system suspend?
> >>
> >> Got it, my fix is too heavy handed.
> >>
> >>> there's also state such as features set which does need to be
> >>> preserved.
> >>>
> >>> I think the thing to do is to skip invoking suspend/resume callback
> >>
> >> OK.
> >>
> >>>  and in
> >>> fact checking suspend/resume altogether.
> >>
> >> Currently ops->suspend, vhost_vdpa_can_suspend(), and VHOST_BACKEND_F_SUSPEND
> >> are equivalent.  Hence if !ops->suspend, then then the driver does not support
> >> it, and indeed may break if suspend is used, so system suspend must be blocked,
> >> AFAICT.  Yielding:
> > 
> > If DRIVER_OK is not set then there's nothing to be done for migration.
> > So callback not needed.
> 
> OK, I missed your point.  Next attempt:
> 
>    vhost_vdpa_suspend()
>        if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>            return 0;
> 
>        if (!ops->suspend)
>            return -EOPNOTSUPP;

right

> - Steve
> >>     vhost_vdpa_suspend()
> >>         if (!ops->suspend)
> >>             return -EOPNOTSUPP;
> >>
> >>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>             return 0;
> >>
> >> - Steve
> >>
> >>>> ---
> >>>>  drivers/vhost/vdpa.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>> index bc4a51e4638b..ce1882acfc3b 100644
> >>>> --- a/drivers/vhost/vdpa.c
> >>>> +++ b/drivers/vhost/vdpa.c
> >>>> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
> >>>>  	if (!ops->suspend)
> >>>>  		return -EOPNOTSUPP;
> >>>>  
> >>>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>>> +		return -EINVAL;
> >>>> +
> >>>>  	ret = ops->suspend(vdpa);
> >>>>  	if (!ret)
> >>>>  		v->suspended = true;
> >>>> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >>>>  	if (!ops->resume)
> >>>>  		return -EOPNOTSUPP;
> >>>>  
> >>>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>>> +		return -EINVAL;
> >>>> +
> >>>>  	ret = ops->resume(vdpa);
> >>>>  	if (!ret)
> >>>>  		v->suspended = false;
> >>>> -- 
> >>>> 2.39.3
> >>>
> > 

