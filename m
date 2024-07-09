Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63F15D5CA
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528931; cv=none; b=Deee0X9PzhR/dU4ptyY57X+Ty2r3MqvSRR/NqgFQlkAL7k/8g2XO5IifHm+ufvCXHdVe1GSvYhcmF/MonPk7gK/ZgI5lK2ZSshCr09lcih48TabXBrQxwF8bVMiZmVgd2aFcN3zoH3VuSyZGyuDT1CcGpxzU5SbTQWDp/1/IvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528931; c=relaxed/simple;
	bh=WMRXeklNAFCXPxZX0QKDYEufIJKcpHVBpPvLr8GdPXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NudGYxF6g12QXdK2onE77qgUSyHYQYluQe8emeQqKAo1uYU6g6udMXLLp14pmOmkWjhbscNVK9iwznp94ulKUkTZe/lFgqsL+JTPAfqrHecrSIaLgO5L2UCjU3mU1twoyx5dem8VtQ51/MtDivydo709d3NjkZ61+rkGounn3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV3VCRS1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV3VCRS1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61FB081CFE
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 12:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63Mn5Vd13Bdt for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 12:42:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CC35881CE1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC35881CE1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UV3VCRS1
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC35881CE1
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720528925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtU0JGN0EJmcocAYFfRCYWD9D/xkCDMAfPhd/SDuPwo=;
	b=UV3VCRS1ohyfUSMmo4QL/yin382P0EvXjKqCHD6lJyzdy0atcmv0VIPkcdesm5Tt9s8vAl
	uugWnbe9OcjywdmgldlRPhT8xv9s8aY9CjHp4p6/I/6XvxNcwJbYLLtt0miePgHlQJimvT
	ja7s5L/gFTXTzZksJ4V/eshFJk7Lefs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-_9kO2563MHG_FEvpirG3DA-1; Tue, 09 Jul 2024 08:42:02 -0400
X-MC-Unique: _9kO2563MHG_FEvpirG3DA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eebcab13f9so114511fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 05:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528921; x=1721133721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtU0JGN0EJmcocAYFfRCYWD9D/xkCDMAfPhd/SDuPwo=;
        b=CEV+zilvt3OxJM5lXuzmDiuPmHn1MVRLMcuRBZedslOPvC8VnTt+pCj4QTzMhpZRsG
         Y553aOqiV8CPgsxmPkFvcqbxwq7U7vVhWJTHovV++j+beMvb5BTZMpWVaMtCFy82aOSP
         OmvZPvmyZyir3oIJUv8+9RyXIf0ZusjK1YjWSq38mxB/5EAtLKhBkuBqpKWmnXstMUL4
         ICxmVFBdwL/8EU0l4fnsBh2uA2wJhkE1vXp8SA39jUbfIuHqoqzn/ucwodPZODWjaB4i
         YLwaFxeFSwYk/KAo9LVuBZxJ8+PKCUMwrSajuHni5NtoAnwVx4nyumD6Trv2RXnQ+T+a
         2aug==
X-Forwarded-Encrypted: i=1; AJvYcCXQZ6QRVbsH8Rj/YFiAPgxp284oELsoctjWhrXF2EA6CP/0ZoTqaHq4rfOmCOIkZLajCOOmr/O8PP9hF7Dh13jMjjqlLBJU7Gq7Yl/eA4bbLoSHw3pJR6FzdA==
X-Gm-Message-State: AOJu0YxkgOMxZ7JyCH3sCDpZG8ZcfQdBEc+H/utP+BoTDWQNnjILaSse
	dRqCqE6XX7nEjh7m+AdGvsy31xmrk4TVXEyyWo9o3pivF1rVp0Hsfrd3m9vVK3Ad+TKSGjIQNcT
	jPNIlIBehPrfiSyl1YA7DqlNF4lpUnqeVk6GCu8WtAHDDH49TUJe6jbcwGDZ+9HXJiRHpbO4ktS
	BLwRU=
X-Received: by 2002:a2e:8952:0:b0:2ec:5547:c59e with SMTP id 38308e7fff4ca-2eeb3198ac3mr15823961fa.50.1720528921181;
        Tue, 09 Jul 2024 05:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQ/3+1cvJIxlRdKB/u4MEHHTb/Kxc0reqE+YePLpyvQDvI/rkVgTUeLmn/vgIWjxO/a5kxQ==
X-Received: by 2002:a2e:8952:0:b0:2ec:5547:c59e with SMTP id 38308e7fff4ca-2eeb3198ac3mr15823541fa.50.1720528918592;
        Tue, 09 Jul 2024 05:41:58 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06b6sm2454398f8f.86.2024.07.09.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:41:58 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:41:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240709084109-mutt-send-email-mst@kernel.org>
References: <20240708064820.88955-1-lulu@redhat.com>
 <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> >
> > Hi Cindy,
> >
> > > From: Cindy Lu <lulu@redhat.com>
> > > Sent: Monday, July 8, 2024 12:17 PM
> > >
> > > Add support for setting the MAC address using the VDPA tool.
> > > This feature will allow setting the MAC address using the VDPA tool.
> > > For example, in vdpa_sim_net, the implementation sets the MAC address to
> > > the config space. However, for other drivers, they can implement their own
> > > function, not limited to the config space.
> > >
> > > Changelog v2
> > >  - Changed the function name to prevent misunderstanding
> > >  - Added check for blk device
> > >  - Addressed the comments
> > > Changelog v3
> > >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> > >  - Add a lock for the network device's dev_set_attr operation
> > >  - Address the comments
> > >
> > > Cindy Lu (2):
> > >   vdpa: support set mac address from vdpa tool
> > >   vdpa_sim_net: Add the support of set mac address
> > >
> > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++++++
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > >  include/linux/vdpa.h                 |  9 ++++
> > >  include/uapi/linux/vdpa.h            |  1 +
> > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.45.0
> >
> > Mlx5 device already allows setting the mac and mtu during the vdpa device creation time.
> > Once the vdpa device is created, it binds to vdpa bus and other driver vhost_vdpa etc bind to it.
> > So there was no good reason in the past to support explicit config after device add complicate the flow for synchronizing this.
> >
> > The user who wants a device with new attributes, as well destroy and recreate the vdpa device with new desired attributes.
> >
> > vdpa_sim_net can also be extended for similar way when adding the vdpa device.
> >
> > Have you considered using the existing tool and kernel in place since 2021?
> > Such as commit d8ca2fa5be1.
> >
> > An example of it is,
> > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
> >
> Hi Parav
> Really thanks for your comments. The reason for adding this function
> is to support Kubevirt.
> the problem we meet is that kubevirt chooses one random vdpa device
> from the pool and we don't know which one it going to pick. That means
> we can't get to know the Mac address before it is created. So we plan
> to have this function to change the mac address after it is created
> Thanks
> cindy

Well you will need to change kubevirt to teach it to set
mac address, right?

-- 
MST

