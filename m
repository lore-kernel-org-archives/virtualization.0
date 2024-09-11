Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637D748A
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026168; cv=none; b=Qe9fpzIbsZ1lZSJto3mXrqIQ5f/CyTILtXW2DohHXt2a9qz7XKmMOhyW4DRvV3dchV2AB/CEJgjopacNfk+5TPNKik/O+iMzdUrHCZtOb2dS96EnCM0eyc2y/G1NkT+2Y7/oWDLYCioppwbYR4CbH8+jUbICBe5zfv22jdx3zto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026168; c=relaxed/simple;
	bh=7lWqkY6rYgWNrKCoSGKWt8J1rPrFev44GvHxux5ASjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZekgInBTlxiMuyOXez6eEnod6rfvSdA0ag+UVosQQOgt4NvQ5hUiHkVusXM6IlNq9flWzc5niu7C9AIsbGz7coL/xoBtJV43vVbMrEBfVIy+KtVCSzy4yzbrci3NNqNLahlitLNlkH5VneZ6kwdHuzyvl20BNnGCyfbW4ObR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlJ/p+ze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlJ/p+ze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCdT/G6ASLPs+mMu/d0vJMQ3EmNT91XHCdsEZRhZj6U=;
	b=GlJ/p+zeNWYfJv7Cap5MQCOGYZNd3dMUU+3f+Se9xkwn8qmatRLtQ4k19VN5LHll6IfFH6
	kaXCXlyX4rgGgS4vJ1vv2K3rK+57ntoqn2G66o/cQWYsZWwKSCMB0dANbioN5W3MbHg5Q8
	LtUocGUgNG5ddWDs8oJhbOrPffTXtYE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-AySuj7QJMGeBTZ0gFP1Q7Q-1; Tue, 10 Sep 2024 23:42:43 -0400
X-MC-Unique: AySuj7QJMGeBTZ0gFP1Q7Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2da511a99e1so1741050a91.2
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026163; x=1726630963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCdT/G6ASLPs+mMu/d0vJMQ3EmNT91XHCdsEZRhZj6U=;
        b=kjk+uMVNYD6oVaOfBlOdsd0Ky7oMUH5VuOrxyrI1pL2nf9FJB/4JcSu8D3XBDhI8v0
         N+mqH8eAl/ZBkzz9NlhvlsUXsYXXDcgvWiTDuDtjjL5d09k7sHfVcubmo5wQJ8jd+VzL
         lwNKLZEQUqgp95JH8RohNooCVgaweGxnE7DN8l2uCPnYiXOQabQNzaJnkM3trm2oe1J2
         5JiGx9YiwBbLlL6JYvTO4ZDp7jS/zg8NUqLShzOItLwMOUWfKLq4yzVdtjoHQhrrd9ji
         bCQg8dJo6EjSCNPVJoIyDceNUEFhuJfrZz11Uwjn3hwfRBzmtr4thq+U+YBxJ/NWTUTN
         AKOw==
X-Forwarded-Encrypted: i=1; AJvYcCXDAuwf+LlzH3Eo6N5H2T4aHv6oYWw4zQoWqR3WOGCt96G9FdhGZEV2owI8NQDIPQeraaLiYfO8LX6GlMDnww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtNCbvXXQX0AUg6CILEL2i9thiRc8NL7WjmqjPURTXCtucL1uj
	UwqtR4+rrHQqL3CNQedlgVwv3e3IpzNJb78Wtn0aQjSCT+Y6dPMO/07RMw+S5E3Ir+YMMPgcQwn
	apwkjJ0B1EgWeK8ehqON9F4xHoWDEGFCiiyBuWIOpZcRvEzDKO3XsEFOOai6be00v6NacU6SpQ3
	EeHM4UH6voifBTNymJBLovfZL75fkD+X6mF3LCXDs=
X-Received: by 2002:a17:90b:d0b:b0:2c9:7219:1db0 with SMTP id 98e67ed59e1d1-2db82e7f291mr1947626a91.3.1726026162727;
        Tue, 10 Sep 2024 20:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYtgxoPYgk4ye8c/+6l2b91ppaTpKhlsXURphnUZh6+MgMb6hMovMDONiqGgSgciil5VhTa78kls6GbtJfkUU=
X-Received: by 2002:a17:90b:d0b:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2db82e7f291mr1947588a91.3.1726026162089; Tue, 10 Sep 2024
 20:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com> <20240910022843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910022843-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:42:31 +0800
Message-ID: <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com, 
	shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com, 
	christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu, 
	xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com, 
	cratiu@nvidia.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
> > From: Carlos Bilbao <cbilbao@digitalocean.com>
> >
> > Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
> > vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remov=
e
> > ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supporte=
d;
> > see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> >
> > Carlos:
> >   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
> >   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
>
> This will need a rebase. Will apply once you post one.
> Thanks!

Note that I think patch 2 is probably not right as we indeed allow
config write for some device.

Thanks

