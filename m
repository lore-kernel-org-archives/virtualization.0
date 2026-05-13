Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D763AE18F
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674258; cv=none; b=kIJXyQCsPgHn4svXrIvV1zeVzKdLnZpPl1zsimlAq28Z5SCu9OKNnkhDx5jEr0UMjs81hFcTMlnnnhg+qG6L6aravCe4JYwbEFd2zfq4nZ9PKu7Na4I2Tfe80lrgtg4F3ywr8f9ZIt7F4fU4oYqDZfcUtJlTvA2ZaqpMGOgKjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674258; c=relaxed/simple;
	bh=qag4HZBEbOWMfveLQJydGBeg4Xk2bclkDFncWGVkdvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gsf0drT6Xl5qZRZql4nNRzJSQFV1CbovL8oFbT1iR9fiAC0qf23CIvtMqKithIFgux/XYQX288Z7MuISAv0Rc7d37uR3vlNTK/VDCsjWXGxMsjC/za/NlPNuQyCJFV+YRVTSRsFpwq8mPLDQ1yac8XrHucWYZrLA9dUSVNHVR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gntlgRt6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gntlgRt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778674256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvNsaPUwi394bBOCZmbGOFCLqPIJOdPpc1dHADKfuI8=;
	b=gntlgRt66zhea31DsN45b28zVrrkqZeEdrahCJ9LSNQC029gLYtW03o0deAbN4OCmNUOZz
	Z/mX3FaoPA/xXgRWo5WQTOmPhpxPfwPMN3avrufh2QWYPTEo8C+ZyUJ/FkbXMTTCBsxjkY
	kvF+98enlDs/y8FkMcrsWM6W3/oy/Vs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-G7CAvYM0OIi35XwBC4Ruag-1; Wed, 13 May 2026 08:10:55 -0400
X-MC-Unique: G7CAvYM0OIi35XwBC4Ruag-1
X-Mimecast-MFC-AGG-ID: G7CAvYM0OIi35XwBC4Ruag_1778674254
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44f56d5523eso5504978f8f.1
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 05:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674254; x=1779279054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvNsaPUwi394bBOCZmbGOFCLqPIJOdPpc1dHADKfuI8=;
        b=d7LC/f1v4enhesq8i5OyNXqYisIH1ankxMvb4i+IovU6zods70sTUVOERhdbvWj6O8
         3e3Q6vA4MEj7up05aV94341+/NsptWDrJxycEFmH2ab/jmWDReqBle8r7LJ3aji9BZXs
         w3LnVfwEbYSzsbKScoOxytdACClLfxQHe1R8Toy4JSDD3c0rEkdb7ohCXkNr0xLIwnAw
         87RGE3Xn522CphVMK9+tAQpCtWc17u9vmXR63JJY/IrS7j/xvQvQcZd9PMx1i/DpAery
         OjWYPRzSVanDwcB2KKpbuxRgbxE/n3yuc7PAttvqaxPGwxyUlGwz6+K+mNRt2vSkp2li
         n0Yw==
X-Forwarded-Encrypted: i=1; AFNElJ9k3pNQL8JSEK86o5kiZd7tuybGFkB8STeKRxvNq77Z8E7IeZJPZvz6Rrv+RaN8Mi80duY4Z75uqKJQMpYiSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8efVUKclWOVW1gefLn3Ojz/WQ5BeptUDWPmvv7XB5skbcd4VS
	JRmlqxmrgJK0BVYndRNh2lpD5G/aHCmKTZ5iMbfuS41Dje5HCoO9wL1v429oIVGDdXWWU/53zfP
	jhapvPmchm5KxcaiW3vzre/OnclGnmKNyRM4OB64zcXRjWlDhWJxtRmqnfeDxRGffIrI3
X-Gm-Gg: Acq92OH+nMA2h3rvTLthb/Y/EknM/Mt8cVCfW8QNhfU/vJQMmD27KwdXLdDNedTcQCm
	mm04rEBRlwduR6ocqb8zenCvMfRUEzvzciRv16cS0m+W76R1TDFdSETEVmx4Z2gv6SlLddtTN9H
	UROY0qdKlEf/rMegTQ+0j63cXj3P9W6vkI9EYrQh6sySqKThfV+6h5pW6eRDJWEkoeRrZGVLZYL
	kQAB/vqw/SSuAmsPGhyCuqe0exQKrjBr38gdW/aJZnS79XlQ5jXmHirj0m+u05TGO3Q8/DIo+yM
	rVgpFlzMSBHVGDxrRwSd+EO2kxZsoYAw7Cugsmq2YFa1DqjXVtNoWHV0DIq0gIET8RXZhXVjFCj
	zu0rP7JUl+GE5eVaF7+vuArpUY2vI6K0B5OGR0uVt
X-Received: by 2002:a05:6000:1847:b0:455:4288:6c34 with SMTP id ffacd0b85a97d-45c5a0b17bfmr4742596f8f.24.1778674253705;
        Wed, 13 May 2026 05:10:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1847:b0:455:4288:6c34 with SMTP id ffacd0b85a97d-45c5a0b17bfmr4742485f8f.24.1778674252920;
        Wed, 13 May 2026 05:10:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45cb1489594sm3997592f8f.5.2026.05.13.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:10:52 -0700 (PDT)
Date: Wed, 13 May 2026 08:10:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
Message-ID: <20260513080456-mutt-send-email-mst@kernel.org>
References: <20260413034046-mutt-send-email-mst@kernel.org>
 <20260413100013.32399-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260413100013.32399-1-guojinhui.liam@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9eZqmkdKvaIZushlzPypDGl3Qqvm8xCPA1cdbQ0toG8_1778674254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 06:00:13PM +0800, Jinhui Guo wrote:
> On Mon, Apr 13, 2026 at 03:45:20 -0400, "Michael S. Tsirkin" wrote:
> > GFP_ATOMIC allocations can and will fail. If using them, one must
> > retry, not just propagate failures.
> > Or just switch admin_vq->lock to a mutex?
> 
> Hi Michael,
> 
> Thank you for the review.
> 
> Regarding the suggestion to switch admin_vq->lock to a mutex:
> 
> The virtqueue callback vp_modern_avq_done() holds admin_vq->lock and
> runs in an interrupt handler context, making it impractical to replace
> the spinlock with a mutex directly.
> 
> I considered deferring the completion to a workqueue so we could safely
> use a mutex, but since this is a bug fix destined for stable@vger.kernel.org,
> doing so would introduce significant code churn (e.g., handling INIT_WORK,
> cancel_work_sync during cleanup, etc.) and increase the risk for backports.



This is not how we do kernel development here. Please fix the bug
upstream first then we will consider backporting strategies.



> Therefore, using GFP_ATOMIC with the existing spinlock seems to be the most
> minimal and safest approach for a fix.
> 
> However, just replacing GFP_KERNEL with GFP_ATOMIC isn't entirely safe
> because of how virtqueue_add_sgs() handles allocation failures. If kmalloc()
> fails under memory pressure with GFP_ATOMIC, the function falls back to using
> direct descriptors. If there are not enough free direct descriptors, it
> ultimately returns -ENOSPC.
> 
> In the current code, -ENOSPC is handled with a busy loop:
> 
> if (ret == -ENOSPC) {
> 	spin_unlock_irqrestore(&admin_vq->lock, flags);
> 	cpu_relax();
> 	goto again;
> }
> 
> If the -ENOSPC is actually caused by a GFP_ATOMIC allocation failure under
> memory pressure, this cpu_relax() loop will never yield the CPU to memory
> reclaim mechanisms (like kswapd), potentially leading to a soft lockup.
> 
> To properly handle both actual queue-full conditions and GFP_ATOMIC failures,
> I propose replacing cpu_relax() with a sleep (e.g., usleep_range(10, 100)).
> This allows memory reclaim to run while we wait.
> 
> I plan to send out a v2 patch with this modification:
> 
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -101,11 +101,11 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>                 return -EIO;
> 
>         spin_lock_irqsave(&admin_vq->lock, flags);
> -       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> +       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
>         if (ret < 0) {
>                 if (ret == -ENOSPC) {
>                         spin_unlock_irqrestore(&admin_vq->lock, flags);
> -                       cpu_relax();
> +                       usleep_range(10, 100);
>                         goto again;
>                 }
>                 goto unlock_err;
> 
> Does this approach align with your expectations for the fix?
> 
> Thanks,
> Jinhui

Nope.

I think we need to get out of peephole mode where we are just looking
at the warnings and "fix" them by 1 line tweaks and actually analyze the
codepaths. GFP is just for indirect allocations and VQ already
falls back to using direct when that fails.

The question is:
- what is going on with VQ ring state, can we actually get into a situation
  where indirect would succeed but direct fails?
- how can callers either prevent failures or get notified when buffers
  have been used?

And it is quite possible that the fix in the end is exactly your v1 but
with the analysis in the commit log explaining why this fixes the
problem and does not paper over it.

-- 
MST

