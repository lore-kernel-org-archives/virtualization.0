Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C814A616
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183316; cv=none; b=gHEGSi1onOR0URJ7OjB01suOowYk59+nUgbO460txfVjEhmHFx7Ie3rqcMZPNx3HNVOK79cb1zsCRWAvE85GqHIQ2inHDmBfI+y4lnqYnV3ACKQyfgwnQZNj6pUnMckD+OBoRTWjRShaP5bY36wealvFN05lTrueG/sNn9kqeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183316; c=relaxed/simple;
	bh=0VkwOEYNEGTePOxeBzMH5nAzeX1LMR2wiTaFcPC5G8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BCA0zTXQCBgAotshrDD9T757b9i+9aEns66J9B94rmN2aOM06ErppeBe4bGjH997Ffv5iOvzRDvGqxO9jYUizkfXVsfku/g2QS4ilUp53oDTAkgCyPSze1SPDpa+eUFtpk86N7HaXLUDbcAQcg8CGO2t294ZeJoyH9bOG0+ZLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7Ns89rD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7Ns89rD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720183313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUmdoRcwxF0vtGDq5CApO6vlw3HSpxN+XRrrWd5A6/0=;
	b=U7Ns89rDjXZfdBRrFoJA5fNqUet0mulb8Wr2gCgsmPX/K2MLDkE/jf+ggDLvGSczlMTWRm
	GPfbGFncWmoOECi80IpDlELpDCB4Slro+ri4mbkCs6bs873C5GDHVmJTe3ufLDgjH/BCz/
	882sAOclsAXaCmV4SNtAAVm1tz0TKVM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-rRwOV6YpMPO16nJD1Jz0Uw-1; Fri, 05 Jul 2024 08:41:51 -0400
X-MC-Unique: rRwOV6YpMPO16nJD1Jz0Uw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a754440370aso28900066b.1
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 05:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720183310; x=1720788110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUmdoRcwxF0vtGDq5CApO6vlw3HSpxN+XRrrWd5A6/0=;
        b=GXoRrWquCyXRObMEq1RoyA13RDRAH7UsoSSPW1lkk0FuTLEC+g10PQW7fob1xFqg9A
         TGDCvqgbNVYYSMc1NvSbhIpSh33v4Uasgj8WTlGlcs+EbIc02KEHNeRBUxdsk6USo+q0
         Ng/Hw+eX2mB4m/1qfWHYOJBhF/1bTxtpfa19UQX10EvBZL3gmAdxAC5cobT3jhXf9tas
         wCgbltLoPVvfMZr4gPtuyekKuD0PPD5k8uUKySVFyHoq+LbO5wzX90LuD5rhiDyuhM2h
         wHQx8tKK5eoSher5oIYuEaZ5cQbqi7i7+ssTBa67hV/7iTpDyaWauu4vW3aPyeSZz92Q
         nZvA==
X-Gm-Message-State: AOJu0Yw9ZbcQPJUMDuiNiVw5zbOaimDuVWUJJGs/dlxw4nV9mNepvS/N
	5PCmA5H5RvPROC4YZtYM7w/evR2QaGY7uLo5sR8M4NyW1qp/GQVPQnnSssm6ZTTKnyG9sS6LgH2
	aQ9Qs8yQFSW7lECPP6SlDpKZgTOmzFcZjYWH7vpEdrns4dgRwRnINED+WYkYJ4hZg
X-Received: by 2002:a05:6402:26cc:b0:579:73b7:b4cc with SMTP id 4fb4d7f45d1cf-58e5994df08mr4069651a12.2.1720183310549;
        Fri, 05 Jul 2024 05:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKvFDzwRQlV+iTOvh4/L4b/Nx5EKEO6E1JE+809E/tI6VMgbL/Y6rWpOPm+MTM4DSqhdFdnQ==
X-Received: by 2002:a05:6402:26cc:b0:579:73b7:b4cc with SMTP id 4fb4d7f45d1cf-58e5994df08mr4069621a12.2.1720183309878;
        Fri, 05 Jul 2024 05:41:49 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58eb85cc1bcsm1692664a12.94.2024.07.05.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 05:41:49 -0700 (PDT)
Date: Fri, 5 Jul 2024 14:41:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>
Cc: virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
References: <20240705112821.144819-1-sgarzare@redhat.com>
 <20240705073017-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240705073017-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
>On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
>> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
>> filesystems (e.g. XFS) may require larger minimum sizes (see
>> https://issues.redhat.com/browse/RHEL-45951).
>>
>> So to allow us to test these filesystems, let's add a module parameter
>> to control the size of the simulated virtio-blk devices.
>> The value is mapped directly to the `capacity` field of the virtio-blk
>> configuration space, so it must be expressed in sector numbers of 512
>> bytes.
>>
>> The default value (0x40000) is the same as the previous value, so the
>> behavior without setting `capacity` remains unchanged.
>>
>> Before this patch or with this patch without setting `capacity`:
>>   $ modprobe vdpa-sim-blk
>>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
>>
>> After this patch:
>>   $ modprobe vdpa-sim-blk capacity=614400
>>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>What a hack. Cindy was working on adding control over config
>space, why can't that be used?

If it can be used easily with virtio-blk device too, it will be great.
@Cindy do you plan to support that changes for a virtio-blk device too?

In the mean time, for the simulator I thought that this change was fine.
It's just used for testing and debugging...

My main question is how to use that when we have `shared_backend` set to 
true, since we use that setting to test for example live migration. In 
that case, how do we handle the size of the shared ramdisk between 
devices?

Thanks,
Stefano

