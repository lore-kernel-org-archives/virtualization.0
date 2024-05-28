Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680016C6A0
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914749; cv=none; b=FhED+9Z5PFQ+wk2nFwFOxF7s2eBxcilozDNlgLMrHi0lhG/XBkXeXQ1Qbn2IJXW81AjNz3L+uODMya/fhqTNHU2dA94KtZeRZ3jJpNHIdqrQuwVAiTII0FFuN6PuQEhKXfHLkRawp71qvx+XQRfJBtbtWCcQ2WHbKNZcBcWy71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914749; c=relaxed/simple;
	bh=iFNnuOu2HwWtWmWue9l7M2F5N/SbCFGvNbXjcJ7ZdJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rSfJ7ifC+1gS4+WAwOg2zH42foxH2NMh54V6cBJGVcH1xXwShElzTng9e5x/8dDM735i5vyTNZG6rOtMDRbpBv8VH4AvH+I3IYY5c9Pn2AUnTzTWTNc2yvD+VNktLa0tMdk/78lXEHwiFGGy1e+3wPt8YqKXb/FnXJEqv/XfskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8I5Lm4Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8I5Lm4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716914746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wa5dly9dXKEpZgbrWQL2pjwW4nOpdYdwbtcWXOar958=;
	b=f8I5Lm4ZfLvhuWp1Kwc8OwCyx7/6nWHSevvV6lyR1Xjt5SyByKmEcaA/tUZcuSrTjC7cYe
	cmUuE7P2J/knWisBZBbJREVc9rAzz3BqTw/40b58uSdzaH3gxs5tHfo33raOLck3aJxm2M
	1vjo0Vn6RBpIXKmHMsyuaIPlwjshQV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ghdUMxE-OPeoXYrPyHmkIQ-1; Tue, 28 May 2024 12:45:44 -0400
X-MC-Unique: ghdUMxE-OPeoXYrPyHmkIQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41fda32e6c0so6031165e9.1
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 09:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914743; x=1717519543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa5dly9dXKEpZgbrWQL2pjwW4nOpdYdwbtcWXOar958=;
        b=VjaFPWqGcbhKErgYoUuo3lXtfj2Alw8US5XflQxybl3E4nXQMT3Fck/c5EQAHXXuzk
         MrvR+XHbKHwZpvy4PXpA73UUlkNm6kwXi2fK1K3CQlKinAksoNKl1WFMrnPb1D5aSSQp
         M8o0mmdDkjTi4+RyiX0cUeU9njZ19uRSf6IWcckT0M+ovny0T+WEoe4VkLka2rRCZiMs
         psKk5c0bzBEcyUjqaWkH/pyXUmuJ0J2ezQtelYK2NC8OP27DkEHgBfPfb9YJPoEEng2C
         Hd+5YbilJ0zlLSWNTdOi5VGSMoG9bJyeVabu19Ho8l2XlRDE2ky7OfkWYOi5rVg5dgvR
         xHtg==
X-Forwarded-Encrypted: i=1; AJvYcCXYGIBsL2sHDvbg1iEY2C0BwuZEu297JWCS3sp4RKBStiKnA5OPN66PUG4cZgP7pCv/C/7h+qq+hkWQAVAhYMGmujsL38oe/kCBH1kxsYs=
X-Gm-Message-State: AOJu0Ywpl/zQ4EiPuE4rNdvutE6G+FaU/8SZfbAt4r2rCmUTDOALOodi
	9hgzZxY7K8JNgtq1DsjQbb8MQE2WxgqEuTwZlLuA+P7oQbFUZyNkcvmp10X2lI5YWMSDRfwDS6R
	+uxL/l/89XKw/gij5tFqLlR8aSDy+b4E0yEPXzsNJ9KpudbXqsAgDqLYvKsla8iGB
X-Received: by 2002:a05:600c:4f48:b0:41f:c5c5:c9df with SMTP id 5b1f17b1804b1-421081dff05mr118456065e9.14.1716914743345;
        Tue, 28 May 2024 09:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBXW0wrd1ee1hCZrl8Yx0rQb9lk7S9zHjdf8iTXhqpiDFpcyGn/ILsKlm48qukSntx6bMJEw==
X-Received: by 2002:a05:600c:4f48:b0:41f:c5c5:c9df with SMTP id 5b1f17b1804b1-421081dff05mr118455715e9.14.1716914742696;
        Tue, 28 May 2024 09:45:42 -0700 (PDT)
Received: from redhat.com ([2.55.190.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae866sm147498295e9.34.2024.05.28.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:45:42 -0700 (PDT)
Date: Tue, 28 May 2024 12:45:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 2/2] virtio_net: fix missing lock protection on
 control_buf access
Message-ID: <20240528124435-mutt-send-email-mst@kernel.org>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-3-hengqi@linux.alibaba.com>
 <20240528114547-mutt-send-email-mst@kernel.org>
 <1716912105.4028382-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1716912105.4028382-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 29, 2024 at 12:01:45AM +0800, Heng Qi wrote:
> On Tue, 28 May 2024 11:46:28 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, May 28, 2024 at 03:52:26PM +0800, Heng Qi wrote:
> > > Refactored the handling of control_buf to be within the cvq_lock
> > > critical section, mitigating race conditions between reading device
> > > responses and new command submissions.
> > > 
> > > Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > 
> > 
> > I don't get what does this change. status can change immediately
> > after you drop the mutex, can it not? what exactly is the
> > race conditions you are worried about?
> 
> See the following case:
> 
> 1. Command A is acknowledged and successfully executed by the device.
> 2. After releasing the mutex (mutex_unlock), process P1 gets preempted before
>    it can read vi->ctrl->status, *which should be VIRTIO_NET_OK*.
> 3. A new command B (like the DIM command) is issued.
> 4. Post vi->ctrl->status being set to VIRTIO_NET_ERR by
>    virtnet_send_command_reply(), process P2 gets preempted.
> 5. Process P1 resumes, reads *vi->ctrl->status as VIRTIO_NET_ERR*, and reports
>    this error back for Command A. <-- Race causes incorrect results to be read.
> 
> Thanks.


Why is it important that P1 gets VIRTIO_NET_OK?
After all it is no longer the state.

> > 
> > > ---
> > >  drivers/net/virtio_net.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 6b0512a628e0..3d8407d9e3d2 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >  {
> > >  	struct scatterlist *sgs[5], hdr, stat;
> > >  	u32 out_num = 0, tmp, in_num = 0;
> > > +	bool ret;
> > >  	int err;
> > >  
> > >  	/* Caller should know better */
> > > @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >  	}
> > >  
> > >  unlock:
> > > +	ret = vi->ctrl->status == VIRTIO_NET_OK;
> > >  	mutex_unlock(&vi->cvq_lock);
> > > -	return vi->ctrl->status == VIRTIO_NET_OK;
> > > +	return ret;
> > >  }
> > >  
> > >  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > -- 
> > > 2.32.0.3.g01195cf9f
> > 

