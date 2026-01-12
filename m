Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978A30AAA6
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768192949; cv=none; b=LV06dt350OPrxLmwdeO1QbB0Nklm7rwOhC7Ctvq82k2zu3XhN8Y1RMxtod98X3fvDvDnqPXHGMkDeoGARrvzOQvYYoQ5YzdvIVbwwn6SABWrzmyCEWiZaeXZfIwl/ZuqSkI0EIPT4f1bOkP792BY2zbLDiXkceKB37g9h+baabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768192949; c=relaxed/simple;
	bh=2VltQBFJygJXWBbOcvlhVXQ2y5H6Win1bazyoi6YOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GV0t2AskQwd03G2PtGriOcrOwEkwIrqDCPB70RLONEq056ZE5fXg/adzSYHUSS17HkkJNAlWlI6LWxoXX5Kdych25GUpPCGPdXMDNQLaWswkIoteedwafI2WMAdTLNtzZ5XwB1wJuUKTwKcE0nY8OmFwwIkuuowdV1lVcJTGHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMgLth3y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMgLth3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768192945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRnCSJo0TmvquSWDDIrpEWk/wUKA+CvYamy20zcpVrg=;
	b=HMgLth3ys4JwuMtzKCUdVeuPMNCq7VXNNwxl937lYaSXBTnRIjCK6+InKAkDMYIk7a+FDA
	1Kf6/yHjkr6yW6QJF0Ydce3lY3/DQHXSq9PjjPZ77vD4qG/nbpU1MWmUzUWt8LtkmfBmrN
	Hpww8KxZNj2IF2m2op8LmRv8pBzqG7E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-E26903q5M7-jillaee0_ug-1; Sun, 11 Jan 2026 23:42:22 -0500
X-MC-Unique: E26903q5M7-jillaee0_ug-1
X-Mimecast-MFC-AGG-ID: E26903q5M7-jillaee0_ug_1768192941
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fb8d41acso3904902f8f.1
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 20:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768192941; x=1768797741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRnCSJo0TmvquSWDDIrpEWk/wUKA+CvYamy20zcpVrg=;
        b=vyFzZDIbeLSG3zL0eaVwGm7KI4W6ebkefLJGHohKqhDunDv8EWUCHYWAsjO8VlB6Ou
         mqJ9k020OGkL/Vdwlz4Sr3wDi/+kdOpc/DyI3309ZZ5J4FF+UFuXyCQu3x/1b0TA2Pk2
         V7XT+lj3LFJE18Pc4kh5veClYd3jLMjAJlHPa7OB6l5WF5VuABOooaU09xfdnkQ54ydq
         dp6LvvMIuzyE28ZP/IR2y7vIHnsh6eWNGg/QWJ0kTQTMGIhoLpKUgsm6jAZke4mkHgZG
         8iivb5qKVZomxkT4uS2IGyJwNkhUJN8WnXC/2ZJNvSAJH+zzlQCynGx9Exj0/Nwechmu
         YD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjdmD7E7zR5bInh7dvYLipMtDSYzkcP9Vtywo8R1ghApYy7XAHqq3y5V4/+Y311D8D1WPTNBqRiIaNJP9X0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzyu9pkLcYmmnhGOb6Oe2K+wgV+LnbsqGpHjx79ZlWw5ZGp2FTe
	Nn2A/OmYTJBL2RM9JUO7KIn8FfWzk0MIIsAM+9ePggxDk/XXZLw0T3fCxrn3x6kUYG1ljYGb943
	cS1IXpdn9Ww1RjK1nzEJWrXcQX08LXWxWvNPNlWJbmTsZHRnM8xQpoH3ZVp5/FaLfiEyK
X-Gm-Gg: AY/fxX4dN1N4v6owVrFUE/X7k0fpT/NIJt7nx8SCZIjhGLVUQKbe8nAHXs8VNIbbcvD
	TOo6ll9xxDjbPvyZkKSZSL0h3T2+KVciFAqHISqQxhsa7/c9AxhtZC2lU6I7Y6Rz/O/x5L9/Y7Q
	0biiGOfJKTd0u1ljF8EBxounmK1sihCZbSIb3GS6SXLUuKk6Yh0trbZb+HBOJdtwrze9qnIr3NI
	PEJW7mlbZi20qyjc3618u2LjB0IS3wKXLNfutjsj9WQ81+y8leTXp6epbFI/9xrPlNbIPukz2Ho
	SOmoa75hQSGve4Bk3bPcdirol0XQQbo7Ks1hyjYy/I1Hagi3O/CS2ZdamPisxKijSnf+EX4tpUS
	IRZNlge8lck98NjetdziudBCOBWD4JNk=
X-Received: by 2002:a5d:5888:0:b0:42f:edb6:3642 with SMTP id ffacd0b85a97d-432c37767acmr20558543f8f.60.1768192940935;
        Sun, 11 Jan 2026 20:42:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGksWsEOp11E7do7kSJe9rVBAth4jOqGHv4mw3q8StsdQQPY6PxltAQTL2SJSNkU9vJyWdeOw==
X-Received: by 2002:a5d:5888:0:b0:42f:edb6:3642 with SMTP id ffacd0b85a97d-432c37767acmr20558531f8f.60.1768192940549;
        Sun, 11 Jan 2026 20:42:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm36985010f8f.43.2026.01.11.20.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:42:19 -0800 (PST)
Date: Sun, 11 Jan 2026 23:42:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 7/9] vhost-net: vhost-net: replace rx_ring
 with tun/tap ring wrappers
Message-ID: <20260111234112-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-8-simon.schippers@tu-dortmund.de>
 <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
 <5961e982-9c52-4e7a-b1ca-caaf4c4d0291@tu-dortmund.de>
 <CACGkMEsKFcsumyNU6vVgBE4LjYWNb2XQNaThwd9H5eZ+RjSwfQ@mail.gmail.com>
 <0ae9071b-6d76-4336-8aee-d0338eecc6f5@tu-dortmund.de>
 <CACGkMEsC0-d4oS54BHNdFVKS+74P7SdnNHPHe_d0pmo-_86ipg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsC0-d4oS54BHNdFVKS+74P7SdnNHPHe_d0pmo-_86ipg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H8nPbFtwYEMIL9NCGlFik1ulqWEyYjcDgTYL3Uzfugc_1768192941
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 12, 2026 at 10:54:15AM +0800, Jason Wang wrote:
> On Fri, Jan 9, 2026 at 5:57 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > On 1/9/26 07:04, Jason Wang wrote:
> > > On Thu, Jan 8, 2026 at 3:48 PM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > >>
> > >> On 1/8/26 05:38, Jason Wang wrote:
> > >>> On Thu, Jan 8, 2026 at 5:06 AM Simon Schippers
> > >>> <simon.schippers@tu-dortmund.de> wrote:
> > >>>>
> > >>>> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> > >>>> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> > >>>> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_NONE)
> > >>>> and dispatches to the corresponding tun/tap helpers for ring
> > >>>> produce, consume, and unconsume operations.
> > >>>>
> > >>>> Routing ring operations through the tun/tap helpers enables netdev
> > >>>> queue wakeups, which are required for upcoming netdev queue flow
> > >>>> control support shared by tun/tap and vhost-net.
> > >>>>
> > >>>> No functional change is intended beyond switching to the wrapper
> > >>>> helpers.
> > >>>>
> > >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Co-developed by: Jon Kohler <jon@nutanix.com>
> > >>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > >>>> ---
> > >>>>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++----------------
> > >>>>  1 file changed, 60 insertions(+), 32 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > >>>> index 7f886d3dba7d..215556f7cd40 100644
> > >>>> --- a/drivers/vhost/net.c
> > >>>> +++ b/drivers/vhost/net.c
> > >>>> @@ -90,6 +90,12 @@ enum {
> > >>>>         VHOST_NET_VQ_MAX = 2,
> > >>>>  };
> > >>>>
> > >>>> +enum if_type {
> > >>>> +       IF_NONE = 0,
> > >>>> +       IF_TUN = 1,
> > >>>> +       IF_TAP = 2,
> > >>>> +};
> > >>>
> > >>> This looks not elegant, can we simply export objects we want to use to
> > >>> vhost like get_tap_socket()?
> > >>
> > >> No, we cannot do that. We would need access to both the ptr_ring and the
> > >> net_device. However, the net_device is protected by an RCU lock.
> > >>
> > >> That is why {tun,tap}_ring_consume_batched() are used:
> > >> they take the appropriate locks and handle waking the queue.
> > >
> > > How about introducing a callback in the ptr_ring itself, so vhost_net
> > > only need to know about the ptr_ring?
> >
> > That would be great, but I'm not sure whether this should be the
> > responsibility of the ptr_ring.
> >
> > If the ptr_ring were to keep track of the netdev queue, it could handle
> > all the management itself - stopping the queue when full and waking it
> > again once space becomes available.
> >
> > What would be your idea for implementing this?
> 
> During ptr_ring_init() register a callback, the callback will be
> trigger during ptr_ring_consume() or ptr_ring_consume_batched() when
> ptr_ring find there's a space for ptr_ring_produce().
> 
> Thanks

Not sure the perceived elegance is worth the indirect call overhead.
ptr_ring is trying hard to be low overhead.
What this does is not really complex to justify that.
We just need decent documentation.

> >
> > >
> > > Thanks
> > >
> > >>
> > >>>
> > >>> Thanks
> > >>>
> > >>
> > >
> >

