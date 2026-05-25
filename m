Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E62382F3C
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712933; cv=none; b=gryGBQg9bp4cMKdiACQAHwyKTiySfh9kKfpFoZs0dmLRAdp5/G2Q5MdNTRQMwXfkeQk7fWyu3kRI3ZZW//c6pT/qYXpVpwdvCoU3PBBGF41O7C+YDtSFPeAn7AKOIr5Tgzae25i0ZljxV/lP+5URvwOm8SOT5SJDtgS7Bnys8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712933; c=relaxed/simple;
	bh=nBZFB/qKiQFEmkpum3LmDBV+XZABkX4tDlOB6EU6g/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Srfj9e+sfHNMZhBXGATqaDm/seotuHMV1LyjbgcAFsfSdoTC99+nQHEUw3Cgj0XZkg0L2iiYRmt13d1CGG46+KXFBT11sOGKb4kBfo7qG1I3MmE5jZEQYGKRTSyTdXeIt+4DN+ouBzuMSCBwQ8f1QIrWYhT9ZROR7aGZ+Eusmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTN933g0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTN933g0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779712931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
	b=CTN933g0PicMHAtX1r+j9tF11/02fbvRdsudimsr9pDXTWhKE0NWgI6QsTcSNkl1yAeWHI
	84v4yl53E+5BPKZlf67AbmfwggLwTR+dwbAbl8srFxpZhVqtskBX36WYTDDQ95X9lLEvqQ
	hEJh15+FCYYVgRkd+vXCuE4iLGi5Zds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-lWhi9B7KPK6aswqbQ7iB0w-1; Mon, 25 May 2026 08:42:07 -0400
X-MC-Unique: lWhi9B7KPK6aswqbQ7iB0w-1
X-Mimecast-MFC-AGG-ID: lWhi9B7KPK6aswqbQ7iB0w_1779712926
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-447f2ce5556so7153350f8f.2
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 05:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779712926; x=1780317726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2mO9ihHPbnXM6c2+MtWPyD/ZxOr74sqrY+NK7spw+c=;
        b=M8fbmyjXOqGO2t9MmQ8eFFZG0NQ8kwlWc/w6y8dziII3h/Wr2RKPpNxzvlmX/s4HyL
         gMW01IcDlwsWOgrZFRZNSvB28Hcb91uRJRnSTc9mzVNmMtFwgf8ywh4yNSbLT6kJkV/K
         WY2Cn4KGPur0MlecRKewnkLXSd193eqL6mrYKvCNd+fOAaCauW1bDN0nKth50lUgrGjx
         qAYnVid/RcjuO6ib+1luRbGgYj094mDLzvMCJt9aeO4/SjGPFM0PL8irCK9DR7t31ZCG
         VVBI9r00ArtyBi579LPjOPi3DrYPORBEuLT/mKhZoa6KXhYAN82VJ6T9knIgLUQfRC/0
         KuhA==
X-Forwarded-Encrypted: i=1; AFNElJ85KbL+ONcGkkfyJuJRDH1ybsEumEY6NuhCoh8NyV1/cjKvIhnXQjkCebNPVv3GpmbjDHshxo+m/RpeE8IZNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxap930IEbgCqgTU74TwdcGegKqdpIFiApe6vjx1lgG8h9866QT
	LJUUKMsDtdvqBbbRlh4TBDL53dNBTaVeYCIHeAryp5Fg7cta9cJH8C9SEpR4+aB5P+IIwS3XDTn
	PLYkeUq3hW34GZzH7Frt950n1p/XtLaRim5F+FT3Oztlbz8bK1soajk8UPiFQUZcIZWqn
X-Gm-Gg: Acq92OH0axVgG+YVdQp8iF0ShXeXh51VFgiOvo5Z98gT+xRjZTnz+RNN/pLnipprtbr
	V5rCtvQsdn1BFzDHgp3YXkNPMaOP1msrDsCxkbkuruQZ5i08bLVw/G8zYjjsLC7KGJgU2fg0q2j
	x6QJwFcH052OHqyyNuVVJpEdBAbGWxpMUTu1bSCCY9B4KY5O7k5sYkTgGMarR4TeYjSMp1ebkvu
	EsAzuQHFTX/bR9NG3Ur07rdhFBiZYPOPHL+71rkNYFq+57PAN39rWesejH+QzshPqgK/UUoY6GW
	NAwBPlj9wsf0aN8Uh1KDBz6p2zrHa82XaY3gvvgzabMMEwTCF/mB1f17S3b9kbT+rRwourNsjbd
	oyc/hYCezfDZNlgUdNML6f0ldF7qG09jbefZyaxqdGQoxjvNtI6X8HA==
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr23325982f8f.17.1779712925862;
        Mon, 25 May 2026 05:42:05 -0700 (PDT)
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr23325918f8f.17.1779712925385;
        Mon, 25 May 2026 05:42:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4850dsm25575281f8f.17.2026.05.25.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:42:04 -0700 (PDT)
Date: Mon, 25 May 2026 08:42:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, horms@kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
	pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
	stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525083859-mutt-send-email-mst@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260525115314.3cf310e6@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 36WQtO4urh-h0WL6DSCqfbfwiVGPtdak7OQcVmhBx7I_1779712926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
> On Mon, 25 May 2026 11:57:45 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
> > >On Sat, 23 May 2026 02:20:29 +0000
> > >patchwork-bot+netdevbpf@kernel.org wrote:
> > >  
> > >> Hello:
> > >>
> > >> This patch was applied to netdev/net.git (main)
> > >> by Jakub Kicinski <kuba@kernel.org>:  
> > >
> > >Did anyone else notice that is isn't a bug?
> > >
> > >There is no way that a 'count of bytes of kernel memory' can overflow
> > >the size of 'long'.  
> > 
> > It's more of an estimate than an actual calculation of memory usage if 
> > we queue the incoming packet. In theory, an overflow could occur if the 
> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
> > the memory should run out before we get to that check.
> 
> The calculation is:
> 
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0); 
> 
> skb_queue_len() will be the number of items on the queue.
> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
> 
> Unless you either corrupt the queue length or manage to allocate skb that use
> less than the minimum about of memory that product can't overflow 'unsigned long'.
> 
> The later calculations might wrap - but the multiply can't.
> 
> -- David


Indeed, I wasn't thinking. For this to even get close to overflowing
we'd have to have almost all of 4G available to the 32 bit kernel taken
up by this single queue.

Revert, I'd say.

> > 
> > Thanks,
> > Stefano
> > 
> > >
> > >-- David
> > >  
> > >>
> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:  
> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
> > >> >
> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> > >> > to 32-bit values. The multiplication can overflow before being assigned to
> > >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> > >> >
> > >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> > >> > 64-bit arithmetic.
> > >> >
> > >> > [...]  
> > >>
> > >> Here is the summary with links:
> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> > >>
> > >> You are awesome, thank you!  
> > >  
> > 

