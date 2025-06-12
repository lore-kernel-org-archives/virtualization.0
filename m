Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686C1F5858
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710041; cv=none; b=CURDHMsrl/pRa8/rwgqPgfss0FTLAzunz/2HYQZK/B7r611Mm1cgdlGPTwC/HOROM2VwtkDCblQdZJNKyGpvCWhp9vVaDVKr6wky4HHxBoMPzGElmDMJPN8iI6k5uPOVnA60dTHGilie+tsAU75dxgV7mQ7PSmicuQp6NrjRHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710041; c=relaxed/simple;
	bh=0RFsYK4/bVTOu8PeXbzz5JHWzOqZR66/rgr6E+bl00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FZhzddZc16MIdg5gwxvGaz5bW/hYJbnLCIfjUzXGIlP8VvUn4xCfyCZ7aUxuURotQj9Eu4EceDiuSmPkvV7tqXTk5NNaBpd9ZzeaXOtWy1PnGGntejv5s17P5Cz/prIorM0tAHJhY1g6u6chuhqyzWkeW/3w17FXtILh1NPAhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P61dFUvG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P61dFUvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749710039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm9TV6R7Y41QOfPJ6MP5oIIesRRVBP6gVfG7mX/j6mc=;
	b=P61dFUvGfESAUn2qEpA1k2+xHergC+Lr6Zr9p4XaHKG9Q1xgaXC3ZJB5IBQwceyM1el7WX
	jGe4X73mdS86qHb88KUgO3hhPuIHPJ0sgSoVG7r7/AVf5bVJ13Cq0HER7ASMQCdA7l+tG+
	GMMVY0l8aLCzs2CHYshWc+YKwF658gs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-zumNoR6jMpuA3xLbBJlt9w-1; Thu, 12 Jun 2025 02:33:54 -0400
X-MC-Unique: zumNoR6jMpuA3xLbBJlt9w-1
X-Mimecast-MFC-AGG-ID: zumNoR6jMpuA3xLbBJlt9w_1749710033
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso2929945e9.0
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 23:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749710033; x=1750314833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm9TV6R7Y41QOfPJ6MP5oIIesRRVBP6gVfG7mX/j6mc=;
        b=cJTPbpm5DBiIJ7x3vs3qrt59h48zgilSG++qGnKUvLyoO/tSGXbnT3WZrEtpVhttFQ
         xaeNSGmpO2o0VzcewE5G9b6EXAaQ27yexbBR3S0dOupGH4bcsLQiu4+JwXh3XpPsu/d+
         nqau0wqSYgrhAs7YA2FbKPVtYxeQIpvhuDDWiWZH/wRWK3CK+h1ADvul4o3PMKdnVq0y
         YBGPAiNX6aKH47/MHwzCsywNhN8scKXp2JLuhyM4TvzIUOweipcupcspmOxB9X/YdCsx
         nHAUvCr/UaqErQGe+bRwT3W7wCBWVL7/9vyCcYPfwAzOBeEavWYOTIKbg4rAvk9ryg7u
         UtSw==
X-Forwarded-Encrypted: i=1; AJvYcCXqeHVvFeIBKxZINkxUclNrHTc9OQCC7kiZYEkRdMY2GuIk/IPzMuBy45U4AQNG6UQs3FLfNtjLNM2mxt3Aiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBFUcf5XT+29gLqJo3QCg7ovyxLQpnXchSGlJyuBFO60UGbjyf
	ZsAtm5PpfCIdKGfp8DRLFaI6iE9y6Fgj7TnLgfOm3jIRxN50wwsD8yy3erKPvo+17kPSkrfIGIn
	JXjwaeYn8qb8rTrFEyTpsdqrPV4JB9OgGKUBYgiduFRDcFFhxv3RoQjfeQfZjxdDxws/F
X-Gm-Gg: ASbGncuF3y25xZxhYCLiQDvXhcV/h5PIWD0PykbzioUa5Qvqa27KTFF/X/Y+hVM0V5l
	vXpSkUlZJeVrMBubyYKYc84Vbx2TaSVUp1Oyf10QZvWi2yPnur7m87J31js0fYWN/CRog14WFJV
	NczgYh3xZ006ZX0Dmm7HdyOS90TTyNsHCkb7X9zhUV/u7WRQYPk4pATClq3f77p3k08MI96XdgX
	pX9sEEsS0+h2xDEXX78Q6O2/JXmX8SAL8qDUQt2cDArUeGvrXPyV7vBRrLHGzdxJAtX1Cwhhz1T
	ov22XueHhNU/Qhu/
X-Received: by 2002:a05:600c:c162:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-4532d2f7108mr14039505e9.19.1749710033350;
        Wed, 11 Jun 2025 23:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUPXH7B83FgsgIbWOCFa8wLAry7d4eNcJALWMalXCx0ZQ4ODVUAv9DRXGbLvxZDae4zuYiyw==
X-Received: by 2002:a05:600c:c162:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-4532d2f7108mr14039215e9.19.1749710032990;
        Wed, 11 Jun 2025 23:33:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531fe8526bsm43377245e9.0.2025.06.11.23.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:33:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 02:33:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: sgarzare@redhat.com, Oxffffaa@gmail.com, avkrasnov@salutedevices.com,
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream
 sockets
Message-ID: <20250612023334-mutt-send-email-mst@kernel.org>
References: <20250521121705.196379-1-sgarzare@redhat.com>
 <20250612053201.959017-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250612053201.959017-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HNvs2KyLMtuE5MY8Xz19j68PMD4sfONi8xv43Cmm7uo_1749710033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> No comments since last month.
> 
> The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> patch. Could I get more eyes on this one?
> 
> [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> 
> Thanks,
> Xuewei

it's been in net for two weeks now, no?

