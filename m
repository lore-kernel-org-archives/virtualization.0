Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EB175A90
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607670; cv=none; b=GG/UFLRZNIeQQpfVLpdp88nROKFPD7QaUPwpuA4/l/JLYqncicvCVIH7rPgiQMkrwNkbGT7ioV3sLxSdcD9Qalb81jUGCFmdo2hRShiwk5o/ShwleAcdvXZ81hTy2q6irlou+sCLIcMFxdypRL8JqyGnivEcigwvBXT2COxqTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607670; c=relaxed/simple;
	bh=KWWIB7t7C3pJOd/0xpSdaV+2Zw0SpFMTOmm+zMTeHAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IongYH5G06DZAG6VA7x3IIsycG4hbLxGdZIosfOpS0vKksA20oothhNZQYwaOfShG5RDOyFuCmLNJTFeaSJt4BTK9kEQPYhIIjN4gHucGHHCNzU98f35OSEMA6iOnRrRTZLCi03UfEsdGbPYpenozuob7PRUQS3X9Zzv5ntUQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EogdiAnS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EogdiAnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772607668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwBE4akms1F/Y859toP4EhYH9BAxcWIZ0TA5l5/GfsM=;
	b=EogdiAnSTWLNH7lxh5azeUoIlkl0ui73NNiDUT4+X0iBmhj1zvFZT2m1kfP0vMgWXsZBt1
	vXoTQ/Yf83J5UxhLcZOu2937XKkqM1CMLiGHhKyxFvvT2Jlf8XOw1BKGGK7RVYFkfXe/ws
	v2ohTlqtSKxnxCCa+kuyiUeYkSy2WJs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-yVaoFWNwOha7IosJneXHhw-1; Wed, 04 Mar 2026 02:01:06 -0500
X-MC-Unique: yVaoFWNwOha7IosJneXHhw-1
X-Mimecast-MFC-AGG-ID: yVaoFWNwOha7IosJneXHhw_1772607665
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3597f559e70so2733006a91.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 23:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607665; x=1773212465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FwBE4akms1F/Y859toP4EhYH9BAxcWIZ0TA5l5/GfsM=;
        b=sMqS01cH9mxm/yH7FnAclItsX7Czs25QvtPQ9b7g7ko4ZVR4wZSVNQNpL9O9NJ+DJ5
         QAbrYBiEkH5c4iDUAoMm9EljXEWmdgq+3ZHq9OQwDOCMh8rG6ZCa+vL49NWKVv6ujAKW
         tC8VWYRXAlR/3F3CfKInUIq5Uak9z6nnaENeRuzE291eAOxrUQSh1QHEYqqw9vI8TkG9
         1La2QeRE258FekLdX8UxnoHCG3QADUlZrTjkyac4+sqBznGFo4dhxCNZzascj8P5Juye
         VMv9kBxi6y612sycI68QrZRXMVsiGum4TQiJhGbw4fJlD/jEV1N39yxQK+c1FBBTfuEs
         mIEg==
X-Forwarded-Encrypted: i=1; AJvYcCX++PWDkG2M0Yi1z/Ktd9EVOUOr3jypJhduPdFJmbvDqwXzAasJiA3ZhGlSv17ZHH0xeB5nJeN5oMhUiOKYYA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3eu9rZekU4nxYIJZ3P4qRmC8WWhTaklvRuj8RPY9yt7V/zFkm
	MhHtcVxqCB2MYBWrpiC5ZGDothVhX3mA+T3207lX9rrhmC+THkfnNBNEIDyx6JfGv/vkaWZk40m
	qLJ0/aceeNonsuauKkvzu75QlPu0fX7pmYC1E9ata6X2pUce8D6u6DqPf5Qpia32OCfeGFLIZdj
	o6vki+f8kVzOXj1nwagZHnp1vCpiaGQZrRdPwmlC9x6KM=
X-Gm-Gg: ATEYQzxbKX1ZoXpypiY+1jqiYpvctaULxr61wDCcpljahjgmiGCzwIoLg+SAY7WccUq
	kdXZapPXzxXiiOWXMIymUr7VDCZ/nxIGQuVG03rzvzJFt/6BZqHBhjMqzBZzwwAQaxq56i0hMks
	7B4CcvQZcFOpik58aQ9CHUQHxYB+Y0qKroJLzhYEIctOJDg5d/5/CHD7Yl8RfNpnEIxko08nYJx
	At16VY=
X-Received: by 2002:a17:90b:350e:b0:359:95c1:6b6 with SMTP id 98e67ed59e1d1-359a6a65fd1mr1207224a91.25.1772607665318;
        Tue, 03 Mar 2026 23:01:05 -0800 (PST)
X-Received: by 2002:a17:90b:350e:b0:359:95c1:6b6 with SMTP id
 98e67ed59e1d1-359a6a65fd1mr1207183a91.25.1772607664851; Tue, 03 Mar 2026
 23:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com> <20260226115550.1814-3-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260226115550.1814-3-zhangtianci.1997@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:00:53 +0800
X-Gm-Features: AaiRm51O97aS5NJ96agoaKegTRxNIomgtn4-ZRlUTVYj1ctl5GYjn5O3tIxLPFQ
Message-ID: <CACGkMEtduDsnZjGhOYwdRpOBVxX=+2z4C4sJ47KwROF7NWNzcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BuJuQD3iJMxYBf3lUFEDQK0ZPury6wjzyzbAnk_FTHo_1772607665
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 7:56=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
>
> vduse_dev_read_iter():
>     lock(msg_lock);
>     dequeue_msg(send_list);
>     unlock(msg_lock);
> vduse_dev_msg_sync():
>     wait_timeout() finish
>     lock(msg_lock);
>     check msg->complete is false
>         list_del(msg);   <- double list_del() crash!
>
> To fix this case, we shall ensure vduse_msg is on send_list or recv_list
> outside the msg_lock critical section.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

