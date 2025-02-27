Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205DB27781F
	for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696894; cv=none; b=sZA0MU27mks1vR7rhAX2ai0PDUnLr0+ar/+5xNlz2u2rJSoX8pPndx9IE/5z4pdyanQK9B3SQdazysGBevielfp2695eOv852RRm4CFlxxyTtuhX2uAJXPITz1bedppx6NfpziWXXLOCH1tPSwOAGqpuSmmR6AFJ/kuL2GEQE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696894; c=relaxed/simple;
	bh=isM+P0D8Ztc3w8ml7L7wN08/KrinT+zgzJxFJaJXlW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpwt8LhzllvyKyVJaNcaKjdDDmDQEHTkX5sPyN+aVaMkxEAPZ5NBRU2I5eUyLalfsC9ZiKy4JEmQMvO7ewq+DV1lxCnQG5txc4SAw9zMtnSu01FM0/2KRTZMZEsoNLh8H3HRkLDYjnPHt3r8PgfyDDgAAwwHIO10t+DW35INy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEH2a46k; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEH2a46k"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2C7A81FD0
	for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 22:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m02l9ORClkMO for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Feb 2025 22:54:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DEC1381F54
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEC1381F54
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dEH2a46k
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DEC1381F54
	for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 22:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740696890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiESKZ4FebR2Yq0NgbIsVEH+VbxoyO9otVYB7Wuhmsc=;
	b=dEH2a46kJ1ZvMkrfThHaEjJB/T/cKbmcNqj13IsXGpcw2MjxR3O4DUgpFQecn3XS3Q+IyM
	PdCywDw6r1vIGhLrAvIRMY1Aj8v4E9FnABTZeIjK6wVgX8pL9j0UmE0JMaJro01CKeczXB
	uzL3dbYyccZrTvSQZ9eH1RbupY7jVkI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-uLTiD9rjMKOR7DLHVu0-1A-1; Thu, 27 Feb 2025 17:54:49 -0500
X-MC-Unique: uLTiD9rjMKOR7DLHVu0-1A-1
X-Mimecast-MFC-AGG-ID: uLTiD9rjMKOR7DLHVu0-1A_1740696888
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-855fc58b9b9so21699139f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 14:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740696888; x=1741301688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiESKZ4FebR2Yq0NgbIsVEH+VbxoyO9otVYB7Wuhmsc=;
        b=UffnRcuOsKzHaAuxA5gwpL1RtS56agwyWq+kwUKzDlJoy+inq7TpsGI7Bi6CPO6LUM
         DVxVYnKvtqDWcXvbe4DjvR/ZrthKKvHEcJh0qVADfdRITuFPRv2eDpqutG8TApVxBR6j
         DNQ7V6n/R6on0LQukCZnb0AZ0bOElhUDi8mpApU8Eu2CV9tP4/urRRv4fMUJ188VdJw+
         9tXXO+cayXMlbTNgskkqoTjKDrP8XTK9NzYg/nCtjyL8YyZXxCpyJjP1mHAvsP6nxhB8
         RVtxl+chVPopRs/MC98gVSa/NwAbxFh3HXrjViMLLQH+POZp8n/MglbEBEm0pq8YRsJS
         3eSw==
X-Forwarded-Encrypted: i=1; AJvYcCXcgKg+/SEgeNkpwW+7vACvNHY/X+SFfMnMKU9u+zXfCz+tL+HEgBAD3UJm3piALysLzrX8+uLA1OFUGzrEJA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywy7lTB25NVhndCWVLsMMr0ykzpFBG1bkc5Xg78iOkDFpik6cgs
	xrvzrjygclN9b5oS/CMjEeaZrZajDkXMa/jt1yip+VIWxL9dFLtvuE8BMggwcx21uGb9P/HDcwO
	ea+3rQl0bGykRZwK7qhroht/dtrOUvmX+RUUwbfqBC5u4zx2UMaB/55RFhSMWUB967eNxAmuqVJ
	Rn7Ps=
X-Gm-Gg: ASbGnctG7Ga/udyedRd8CBN+/cD0X4ChUpQE+k6vFE41wIrpffAgoYg4Xh64Ki0chGC
	RFtI0aGlpQJGzVDp2kMZw0CCzNSHmkxFK0qFpiiTvkrWD/JNCi4XdVCGfhZ7dTd+bWKQqQW/uLB
	6oj8TmC3cVLTAQXXjNmYV3FuT558mW7VppLqkRGfQTUtJwaFItGEQ9x7ljZO/eiJtniAPyO0N8/
	VyWXz1KPO9YwANUs9hFHS6ftM76bkck3HwhZBBj5PE3Mh0IpFU+92hLno/dZw6twTKKW3gyIuZ9
	Z4pp9B2CFQVZKZ3xjjw=
X-Received: by 2002:a05:6e02:2181:b0:3d3:d187:7481 with SMTP id e9e14a558f8ab-3d3e6e223d7mr2254055ab.1.1740696888006;
        Thu, 27 Feb 2025 14:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMedaVsEJTf4lzwnFUptrvda9SdGFu/7wKMkjX+d6rglnbylRnyVhU4TwwaXtmWb5hV8iFGg==
X-Received: by 2002:a05:6e02:2181:b0:3d3:d187:7481 with SMTP id e9e14a558f8ab-3d3e6e223d7mr2253945ab.1.1740696887715;
        Thu, 27 Feb 2025 14:54:47 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3dee70dd3sm5227205ab.38.2025.02.27.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:54:46 -0800 (PST)
Date: Thu, 27 Feb 2025 15:54:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "parav@nvidia.com"
 <parav@nvidia.com>, "israelr@nvidia.com" <israelr@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "maorg@nvidia.com"
 <maorg@nvidia.com>
Subject: Re: [PATCH vfio] vfio/virtio: Enable support for virtio-block live
 migration
Message-ID: <20250227155444.57354e74.alex.williamson@redhat.com>
In-Reply-To: <8adbe43a-49f8-470c-be67-d343853b17f5@nvidia.com>
References: <20250224121830.229905-1-yishaih@nvidia.com>
	<BN9PR11MB527605EBEB4D6E35994EB8068CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
	<8adbe43a-49f8-470c-be67-d343853b17f5@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -I83jQRIVXcPYdDtOaSATOGsrWrHQgON2S6_6-3xboQ_1740696888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:51:17 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 26/02/2025 10:06, Tian, Kevin wrote:
> >> From: Yishai Hadas <yishaih@nvidia.com>
> >> Sent: Monday, February 24, 2025 8:19 PM
> >>
> >>   config VIRTIO_VFIO_PCI
> >> -	tristate "VFIO support for VIRTIO NET PCI VF devices"
> >> +	tristate "VFIO support for VIRTIO NET,BLOCK PCI VF devices"
> >>   	depends on VIRTIO_PCI
> >>   	select VFIO_PCI_CORE
> >>   	help
> >> -	  This provides migration support for VIRTIO NET PCI VF devices
> >> -	  using the VFIO framework. Migration support requires the
> >> +	  This provides migration support for VIRTIO NET,BLOCK PCI VF
> >> +	  devices using the VFIO framework. Migration support requires the
> >>   	  SR-IOV PF device to support specific VIRTIO extensions,
> >>   	  otherwise this driver provides no additional functionality
> >>   	  beyond vfio-pci.  
> > 
> > Probably just describe it as "VFIO support for VIRTIO PCI VF devices"?
> > Anyway one needs to check out the specific id table in the driver for
> > which devices are supported. and the config option is called as
> > VIRTIO_VFIO_PCI  
> 
> I'm OK with that as well, both can work.
> 
> Alex,
> Any preference here ?

What's actually the proposal?  It's fine with me if we want to make the
tristate summary more generic, but I'd keep the mention of the specific
devices in the help text.  I don't know many users that preemptively
look at the id table.

I might replace "NET,BLOCK" with "NET and BLOCK" for readability though.
Thanks,

Alex

