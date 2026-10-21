Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576126;
	b=GQ8uXtoD+X08Lbq+wk1vD4dAwLdoxR0ZJv/swiQcPpoRe+YHTYEuzBEsbHfN+g8fu4eO
	 2iW4skiybcMkC56/FeXVZOoQbl3LkF5SeccWOMFFwMmYpuBOUZAQXmZW6yghLT2Wp17GN
	 W8fBcOWjyGhjUdW2WoEjYu47/0D5DFX2fS67OzN19Wzz7QmUaCNeEqrSZxl1hUa5bi/Nv
	 WTLH/ugQwV70NF0C8mMF5hvpXURsPq2fy3Id6pOrt2s9MYeoUNTsEMFtK3FyJiAc9qlNX
	 OLe26NksqYaWtNPtAwGcbMuk30RGXomCLamDcSV9M+INytdjxPPvkZbHV1ZQ3weBzug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576126;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
	b=aey2rN7ksNVLU3cOj0ZTqNo4Fex0IcG7uYkvGCyG5J9lHYJpP/PlZIo67F8osgvfJ0wS
	 RiS3n0N4zzm/ITwlm1QEygGzG454KVEInqpXcE9sWwt3dr72jMYdvyXOl6ZubK2ylNATG
	 BzYto3tmrd3nUE9pJq231xUnW+Jf9PGxNT7rkOcokhlrCQPdBlH4xpUi3Y+tPMeFky0tR
	 JgiqJV56JgDD+q197eSDuyONOV5/8m1oAB6Q0Fd+W/eDdVXL/78lxj6Iusngj2CSB7Mkh
	 JPh8/baX6y6RCZtyCz35bjnW3Cd4RmCiaDV8/DP4rRj4pGCjAOQIk4THE+nYmDxo9dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQn7v4a3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F7606A320
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B43F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQn7v4a3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792576124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
	b=DQn7v4a3TWcBwZDOTMgjh4Fm/PHPKK8eXbQYStshtIVfZ0jeZH75grAeOsteZ0VJLmu66H
	/KvtoVoWIVN+pPtoCZtxUxf4cvEKwLZjo2MTfoJs2+UAYg3wTFdjYb+561OfRDzFKJrsZI
	gpNBYGX0Ni3XPGd40WsG+ad6zAndDj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-OggHnViPNDCU3ImZPGSacQ-1; Wed, 21 Oct 2026 09:48:41 +0000
X-MC-Unique: OggHnViPNDCU3ImZPGSacQ-1
X-Mimecast-MFC-AGG-ID: OggHnViPNDCU3ImZPGSacQ_1792576120
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso4753775e9.3
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 02:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576120; x=1793180920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
        b=KolVCsoTwhn3lX9SGc/JAn1txwFQj4zMEoYvmlmV1ow87C9HIi9vpkmm2CJm0VCP1+
         Ap5bZ8Jn24BOBCq7crO0FbqEh8SnKkvV/P3MyScIfXtV9en5wmQL+FMLe/U8IgmA4KmX
         pjOQkG1p3Lt1WkJ/3ewwyNGjoPEf4HwsI0SreVVSZ7uetP1gbPm8wzDbKv9dBwHxSjjA
         9C+9WVcBhXtWmjU4BFGi8X1Onibav4JISls86wOkZnj3JQ9Krb6MVGv6CQUJxa+JM7ze
         qKkbehLWjURasU0DQ7JmeDEybhSVnFlFVhH363wtJcmPV+eqXBR+f0A4Lk7kx8b8fGCs
         /V8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxGwAouO0okXLmevtRqQpCOMhM+zWhIESjJ7HiuKWkRbWnoIeBPb2MyMQH2B5F7PIKOYH1hd1/8lJq7eaRevA==@lists.linux.dev
X-Gm-Message-State: AFq9FYK9ZGzGx7ZLNLfr40VUZbutlGUIErRZsGRR01QNQ078gOCp8ARo
	k0Uv55pcatfGVJqeSJYniv5FJFNediBR1EpCeRHrXG6kTC4jVuMc7Oh4H2QE2Qj/B631XZvfGV5
	gwdINB7M3w+mOwOf1l82h+HZrV61RyfVHqpVPG+5yFf8j7Wo5WQ5jCYza2cIAQCgBjI5Y
X-Gm-Gg: AYBFou1PkGAlqlorzjluO45QXGCJnDK4kmSrMkFxueQ1qr1853zAUgRWUZIr1KCCzXz
	M0r6YqjXpLji7j56ChRvxXaRFIb0/X9cKRpibM4l8oPvuCL4hbEcDEkTnl9dQYNmj0FppBFkEfp
	ySy7tHQShIl2w7RExIsqsAUx7aKgzhSgMoPkAthOuh1ezrJbCVmslGZPTIo0CvqquRcMEHvVXR1
	JOsvu0NNiiKWiuIlvtiXNT84OvEQt1pnLYfTAc9tEU+Bzdm57wxPKh/C6VBoqxLEtVcGpx7d8Mp
	42IayAhS8bs4nJG6aamN6BtsxDEIoyxSa3cjbcte6kn2bY/CgfuIC1bpcucK4Zo1Vou23FKlti0
	+hZ7/7Q==
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1fdafd610mr29312475e9.15.1792576120187;
        Wed, 21 Oct 2026 02:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1fdafd610mr29311875e9.15.1792576119740;
        Wed, 21 Oct 2026 02:48:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1b227dsm52096435e9.6.2026.10.21.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:48:37 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:48:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <atiKKS3piuBLEiSd@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vf2z4UucfelWhbTtpgcY9hTFU3BR0RfOVUL075ozG4w_1792576120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Oct 20, 2026 at 06:15:03PM -0700, Bobby Eshleman wrote:
>vsock network namespaces let a host put each VM in a namespace of its
>own. A guest has no equivalent yet. It has a single G2H device that
>cannot be assigned to a network namespace.
>
>This series lets a guest move that device into a network namespace. A
>new generic netlink family, "vsock", supports the command
>VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
>request was sent from. The namespace's existing ns_mode then decides who
>may use it: a "global" namespace shares the device with every other
>global namespace, and a "local" namespace keeps the host connection to
>itself. The device starts out in the initial namespace, so until the
>command is issued nothing has moved and no mode has changed. There is no
>explicit unassign as assigning the device back to the initial namespace
>is equivalent.
>
>The command requires CAP_NET_ADMIN in the initial user namespace, so
>that an unprivileged user namespace cannot claim the device.
>
>Connections that can no longer reach the device after a move are reset,
>so that a namespace which has lost access cannot keep using a socket it
>opened while it still had access. The assignment holds a reference on
>the namespace, so deleting that namespace does not move the device; only
>another assignment does.
>
>Transports opt in through a new netns_assign_allow flag. Only
>virtio-vsock sets it here, because it is the only guest transport
>that I am able to test against.
>
>Based off of Stefano's original series:
>https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- All Sashiko fixes (see individual patch change lists)
>- Link to v3: https://lore.kernel.org/r/20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com
>

Sorry, yesterday I started to review v3, but didn't post comments :-(
I'll send on this series.

Thanks,
Stefano

