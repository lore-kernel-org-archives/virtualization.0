Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F8535A3
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833801; cv=none; b=BvVcG3axnHRv/1AVdhGVCw1V8BZmFJScpuYxVhdLZVZzNxmx81/3rS7TlfRkuqA+7vAsGDwCTLY72yEPl/cDi76Nd6uUUfwFY2DlCp5laQm7bqcsbzhXHoj5rcLuuHMqnk0jKy6yhaibu03bM42lZi4OyWdT47A6kBU8JTTO+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833801; c=relaxed/simple;
	bh=rPNTGp/Tn8oSnoxZozZdnWDR8B4Ksv7q1cBV0qnDa3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hAFe8GWHQJ9Buq3MO3p0U14Ghg6smlIvMHQKewnFj31ruWSQKNhsSL58HWLrYn+HsYa5p0/DC9+O2Yr96QnEHMgzzaBWFk0v5bR+ulDwmgyMlBbyjQT4TJFpuQxcJca9DBcF9iOpYZVdfZcXnpCmY2HDvks0lGQDv53f/czKfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TntvpOXS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TntvpOXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710833799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKg9GvJFLNWkRSN6sgPN6hHh5dCxAIK5VhU/j1vuYMU=;
	b=TntvpOXS4bqP1n7TkEpsn+FdgQ+/1nf1jwQRm8/XTPCMTAEK5FegNEP7xMpMNqeiI/BGWZ
	QSwAoCQHnGZwbqT42xThBdfvmKJCrh6XbYrqADcn5dEAr14qbDM1/5HtCvV7EzUInXqhkP
	LO9qfsp4jp4SZe+3cVdQ3FrhdfbET9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-FMdwgMm6OtiIiVXGjPa4rQ-1; Tue, 19 Mar 2024 03:36:37 -0400
X-MC-Unique: FMdwgMm6OtiIiVXGjPa4rQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ecc0f0c95so2888642f8f.3
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 00:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833796; x=1711438596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKg9GvJFLNWkRSN6sgPN6hHh5dCxAIK5VhU/j1vuYMU=;
        b=Gt4lxV1MZAL8TOiR0xer1OPepvVNyBa9lkq/pocN6TZtGLj+LVldseEeysSAo4BW5I
         E/c3dGir9qVQJzKv+NX49JNOUdVrWPzniuiWCjVLp8eulSjjI0k0i6/wtgs7vvGVOeo+
         VgLywHAQUiGt7RPEUdNspVK2/QP47CyOmxcK7JqJ2R/RK5wTlLi3Wii2qByM+raAEfcm
         wC6Ycin7ZsfI6oe5wjEBc7sa3XtaWqLvFvaUqO5fxxuEhZCY+CFYTRiAB1vhTouc1v5v
         /H853uKjxJKceZ40kkiU2RQSJuY2p3Jd6MxjG6y3L/yH1RYHiEaJEu+TC6r9MZOzuQX3
         bpWA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8FlGE2SBOkdVvpB1w6KIa5XnpfUBIMvktXlT5Gwqbit/5VcVVFXT4h+OxHLOlBv5hLe+LpIDoAH0j+UzUN/k75HGLx9yuzA99WJ1mus=
X-Gm-Message-State: AOJu0YxLvpBJxBGoT4+K/H8RfGWciTaPl019dUCx+syEhvrSIzzmH2IW
	UJGHZUNTql/q9TwZ9ii5oBwpsQISviWCPP6RzoNS1QaKHUwaHhLzSVCbcooKZUshOIIfOEsinG1
	zFpB/cfzpAxtAUIDoVwxq+1nOpHomqTu6DUHgFYu22ZluazzDc1LKc153Z8x79fGh
X-Received: by 2002:a05:6000:e4a:b0:341:80fc:4913 with SMTP id dy10-20020a0560000e4a00b0034180fc4913mr2202830wrb.67.1710833796207;
        Tue, 19 Mar 2024 00:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMIhZzBmKNSSWXzIOXaRHlk22Ags3JFIXiJkum6UNSmNtxg7G6yImmY6QTGuvptfpS2dsfg==
X-Received: by 2002:a05:6000:e4a:b0:341:80fc:4913 with SMTP id dy10-20020a0560000e4a00b0034180fc4913mr2202813wrb.67.1710833795615;
        Tue, 19 Mar 2024 00:36:35 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b0033e99b7cfa8sm6483794wru.13.2024.03.19.00.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:36:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319033016-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240318165924.GA1824@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 04:59:24PM +0000, Will Deacon wrote:
> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > The issue is reported by Yihuang Yu who have 'netperf' test on
> > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > client is started in the VM hosted by grace-hopper machine,
> > while the 'netperf' server is running on grace-grace machine.
> > 
> > The VM is started with virtio-net and vhost has been enabled.
> > We observe a error message spew from VM and then soft-lockup
> > report. The error message indicates the data associated with
> > the descriptor (index: 135) has been released, and the queue
> > is marked as broken. It eventually leads to the endless effort
> > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > and soft-lockup. The stale index 135 is fetched from the available
> > ring and published to the used ring by vhost, meaning we have
> > disordred write to the available ring element and available index.
> > 
> >   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> >   -accel kvm -machine virt,gic-version=host                            \
> >      :                                                                 \
> >   -netdev tap,id=vnet0,vhost=on                                        \
> >   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > 
> >   [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > 
> > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > ARM64. It should work for other architectures, but performance loss is
> > expected.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 49299b1f9ec7..7d852811c912 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> >  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> >  
> > -	/* Descriptors and available array need to be set before we expose the
> > -	 * new available array entries. */
> > -	virtio_wmb(vq->weak_barriers);
> > +	/*
> > +	 * Descriptors and available array need to be set before we expose
> > +	 * the new available array entries. virtio_wmb() should be enough
> > +	 * to ensuere the order theoretically. However, a stronger barrier
> > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > +	 * by the host (vhost). A stronger barrier should work for other
> > +	 * architectures, but performance loss is expected.
> > +	 */
> > +	virtio_mb(false);
> >  	vq->split.avail_idx_shadow++;
> >  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> >  						vq->split.avail_idx_shadow);
> 
> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> here, especially when ordering accesses to coherent memory.
> 
> In practice, either the larger timing different from the DSB or the fact
> that you're going from a Store->Store barrier to a full barrier is what
> makes things "work" for you. Have you tried, for example, a DMB SY
> (e.g. via __smb_mb()).
> 
> We definitely shouldn't take changes like this without a proper
> explanation of what is going on.
> 
> Will

Just making sure: so on this system, how do
smp_wmb() and wmb() differ? smb_wmb is normally for synchronizing
with kernel running on another CPU and we are doing something
unusual in virtio when we use it to synchronize with host
as opposed to the guest - e.g. CONFIG_SMP is special cased
because of this:

#define virt_wmb() do { kcsan_wmb(); __smp_wmb(); } while (0)

Note __smp_wmb not smp_wmb which would be a NOP on UP.


-- 
MST

