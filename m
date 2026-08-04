Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAE43849B
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836745; cv=none; b=M5wAAoSFAHMElbnjz+EJvU14NEWub2c+wT0yvfTGyJWXOn+e+CTTtyoT2ORdea1cYcV3Blo+v66VdN+MkxeCqhQLnXduqUxIuGpeEOgYRiBGA6+L6QXMLbW7SDoYV3M5HNeQAVz820vM3yTEAGEfiXXUQeDHGkAtMIfFrmr0Fz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836745; c=relaxed/simple;
	bh=dDky39zYJMrArXt7rlDyNBxmEhWZ3ij1bJVMuJuX4U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aCZ/re419ErYH9tKb8J7wJ8nlQeviYVq6J/iwZn4nunM/6GoYSX5ONCWk/XY9qhUkqvJqzgmVtuINGpZxEzSg5T5ycrXLvNW6kWyG0lsHiH+yKqZq55yFD3pr/iEPFnlDWckFqqS7IpRK8ypdoyTGnu5fM16YlY76xPLSWbfeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpWWbeDZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpWWbeDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785836740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0Vr+6epLbEBl+Ut6IFtBIqkvpbRQNZ+42wTzBOY/ns=;
	b=KpWWbeDZ7ndT/xceTwb2ePCjmoR6aisDDPnJPkJlEpybhDHe4COnCOxxOSy1Lcq1Q74cJs
	oUgbljMWaXHKORjr03jEI16bceeKHg3NPZUyukxImU1PpEUJWutgBAH32zb4v7HopwHeIh
	HyMBgTz+9ZFcrq8QlMZOF5ao8EtNhq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-mNU81ZABOO-0mWhLAhLogQ-1; Tue, 04 Aug 2026 05:45:39 -0400
X-MC-Unique: mNU81ZABOO-0mWhLAhLogQ-1
X-Mimecast-MFC-AGG-ID: mNU81ZABOO-0mWhLAhLogQ_1785836738
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-474170b59dfso2484011f8f.3
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 02:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836738; x=1786441538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0Vr+6epLbEBl+Ut6IFtBIqkvpbRQNZ+42wTzBOY/ns=;
        b=ZwhzuPUPdug3gFsf68Fu2zWJeKQ4vmYwvkLz1d+rxN0XnMHHHkvOYpp1JQueAg6aXR
         fIiz82cxnFBllG+/2RsN3zg3EuWkGKtgnI5bTg/42WHFDmDBjpbZAWdiX3jKpXtIqi2t
         idgQ5nezAiNjGzuvmXn21n/EGPDktmn8jHirA/RrNIQXDrhI9xU6HRLNG0yt7Lz0vkj3
         LBHfy9hq1k6HDbOSFE1IkgBOZGUvs64KV45T4TMSzuFOWlir0rnZqDvnQGLZzLSC/AfS
         HBVERN3GsMWTb128lbbEUa1wMT9QHK+g968XapT7XLpOCfpuNKPotBtq96KrPZ0BVVZV
         OhjA==
X-Forwarded-Encrypted: i=1; AHgh+RrOa32sxWYpLuloMypUftEF2ROIwAxVtmJ2Id1pnCpRMHuiX2wawBW8utWSs3q4BF5ODws2mlZLv/Lf+Mxsqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCXdNpX2EphT5CPxnyWes19IJsvk9R2y+gMhOPAO2T63/9n+CZ
	OPYheVHITGENYcVTg2tvqum60+9RNU+tE7cSCTL0kZKglwt4HSqdoh315VGPuHrH3XG7O43+fcw
	PbirYGy1D74MNKKhZJI9qUdL6gTpRIdXPEkuwc8OsFEQAB/R6B+vQt6IANzEZhrym0ZbF
X-Gm-Gg: AR+sD11xvsC1o+YQLve7Awb3t+Ug7SretSIATHBSs1A+ZFn0S0rG3Dw8HMwGJnfV+Sa
	DnHZfpD2bZYF21NiS2A1jszhprLmbJwwXivhV8OmOT+e/f54/5hChVIfiZS4kGSTSxzyVdMUMX2
	Wy6WR0RAtX5fl5841UDwvbo3S106+ktnfBhjZmk+v4JctQxtcPFg9esr1y72M1kge8BKVfhHcIt
	W5wAGRJH7UTjUO/4yUoMYufP3VmgKwawE7VFYse8/pF0N/QCE0BgUBs+X9zjxRXQhNat1DyUKDR
	J6i4vigbc2WLSmMWa3i1vO4i+jQdQCC90vZYeM+pn70qUoAD0e2vsI+kg3z6rjDXv5mbcjXbKof
	lT7Y=
X-Received: by 2002:a05:6000:1886:b0:47f:b622:fcd2 with SMTP id ffacd0b85a97d-47fd72bef88mr33977911f8f.25.1785836738273;
        Tue, 04 Aug 2026 02:45:38 -0700 (PDT)
X-Received: by 2002:a05:6000:1886:b0:47f:b622:fcd2 with SMTP id ffacd0b85a97d-47fd72bef88mr33977826f8f.25.1785836737765;
        Tue, 04 Aug 2026 02:45:37 -0700 (PDT)
Received: from sgarzare-redhat ([5.11.104.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm40802768f8f.5.2026.08.04.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:45:37 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:45:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v3 0/2] vsock/virtio: fix worker access after virtqueue
 teardown
Message-ID: <anG0WA8cvB_TnPbZ@sgarzare-redhat>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OhEiRCQSWbr8oV5NmZm3Iut-DpdJfy1MgkWhyzXjffQ_1785836738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 29, 2026 at 12:16:53PM -0700, Weiming Shi wrote:
>Virtio-vsock workers can remain queued while freeze deletes the
>virtqueues.  This series prevents workers delayed across freeze and
>restore from retaining pointers to deleted queues, and prevents the RX
>worker from refilling its queue after teardown.
>
>Changes in v3:
>- Resend the series with proper email threading; no code changes.
>
>Changes in v2:
>- Split the worker pointer changes from the RX refill fix because they
>  fix different commits.
>- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
>- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
>- Use the suggested out_nofill label when rx_run is clear.

Thanks, it's already queued but sice you fixed all my comments, just for 
record:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

