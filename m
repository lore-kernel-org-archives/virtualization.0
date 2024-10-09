Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6A18E744
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469435; cv=none; b=anqnDULCbWntgiz129txhjZZEUR1XkTLMI/4G7Hc2htas+WycO8ww2JTv03l+a2n61ZAo5Lx+dhXt+BMqXcR+32ro3N/hfNQOGjMb4Yusho1PRilhE2d4ELRb0R7FT8OUoWmrdZnNnz8vUorWWvxi7QTFKTHH3JIAlAPeQ5/Rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469435; c=relaxed/simple;
	bh=tULl/ls0Ul5gHI76lwvmplsSs8rVtW+bHw1bUYo65+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cLypHPRrrM08169d6Bhqy3QQI3idvFOE3XoWwL589f63z2csnke3mpTMsoZNdO7zAnXXOV58xH2I8NLle9Zxc7UWLVV7TB8u2plOafm7HG2XHtRXUIstyZO/kzhcVpLbqPN2zaJM3UjRTYnBSsaTI7V6jZU1NBWEfi8Vx6Qkgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKmEvby/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKmEvby/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728469432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpLic9jP5d6PvzVoHze8EYpsWrl8KUJr/VbwIcRlGGk=;
	b=HKmEvby/7C0PZ0O3vqu/Ixt1FHa1/TkPXIXWsHxa2S5/aTgY/E9uI2HLP9QXX51Pua23T4
	bRks3wBzs6yQhlzcWCndJvCNau7WNFGeKs3ebClQTzt/K2Lgn3DHmVTzRixuC0KzeiIRtq
	lSNTLyOZZsyAUwJjrlf8i6masu8B3LI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-_cf5NtGQOMaVNjvVwvP5_Q-1; Wed, 09 Oct 2024 06:23:51 -0400
X-MC-Unique: _cf5NtGQOMaVNjvVwvP5_Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so54582035e9.3
        for <virtualization@lists.linux.dev>; Wed, 09 Oct 2024 03:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469430; x=1729074230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpLic9jP5d6PvzVoHze8EYpsWrl8KUJr/VbwIcRlGGk=;
        b=UBAMA++nErH5akHAMgzMRorUTiSdoSoFNqf1WFAJXrOInpu8YRuDy/U/nhJaqxUPcW
         aMWHytvjNCbK5G4V49cJomKeXqIyfKtMbnsNrWHDQtPRbokb2/Yx1rLJMDDWWtpvpNOQ
         MdpWgvFtEgLheg02yPn6QhiUPTf0r7yRaGzTvkL995yg0Kz+6GpRTOMHWBtFOHiYnvvu
         yyak/Fm7U7Dx8zyLYY4p7rnQdDX1rRlYLjnHK1/8FESVLAx83g0WELyWMqGgE2dxD452
         vP2Fd+SDemnLBjqIyHrQ+AWuMX47+vCd4Nh8ePjK8oBo12sJPrXeaq5kMEHulRDulRcM
         8oBQ==
X-Gm-Message-State: AOJu0YyjE+8MCXSdQ2uHyKEKqf5fyjUAwlVWh8PrpYNXVNHIncY0GVmp
	XtbPeJUAvBmLvBctBC42BG+Q5OkKgPh6R3kMxX2o+IAruIwFKHyLG2NRBoV+GBPUvrZvGeXxC8p
	BJv/Hzthm2n9r0rVuYFFM74KExlp4vu2guVJVn4E89N/0Ipt90Mgjkw+okLmbSgPE
X-Received: by 2002:a05:600c:1d09:b0:42c:b9a5:ebbc with SMTP id 5b1f17b1804b1-430ccf433e6mr17597855e9.16.1728469429993;
        Wed, 09 Oct 2024 03:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExpQoOOTx2ga9Pd234t3ZPMWGZOgOvLFHkkaI7uKTRvgzlBa5EG8Z+dpuvOGlf02vaOieaPg==
X-Received: by 2002:a05:600c:1d09:b0:42c:b9a5:ebbc with SMTP id 5b1f17b1804b1-430ccf433e6mr17597605e9.16.1728469429578;
        Wed, 09 Oct 2024 03:23:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920450sm10031660f8f.58.2024.10.09.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:23:49 -0700 (PDT)
Date: Wed, 9 Oct 2024 06:23:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20241009062315-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20241009052843-mutt-send-email-mst@kernel.org>
 <1728468047.566891-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1728468047.566891-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2024 at 06:00:47PM +0800, Xuan Zhuo wrote:
> On Wed, 9 Oct 2024 05:29:35 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> > > Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > >
> > > I still think that the patch can fix the problem, I hope Darren can re-test it
> > > or give me more info.
> > >
> > >     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> > >
> > > If that can not work or Darren can not reply in time, Michael you can try this
> > > patch set.
> > >
> > > Thanks.
> >
> > It's been a month - were you going to post patches fixing bugs in premap
> > and then re-enabling this?
> 
> [1] was tried to fix the bug in premapped mode.
> 
> We all wait the re-test from Darren.
> 
> But Jason and Takero have tested it.
> 
> If you do not want to wait Darren, we can discuss [1] or add it to your next
> branch for more test.
> 
> Thanks.
> 
> [1]: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> 
> >
> > Thanks!
> >
> >
> > > Xuan Zhuo (3):
> > >   Revert "virtio_net: rx remove premapped failover code"
> > >   Revert "virtio_net: big mode skip the unmap check"
> > >   virtio_net: disable premapped mode by default
> > >
> > >  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> > >  1 file changed, 46 insertions(+), 49 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >

I suggest you post a patchset you want me to apply on top of master.

-- 
MST

