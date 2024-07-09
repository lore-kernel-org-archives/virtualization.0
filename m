Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149877D07F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506003; cv=none; b=syAhFi2kgAIougaD2h3UOf64x7GKU928LI0b5dcW07KRhxN7Ufi7j/5SOyHVrlLks2oPpD7nvqc2EWu2gQuuZlCXgKcne08KA5jp+YqmN3izgazxHQw3+3okn+tIqAteEbfeTmLXRgjdBdkrLsL6FctdtLFvZFXAl0Q5jrerKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506003; c=relaxed/simple;
	bh=IgIMapnYz4R7QhXStj3YA8Z3MkB+898jyfEDj8yV1IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGI7CoK4+54/um5wAwDqw7X5ShM9QJpiDLuls1YaBDp1zRoRt/uBFt+jDQToV75EmiThF6ALIrhmb1he9rPZzwkWX0Jz+JbHLwnkequzG1PPXg5u9M48I3GXYkX84Id2Flkw7wIRc5opaM3ZPdfgXWP/BHRJZtN3yh6oKsOBwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqLnVXD4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqLnVXD4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A818E4098A
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 06:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQIz-Wq9ixqe for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 06:20:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 915674073B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 915674073B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aqLnVXD4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 915674073B
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720505999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PAJ3NQZoDsxViJ6hO5lgvZht1GTrzFNq+ksySjJ6SY=;
	b=aqLnVXD4xHO/2RywEWtUF13x2bjPkBmcFqiJ+uFiiVKSFx74OmXdfOWcFp081h5TLTo0ny
	HU4TdwLdY6rq229+hvLaI5DOcHRYljKvm/h7D/3JGUrfMaR9KE4IWwUYlzhNzak5E/2MLD
	cnR08f+Hjtk/uat9a8dsLAkm5Zwi58k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-71WmD3GaO7iMXf_gaohaLQ-1; Tue, 09 Jul 2024 02:19:57 -0400
X-MC-Unique: 71WmD3GaO7iMXf_gaohaLQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58b92b79a46so7452844a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 23:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720505996; x=1721110796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PAJ3NQZoDsxViJ6hO5lgvZht1GTrzFNq+ksySjJ6SY=;
        b=mrWZo6DJg27LYhjyKmOzbKWITMF977FmZp3Fa4zemccqLRT4QCmUk3XZtpMGB2nTPT
         St02hqpx2a/fSMC3bk4TtWAb/8aaYp7ULPVTx5JYaK6+VawndTNQSUEVsjF2LuE7dmxy
         njAhPXoqluut0tMdclz/turz+qv+CEH9pgsnhMjseL6AyMYx334yJBFEzZLiRYjF1zHu
         muYPn/flH16A7g/Sb5wDDSpbxyjCvp43+TbQ0aBGXBj3v8OZledOKkMDjpV3ImXDRAFf
         ZzH8ktLhKQnjf1WD8AisaFEpx3JVbYPSnPkQLUU9+qNE3dQePSz4Sb2WhVKU9c2EXVJG
         CmOA==
X-Forwarded-Encrypted: i=1; AJvYcCXzvLvUN7i3aShvrpvd65/QZcW42cfM5tQvTUb5iCOvsrDdDTSBXSN8bptXKXX4nCNck9xwmyW45//rMoTWYZ3KSyg7IbKtEi1jdk7QObElXuAg1vhc289rLA==
X-Gm-Message-State: AOJu0YxqGUltQPkSETtdBw8RP5BCxSfQzr9JiziMih8NiMzRkhKYpIOD
	vmWEh0W/Yo8Opgal+fmvzAACVhsmZL8vLJ8OlcyKj/a79F7hxcb32EBHWrvOsRLfm4lhZ7AsBOD
	S2epWj8pe3LyeXyJyDTIf0Rzy/tOjLbjeC67yKAvuHvUgFbzYBpx3pwjksybj+mD5sF+pr8OBGd
	f8DLvSesBmDTRxC8GcYRHvxmUscKcE4uauiC00BmqUwW2j4k8bI5p1cw==
X-Received: by 2002:a05:6402:4309:b0:58c:77b4:404b with SMTP id 4fb4d7f45d1cf-594dd34aa4dmr1068302a12.15.1720505996528;
        Mon, 08 Jul 2024 23:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ9cScRO5pziPV+dYduWA5rh756OgcUnuUTG7kK7SZbXCFXGzo6HuFDwa6LNFne0lhqbLXSFEqskdyCJsHCbg=
X-Received: by 2002:a05:6402:4309:b0:58c:77b4:404b with SMTP id
 4fb4d7f45d1cf-594dd34aa4dmr1068284a12.15.1720505996168; Mon, 08 Jul 2024
 23:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 14:19:19 +0800
Message-ID: <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: Parav Pandit <parav@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
>
> Hi Cindy,
>
> > From: Cindy Lu <lulu@redhat.com>
> > Sent: Monday, July 8, 2024 12:17 PM
> >
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address to
> > the config space. However, for other drivers, they can implement their own
> > function, not limited to the config space.
> >
> > Changelog v2
> >  - Changed the function name to prevent misunderstanding
> >  - Added check for blk device
> >  - Addressed the comments
> > Changelog v3
> >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> >  - Add a lock for the network device's dev_set_attr operation
> >  - Address the comments
> >
> > Cindy Lu (2):
> >   vdpa: support set mac address from vdpa tool
> >   vdpa_sim_net: Add the support of set mac address
> >
> >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> >  include/linux/vdpa.h                 |  9 ++++
> >  include/uapi/linux/vdpa.h            |  1 +
> >  4 files changed, 109 insertions(+), 1 deletion(-)
> >
> > --
> > 2.45.0
>
> Mlx5 device already allows setting the mac and mtu during the vdpa device creation time.
> Once the vdpa device is created, it binds to vdpa bus and other driver vhost_vdpa etc bind to it.
> So there was no good reason in the past to support explicit config after device add complicate the flow for synchronizing this.
>
> The user who wants a device with new attributes, as well destroy and recreate the vdpa device with new desired attributes.
>
> vdpa_sim_net can also be extended for similar way when adding the vdpa device.
>
> Have you considered using the existing tool and kernel in place since 2021?
> Such as commit d8ca2fa5be1.
>
> An example of it is,
> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
>
Hi Parav
Really thanks for your comments. The reason for adding this function
is to support Kubevirt.
the problem we meet is that kubevirt chooses one random vdpa device
from the pool and we don't know which one it going to pick. That means
we can't get to know the Mac address before it is created. So we plan
to have this function to change the mac address after it is created
Thanks
cindy

