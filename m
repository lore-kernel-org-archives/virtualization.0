Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEF1EB5C2
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490810; cv=none; b=HRyKV1Inz9H+VUQx8aah39RRIw0U2gZxj8cQhSYG6BLZVSyj/3Tij3ordZp1PYirRzOGEP0Wf7oOar93DdRRJ5UHgQeD9QnBylSwxRrz/socK+py5HVNDr0jlVAagNqPbMeHLQ444OYUdELqJlu/X//w1yItRX1//AqVBQCbPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490810; c=relaxed/simple;
	bh=mYlu1Cb8XJxVfGYYbOwNf+5SlCKDDhSJhlXNvH2HuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t9HHyVoSqjbvIVmFVXYRm9qTCYkXNATYKTnrEfOiyWnbhKE0wnzc/SPgciVlKewKDqNMLNPnf9y4HEQMlEY7zk6OOhF6AMYIft+CpNy1/drfkFb5JH1xDIokGr+vvSINGureoRRoxUtsL985sJNC8hsfAJ8DUnCLsOYTWkEeIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiQnNExu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiQnNExu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjWDsw8BL0wSRiGtGTApSm/QghMD5iCMDJieH5fCE5Y=;
	b=JiQnNExu49lrS5lWFoWGHUQ3u02cfsCt5Wsl7tmSi9oZ6A+lEWRqM0yI60isXxzg3l3iMq
	o0bj/CZGNQ2oj8B/UimwwDcS7JmKlqNAnYnCB6iTa2TanERb6GhXYMoS1IkEyCExPrNvoe
	vTCIrXSgZhkaS31hjTKRToNNRRutm0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-vVw7BsvWMQK5x8ve6SjCBg-1; Sun, 21 Sep 2025 17:40:05 -0400
X-MC-Unique: vVw7BsvWMQK5x8ve6SjCBg-1
X-Mimecast-MFC-AGG-ID: vVw7BsvWMQK5x8ve6SjCBg_1758490805
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f456d4db0aso764767f8f.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 14:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490805; x=1759095605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjWDsw8BL0wSRiGtGTApSm/QghMD5iCMDJieH5fCE5Y=;
        b=REP35zvRMWVZuDPDI1INZkMxUI6+o9iSr5+KqNRdWXH2dINaG4prP/tOhOsCKddjaR
         0m1shzbXKfpWFhyJy/qBUm2QFxXClfunjHr+fOgv6vd0os/UoRELoHCVL3bEeayozLYC
         yxdeV1zMCwAIqXZh2vVDfiJtfo45p5uiGwOgup55+mqQBguUh79xTfTwWKROhQHvEy09
         jo3TzUr6blJNtoCJhuxpwGnzqzJYyP5jqsp7rxMB4XCGbLPMYbgT6S0da2DDfAtRCt6t
         Cvhok4XyVcR4zVgVTStG9szLh2WqZTSR3lOODGmvYhU+j2g5yn2594V21PhJVJeufQrb
         SWJA==
X-Forwarded-Encrypted: i=1; AJvYcCXyVTFptc273oW8jwgDVJ+DydOmmW2LpR4m47BCxyuziW/Gm2mKe/8TjdS7YuIUTcgZwIhHWVgQwSqJl8C9Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmfU0X0MBB0EieKWV6Kyre7Sm5DMkkmM2xn7Rt+fbesYk4x5pA
	EjfhF0C8eMmo/V6rI2cJYQxy+Za3/CJDThJ06ELEoQOWBTj+ZsffZAXA1wjvzTVZc9Z7kd1Ie7k
	1Z32T8J7Jjb4gM9t0f7+ue7Scs8SKvIUWcuQfJQTqqATNlEzh251Q7F8K8T7HgTPZd3yc
X-Gm-Gg: ASbGncsRsCLHoHheWSos1eDcET/zwDBAgaboHMZ8WI0Xmk0HCX0zWOWQrZ3U6+Mpbbt
	A+XmaEOG7jAjnpBIviCGb0JlrER26TWmutIOCxEXq1xRvZsU4pwpOBdScBcVWljf+sMosJwK+QN
	C7N3s8CmUiEL9wrCJlrYK8lAzOIqzLiD9AjS382zWGwZxZKluCQFOoMuu/z+ucyUxPSVkJP3t7w
	uwyXrXgKFgJmtzO972mhlayV2ZhGcT9DjFgxyW5NdkaKEF88ES3iirULuaEtyBK/qNbKuMgraaq
	T4Yd195cOokltNmYC9uZrLZb/TGGmcyN3rQ=
X-Received: by 2002:a05:6000:2285:b0:3ed:a43b:f173 with SMTP id ffacd0b85a97d-3ee8585e3d7mr9640222f8f.42.1758490804609;
        Sun, 21 Sep 2025 14:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW4yYuHu/iRIBuAiq3TYquYa/BUUV5VnlAcln8dUtQI5Bcq9TDf+qyoforvTHvt2Z+XzLrWw==
X-Received: by 2002:a05:6000:2285:b0:3ed:a43b:f173 with SMTP id ffacd0b85a97d-3ee8585e3d7mr9640208f8f.42.1758490804220;
        Sun, 21 Sep 2025 14:40:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm17304749f8f.60.2025.09.21.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:40:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:40:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
Message-ID: <20250921173934-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org>
 <20250918181144.Ygo8BZ-R@linutronix.de>
 <20250921165538-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250921165538-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d5I2Is29XtfnhroFI_342XamufKe-RIhpTxIr7KfMvs_1758490805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 21, 2025 at 04:56:20PM -0400, Michael S. Tsirkin wrote:
> Subject: that is reference -> that is referenced

to note i fixed it for now. just dropped "that is referenced"
completely. shorter.

> On Thu, Sep 18, 2025 at 08:11:44PM +0200, Sebastian Andrzej Siewior wrote:
> > vhost_task_create() creates a task and keeps a reference to its
> > task_struct. That task may exit early via a signal and its task_struct
> > will be released.
> > A pending vhost_task_wake() will then attempt to wake the task and
> > access a task_struct which is no longer there.
> > 
> > Acquire a reference on the task_struct while creating the thread and
> > release the reference while the struct vhost_task itself is removed.
> > If the task exits early due to a signal, then the vhost_task_wake() will
> > still access a valid task_struct. The wake is safe and will be skipped
> > in this case.
> > 
> > Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> > Reported-by: Sean Christopherson <seanjc@google.com>
> > Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/vhost_task.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index bc738fa90c1d6..27107dcc1cbfe 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
> >  	 * freeing it below.
> >  	 */
> >  	wait_for_completion(&vtsk->exited);
> > +	put_task_struct(vtsk->task);
> >  	kfree(vtsk);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_stop);
> > @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
> >  		return ERR_CAST(tsk);
> >  	}
> >  
> > -	vtsk->task = tsk;
> > +	vtsk->task = get_task_struct(tsk);
> >  	return vtsk;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_create);
> > -- 
> > 2.51.0

