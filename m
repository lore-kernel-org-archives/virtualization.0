Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48111B4C2F
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632054; cv=none; b=LZ7yitxpO1I3xiI1Iag2LWrTW4s7g2oWO/z99YRMBaTaBkMqCV6uXDuUdjozDwekmCz99l1TcRvZ8vzdQRhYzVBAk35rpf32Dk88rldQo8eLtnGqhCaYBkkHgdcqFnE80X7y18b7atpTwDnyA3bH8KvA7W5AqYwtcPqOoHAJm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632054; c=relaxed/simple;
	bh=9vMowxz1Q+3I2YwsUDY+sWrqcLKaTWtnkDjXYlErIX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Jk4YvkmPrRETyxRKX84t3dj2IfZyOxEK6hJpB15kAqxMr5ZAm9VbFk/DNKv/XEw23CzTx+6XrzjoXIypeNOKNiTnfUl3KJ6JBaDDBGp2/K1AntAhGFf9lL6uhc9BtvmguuMZ33VobXitqp98HYc+bMSWBL+IVKEDse0qFhT+Pv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD1mpDFs; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD1mpDFs"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 954E240333
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 13:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fx3G2Ad4RKWE for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 13:47:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 556B240061
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 556B240061
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PD1mpDFs
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 556B240061
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718632049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxMIasYgmKOwN2Uh/eYVqv+BqAex9HFyWItgJcmfmCI=;
	b=PD1mpDFs9VtR6ZKiaw1JT4aMy/YpP1NRpy6eqeQ6cHCgSIr7Z4cNs4I6qxV5SFiGGo3YrV
	QAcjqKHGB7wN/EIM/FjC4+Niz08ZLaeHlsIQCHIem+/jEk+Re8ncART9gnYPsX9gBAxhDS
	KJinm192A11s6qvEAoEhg2Aggw4MW8s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-7E6nYDwMMSutNg8DZbYNQw-1; Mon, 17 Jun 2024 09:47:26 -0400
X-MC-Unique: 7E6nYDwMMSutNg8DZbYNQw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42120e123beso38489595e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632045; x=1719236845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxMIasYgmKOwN2Uh/eYVqv+BqAex9HFyWItgJcmfmCI=;
        b=C6aMLY73mT9WZeaZSYWWv3T06Xh0NheOgezB7q5BODM3rWndRz8a+NaXjzLnlkHQpP
         V69iNSkDS6L84MZH70k0iqSqHEf8GfEaIcIMu2Tg806o3M8eGRlOc6whFM+5I2Xb4+0K
         gAuO6vMNf2GmMF9Ly9QWSidOjO7+muIN4/y8Fo6Xjx8InqXxXpLC3Pbc9RIFPn9Z8TkE
         J6eiHM+YRwMVKwe1FWPduGY+B4sawGHgdtmjSnCYIMw2CVT4tZR+xN5EC2+DqyQQO1dm
         y2IlWdwGwuJwMhELbXs/K0b133GC6n7h/pv6BxrSL2KtkuLQyhNUJ0TrYgBibnZatt9r
         Y4TA==
X-Forwarded-Encrypted: i=1; AJvYcCXfYfspsVlHkEDb4d0xD8QOv/pYKupIHeY8384pdSHLn7UtAdaK0IwzJa64+6lcVXHiKmq1og25sOYu4xxE8cdUaM/S/IdqnOB9BII9RIl+GGbOj6d7+zPr9g==
X-Gm-Message-State: AOJu0YzQrvMSuS850MKK0/msilG5a+JrsGZ/m4AhNt6JWvSsAtWoXkx3
	01JgbZMgULYvNiZy2pH8QiIn61aOj/XlYX0aInnzrGK+H+AMwlOXARIoq/Toz2h4EPX5bvdCVim
	t2dA8RMCH6wFZ9Epb5bHdvP0E1biMJlsQQco8Fzx/7IQGksa/7jT4YN5Dr7WThwTEp7GYklRX7S
	fUT1I=
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id 5b1f17b1804b1-42304844acamr91904735e9.25.1718632045325;
        Mon, 17 Jun 2024 06:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDkRJ1ZBxBFsxD0RRnuf9bQWNjc837sVUfnG+M/dHrjMGzbYj/nvXPGpSefPzRBftuhU0mNA==
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id 5b1f17b1804b1-42304844acamr91904525e9.25.1718632044859;
        Mon, 17 Jun 2024 06:47:24 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750acd7csm11936995f8f.52.2024.06.17.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:47:24 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240617094314-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnAz8xchRroVOyCY@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 17, 2024 at 03:02:43PM +0200, Jiri Pirko wrote:
> Mon, Jun 17, 2024 at 01:48:02PM CEST, parav@nvidia.com wrote:
> >
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Monday, June 17, 2024 5:10 PM
> >> 
> >> Mon, Jun 17, 2024 at 11:44:53AM CEST, parav@nvidia.com wrote:
> >> >
> >> >> From: Jiri Pirko <jiri@resnulli.us>
> >> >> Sent: Monday, June 17, 2024 3:09 PM
> >> >>
> >> >> Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
> >> >> >
> >> >> >
> >> >> >> From: Jason Wang <jasowang@redhat.com>
> >> >> >> Sent: Monday, June 17, 2024 7:18 AM
> >> >> >>
> >> >> >> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >> >> >> >
> >> >> >> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >> >> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> >> > >> Add new UAPI to support the mac address from vdpa tool
> >> >> >> > >> Function
> >> >> >> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address
> >> >> >> > >> from the vdpa tool and then set it to the device.
> >> >> >> > >>
> >> >> >> > >> The usage is: vdpa dev set name vdpa_name mac
> >> >> >> > >> **:**:**:**:**:**
> >> >> >> > >
> >> >> >> > >Why don't you use devlink?
> >> >> >> >
> >> >> >> > Fair question. Why does vdpa-specific uapi even exist? To have
> >> >> >> > driver-specific uapi Does not make any sense to me :/
> >> >> >>
> >> >> >> It came with devlink first actually, but switched to a dedicated uAPI.
> >> >> >>
> >> >> >> Parav(cced) may explain more here.
> >> >> >>
> >> >> >Devlink configures function level mac that applies to all protocol
> >> >> >devices
> >> >> (vdpa, rdma, netdev) etc.
> >> >> >Additionally, vdpa device level mac can be different (an additional
> >> >> >one) to
> >> >> apply to only vdpa traffic.
> >> >> >Hence dedicated uAPI was added.
> >> >>
> >> >> There is 1:1 relation between vdpa instance and devlink port, isn't it?
> >> >> Then we have:
> >> >>        devlink port function set DEV/PORT_INDEX hw_addr ADDR
> >> >>
> >> >Above command is privilege command done by the hypervisor on the port
> >> function.
> >> >Vpda level setting the mac is similar to a function owner driver setting the
> >> mac on the self netdev (even though devlink side has configured some mac for
> >> it).
> >> >For example,
> >> >$ ip link set dev wlan1 address 00:11:22:33:44:55
> >> 
> >> Hmm, under what sceratio exacly this is needed?
> >The administrator on the host creating a vdpa device for the VM wants to configure the mac address for the VM.
> >This administrator may not have the access to the devlink port function.
> >Or he may just prefer a different MAC (theoretical case).
> 
> Right, but that is not reason for new uapi but rather reason to alter
> existing devlink model to have the "host side". We discussed this many
> times.
> 
> 
> >
> >> I mean, the VM that has VDPA device can actually do that too. 
> >VM cannot do. Virtio spec do not allow modifying the mac address.
> 
> I see. Any good reason to not allow that?
> 
> 
> >
> >> That is the actual function owner.
> >vdpa is not mapping a whole VF to the VM.
> >It is getting some synthetic PCI device composed using several software (kernel) and user space layers.
> >so VM is not the function owner.
> 
> Sure, but owner of the netdev side, to what the mac is related. That is
> my point.


I don't know what this discussion is about, at this point.
For better or worse, vdpa gained interfaces for provisioning
new devices. Yes the solution space was wide but it's been there
for years so kind of too late to try and make people
move to another interface for that.

Having said that, vdpa interfaces are all built around
virtio spec. Let's try to stick to that.


-- 
MST

