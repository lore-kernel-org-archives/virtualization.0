Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196735;
	b=0Z6YOUH/yUVkEYpLxa0uHKMgfB0wqBnsdZPGYsw168S68B29QcgLTK0BVyQ8zXfwLfaH
	 7nRQqKgqvkCqag2r2BCghs459fdrcPBvtS+DDchRO8rtWANEsBJw9XDPL5bmE7BSQ7QfJ
	 BKABpkD80E77JahLm+hu04wE3e53mIcTKqISjqKJN4k/vd8c4kD3RhLCpTzspGCait8Ch
	 evatq05GAA67ZSgjXIi08dRWno6UlFd89Q5t/y7SrMSNzuLv4/QVYOHICImx46qWKT39C
	 re4fFe1GLEyTqNhGpzlII1C3kUm3X7i4cI/VguRWg/aAH+B7IACfmEb5sIXCnADe5cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196735;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=uq/o5iwtxXSQxTRJv8L5q8Xn0KTb+mT3qs/Sf++WNxM=;
	b=QE85r9RtWOmmAv7R3MX9LmZIsTZ+rrfuC0WP8MCWQjIE1LNWhvThlkEF4FDkfd0lXZq4
	 yAb21dLxP1+e7XQhGKTES5YyBk0Zsz6q0abDIFdhiL1/i/KoPFm+8clrZ5BiPOMRQ3ydO
	 eNdzKK+d6LlNmPqDLLL9C3QcMnzGvPFSJTSaImSYF7P9/DDtCdpwWvDfb1tyEwsBPbq1h
	 0Ig08MTCQna9p31zUjs+BxdZ7Ziu0iUwtb01EzywZJB1SVfgb/tZ+yVrd6AVGykbyoOSN
	 9MzZBZbGLjoCgNsEvtQ3JE3n+OUeE5QHCJEQD4PXZogWlm9Pm0BDCPOgO8pAZTGQbZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ICgsiF3B;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024560A2629
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 17:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4024560A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ICgsiF3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795196730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uq/o5iwtxXSQxTRJv8L5q8Xn0KTb+mT3qs/Sf++WNxM=;
	b=ICgsiF3BabQ7rZXv1dkZIqA5KJk+t294fUSswbkN2ARpa7K3/AQ1EDVKYWY7XLxn0+lc5y
	CWJbni5h8Uqt4weSC7Esxi2Q+lM3hCmVE4q3DzTD3eJUYP3bbCXHaSFYse7Dwpq6RWUT1d
	6SssDcJtDxJCTXoLeuRIIRgjJ9+Dbfw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-SJ_dpnZlNdyUoXJLq7Dl9Q-1; Fri, 20 Nov 2026 17:45:28 +0000
X-MC-Unique: SJ_dpnZlNdyUoXJLq7Dl9Q-1
X-Mimecast-MFC-AGG-ID: SJ_dpnZlNdyUoXJLq7Dl9Q_1795196727
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so8882225e9.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 09:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196727; x=1795801527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uq/o5iwtxXSQxTRJv8L5q8Xn0KTb+mT3qs/Sf++WNxM=;
        b=tlNFT8yqHUI8ggRIHxt6NUoOd0sfAzhdMnRbj7PRHjwBNfHnNon2khSY55CTCisMh4
         W2clPybWkGS6v459Fay0piuSroYqjMxxMSwG0VK0tzRRPvD50uLAMsFFENV9iWUtcQON
         y8Td1afInG6nmogzpGMpqfErbz68AvCAYD9om/q+YdNsZAPCe6cOsxpYMjAOt6BCOG0q
         DB/Jmnl9i+MBUZYKIISkj6yfz3hE+BYoBVPT6fTx/DQ48mYqFk1OyukrlINlMldD6FPH
         95qgxUwvfn7mpE2sg1UxgkywIvE2AZxzFg9yjDP0Zi3tqni4qSPQxI4+em9C83wp9Us2
         2OXQ==
X-Forwarded-Encrypted: i=1; AL+hErG0cvo+aG/lfPXCZ0E0KbrWUCRgJOz5XOBnnArI/tTCPXL7k3xAolERzQmT8rDGmS8aW3yukRzQ0lKgyHXwTQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jC2IbcpmNkbwMgPgwjJe62GsbZYfDoKeoOwcjk6qVUWge5l5c
	T/GErGsGzMweCsKkIPvjg2gKzMV9ZvVE35ucNOCbce0DkqhbJSSGt73iyNJYG/uNmrz2jval3EN
	V0r5jfAHHc3o/YhMbWwOI/4595n6NCRTjWbWvjxiRt8JhAtxBX0Iy80zhhuASlchaygyib1ZPQF
	4S
X-Gm-Gg: AYBFou3TA8g/TYMJf9Hn5GIVbu1FGiLAMcoUdF9rdoh6nALZ48dRiYsdtAYeVigvGQU
	ShiARHQmRCOkuqEvKsJKFLQRqfCWSXucmWxtDqiIJyEOy9CDUqw6EGscfxFLHJM/EA0gZu78pLY
	awd4D3vISq4SUVx63mtJMMgiL39MjQqKjvajz9SUqvcDX4Tm/bpv4Cu/F9HJH85eUPTFMZGC8Yt
	Ig3slDgn0PgqOETHsex3X1tdCnUXsMenPGtzJDupWqxTgzNeoQL1hB3wVlXfBee0bZFNSU+bG7h
	hWqyDVv/x3HX24yg4XUjm0CIKrCPfXRoL2Ajg6AB3on26KjmxTz9YLVZS8jhr8qjS8eytKrkryL
	3FvahDS+4b4FC1UR916dvGAzLh33RKh2ccYkAaQQnlL/0
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr88569335e9.28.1795196726642;
        Fri, 20 Nov 2026 09:45:26 -0800 (PST)
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr88568535e9.28.1795196725990;
        Fri, 20 Nov 2026 09:45:25 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm142927935e9.13.2026.11.20.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:45:25 -0800 (PST)
Date: Fri, 20 Nov 2026 12:45:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH v2 0/3] virtio_net: introduce an RX queue watchdog for
 stuck detection
Message-ID: <20261120124403-mutt-send-email-mst@kernel.org>
References: <20261120071826.198604-1-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261120071826.198604-1-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RAXBxhYzfOcaIWG-_WM-f4hyZ79PytwuNL2SQUkVhe4_1795196727
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2026 at 03:18:23PM +0800, Longjun Tang wrote:
> Hi Michael, Kuba,
> 
> I once ran into a problem where the virtio_net receive queue became
> permanently stuck.
> 
> The virtio_net RX path relies on backend interrupt notifications.
> The backend(vhost_net/vhost-user) appends buffers to the used ring
> and then notifies the guest, relying on the hypervisor(KVM) to inject
> the interrupt. On receiving it, virtio_net schedules NAPI, drains the
> used ring and refills descriptors.
> 
> If the hypervisor fails to inject the interrupt(e.g. a transient KVM
> failure), the guest never schedules NAPI, so it neither consumes buffers
> nor returns descriptors. The backend keeps appending until the ring is full,
> then stops and, with no free descriptors left, also stops sending
> notifications. Both sides now wait for the other, and the RX queue is
> permanently stuck.
> 
> The root cause is the lost interrupt in the hypervisor, and the proper
> fix belongs there. Nevertheless, I believe virtio_net needs a way to
> observe and diagnose it. Today, once a queue hangs, there is no signal
> to the operator that anything is wrong: the RX path has no equivalent of
> the TX watchdog (ndo_tx_timeout). This series lets virtio_net detect and
> recover a stuck RX queue.
> 

Why virtio net specifically?


> Implementation
> --------------
> 
> Patch 1 exposes last_used_idx through a new helper, which is used by both
> the split and the packed ring and denotes the position the driver has
> last consumed. Together with the existing virtqueue_poll(), it lets a
> driver ask whether the device has produced buffers that the driver has
> not consumed yet ("backlog").
> 
> Patch 2 adds a per-device RX watchdog that scans all RX queues once per
> second. A queue is considered stuck when, for 5 seconds, all of the
> following hold simultaneously:
>   - the queue has a non-zero backlog (unconsumed buffers);


what does unconsumed mean?

>   - the driver makes no consumption progress (last_used unchanged);
>   - no new interrupt arrives (rq->calls unchanged).
> On detection it logs a warning, rate-limited to once per timeout, and
> reschedules NAPI, which drains the ring and refills the descriptors,
> so the queue recovers.
> 
> Patch 3 adds a per-queue stalls statistic, exposed via ethtool -S, so
> the number of stuck events can be observed per queue.



> questions and comments are welcome.
> 
> Thanks!
> Lange
> 
> Changes in v2:
> - 1/3: fix the kdoc.
> - 2/3: drop the module parameter, use a fixed 5s timeout.
> - 3/3: rename rx_timeouts to stalls.
> 
> Longjun Tang (3):
>   virtio: add virtqueue_get_last_used_idx() helper
>   virtio_net: introduce an RX queue watchdog for stuck detection
>   virtio_net: add stalls per-queue statistic
> 
>  drivers/net/virtio_net.c     | 105 +++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_ring.c |  18 +++++-
>  include/linux/virtio.h       |   2 +
>  3 files changed, 123 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1

