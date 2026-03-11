Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABD3BD240
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216140; cv=none; b=EG+1uPnzE/dF4TfQ7SEDuG9JS502xvnIoN5Rtq1alv0YC1uqyxTwM4AqHwATXOvrKLfhBv41m3FxZBzQZHHxBM9FycEkfaGPU2cXppx/L77nfzIpki7GorE+FVihLOYZg4rg7mUgyS+66LldU7mr7oVZzomtvzD63OaphpMZSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216140; c=relaxed/simple;
	bh=iZkRXUyyM/FvlFMWfZpq2DthJE1u88Lcb9ffK7KxgFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uSOh/fDxsKszWbn7Hb56AUo7Xf6LiBldd0rpSJbvzFc2qwCSuSkLdT+lxju7SpMifiy8KOtWWdlvRpJYPyWKqZ9SuiUIMloSw197rZp04uTeajitGpCGbKglzp8ia/dfmB8aFw6LlcETtkapQVpWXTCqmewxBH4IjOL5ksZ4Pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoOKzBnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoOKzBnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773216135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbFfIhSXBrOVq4QWbTUPr93+aENxgGefOo5affMVRAU=;
	b=AoOKzBnB1n/rciLxMc/V9F+CVZOFO1IDbz/4psckuSEXhYohlz7/34ZMME09J/lixHEmCI
	Q9dm86VKWV2KZkZSCMOEpIun8q2h6/zFizVXFMDHyFdsgn7xWRU9phDM3d+NDQLuZlYhHm
	s5v3aUX3lwrkHn4FFlZk1K2YKmm1DrY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-bVhmDFx2PRKVXNgFoG366A-1; Wed, 11 Mar 2026 04:02:14 -0400
X-MC-Unique: bVhmDFx2PRKVXNgFoG366A-1
X-Mimecast-MFC-AGG-ID: bVhmDFx2PRKVXNgFoG366A_1773216133
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853efceaddso24832595e9.3
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 01:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773216132; x=1773820932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbFfIhSXBrOVq4QWbTUPr93+aENxgGefOo5affMVRAU=;
        b=bw3BGmg8Bw7UukDYXeFcQJ4ElhOnrnpuJmJ5sPBemGm3dYyy6yeWEs0XiB1kl3nD3C
         3WdsApbTw13L8RJOnPDQoMDRzhwKOWhtNNK5Q4bJ/cjfayCQZne5+Ha/v2xVgnN5Tflm
         2aNnQW0rVzdlCm5LLf9TTgRaNzOoVt3tnCJEXZq7a/iMBJN2ckm2sJ/zVHL4DQjDBV46
         xYuvXoCRRsAKL4Fbw1c6V0W/2C3JZOdWoiB0v7PAMyuyOGW4NjVvLwUwTWryC+n7QBPh
         1dVCc1ZdCpYhegsBCBakD4Sm4RzI3eyn3+WYnslr3S/DJr3AgB6oK0/knCbRWfj1T9m2
         Nsnw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZvsi+mPdLuicZ1iGQbNsDrdHwI7rsR61pQw/6REel0Tw1AykJp5RBZeeT17Pnm5hnqwEesC8YLDf7dJxuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPZb+fkREv3aOYLTv9WIj4NOV1bqR+gJf26429qIAOX/zdHaF9
	XM7eT8OSaqvBQMlqu/qHRzmOnui+7wSvSbQH5re6xmWmRrTt5sLAvNJeX5+/DxTdhK0lnv008fq
	4QGDKKqdvFRrXswHWM8kfu4azSDsavj8lHQtIFwo79bWcjL7inZFA6Ys1dco5p5jJoHMKm/VaFH
	Eo
X-Gm-Gg: ATEYQzy1WADlYUhGB61YP3skcTWaaf1Kny7G3xiQNh9sGQKuLz5lqplIGl66cGQ0Q/U
	rMPSzKFKCkt90MwmQ1mmhNMOUb7oxbAz2NcF2/1gYUGmoAuuffTJXXZeO9w1M65Bc8azx7kMsdJ
	HFBIrWbd2tXZs1fZVLFcFzOs7dc4LX8sjC3rXW0Imxll7dNw8PZmviCqTiitl7OsTll3DwudwPU
	G5/XoOAd8nmpe3g31H0bT9RDeWLQf3G01gYwyXokcUwvtsECPUkAQ2tocFZuQOumKTosqtiIuds
	WK2NfTreAj8Hr3gWwlYU/NQF1nimnrHL8bOrSzR2EBjJrsLxdLoOQa+MX+0qqqlij9T1Fa4rCpY
	zGwP6AMX71qP2+4R0aYc5NAB4BHfMuwtdiHCCKGPUPPnCCQ==
X-Received: by 2002:a05:600c:3b02:b0:485:3c41:360b with SMTP id 5b1f17b1804b1-4854b14f5aamr22553495e9.35.1773216111618;
        Wed, 11 Mar 2026 01:01:51 -0700 (PDT)
X-Received: by 2002:a05:600c:3b02:b0:485:3c41:360b with SMTP id 5b1f17b1804b1-4854b14f5aamr22533075e9.35.1773216091770;
        Wed, 11 Mar 2026 01:01:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm156352415e9.7.2026.03.11.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:01:30 -0700 (PDT)
Date: Wed, 11 Mar 2026 04:01:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtio_ring: Fix data races in
 virtqueue_enable_cb_delayed_split()
Message-ID: <20260311040009-mutt-send-email-mst@kernel.org>
References: <20260306022448.216131-1-wdhh6@aliyun.com>
 <20260306045629-mutt-send-email-mst@kernel.org>
 <54646.126031023201101239@us-mta-438.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <54646.126031023201101239@us-mta-438.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K4Up7e2ggdfwJesf3ctdIMtS-KvwBWDFXihMT4kNeoU_1773216133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2026 at 11:20:01AM +0800, Chaohai Chen wrote:
> On Fri, Mar 06, 2026 at 05:04:11AM -0500, Michael S. Tsirkin wrote:
> > here's how I would put it:
> > 
> > KCSAN reports .....
> > this is because ....
> > 
> > 
> > This is not a real issue, because ....
> > To disable the KCSAN warning, use READ_ONCE to read vq->split.vring.used->idx.
> > 
> > 
> > 
> > 
> > On Fri, Mar 06, 2026 at 10:24:48AM +0800, Chaohai Chen wrote:
> > > Add READ_ONCE when fetching vq->split.vring.used->idx
> > > without synchronization.
> > 
> > it's with synchronization, of course
> > 
> > > KCSAN detected
> > 
> > detected -> incorrectly reported
> > 
> > > data races when accessing the split virtqueue's
> > > used ring, which is shared memory concurrently accessed by both the CPU
> > > and the virtio device (hypervisor).
> > > 
> > > Example KCSAN report:
> > > 
> > > [  109.277250] ==================================================================
> > > [  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split+0x10f/0x170
> > > 
> > > [  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of 2 bytes by interrupt on cpu 1:
> > > [  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
> > > [  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
> > > [  109.318852]  start_xmit+0x315/0x860 [virtio_net]
> > > [  109.324532]  dev_hard_start_xmit+0x85/0x380
> > > [  109.329993]  sch_direct_xmit+0xd3/0x680
> > > [  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
> > > [  109.340568]  __dev_queue_xmit+0x560/0xe00
> > > [  109.345701]  ip_finish_output2+0x49a/0x9b0
> > > [  109.350743]  __ip_finish_output+0x131/0x250
> > > [  109.355789]  ip_finish_output+0x28/0x180
> > > [  109.360712]  ip_output+0xa0/0x1c0
> > > [  109.365479]  __ip_queue_xmit+0x68d/0x9e0
> > > [  109.370156]  ip_queue_xmit+0x33/0x40
> > > [  109.374783]  __tcp_transmit_skb+0x1703/0x1970
> > > [  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
> > > ...
> > > [  109.499585]  do_idle+0x7a/0xe0
> > > [  109.502979]  cpu_startup_entry+0x25/0x30
> > > [  109.506481]  start_secondary+0x116/0x150
> > > [  109.509930]  common_startup_64+0x13e/0x141
> > > 
> > > [  109.516626] value changed: 0x0029 -> 0x002a
> > > ================================================================================
> > > 
> > > Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> > 
> > 
> > 
> > I'd like to see code size before/after compared, and included in
> > the log. Does this make the compiler's work much harder?
> > 
> I found the code size is the same. And virtio_store_mb() can do sync.
> Perhaps we don't need to modify the code here, but rather fix KCSAN.


I think your patch is useful, thanks! Just pls tweak the commit log,
including my suggestions and mentioning code size is the same,
repost, and it can go in.

Thanks!


-- 
MST

