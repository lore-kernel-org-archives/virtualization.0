Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7025FA00
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356369; cv=none; b=g0IQfJgLn7hzdtyZgDQmciE2TbXTdLhx50NNacJz5FTM6zw4KmA2RnF17V+BAPvEsEdd+ndVfPjzVPNCBdnWzX8U/nvG8kCQnYQfiD4QqaSOQRkqb9Bfb+3zu1radgNiMJD0YJWDkskc6yFaf4ynYw/Yh9wVi5/+z2MKE50nU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356369; c=relaxed/simple;
	bh=iqtTO7BdgSOS0hugcE5p2vfRNGvtKPLOW4//tI8bFOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kBFKrl/4GVlL177cDjD2RrQ6rGKKbBGOVhQFidmCGiFyJZ/FL7wk5isrZsvYZVpKdNRO7IlBqvA/sAPXaR5neI3Nc1huFbt1yt5BM3AuSfovMzV2SbSppDOodHWP66m7La7qfgN9a7qGWhKjOoZPDm+Dqs+MzxwUUfI2K2L4B7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RS3a9aUY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS3a9aUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5W4qfJP5trIgKgYi+NpmwjcNUOZanDpnOGZEn8fp13E=;
	b=RS3a9aUYB+ijGanu5LQ3UWpdEQ9RpQfBIYeCSNYyoL5ji4Sk7pB5r/SvghNHo6o9e35BM9
	IZCT8j/bOBV4ir01Oj2sMlA97tCAqTKqaRvK3GQ6qi9QJ8dUO0lKBfz2XN8rk8vQ2EDXYU
	l7k+Wes8PXQH/yfwG7oHfnBS8ktihpQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-ujJYzWO8MdatwuipYvemUQ-1; Tue, 01 Jul 2025 03:52:45 -0400
X-MC-Unique: ujJYzWO8MdatwuipYvemUQ-1
X-Mimecast-MFC-AGG-ID: ujJYzWO8MdatwuipYvemUQ_1751356364
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1316887f8f.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 00:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356364; x=1751961164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W4qfJP5trIgKgYi+NpmwjcNUOZanDpnOGZEn8fp13E=;
        b=tnQvGkhRVkbQXEcj2BOhWloU8Huja6oNojf74wcZYM8Oc7MloEm+6HnTc3WXIw234f
         1D0+rzK9asy5+b7rZUCIbtOmCysj+rVI9pV5xHbvBIWOx50YixeN19JqkRhwKi590bx0
         nCj0AEGJpVvSyj6DUNGKqtTdySSyAuOQimrXsDQXwGpYiwceUj167AWDxKnlEUhPltNX
         nL24huaTL2PEyyXm15x3u5wX1pE0KS8mPKmpp/nj4E1/aXX8GCfBBZczvVu+SQXBuBC5
         Nsr3ZYZs01FxhoxDgOeGxIuKg293c8GYvpTPV8/YgEHjHMUXigI3/HGCWJzJBCg/IG17
         bUbg==
X-Forwarded-Encrypted: i=1; AJvYcCU8wJP7At2nEFHGsrwJ7g898r56zQUVyrD45oBIncsXI8ssYgf5P32EGwWsP0YhRFiph/0PJe3Pzmn+2h+2Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhwrLORFJPjnUkWdXXwhE1aUdUW8vCcpCCP3O/eQbVAaUqUmQI
	nFG++Fpsl6i0j1ODVB0n8q4sXmp+sJYkBW+AjNGUdtuFAd2ooEfmURRWopju1kBsGBpC5rhC51f
	CMHFtkWR2TtuBaUMPnIikei6RJJGeFxU1LXJtkXMaR6S0YBoVwEyQsy//aaAd9Ht/GHFW
X-Gm-Gg: ASbGncuchLGOhCJZz0mlhStvEhp45wP75QsFXLCQMf7shsUw0m79HOhoTMfYSS9bpLR
	rnUGtwQb8fvlSVVJsfcFmBkaW+TOr/DP9BBY36hAoZgmeRNzmKs95p+aR2puzqImTdW6dbO0wZ6
	gruwT4Ht1bWARx4u+IK9vfYSEDomnkvAHXD0X25x9/BSUpAvo/Et/5NBeyUpaHVgnIJb1ERfXpT
	GkRq8iO3cIOrvsxbbncct6h0PPI66dxjAJcERnd4wUVDBh1+BokIqU7doJpPKs8NNAZAny2M9Hx
	5Qjchuf/nQKuIqSe
X-Received: by 2002:a05:6000:25ca:b0:3a4:ed2f:e82d with SMTP id ffacd0b85a97d-3a8f51c1a81mr12478142f8f.22.1751356364392;
        Tue, 01 Jul 2025 00:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXOoMiKZEJq6ceWK4Q10DrkD7JlKwDdbKrLj6V8anCMySNXNp0lfxDJ0dXtxq9+6g1HirIxw==
X-Received: by 2002:a05:6000:25ca:b0:3a4:ed2f:e82d with SMTP id ffacd0b85a97d-3a8f51c1a81mr12478113f8f.22.1751356363901;
        Tue, 01 Jul 2025 00:52:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a5asm12587008f8f.54.2025.07.01.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:52:43 -0700 (PDT)
Date: Tue, 1 Jul 2025 03:52:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH net] virtio-net: fix a rtnl_lock()
 deadlock during probing
Message-ID: <20250701035110-mutt-send-email-mst@kernel.org>
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
 <20250630103240-mutt-send-email-mst@kernel.org>
 <20250630105328-mutt-send-email-mst@kernel.org>
 <f1f68fbd-e2cf-40c5-a6b8-533cb3ec798f@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1f68fbd-e2cf-40c5-a6b8-533cb3ec798f@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xo4DB9ahiwWql0yxVvyges1I0Sob5WhieKaxnaDVsao_1751356364
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 03:48:41PM +0800, Zigit Zo wrote:
> On 6/30/25 10:54 PM, Michael S. Tsirkin wrote:
> > On Mon, Jun 30, 2025 at 10:50:55AM -0400, Michael S. Tsirkin wrote:
> >> On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
> >>> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> >>> the virtio-net driver is still probing with rtnl_lock() hold, this will
> >>> cause a recursive mutex in netdev_notify_peers().
> >>>
> >>> Fix it by skip acking the annouce in virtnet_config_changed_work() when
> >>> probing. The annouce will still get done when ndo_open() enables the
> >>> virtio_config_driver_enable().
> >>
> >> I am not so sure it will be - while driver is not loaded, device does
> >> not have to send interrupts, and there's no rule I'm aware of that says
> >> we'll get one after DRIVER_OK.
> 
> Yep, at first we're thinking that when the VIRTIO_NET_S_ANNOUNCE flag set,
> we can always assure an interrupt has fired by VMM, to notify the driver
> to do the announcement.
> 
> But later we realized that the S_ANNOUNCE flag can be sent before the
> driver's probing, and for QEMU seems to set the status flag regardless of
> whether driver is ready, so the problem you're talking still may happens.
> >> How about, we instead just schedule the work to do it later?I'm not sure if scheduling the work later will break df28de7b0050, the work
> was being scheduled before that commit, and we have no much idea of why that
> commit removes the schedule_work, we just keep it for safe...

Well managing async things is always tricky. Direct call is safer.
If you reintroduce it, you need to audit all call paths for safely.


> Then, for plan A, we change the check_announce to schedule_announce, and if
> that's true, we do another schedule_work to call virtnet_config_changed_work
> again to finish the announcement, like
> 
> 	if (v & VIRTIO_NET_S_ANNOUNCE) {
> 		if (unlikely(schedule_announce))
> 			schedule_work(&vi->config_work);
> 		else {
> 			netdev_notify_peers(vi->dev);
> 			virtnet_ack_link_announce(vi);
> 		}
> 	}
> 
> >>
> >> Also, there is another bug here.
> >> If ndo_open did not run, we actually should not send any announcements.
> >>
> >> Do we care if carrier on is set on probe or on open?
> >> If not, let's just defer this to ndo_open?
> > 
> > Hmm yes I think we do, device is visible to userspace is it not?
> > 
> > Hmm.  We can keep the announce bit set in vi->status and on open, check
> > it and then schedule a work to do the announcement.
> 
> Okay, so there's a plan B, we save the bit and re-check it in ndo_open, like
> 
> 	/* __virtnet_config_changed_work() */
> 	if (v & VIRTIO_NET_S_ANNOUNCE) {
> 		vi->status |= VIRTIO_NET_S_ANNOUNCE;
> 		if (unlikely(!check_announce))
> 			goto check_link;
> 
> 		netdev_notify_peers(vi->dev);
> 		virtnet_ack_link_announce(vi);
> 		vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
> 	}
> 
> 	/* virtnet_open() */
> 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> 		if (vi->status & VIRTIO_NET_S_LINK_UP)
> 			netif_carrier_on(vi->dev);
> 		if
> 		if (vi->status & VIRTIO_NET_S_ANNOUNCE)
> 			schedule_work(&vi->config_work);
> 		virtio_config_driver_enable(vi->vdev);
> 	}
> 
> This is a dirty demo, any ideas are welcomed :)
> 
> (I think in virtnet_open() we can make the S_LINK_UP being scheduled as well?)

