Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6815279C
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742404; cv=none; b=QIaYVYVNo8t61ECnBnaGr/573uuelkc7bzfytujgHtaXbynJ5KFbXNGjxaL4NKhZ5TrFrbcI1T8SQ12H9otG5VlYY9a0WiAtcM/fsTKkYNzrjDHp8dx5cnf3LNVqaeLvgWtstBRwoPt/5ZZegam4OvxvKjy+NwLkOsJNcGvV1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742404; c=relaxed/simple;
	bh=AKCGweRURmDBUnQOXI2rqeJMFl+907yXROT9IJrV0+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f3dhgGkXcAhwq7YJgu6HzXI2je8TXhiDZbKMJc3lCyVbZMRARJIU4ZafdEjlMJLl7C2myTPy09OeiFYQnN13JYGfbdJ5f+SlzFcQRoE9afd4cFP942gKAR3ElnouC9XkZC1aLcnkz2g5WRYYK5XO8TF4m7GZaCgKU/xvePEF2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLkkWQaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLkkWQaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQmpBmdVffr5jwW6Krv4yv1UP5UH4NOMMf579PC1cCA=;
	b=RLkkWQaVRy3GOUIqM4tRal10mzKxRpEr5yqf8phgxSmPuvkf0MSwzzhitwCzIrejfuJ4V1
	zXVbn21hKIskZ6rkNUjLivSm/SPvOBAa9/7qn1+qLisTHQ2Tz6F4B7qrOQPASYGuFKeg9E
	lkTKU0RnPg29O/TkabINaA66ubgiQqQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-VrXJux6BOTiZoEBveHi3Cg-1; Fri, 07 Jun 2024 02:40:00 -0400
X-MC-Unique: VrXJux6BOTiZoEBveHi3Cg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57a4d24a479so546682a12.2
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742399; x=1718347199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQmpBmdVffr5jwW6Krv4yv1UP5UH4NOMMf579PC1cCA=;
        b=tEQ5fxluM9c8QeezneUTLG5n8zZxcGDKFo0DYv1omk1wfDCuOYZMJPZ108+NuFRX5m
         zwTO0FMjMVTHMeYCg/hYdpjp3P5kYkD0yjPk8O5pSwqgBR0U7bKjIIFkCIupDOfXZoXV
         cmvV+o9ATn8jVWRhjuP7qP0szzpOPaRMB54hf5CnqkMJYSpPf2Tz+HRGgkDra+bf/gBu
         qGo/G0wyL4GLn+6eRbq7Q/rVp5fccfIgk4x4yc6hMzF0NdhuLGIHwm+Bqklxa0Dctba8
         yxF8YAIAqChswNcYcGGLnyG2slr/eFVJIv/I5guCPqde72RWS6Z1cqXUeRZxw47+EP5Q
         P1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Bf4JJpUGlOa0yYgJKUi+8cMXMpevMhZKrYW+d0idICJ0Wrkiab1ciMEWXLM1aqj8Q0N8SUAvJsshA7+2ronVhCb1+msxO5XKnd/+g/c=
X-Gm-Message-State: AOJu0YySnPMJqphbnrbQqJsr4Jjx4cNwuscd5w7J8Bdp1Y0PM8lCdkfA
	5UtHEDK90NvlRLC5HYN8vCFoAZpw3ydquVOpG1NOVd6lXrgVSNr9lLvfrmUlEr6lYNElcIJeEgr
	d8I5kAgkubdqUPTqqBcjIDAl0YeUtgrvVhRKQHFC2H6F24KnaNyhpxJg5muSjDMVI
X-Received: by 2002:a50:ab1b:0:b0:57c:5764:15e7 with SMTP id 4fb4d7f45d1cf-57c576416ccmr457015a12.36.1717742399203;
        Thu, 06 Jun 2024 23:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG44KNJ431HoiCfVrtYoo/wgg6mAw+TVADuXjxD8XLlagNU3bOR05lU/dyZo7uSOdTJ1xqFXg==
X-Received: by 2002:a50:ab1b:0:b0:57c:5764:15e7 with SMTP id 4fb4d7f45d1cf-57c576416ccmr456990a12.36.1717742398612;
        Thu, 06 Jun 2024 23:39:58 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d064sm2230021a12.10.2024.06.06.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:39:57 -0700 (PDT)
Date: Fri, 7 Jun 2024 02:39:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240607023358-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
 <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 07, 2024 at 02:22:31PM +0800, Jason Wang wrote:
> On Thu, Jun 6, 2024 at 9:41 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >
> > Thu, Jun 06, 2024 at 06:25:15AM CEST, jasowang@redhat.com wrote:
> > >On Thu, Jun 6, 2024 at 10:59 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >>
> > >> Hello Jason,
> > >>
> > >> On Thu, Jun 6, 2024 at 8:21 AM Jason Wang <jasowang@redhat.com> wrote:
> > >> >
> > >> > On Wed, Jun 5, 2024 at 7:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > >> > >
> > >> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > >> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > >> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
> > >> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > >> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > >> > > > >>>
> > >> > > > >>> Add support for Byte Queue Limits (BQL).
> > >> > > > >>
> > >> > > > >>Historically both Jason and Michael have attempted to support BQL
> > >> > > > >>for virtio-net, for example:
> > >> > > > >>
> > >> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> > >> > > > >>
> > >> > > > >>These discussions focus primarily on:
> > >> > > > >>
> > >> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
> > >> > > > >>needs to rely on the judgment of use_napi. When the napi mode is switched to
> > >> > > > >>orphan, some statistical information will be lost, resulting in temporary
> > >> > > > >>inaccuracy in BQL.
> > >> > > > >>
> > >> > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
> > >> > > > >>reasonable. This provides good support for BQL.
> > >> > > > >
> > >> > > > >But when the device does not support dim, the orphan mode is still
> > >> > > > >needed, isn't it?
> > >> > > >
> > >> > > > Heng, is my assuption correct here? Thanks!
> > >> > > >
> > >> > >
> > >> > > Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
> > >> > > most scenarios. Although orphan mode performs better in specific benckmark,
> > >> >
> > >> > For example pktgen (I meant even if the orphan mode can break pktgen,
> > >> > it can finish when there's a new packet that needs to be sent after
> > >> > pktgen is completed).
> > >> >
> > >> > > perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
> > >> > > support dim for devices that want the best performance.
> > >> >
> > >> > Ideally, if we can drop orphan mode, everything would be simplified.
> > >>
> > >> Please please don't do this. Orphan mode still has its merits. In some
> > >> cases which can hardly be reproduced in production, we still choose to
> > >> turn off the napi_tx mode because the delay of freeing a skb could
> > >> cause lower performance in the tx path,
> > >
> > >Well, it's probably just a side effect and it depends on how to define
> > >performance here.
> > >
> > >> which is, I know, surely
> > >> designed on purpose.
> > >
> > >I don't think so and no modern NIC uses that. It breaks a lot of things.
> > >
> > >>
> > >> If the codes of orphan mode don't have an impact when you enable
> > >> napi_tx mode, please keep it if you can.
> > >
> > >For example, it complicates BQL implementation.
> >
> > Well, bql could be disabled when napi is not used. It is just a matter
> > of one "if" in the xmit path.
> 
> Maybe, care to post a patch?
> 
> The trick part is, a skb is queued when BQL is enabled but sent when
> BQL is disabled as discussed here:
> 
> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> 
> Thanks

Yes of course. Or we can stick a dummy value in skb->destructor after we
orphan, maybe that's easier.


> >
> >
> > >
> > >Thanks
> > >
> > >>
> > >> Thank you.
> > >>
> > >
> >

