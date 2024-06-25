Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17641CABB
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300581; cv=none; b=FmylYvnQH13M8cgQTbqqu5hkdij+9QT/oamUdIuBqKHceP4V0f9PmnN6RT5OxjgwUj5H7tRwbZhr+QAaatDeAY53QxgdLO91CH9BZjr/45dO5x1X2fDPhDSo5MNkmd0FLUMtN5tAfvt07JJDOlmrw8sSV5kL3/Hf5EPK2DjJukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300581; c=relaxed/simple;
	bh=Fs+KvxZdj/5n5gntjHQD2lgReala6CCROAZJ3aMokPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ovatGrYre6hUmgooIZkOlZs5oro7ompwZ0QsGdm4iFhbuhdHHACMnaWcj8uTBA2qG/zJ7/c/0nfhxrXFor6yiIcva6pMP9QgqlkzKn7PW6MmW9c0/+ONMDUSOD+BKVyIawDiQKdOAzbTsV0W/k0qHyiJWe/E/30RRPj+9zPxgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uq/Y8UbP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq/Y8UbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719300578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vz43dd0OvBnl13zy7KmNOK7z1fuY42vGUyn+cR+kU1U=;
	b=Uq/Y8UbPa3DLreiSB0MyePO51EQZRIiimhRHBQuAGjWNXyPGhcY1YMIpGm6uJpZab17YIb
	aHfuNnIKIF6qjwMwVKiMoCsfpPd0K0gj8f+iRp+kZQDCgm3CPgU5bodCAwuPDuqTtmjd1z
	UPg1hmEYXE8RaJNAxEXzSV06MZsbb7Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-qDhpxgkXNfGbPiA7-VJGvA-1; Tue, 25 Jun 2024 03:29:32 -0400
X-MC-Unique: qDhpxgkXNfGbPiA7-VJGvA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3625bef4461so2888445f8f.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 00:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719300572; x=1719905372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz43dd0OvBnl13zy7KmNOK7z1fuY42vGUyn+cR+kU1U=;
        b=mJSlO1BftrM/Qtkp7IL8JH0ms+AEvRpITtZZ6n28ROAqIhJBMwUoIdR/rrC6+S2qfK
         JPCDFzADV0ihZPJk6L4sCP9KsG1GauXgTArUzQvmbX/OhgaqMCFPfJZrzYOgE0CKEy5f
         6qvM/5D0tQqTyORBMQ22DS2IqOByFF3a3wFpq1q2jtjlFTh2J8Dxr0Dc4hKIEm9VJJKd
         jKsi2o1XjzIFDYQIRVw4C8iJo9J4A9XmRY+629sV/XHCk2SpCFr6zkArwVbHmfTguwvl
         2DGmIEgDGZzxAFc53yn9KFCjZTsOkG/wg+s/qKDn1tq6yQxEj5XnMwCBRq1vY3xRsOK2
         fnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+SUmxV+CYkWLTDZi/Oh86nGYcdBSjNYltldfs7qAYc8VvlEckmHZdVup4ULHnKRGdbW7cu3K1AQyTky58iu2fLh/0YzCyTRoeuVcUsXs=
X-Gm-Message-State: AOJu0YwOXqNXPveJLZ8zzLeYbE4ka+0YIdxQvEd9G8D1vDLQTWmnqMaW
	JggKZaMdhjz3XngXeg6miy6E62ziu/aEj++NdlLA9iQVFB3yE4ltpDUl7I7AaAH8xxMCUVOTxW8
	xbqyA+dTBEy4+s9GlP7+m90kCcWI6/GqBfG9Pxvhp9xsNiFcB9BkgJu69B5G9UOsf
X-Received: by 2002:a05:6000:d09:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-366e3291345mr6001932f8f.15.1719300571772;
        Tue, 25 Jun 2024 00:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAEvBLiaXivEGU5kdsJwd3F7Cb0zlp48l5mlrR010qgNJhyIiHnE63nWTquW2g5846zHsYw==
X-Received: by 2002:a05:6000:d09:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-366e3291345mr6001910f8f.15.1719300571038;
        Tue, 25 Jun 2024 00:29:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9bb1fsm12124971f8f.49.2024.06.25.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:29:30 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:29:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Heng Qi <hengqi@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240625032753-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
 <1719281486.8829272-20-hengqi@linux.alibaba.com>
 <Znpl3lrArGU8EdFQ@nanopsycho.orion>
 <PH0PR12MB5481409E517CD45449CAE1FCDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481409E517CD45449CAE1FCDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 06:41:52AM +0000, Parav Pandit wrote:
> 
> > From: Jiri Pirko <jiri@resnulli.us>
> > Sent: Tuesday, June 25, 2024 12:08 PM
> 
> > I'm working on a fallback where admin queue and cvq would share config
> > vector. Lets see.
> 
> Cvq or avq resulting in performing more MMIO reads of the config space is not good.
> CVQ and AVQ sharing irq is good, but it should not share with config change interrupt.

Well if a hardware vendor doesn't want that, allocate enough vectors
and all is well. Your requirement is harder to implement because
ATM cvq isn't special from virtio core POV.

-- 
MST

