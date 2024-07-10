Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BF55C0A
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591853; cv=none; b=B0H4UiTcJyH/+Fbg0FZtIU6U3bp4W45q+OUGrsmS5HhVbXJR9PhnLf9rUWpaEdlIhn8RqEbRpA8LV4NhuWOqS41vlACA51VnQwqSypgwgmHOTl0XRPCQbJCmb166C8c7ZEPog4u1cEcL3mXUup/SP048XjmhMO3desqm8SWXyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591853; c=relaxed/simple;
	bh=1OteSeEEKH0xI0Oh+CNKtD7aOdOLUK4Wax0gEtG/3rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XVrGv9bkYDx7raq7BBd/8N9uUHxJKXwGw34VRcqo3dhLQ9MHeyyn4HcR3hdtm7sDMozCDC9o9PlkkQYvVWy3a7cpxrz7mGRDkbZiw8+eq2nCaAGLU8iqW/wZxIIKnDxWaUQ5nPxu2Az71NTC7Uw3FA5I/wapTDrBcBk1gmhWkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6UoVETN; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6UoVETN"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9904260F9B
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 06:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwVTqgLhfPAT for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 06:10:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BC60560F9A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC60560F9A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6UoVETN
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC60560F9A
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720591849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4MsH1lA4eWc8gvy+b6nRd+irAYUf4vc/vQAj43j3S8=;
	b=a6UoVETNm4UdP9f1bofzRfEIMzTtjdjwhxjeOL0uxvE7Tlg2Ful7nu161PFOUEeMo9BThn
	lY976bpXO0nh8rgT9P4j7Fr0OcNSKC5ZctmuUqB6z5bAwDB1qO8V8j//tdavZ4MktUycSB
	SWfFJahqmOX2ALdw4oty9W/SFBnOZXc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-0p4_nx73Pme9hCR1fga91Q-1; Wed, 10 Jul 2024 02:10:47 -0400
X-MC-Unique: 0p4_nx73Pme9hCR1fga91Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ea249d1c9so5619857e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 23:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591846; x=1721196646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4MsH1lA4eWc8gvy+b6nRd+irAYUf4vc/vQAj43j3S8=;
        b=vqI+EmpotXicA2BHrIxHrboYCj7BEZBYZxQKynXMCS5esxWMQady9kW3BQ3PlmIMPl
         C6LdWIbpQBmWO41V5FNTVP3PcusAC4po/Fhs41KaGE2v7X27A+Ui33xl2vtRrJnhtK7J
         3WhxSVxJQI7vi/8l7FutwgA/JQD96YTXVRF+Rh+1UaeciQPyDeX09gTPAwQfoAKnZkLt
         tDBu64XfHzZBALknxlU0/548VfufF+OJdlj7UbpJzFKGaZXCUHrrvHThZVMPAvVuqPHw
         8O0etgQgPI23p5TuJZIJJY17SEpmsj6WnKR8cYmUAFrbHHjgY7p1x9RbVWFkzqAe1UVP
         vQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6r0A8s3FGXBt+yidEOqW2mZYq0gCeLUIMAdzp99r5qb3QwO6//gKRizD9ncUFjlPyUekq6NDL6vZ+iuNixemcZN21Y5WWTaDnr4KhE5lp++ou23qH313Qg==
X-Gm-Message-State: AOJu0Yyz6A0+PborzQ2AVpUxCXCp0AalgHVqIgE81lG0D/NOMYumLdwm
	9qT94grTdBEUQy5gZ0764xh6+73BabaHvH3zmNCdXbPviXaUS0/2DU5/u3yu+qYjwY0X5wXNW+q
	9bpiMnEBSSw9Xx04yAA2AcDmawtnat+wbuthOe+YPQol5HCSPKMlOpdbTvrT7YqhflVWqPP5mM7
	uUkUI=
X-Received: by 2002:ac2:42d8:0:b0:52b:b327:9c1c with SMTP id 2adb3069b0e04-52eb99d59e8mr2530505e87.62.1720591845786;
        Tue, 09 Jul 2024 23:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPbauTJ9QFnUJHiEZRXf8cKpY/Ph2hFs+oVaX3YRKAndRpINbHSQxy+Oi4OwHlpwQjmGnGuw==
X-Received: by 2002:ac2:42d8:0:b0:52b:b327:9c1c with SMTP id 2adb3069b0e04-52eb99d59e8mr2530479e87.62.1720591845031;
        Tue, 09 Jul 2024 23:10:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266b03feecsm101417875e9.10.2024.07.09.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:10:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:10:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Leonardo Milleri <lmilleri@redhat.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240710020852-mutt-send-email-mst@kernel.org>
References: <20240708064820.88955-1-lulu@redhat.com>
 <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
 <20240709084109-mutt-send-email-mst@kernel.org>
 <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 11:05:48AM +0800, Jason Wang wrote:
> On Tue, Jul 9, 2024 at 8:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> > > On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> > > >
> > > > Hi Cindy,
> > > >
> > > > > From: Cindy Lu <lulu@redhat.com>
> > > > > Sent: Monday, July 8, 2024 12:17 PM
> > > > >
> > > > > Add support for setting the MAC address using the VDPA tool.
> > > > > This feature will allow setting the MAC address using the VDPA tool.
> > > > > For example, in vdpa_sim_net, the implementation sets the MAC address to
> > > > > the config space. However, for other drivers, they can implement their own
> > > > > function, not limited to the config space.
> > > > >
> > > > > Changelog v2
> > > > >  - Changed the function name to prevent misunderstanding
> > > > >  - Added check for blk device
> > > > >  - Addressed the comments
> > > > > Changelog v3
> > > > >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> > > > >  - Add a lock for the network device's dev_set_attr operation
> > > > >  - Address the comments
> > > > >
> > > > > Cindy Lu (2):
> > > > >   vdpa: support set mac address from vdpa tool
> > > > >   vdpa_sim_net: Add the support of set mac address
> > > > >
> > > > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++++++
> > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > > > >  include/linux/vdpa.h                 |  9 ++++
> > > > >  include/uapi/linux/vdpa.h            |  1 +
> > > > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > > > >
> > > > > --
> > > > > 2.45.0
> > > >
> > > > Mlx5 device already allows setting the mac and mtu during the vdpa device creation time.
> > > > Once the vdpa device is created, it binds to vdpa bus and other driver vhost_vdpa etc bind to it.
> > > > So there was no good reason in the past to support explicit config after device add complicate the flow for synchronizing this.
> > > >
> > > > The user who wants a device with new attributes, as well destroy and recreate the vdpa device with new desired attributes.
> > > >
> > > > vdpa_sim_net can also be extended for similar way when adding the vdpa device.
> > > >
> > > > Have you considered using the existing tool and kernel in place since 2021?
> > > > Such as commit d8ca2fa5be1.
> > > >
> > > > An example of it is,
> > > > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
> > > >
> > > Hi Parav
> > > Really thanks for your comments. The reason for adding this function
> > > is to support Kubevirt.
> > > the problem we meet is that kubevirt chooses one random vdpa device
> > > from the pool and we don't know which one it going to pick. That means
> > > we can't get to know the Mac address before it is created. So we plan
> > > to have this function to change the mac address after it is created
> > > Thanks
> > > cindy
> >
> > Well you will need to change kubevirt to teach it to set
> > mac address, right?
> 
> That's the plan. Adding Leonardo.
> 
> Thanks

So given you are going to change kubevirt, can we
change it to create devices as needed with the
existing API?

> >
> > --
> > MST
> >

