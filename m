Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01F166317
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708650; cv=none; b=IfX51axH0/FdLOaFTjzeeZh7ahKaYOAEkWxHaJjaPtxMEMIAKq39RSJU1FuMiJ5vIN7MRYjRG6IFR++MLJG/Ose/mzvzsLad9cRlPvYsAZy7tgRwdUW2abC+s0nGE1uKY25OYDWIw4x46ZUFKnLK+IXRClJ0vkczD6cAdHQD0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708650; c=relaxed/simple;
	bh=NznUt8AvHpTRafPvGuuEjxJUVQRyGSqR2Bk7bqX1CNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HQkhWDItIoeroFrTiqifQSRwZ/AudHQ97PPqbpXBLcY1DTubapVXbhPvGMpBpIlOS7w0K2279qb/6WxeTCWcqOz0cALHG/iIZBg91OIE8ubvEt4qiAKLCb4iRiDZ78zY9XmxNKu5XnJnCqZkkrQGCB1Pobd+RxIHgC4swklRJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7c3IlGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7c3IlGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720708647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJpoIhhWNKEmE1aglt5autfIQ/nnLzEhjRHtiAi4K/M=;
	b=h7c3IlGbl6bfZJ47bxzNNbdlnMpYrQIBkqCgQ2UX9lyiJ958rnNg2QDkltVLpJFsdodwAV
	QMSDbsYuwTD/JOTgSc+9Ete/JBF7+OOhpCauqYjldl+ad+XCawFkeCekGTceMKUi9mu3mX
	mPghLdXruP8KXYqGJbxBvy/1m9gyiTw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-3aHm3FRaM5edpABns4YMkw-1; Thu, 11 Jul 2024 10:37:24 -0400
X-MC-Unique: 3aHm3FRaM5edpABns4YMkw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52e981abb3fso1004895e87.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 07:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708643; x=1721313443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJpoIhhWNKEmE1aglt5autfIQ/nnLzEhjRHtiAi4K/M=;
        b=xSScMhQ5UFZDzOqcny8AIR3P4ADnwZhh9VXQF+ilv6wTTEn0LfNIwz1IdU+8yNuvt8
         jItRN9aOibIs9mwuhaxHYSkJr+jQzTas4p3sRzufhpTT8WwRY6/LcSQNmQSCPrIauTre
         i7TtaetU/eDIrQFIbwwrzlzfw9bZ2N/sAZRiNV6PloMIAhiWQ3PRiOvUa01qfuy5ABmX
         qccHuhMbzOiGJ2ocuEaMykTZ1EusKPGScd9Ot+Pv0gn/D2ImGYGN0ZgDAnb/sseFUrWN
         A0wjT+RLfZ+Kvns4TrrB+byQNf1gyZkbuXEWfTA1/lokFZh/SEjrgplmyU2HscwTAwrA
         q+eA==
X-Gm-Message-State: AOJu0Yyy1mk0yotTngfSmpU85XJmNh/KdWxtdO4a/YC9tPOUeQP8O1t7
	u5Gpkjqi9HjzLBh7zR0VCeuWL4NjfpEbFyaReYjsXCwuH5k+1uxTImnZB2kU0csLH1eeqbum4XG
	PzD0SJLtCkX0JxJvariisclQVQ0zJlfHJUEpu10ScRioqh4oRfb3smVKclJFLdncc
X-Received: by 2002:a19:3816:0:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-52eb99d4c83mr4834978e87.48.1720708643022;
        Thu, 11 Jul 2024 07:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPv7wZguOZHHpaFJVXZocNyxGYYC/bJwAsNtfSAKsphMKjR2cqqw9rJVqPuAvghyvNPsKvXQ==
X-Received: by 2002:a19:3816:0:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-52eb99d4c83mr4834834e87.48.1720708635299;
        Thu, 11 Jul 2024 07:37:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7420cesm119514965e9.46.2024.07.11.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:37:14 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:37:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH v6] virtio: vdpa: vDPA driver for Marvell OCTEON DPU
 devices
Message-ID: <20240711103627-mutt-send-email-mst@kernel.org>
References: <20240614144659.1776067-1-schalla@marvell.com>
 <DS0PR18MB5368CDFF8C115C8125C0287DA0A52@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB5368CDFF8C115C8125C0287DA0A52@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2024 at 01:01:37PM +0000, Srujana Challa wrote:
> > Subject: [PATCH v6] virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices
> > 
> > This commit introduces a new vDPA driver specifically designed for managing
> > the virtio control plane over the vDPA bus for OCTEON DPU devices. The driver
> > consists of two layers:
> > 
> > 1. Octep HW Layer (Octeon Endpoint): Responsible for handling hardware
> > operations and configurations related to the DPU device.
> > 
> > 2. Octep Main Layer: Compliant with the vDPA bus framework, this layer
> > implements device operations for the vDPA bus. It handles device probing, bus
> > attachment, vring operations, and other relevant tasks.
> 
> Michael, could you kindly inform us if any additional actions are required from our end?
> Thanks.


As far as I know, you should see this driver in linux-next already.
Please check, if anything is missing, pls let me know.


-- 
MST

