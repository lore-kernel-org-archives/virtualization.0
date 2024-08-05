Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6513D628
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847173; cv=none; b=P5H84wZU4pPcTKCzWLpSKO6Sl542XaWQaI+QrA0/r8SqvTXRUv4fCAuufL+Di5KsTL/wi6orB8Gufsqzf9EtB2Qxq6vqM9oA9+EFVVSeaM1sMiUkaUyqShYmpLTf2UGwZJ6jElZC0mek1xOFj9/aYhc2W9EdmQ/U+Q8X+/UQ+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847173; c=relaxed/simple;
	bh=2VhGFoDqNEQQcvojz0IpiTyJYqSkpD3J7Qze2aHR3fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i2y39Cp2BKgbBVHMFVqBpSKUgRcQm8YBKvqs1b+JfFNteFnyTkMMbRRJPjmnuI7Ti+9sJ+XWdGIyHJppWNJYr16OExGgFISJrqZuJ3XZ7s7Ee96JkiVxA+ZEuwnUr95JI1+9rNDXmmSt1Y4hEkX87lvjhAqvcj2Gx3nzCGugpjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlqEQqTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlqEQqTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722847170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ea4hswH1u1nPlUlDCZA86v40saWII4j79Dw05H185hU=;
	b=HlqEQqTudZTwfRFte6v3aqmUm/xm6hxgqfslGIK/SlkfXmqlQuGn2morkL6a0xzW7T8FSx
	trsg84S6IYz/rtJw6+b+rt3dsUOfctbCUrnOEckjyAKalymt8Pj+NTHpeTstH5B6G1WkpE
	h3IauC+vd43JCj2+MIIxu6FwSmPE1Oo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-7XB69ATkPkq1qne-CLP3mQ-1; Mon, 05 Aug 2024 04:39:29 -0400
X-MC-Unique: 7XB69ATkPkq1qne-CLP3mQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428207daff2so54354765e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 01:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847168; x=1723451968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea4hswH1u1nPlUlDCZA86v40saWII4j79Dw05H185hU=;
        b=k2fzyYxfy9QRzkRearyRP9iUPV/ZYfD/prZA18xN0TD4YZEg1CUfwqRD3SdHTv7eIq
         /hyWuBmUpaYkTfseiADIAmSNJNxjeaChQdbjY3KPxPVcH2glNRrr1njON0fgtArQ5T7W
         VEmLM/L8//GzzyAcJueALl7Np/NSI+SGnKys9LQfpjh2kojiO1CLKjXZgA9GXanSqOAp
         wbWfDI7YqotfxZ8hplm4pr9OtWuvYz0WtzTaC+g4br1BA5/wzsDviyDu2DVlR1JM3OUa
         TZ2VO4EFxBfMz2T5Bof13FcpHs6+ItsH51IYVkc30Vw9kbgiunjcfizPV3vFaXOy5/Yy
         rlaA==
X-Forwarded-Encrypted: i=1; AJvYcCWY+pEq9eBUpeR/9xX0eY/NAn8NKBm0KKimUUyTTojM8D4zLGqYKuJQ4XNot8As/Vu+qT0qgwAV95rXdl70qPmwBb0JtOS4cVXl4FGkWIU=
X-Gm-Message-State: AOJu0YyYLNH0J1T5ih/FnDSSjkaXzFPYnHxql/kKQ4L3yb0K76FoWdNM
	QsWomgMoJKpvhyOiaoFapVVioRBQ+qY45w1V7f9X/jMNrYqi1dc4xo/+MMLvPPVz0gm/FWyFdo0
	x06inCBLxBGphs7U1buRPyWjyH57JcqaGo/FUOuYH0Rx8v7/tcx0veuaFSUeIWVeP
X-Received: by 2002:adf:b196:0:b0:369:b849:61b0 with SMTP id ffacd0b85a97d-36bbc17132dmr7003635f8f.43.1722847168039;
        Mon, 05 Aug 2024 01:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM8/anathdf0+itad/SmXLJr8Ha3hpgUqxCdeZR+OeBw6j4Do78FnDxdF5vJm5uH7+QdreGg==
X-Received: by 2002:adf:b196:0:b0:369:b849:61b0 with SMTP id ffacd0b85a97d-36bbc17132dmr7003601f8f.43.1722847167114;
        Mon, 05 Aug 2024 01:39:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd169697sm9050176f8f.107.2024.08.05.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:39:26 -0700 (PDT)
Date: Mon, 5 Aug 2024 10:39:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com, mst@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Michael,
this series is marked as "Not Applicable" for the net-next tree:
https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/

Actually this is more about the virtio-vsock driver, so can you queue 
this on your tree?

Thanks,
Stefano

On Tue, Jul 30, 2024 at 09:47:30PM GMT, Luigi Leonardi via B4 Relay wrote:
>This series introduces an optimization for vsock/virtio to reduce latency
>and increase the throughput: When the guest sends a packet to the host,
>and the intermediate queue (send_pkt_queue) is empty, if there is enough
>space, the packet is put directly in the virtqueue.
>
>v3->v4
>While running experiments on fio with 64B payload, I realized that there
>was a mistake in my fio configuration, so I re-ran all the experiments
>and now the latency numbers are indeed lower with the patch applied.
>I also noticed that I was kicking the host without the lock.
>
>- Fixed a configuration mistake on fio and re-ran all experiments.
>- Fio latency measurement using 64B payload.
>- virtio_transport_send_skb_fast_path sends kick with the tx_lock acquired
>- Addressed all minor style changes requested by maintainer.
>- Rebased on latest net-next
>- Link to v3: https://lore.kernel.org/r/20240711-pinna-v3-0-697d4164fe80@outlook.com
>
>v2->v3
>- Performed more experiments using iperf3 using multiple streams
>- Handling of reply packets removed from virtio_transport_send_skb,
>  as is needed just by the worker.
>- Removed atomic_inc/atomic_sub when queuing directly to the vq.
>- Introduced virtio_transport_send_skb_fast_path that handles the
>  steps for sending on the vq.
>- Fixed a missing mutex_unlock in error path.
>- Changed authorship of the second commit
>- Rebased on latest net-next
>
>v1->v2
>In this v2 I replaced a mutex_lock with a mutex_trylock because it was
>insidea RCU critical section. I also added a check on tx_run, so if the
>module is being removed the packet is not queued. I'd like to thank Stefano
>for reporting the tx_run issue.
>
>Applied all Stefano's suggestions:
>    - Minor code style changes
>    - Minor commit text rewrite
>Performed more experiments:
>     - Check if all the packets go directly to the vq (Matias' suggestion)
>     - Used iperf3 to see if there is any improvement in overall throughput
>      from guest to host
>     - Pinned the vhost process to a pCPU.
>     - Run fio using 512B payload
>Rebased on latest net-next
>
>---
>Luigi Leonardi (1):
>      vsock/virtio: avoid queuing packets when intermediate queue is empty
>
>Marco Pinna (1):
>      vsock/virtio: refactor virtio_transport_send_pkt_work
>
> net/vmw_vsock/virtio_transport.c | 144 +++++++++++++++++++++++++--------------
> 1 file changed, 94 insertions(+), 50 deletions(-)
>---
>base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
>change-id: 20240730-pinna-db8cc1b8b037
>
>Best regards,
>-- 
>Luigi Leonardi <luigi.leonardi@outlook.com>
>
>
>

