Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41694501A
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847008; cv=none; b=ahrWJJ7umnZRrQ2AvmsX3ViCqhJMcPnZKe5LNSS6FLE5f+/ZEH2dJStOFuSFW3m6CwGvWgj58JSmwkGc11C014p5V3IcPKigV8MUe3je6TkJEWynwKNbuT2i1KuRbn4lhzIOAMpVUINbTqqY3GyW3o/MJsr9UZlyFDAgz86c0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847008; c=relaxed/simple;
	bh=k4p6BZBD6f8DVa1WslyLTAjRuEA4N0NOBDUZFqG9OjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lyRAy+byd9/3JmCBFL52glfgYkOzMCaPnCocB+CJvejah+DWgkDBXd1Tuf1C1YufgzqKLVescRA9y51hjxlhgnPxEN0NaVjWJWUYSDHZ0YquU7FhLEPh+E5nDlfLjwqXFODPs6OqEQlAO46LW6Lshm1ncSz2QnD+Pg/RjTdew5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyDR7fdf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyDR7fdf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715847005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA+jepTOChJ7+snqX+5DRaDKCp4RJQjDydrDRBP3COs=;
	b=JyDR7fdfv3N81RIW90JyER2MAOwI/XU40GrKb2b1P4zocgpq9cv7/OU6rcgni1h4KLdbYa
	K36CY7TWoT0J37Bb437Omwb8kr82EFUt0EcR2oxxI97hIr6HytSh6Qe73ZX29gWrhZLYa7
	S+JFrJMlMY6aEhVr9xKOqi8Y0RTHGiw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-7hZETwI1OTW34WbNvvOvUg-1; Thu, 16 May 2024 04:10:03 -0400
X-MC-Unique: 7hZETwI1OTW34WbNvvOvUg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5a812308daso212899066b.0
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715847002; x=1716451802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA+jepTOChJ7+snqX+5DRaDKCp4RJQjDydrDRBP3COs=;
        b=PY8e1qBhgP9xE/A9FARmC5nwNg8UKAmnMXd0yZd4E1hukGQIfOvXINypiGIDJ79QB7
         7WLWSeBaDKt9xulYIlckgRtjphncfxJXfIcioAAfnmHbI9Gd1h0d9OA3dgoxg58sIv7X
         lLV2iejUbBvtbF3iHn+ZCfpg0MvdrDkoRjZ/V6oMdo4i+0xVG2q5ZF2b7ajNfwhG84tj
         2L4GRo9WAoUVeEyQDtdikiDxyd0CjwVVFX4BPTaSJh+BStCTTqxQBkorYZ1ikeqITudG
         PRXRLNE3k7KJ0soPeY6iptBl8k1BLQf3O5KTu851NSAzYD9T6o//HXElKA+mNyLhL1nG
         hLfg==
X-Forwarded-Encrypted: i=1; AJvYcCVhR5wbodwDBk+77Q2nbqc4DMDfLQ1Kumww1XCL84Rw6Qpv+j2eZAx3NC4wbJzHMAMB73h2p2HKCLaHtRWUXE/9VaPh46kB+O6Z07QUagI=
X-Gm-Message-State: AOJu0YyAlxFjjQkZa2m+6ygDW5WERjxdmW3S/yyyMbapfDK2pygaZKZz
	2XWfLXo8uB7PdsXcF+T/IoaiK0dk3C6XwbPk9ITXX1gYWrJIe0d4ZdOr/Bhw9UmlM/vrz4ATmqp
	GyBH/EQdGpLLTFUroKDeP0Uq7zb+GUITgPHI+VPxwIoOxTzhpIJzlpRQFPDMITWkA
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1102993266b.70.1715847002099;
        Thu, 16 May 2024 01:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQyscwxbqGC7a+Epkh0Xcy/QL4T1fDS/fLANmDq3+Ubkm9JOf+n6UBt4e0RPv0Wj5wD462A==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1102990066b.70.1715847001507;
        Thu, 16 May 2024 01:10:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it. [87.12.25.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01598sm963957166b.178.2024.05.16.01.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:10:00 -0700 (PDT)
Date: Thu, 16 May 2024 10:09:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, Jeongjun Park <aha310510@gmail.com>, 
	Arseny Krasnov <arseny.krasnov@kaspersky.com>, "David S . Miller" <davem@davemloft.net>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
Message-ID: <mci7jdezdtzgoxj7zgecf4zyvxk6jixy4jgcwwoxegzkjqqqtx@7zoborovztcs>
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 15, 2024 at 11:05:43AM GMT, Michael S. Tsirkin wrote:
>There are two issues around seqpacket_allow:
>1. seqpacket_allow is not initialized when socket is
>   created. Thus if features are never set, it will be
>   read uninitialized.
>2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>   then seqpacket_allow will not be cleared appropriately
>   (existing apps I know about don't usually do this but
>    it's legal and there's no way to be sure no one relies
>    on this).
>
>To fix:
>	- initialize seqpacket_allow after allocation
>	- set it unconditionally in set_features
>
>Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
>Reported-by: Jeongjun Park <aha310510@gmail.com>
>Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
>Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>Cc: David S. Miller <davem@davemloft.net>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>
>---
>
>
>Reposting now it's been tested.
>
> drivers/vhost/vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for fixing this issue!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

