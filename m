Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB80197A97
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629375; cv=none; b=FlJ5W9oi0br+n3V5s7pnpYClQB/sejtTw9J70rVJ0+mmcKO4xVq2jqNNz84jEkqA0NlJWq5i/8x7kjc9R3Id37b0t5L5k0XmTg/cChx1t4Zx4vKAK6zzYK8lPGQUcx483eekeMXgx+DSCREymGa2KZv9YYOgob3oCPaGCznrfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629375; c=relaxed/simple;
	bh=TRpITMfhSedBWCyK8bo5vy9+rNDpUJBCcfGkU+oVsl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NntGln1AatfVG0nKpJ7Bc0VZ09Tz8ui0cn4fKiDitV1g4QzuXER8O4L05OrcytDL8s3OPTmN7ab/+kYOYlPKrqeX9PzAWdMl6Dsl9wuswrgiYn6Uz0GYPHIqLDcWnMIsAAiwa1p8IsIvxOwZlBABlCXHa8VgxLl9Ysm35reMu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Xq1/0ENv; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Xq1/0ENv"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC29A40530
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 13:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHCLx6ZCWotD for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 13:02:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 12198403AC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12198403AC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Xq1/0ENv
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12198403AC
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 13:02:50 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-57c76497cefso5103105a12.1
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718629368; x=1719234168; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPWu6UjDZMnQVTRsZX0tk4x7xzpqv9lDVHERGvbzAHw=;
        b=Xq1/0ENvu4tP5sOfRuwW0NmKQT1fKAQmM+1cZYJ3UBEaC3cXu0qE5DWSjPsCyUq+rY
         QZMSTdyaknYRjFmAu0YkPWs22ABWskt+Vo/ux0hfwH23VLk2tIqcSs6oLtTP2REZiR4Q
         3dtCN6ZZj7zDd/O3xfCIOGbbUFXatjDLnKQX647oWpCbf+4tIg35AmmJGCybDBAGK4DX
         8c7NW/AUfqP19Y4AXBvptVlSZLgyc+WHZ9YEXp+MlojhqKJaWzqmwU5GeTcoLbbM4Hys
         BUd4GKWoufLHnOlo3zK1DqLRlRm4eYtndIYqeSnmSlj3C+xbS42jturr9o4DyR960ty/
         ry/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629368; x=1719234168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPWu6UjDZMnQVTRsZX0tk4x7xzpqv9lDVHERGvbzAHw=;
        b=S+kzSvknwkv6pZNnROZPdlO3GDOo9KzMEXLhZbDv7Om2ngCBS4lXdMdtPDa1wCA6nC
         PrsyKFHXiFE13OZkBCwr9Bsphkk6z3Q3XAGIYSB8OMZ6k1oWKI5NmWFm+IEQ/Zjcz+M9
         tuEMb9CiSzyBSL5oV+gmtTVoU7JlMShEg1JXwz2F7JUkFIRSkJnwMZrtaSuHRmQBg6d0
         0113gfna+3yzNfHxiJqAf9YmlSx2J8iHeIwQI3zasmc0MFhUI7GLwXVJL0DGGMAJgkIL
         Ukgv5TEed4f5PSdfQ/PaNT25D3ZNyhDxaogxptBnZclFqwi7/hO8n1q2yQk4UCs6nUBM
         Y9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQN9OGRffe83IEySEwr9PYRG6PTxBa5pLeKc0dOENbSFjcKlbOdYkpASZrVwO4Q1h+B3jL2HWzObDwMnWkNLPJaly1xtWVh431JEP6PFo6yUAg1DgQLpJTHA==
X-Gm-Message-State: AOJu0Yx54Gk/pdjNPnRyEAeB65cA9w0oJFvlbnjcz+etPLe+d9kuOgjp
	bk2vHOKLj/zvqnbFaVBz0FEb3GoJarriQUJfZ7ks3Sxp+tSGjUutAcujIEp8W+8=
X-Google-Smtp-Source: AGHT+IGcudZokFT78RyZ7cYSlZbHBwzJ8nGrQcqcTLF+Nm30y+RQMLNd7Az1DxCGUnWXSUhfn6Te8w==
X-Received: by 2002:a17:906:c0cc:b0:a6f:16c7:9130 with SMTP id a640c23a62f3a-a6f60d2976bmr640523766b.28.1718629367294;
        Mon, 17 Jun 2024 06:02:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cddba1b0esm2137421a12.84.2024.06.17.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:02:46 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:02:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Cindy Lu <lulu@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZnAz8xchRroVOyCY@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Jun 17, 2024 at 01:48:02PM CEST, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, June 17, 2024 5:10 PM
>> 
>> Mon, Jun 17, 2024 at 11:44:53AM CEST, parav@nvidia.com wrote:
>> >
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Sent: Monday, June 17, 2024 3:09 PM
>> >>
>> >> Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
>> >> >
>> >> >
>> >> >> From: Jason Wang <jasowang@redhat.com>
>> >> >> Sent: Monday, June 17, 2024 7:18 AM
>> >> >>
>> >> >> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >
>> >> >> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> >> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> >> > >> Add new UAPI to support the mac address from vdpa tool
>> >> >> > >> Function
>> >> >> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address
>> >> >> > >> from the vdpa tool and then set it to the device.
>> >> >> > >>
>> >> >> > >> The usage is: vdpa dev set name vdpa_name mac
>> >> >> > >> **:**:**:**:**:**
>> >> >> > >
>> >> >> > >Why don't you use devlink?
>> >> >> >
>> >> >> > Fair question. Why does vdpa-specific uapi even exist? To have
>> >> >> > driver-specific uapi Does not make any sense to me :/
>> >> >>
>> >> >> It came with devlink first actually, but switched to a dedicated uAPI.
>> >> >>
>> >> >> Parav(cced) may explain more here.
>> >> >>
>> >> >Devlink configures function level mac that applies to all protocol
>> >> >devices
>> >> (vdpa, rdma, netdev) etc.
>> >> >Additionally, vdpa device level mac can be different (an additional
>> >> >one) to
>> >> apply to only vdpa traffic.
>> >> >Hence dedicated uAPI was added.
>> >>
>> >> There is 1:1 relation between vdpa instance and devlink port, isn't it?
>> >> Then we have:
>> >>        devlink port function set DEV/PORT_INDEX hw_addr ADDR
>> >>
>> >Above command is privilege command done by the hypervisor on the port
>> function.
>> >Vpda level setting the mac is similar to a function owner driver setting the
>> mac on the self netdev (even though devlink side has configured some mac for
>> it).
>> >For example,
>> >$ ip link set dev wlan1 address 00:11:22:33:44:55
>> 
>> Hmm, under what sceratio exacly this is needed?
>The administrator on the host creating a vdpa device for the VM wants to configure the mac address for the VM.
>This administrator may not have the access to the devlink port function.
>Or he may just prefer a different MAC (theoretical case).

Right, but that is not reason for new uapi but rather reason to alter
existing devlink model to have the "host side". We discussed this many
times.


>
>> I mean, the VM that has VDPA device can actually do that too. 
>VM cannot do. Virtio spec do not allow modifying the mac address.

I see. Any good reason to not allow that?


>
>> That is the actual function owner.
>vdpa is not mapping a whole VF to the VM.
>It is getting some synthetic PCI device composed using several software (kernel) and user space layers.
>so VM is not the function owner.

Sure, but owner of the netdev side, to what the mac is related. That is
my point.
