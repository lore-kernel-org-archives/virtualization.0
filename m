Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAB420884
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342803; cv=none; b=iz8kQwDZcS1E8q1Ni/rYgWsXeNyxWyssRBwRQrnX1oxKNUSG2qbm6UI5jYRGxbN5maJ9oi4TLO/RwGTTu0mIWhLu9R2uxvupbism8oKdeQ4qd3SZg95Rktv8jA7VeXrj63u1t03+FOgHsF8SwzAm9pHiW79qb2E+pKCvzTxfs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342803; c=relaxed/simple;
	bh=3u09jUh7gLp5iv+UmhDqp0BEuE3lOYgqyKuJNhryqts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kA6bfAhrjqE7YeaeXtO+l0ce8bfUraq4l0JTQqL5sU9/Y5hpNvIbPajC0W7WKnJ0vF32OHrTIUI6vLgwsgu9g1JGsjEVLNETDkxR5Ewz/mduxYa0wa/C9Qs/RKRx1zIVF5WnTdOdYB6pNPfKmnUDez0uvInAl7tNVrABOY5p4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRmcX5dr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRmcX5dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GV9yo9jBEBI28o7XznZuNHujDFZwTfJarP6O8dyD09o=;
	b=KRmcX5drb3QrsIMsOUZ3+JwbPN1H5Suv5EgvuEltFq0DLWd3agG/R9jtkIM3FiT2yX2hK+
	0/J1QbluleKrlteihoo2bGJWA87kuIl58M8kFqP242GkFb1WLitjnVybiuTq7yHxtH6RlI
	9j3S06KwNPBRfEds42i/ztG8K6061gI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-LS-giU0QNyKOlo9Pa8_ehA-1; Mon, 06 Jul 2026 09:00:00 -0400
X-MC-Unique: LS-giU0QNyKOlo9Pa8_ehA-1
X-Mimecast-MFC-AGG-ID: LS-giU0QNyKOlo9Pa8_ehA_1783342799
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4926596eebcso19514375e9.3
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342799; x=1783947599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV9yo9jBEBI28o7XznZuNHujDFZwTfJarP6O8dyD09o=;
        b=fxh2+M9gfKE6jiX/Z2KoLfqEDWClC2tPSyp5Jz50cReXya/DPAOHrVaX0BcD5YeG4K
         idCXVCVg1T8tuPb6KXhTCzVrDZvZ0kUQP6SG4FDC5SKXONPQ9Pf4DJ1bV+R0OWgEtxYn
         fMpYXsvrRZc6sTK+y4+/Jn/nFkc16LJ0HM9VEgbNXw75/T5gYj88yvdc2SVRy34/0P5z
         ohskISvUTb6g22WGaykCNyJnH/pYG8El1lMrz0nfWxu56AtwbJzIHEVEqbN2QGV9y77e
         agM96JWLM6wpLF3ihdZpfFsbmO4aR2Pv4WzgX45yVPzqdtJEXXyUbrLefpEXAWXGe05v
         t/hw==
X-Forwarded-Encrypted: i=1; AHgh+RprrRcfITJo21DFkn93Cuw7Mb0DmPE7fip+g5ZHjYVFFbrIRECN3C8MEBtwiVoE1/VdqgMqm7gYVE4QB1T62Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4V692J4gOmeGmUTaIWLpUJz1AWdeXHOAYfJzLZgzy+UXu53vb
	I4wRdLHb4HkzxUYGxGHpHVo9MgaYk93fG2i3bjIn9d4WcbpEDkcp//vnwU/nFswUtnJnO/ju/A2
	N6qAYa4Fjc3xDE/8xHvsKg7SqAR/c0TcQMxgvDTkWkVBhNRNCnFMwzRDlfAdPFd5+Ge6g
X-Gm-Gg: AfdE7cnrV9zJrJ1WCDyc+nmN9fXgLuqloiNfvHji9sGdUPfahFtsPonKYR+NAt4SOfd
	oBCsVTLBsDilx3kc0UB/kFU/0kYqrquCgv2/BB7Eu6TNt7LHhsLgNrSkj8kafJ/VOY6WCRN7znr
	LM3YckR8BHlIB6t2JGaBPRIwoy+I54YA5hjqOCuPB3f1EtFfPgKuy5Bxc+fHw8l4kQH4UBqjzHD
	QOaBYeVM0JWnuoF/ZFp32pKoQbbjrcWxC3HPzvmAmQVQS43lT/Sj0BbcnAFBXZj/Sa2eA7WOml5
	ffBmWAFWPlgCGqu8BuA/bO78NseBiPZahSVVbzCOi7nzhoNHpc6UktSj8SYX5Y8G46wbn+RIl+s
	9gHSsSmjWicILl9SACTHcYh4L3uIXFu+7
X-Received: by 2002:a05:600c:a00a:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-493df038767mr4416625e9.2.1783342799094;
        Mon, 06 Jul 2026 05:59:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a00a:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-493df038767mr4416205e9.2.1783342798623;
        Mon, 06 Jul 2026 05:59:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdabda3sm287154295e9.5.2026.07.06.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:59:57 -0700 (PDT)
Date: Mon, 6 Jul 2026 08:59:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] virtio_balloon: prime stats vq after
 virtio_device_ready()
Message-ID: <20260706070936-mutt-send-email-mst@kernel.org>
References: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
 <13794c5e-375a-4fc5-84b4-a637d077f8a0@kernel.org>
 <20260706042207-mutt-send-email-mst@kernel.org>
 <6b8e4ad3-6909-4d0a-89a4-104a5ad9fe79@kernel.org>
 <20260706044122-mutt-send-email-mst@kernel.org>
 <24336f56-1024-4c9b-8653-b1a4658b627c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <24336f56-1024-4c9b-8653-b1a4658b627c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IZhvV3dAmsPFpeMlUYDnL0ysR3IB4A846ZjKHB60uAM_1783342799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2026 at 10:57:33AM +0200, David Hildenbrand (Arm) wrote:
> On 7/6/26 10:43, Michael S. Tsirkin wrote:
> > On Mon, Jul 06, 2026 at 10:38:18AM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> Yes.
> >>>
> >>>
> >>> Why not?
> >>
> >> I was wondering whether the spec would state something about that.
> > 
> > Sorry I do not get the question. Virtio API expects
> > callers to serialize calls for each VQ. So this just prevents the work
> > from running and accessing the VQ while probe calls add_buf/kick.
> > I'll add a comment explaining that.
> > But it has nothing to do with the spec.
> 
> The device is clearly not properly initialized yet.
> 
> Yet, we expect that we get a stats_request() callback that would try to
> queue_work(). And IIUC, the stats_request() will be directly issued by the device.

With an in-spec device, it can happen right after virtio_device_ready.
We could defer it a bit, but I don't see what this gets us, and
this also protects against any out of spec ones.


> In QEMU, that would mean that balloon_stats_poll_cb() runs, which would do a
> 
> if (s->stats_vq_elem == NULL) {
> 	...
> 	return
> }
> 
> virtqueue_push(s->svq, s->stats_vq_elem, 0);
> virtio_notify(vdev, s->svq);
> 
> 
> That's why I'm confused :)

First the spec says there could be interrupts for no reasons right after
DRIVER_OK. Second there are situations in which qemu might
consume a buffer without a kick and then an interrupt
races with the kick.

> -- 
> Cheers,
> 
> David

