Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DE24113D
	for <virtualization@lists.linux.dev>; Sat, 16 Aug 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340480; cv=none; b=QlpGGPIH0rxYn9CCSdj8k6ajW0xjqheQEKaAgh7Owt3/EbpgJSTOToAPG5kv+3+KWx2zZkORxydvx/bg/xWdMDpuie7zDKnmPbmPN6F4llzEGaebR3MhSeLZz/qyVYX3YrFFMMwDOxuphMB4RzPBx/WipLVt+ks8Jsd/KaFmm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340480; c=relaxed/simple;
	bh=t9nsA9xxppfh4GuaSr2En7HWIUYMTE5nS0V7EiLZoKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ub9zwXdIV7l0ybEFVC+rw7rEWa5wNE4llvJqwvXXatC1cVWdjD5ySOvWvurZUgQufGI8MFholYLLSB0WQ5H1QmQ6KRrX8jCqHSHRN9t12cVYCAXNDL/bdRdIOGdLACPB7p5vPcLlk8Th/Cq6eZepzM9w7PhtF2X0/e8n5HLptHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMyeqhKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMyeqhKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755340477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbxBMAjshEeD1LlV1sadxP05g9sf1GmiKcl0uerjKR0=;
	b=aMyeqhKZiZNZLPd9u4pCo4NZE5UGbLtyztvqGmaFKab8sRiYSbiji+o4LZgR7+6wD8gHC6
	t/Xax3HczqyOT9bqbLJOXJq0Wr4bQdx7EGZyuRqz95uwPRrkGyQzHHQK2QMuTbgvdE7VQc
	Xu2IM4Tf5JpXM9BgtykhmwWilEiq760=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-fwcwjAlCMYiAPWUMlMJl1w-1; Sat, 16 Aug 2025 06:34:36 -0400
X-MC-Unique: fwcwjAlCMYiAPWUMlMJl1w-1
X-Mimecast-MFC-AGG-ID: fwcwjAlCMYiAPWUMlMJl1w_1755340475
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e418aab7so1400683f8f.3
        for <virtualization@lists.linux.dev>; Sat, 16 Aug 2025 03:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340474; x=1755945274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbxBMAjshEeD1LlV1sadxP05g9sf1GmiKcl0uerjKR0=;
        b=aieAsCJ6HeX5i+kabyqSmFtR30Liw7o/PGE7w33wbsNXoCOsBAmzLjyHYM2lpQr+Ev
         xlvMcKh7UTHep6eP6rk3tv379GVocAVMsDdDi1NK2yPIKk7nmV6zo/vy48wFGdTzbPsN
         5g0uVM+9a6aIfAkj0tQxiKfhKjNfYcmpZi08e3f2Eka9XgGugykXwhJ7SRBpsWwRPg5r
         X9GpOqORlRFuPs1bJtwMe/FzPokIWd1NOgzVW0J/sqgaVeB5iDAG2ZXPCBefizhA1ofL
         Tmhf52thxBkhJECALprdDEYZYtt87fdYaGJSIb6MqJoDFLswpbbJT+iFEHbHnLZJNvvM
         7CJA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4zY/+zRnb8qSkzomNbFCS4+FfL41QQ2dYp099tp4ZbChge5AhuIdqbB5u6Yzjb+zsky/Er5M+9iBm8eM4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxM/lFN20NY3gGr9wIEE1fzHXDK2uJhG5BEh6if+HzAdIZdDpRz
	lrc3tV848S6QsbU2tvNL4unU2gBqVHtOYh+yAV/WLun8xhhvck39KReBelfevVWhF68aVg62zkR
	bAqh3ZjrD+M1RfLYcYMRywCpptXv1Wm+bSCSRmHWLwd/0h33OzAsVOxdUjCV7yMcw+QLJ
X-Gm-Gg: ASbGncun+HOZxLEc5uA4TYUpn0TWMzQw3PpMLQSpgwPwcff2qtLw1mZqJflMkq/WpLK
	/x4EO15sMH5rjSc4UoBZK2Q43aqZM3TZygvuHY4taTjhDCjV65LKMSuBlzzNfoUJCRelqTd4uUb
	EXGA1LkaLAdDpSCufxJiOmcu63nhqx/092J/kU/LL/7Ke9sG36047cskA9MH89lfb3WMAc+gaVk
	xlJ+kMaMipZrCIVD/8WcSDTxo5AvPu8QUg/5LKxyOv51gQ6OA8NtfVETMpyJD27t5mLFs1KDxnJ
	FPVDjM4nX72QN9t67QEZ+rsManlf4pzNy+4=
X-Received: by 2002:a05:6000:24c4:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3bc694261a0mr1550451f8f.25.1755340473677;
        Sat, 16 Aug 2025 03:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvMJVoF0MSZh9zb0Y1qco87mCLOaf2fgKACdvLYKV1i5IJWFVtigfJ0ROFghywjQv+IIbDVg==
X-Received: by 2002:a05:6000:24c4:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3bc694261a0mr1550435f8f.25.1755340473295;
        Sat, 16 Aug 2025 03:34:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d307cfsm5175627f8f.18.2025.08.16.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:34:32 -0700 (PDT)
Date: Sat, 16 Aug 2025 06:34:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in
 virtio_transport_send_pkt_info
Message-ID: <20250816063301-mutt-send-email-mst@kernel.org>
References: <20250812052645-mutt-send-email-mst@kernel.org>
 <689b1156.050a0220.7f033.011c.GAE@google.com>
 <20250812061425-mutt-send-email-mst@kernel.org>
 <aJ8HVCbE-fIoS1U4@willie-the-truck>
 <20250815063140-mutt-send-email-mst@kernel.org>
 <aJ8heyq4-RtJAPyI@willie-the-truck>
 <aJ9WsFovkgZM3z09@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aJ9WsFovkgZM3z09@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nEKxStWoiOIk2f7MqT185-O_bi5FaHpajGXSXYoAFFA_1755340475
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 04:48:00PM +0100, Will Deacon wrote:
> On Fri, Aug 15, 2025 at 01:00:59PM +0100, Will Deacon wrote:
> > On Fri, Aug 15, 2025 at 06:44:47AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Aug 15, 2025 at 11:09:24AM +0100, Will Deacon wrote:
> > > > On Tue, Aug 12, 2025 at 06:15:46AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Aug 12, 2025 at 03:03:02AM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > > WARNING in virtio_transport_send_pkt_info
> > > > > 
> > > > > OK so the issue triggers on
> > > > > commit 6693731487a8145a9b039bc983d77edc47693855
> > > > > Author: Will Deacon <will@kernel.org>
> > > > > Date:   Thu Jul 17 10:01:16 2025 +0100
> > > > > 
> > > > >     vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
> > > > >     
> > > > > 
> > > > > but does not trigger on:
> > > > > 
> > > > > commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d
> > > > > Author: Will Deacon <will@kernel.org>
> > > > > Date:   Thu Jul 17 10:01:15 2025 +0100
> > > > > 
> > > > >     vsock/virtio: Rename virtio_vsock_skb_rx_put()
> > > > >     
> > > > > 
> > > > > 
> > > > > Will, I suspect your patch merely uncovers a latent bug
> > > > > in zero copy handling elsewhere.
> > 
> > I'm still looking at this, but I'm not sure zero-copy is the right place
> > to focus on.
> > 
> > The bisected patch 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs
> > for handling large transmit buffers") only has two hunks. The first is
> > for the non-zcopy case and the latter is a no-op for zcopy, as
> > skb_len == VIRTIO_VSOCK_SKB_HEADROOM and so we end up with a linear SKB
> > regardless.
> 
> It's looking like this is caused by moving from memcpy_from_msg() to
> skb_copy_datagram_from_iter(), which is necessary to handle non-linear
> SKBs correctly.
> 
> In the case of failure (i.e. faulting on the source and returning
> -EFAULT), memcpy_from_msg() rewinds the message iterator whereas
> skb_copy_datagram_from_iter() does not. If we have previously managed to
> transmit some of the packet, then I think
> virtio_transport_send_pkt_info() can end up returning a positive "bytes
> written" error code and the caller will call it again. If we've advanced
> the message iterator, then this can end up with the reported warning if
> we run out of input data.
> 
> As a hack (see below), I tried rewinding the iterator in the error path
> of skb_copy_datagram_from_iter() but I'm not sure whether other callers
> would be happy with that. If not, then we could save/restore the
> iterator state in virtio_transport_fill_skb() if the copy fails. Or we
> could add a variant of skb_copy_datagram_from_iter(), say
> skb_copy_datagram_from_iter_full(), which has the rewind behaviour.
> 
> What do you think?
> 
> Will

It is, at least, self-contained. I don't much like hacking around
it in virtio_transport_fill_skb. If your patch isn't acceptable,
skb_copy_datagram_from_iter_full seem like a better approach, I think.


> --->8
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 94cc4705e91d..62e44ab136b7 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -551,7 +551,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
>  				 int len)
>  {
>  	int start = skb_headlen(skb);
> -	int i, copy = start - offset;
> +	int i, copy = start - offset, start_off = offset;
>  	struct sk_buff *frag_iter;
>  
>  	/* Copy header. */
> @@ -614,6 +614,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
>  		return 0;
>  
>  fault:
> +	iov_iter_revert(from, offset - start_off);
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL(skb_copy_datagram_from_iter);

