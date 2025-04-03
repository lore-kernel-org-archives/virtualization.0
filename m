Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F7207A15
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714374; cv=none; b=rj0C019JLu/k5WML+TUoQwKX4eP4YW7kFXqDsgGXhxph+eRJRxAMtrPM8G8ERtl85+8iua1lNJOn9Q9WrycmB8/hMk1lyarK7Y8HxcuHEvmNMcT3/6IUqVJgmN/GwvrOxY4bIU/MTBgCNtITfzISvIykKlJs/1KGoCUZxk+Qz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714374; c=relaxed/simple;
	bh=gJ5wrIvReAv5QqxtqNCJ9FujkFKj0dFoDyjRW8MTRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BuZzf4rWhQSrNe0C2wHx7lDlgcawS7MDm/UaMInYGeiOOr3h1S9uJocKMtzRcjCismcE778HT4PmuZk/nLbynQrywCxGQiQk8iSKb3capDKDntXQS2pN3f2DdAyX0KHmR0QpAU4o05qZNAzjsNs4K8y39se/27smrJqf6PxgY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKoUdlKs; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKoUdlKs"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF3A441E16
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 21:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ms76WuM3opOw for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 21:06:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 87B5B41A53
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87B5B41A53
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKoUdlKs
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87B5B41A53
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743714368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQPSgYV8xh79P5dCNHj8YipiJGf0W9F/2BqM6SXAVZc=;
	b=GKoUdlKshdKsThZbK5zOqZbl78Sjg3Ump3tG/GZlZdXFRr3vXK/J5CxnyIbwzm74Plcipd
	YVayzEU+FPjYZ7IBTKW3CYFmFyau1i5KgYHzzNQ0kqLjrXQmj8g/ViB98boDrRS4oBJQZU
	sNQs5Lm8AyVXOKgkmTLRWUC5lGbB0wk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-VCazH3MIN3qKx_FLuAcZGw-1; Thu, 03 Apr 2025 17:06:06 -0400
X-MC-Unique: VCazH3MIN3qKx_FLuAcZGw-1
X-Mimecast-MFC-AGG-ID: VCazH3MIN3qKx_FLuAcZGw_1743714366
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so7742725e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 03 Apr 2025 14:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714365; x=1744319165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQPSgYV8xh79P5dCNHj8YipiJGf0W9F/2BqM6SXAVZc=;
        b=u3EXRqx2Lsy5conYVm67hpT+XW+VhWZczcFVdIB4VysHHhryNgS+A0r7t3irusdU/j
         VFdtBJykN0eYMXOawUUYUJ6/8/W2vtIy8qTGbtWwQc1sVGX8wYnyuyivhZJHNZJt6Cee
         sjXJDM3p+lVeRB8fj7iahbsYOCgWrxvAHPdozvsw+HJZEx6wPTVdQVQeOQqluEGVpxLe
         Q8uJwcknY0rPJpRpHOfYdYuo343YHrbW/b9xpvvbFXbg7piaDl4dTBoDzo2VwHaQNsbL
         N9oS0lZG+wTsMYVR9zQrRzBVk86Oi2ruWG4bWtKdEDFLwcOn60OHO27WuRfgsVTSL2XU
         T4Og==
X-Gm-Message-State: AOJu0Yy7G8jQEkGarS3nwfmZyLXBhmA0wgd3PpD1gB/niu20PRJmM9qA
	J36Goe06hFXJD8DnFik0kCWCtDyOkSk6a21L20r7csdLDo1EvDOUJoidHg8Ml3b15t76cMVfr/T
	XQvuCN5DFuyn+Wg7x8PUK1dk4wdQ9zcRWIYvUvuUYrrwVXskXzyS64BoIjDSgEpejhwKKl6z8i0
	sh5jU=
X-Gm-Gg: ASbGncsDVF36REVngyjnOGLJGpox6kR/cbewkcAudsjF/PfkKyF6YeBVqT2HuBXrnuB
	mXJhxRr3dgmhhwy2Cp6VyTYfToHUEckMXe1n6ZRsrggkuvlSxc0CFYbDwCguvqRgQxZQwqDrfbM
	Herw3YPM3ko/lPdzeUDYY7W3DioqreUf7nXiZlrUT/mvD9XnCcKMz4xOFLlESGkNG+fiAvqnIVJ
	XrvCxjOtD8JXAoUcybkJSaeuOPQFT86UdjdLeou/YUqyUPwE6yug/SEpc9G8mXMMl6nPiJxySI5
	VzkAS2wJUg==
X-Received: by 2002:a05:600c:4695:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-43ed0db3646mr1629465e9.28.1743714365523;
        Thu, 03 Apr 2025 14:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIXS5hwbzfgThNhAktLRgRbRw/FEpi7tWXoj6bda4No5E7hvlK67fZzMkXDe5GScLwGcYoA==
X-Received: by 2002:a05:600c:4695:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-43ed0db3646mr1629325e9.28.1743714365119;
        Thu, 03 Apr 2025 14:06:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226da7sm2788385f8f.98.2025.04.03.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:06:04 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:06:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250403170543-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
 <20250403100206-mutt-send-email-mst@kernel.org>
 <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _JNfzYELZAw-QKALrtsXwTuiBmzGQyOMoeQeEK5r6L0_1743714366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 03, 2025 at 10:07:12PM +0200, Markus Fohrer wrote:
> Am Donnerstag, dem 03.04.2025 um 10:03 -0400 schrieb Michael S.
> Tsirkin:
> > On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > Tsirkin:
> > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > > Hi,
> > > > > 
> > > > > I'm observing a significant performance regression in KVM guest
> > > > > VMs
> > > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > > > 
> > > > > When running on a host system equipped with a Broadcom
> > > > > NetXtreme-E
> > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > > > > guest drops to 100–200 KB/s. The same guest configuration
> > > > > performs
> > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > > > > moved to a host with Intel NICs.
> > > > > 
> > > > > Test environment:
> > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > - Guest: Linux with virtio-net interface
> > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > level)
> > > > > - CPU: AMD EPYC
> > > > > - Storage: virtio-scsi
> > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > bottlenecks)
> > > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > > 
> > > > > This issue is not present:
> > > > > - On 6.8.0 
> > > > > - On hosts with Intel NICs (same VM config)
> > > > > 
> > > > > I have bisected the issue to the following upstream commit:
> > > > > 
> > > > >   49d14b54a527 ("virtio-net: Suppress tx timeout warning for
> > > > > small
> > > > > tx")
> > > > >   https://git.kernel.org/linus/49d14b54a527
> > > > 
> > > > Thanks a lot for the info!
> > > > 
> > > > 
> > > > both the link and commit point at:
> > > > 
> > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:   Thu Sep 26 16:58:36 2024 +0000
> > > > 
> > > >     net: test for not too small csum_start in
> > > > virtio_net_hdr_to_skb()
> > > >     
> > > > 
> > > > is this what you mean?
> > > > 
> > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > warning
> > > > for small tx"
> > > > 
> > > > 
> > > > 
> > > > > Reverting this commit restores normal network performance in
> > > > > affected guest VMs.
> > > > > 
> > > > > I’m happy to provide more data or assist with testing a
> > > > > potential
> > > > > fix.
> > > > > 
> > > > > Thanks,
> > > > > Markus Fohrer
> > > > 
> > > > 
> > > > Thanks! First I think it's worth checking what is the setup, e.g.
> > > > which offloads are enabled.
> > > > Besides that, I'd start by seeing what's doing on. Assuming I'm
> > > > right
> > > > about
> > > > Eric's patch:
> > > > 
> > > > diff --git a/include/linux/virtio_net.h
> > > > b/include/linux/virtio_net.h
> > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -103,8 +103,10 @@ static inline int
> > > > virtio_net_hdr_to_skb(struct
> > > > sk_buff *skb,
> > > >  
> > > >  		if (!skb_partial_csum_set(skb, start, off))
> > > >  			return -EINVAL;
> > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > +			return -EINVAL;
> > > >  
> > > > -		nh_min_len = max_t(u32, nh_min_len,
> > > > skb_transport_offset(skb));
> > > > +		nh_min_len = skb_transport_offset(skb);
> > > >  		p_off = nh_min_len + thlen;
> > > >  		if (!pskb_may_pull(skb, p_off))
> > > >  			return -EINVAL;
> > > > 
> > > > 
> > > > sticking a printk before return -EINVAL to show the offset and
> > > > nh_min_len
> > > > would be a good 1st step. Thanks!
> > > > 
> > > 
> > > 
> > > Hi Eric,
> > > 
> > > thanks a lot for the quick response — and yes, you're absolutely
> > > right.
> > > 
> > > Apologies for the confusion: I mistakenly wrote the wrong commit
> > > description in my initial mail.
> > > 
> > > The correct commit is indeed:
> > > 
> > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Thu Sep 26 16:58:36 2024 +0000
> > > 
> > >     net: test for not too small csum_start in
> > > virtio_net_hdr_to_skb()
> > > 
> > > This is the one I bisected and which causes the performance
> > > regression
> > > in my environment.
> > > 
> > > Thanks again,
> > > Markus
> > 
> > 
> > I'm not Eric but good to know.
> > Alright, so I would start with the two items: device features and
> > printk.
> > 
> 
> as requested, here’s the device/feature information from the guest
> running kernel 6.14 (mainline):
> 
> Interface: ens18
> 
> ethtool -i ens18:
> driver: virtio_net
> version: 1.0.0
> firmware-version: 
> expansion-rom-version: 
> bus-info: 0000:00:12.0
> supports-statistics: yes
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> 
> 
> ethtool -k ens18:
> Features for ens18:
> rx-checksumming: on [fixed]
> tx-checksumming: on
> 	tx-checksum-ipv4: off [fixed]
> 	tx-checksum-ip-generic: on
> 	tx-checksum-ipv6: off [fixed]
> 	tx-checksum-fcoe-crc: off [fixed]
> 	tx-checksum-sctp: off [fixed]
> scatter-gather: on
> 	tx-scatter-gather: on
> 	tx-scatter-gather-fraglist: off [fixed]
> tcp-segmentation-offload: on
> 	tx-tcp-segmentation: on
> 	tx-tcp-ecn-segmentation: on
> 	tx-tcp-mangleid-segmentation: off
> 	tx-tcp6-segmentation: on
> generic-segmentation-offload: on
> generic-receive-offload: on
> large-receive-offload: off [fixed]
> rx-vlan-offload: off [fixed]
> tx-vlan-offload: off [fixed]
> ntuple-filters: off [fixed]
> receive-hashing: off [fixed]
> highdma: on [fixed]
> rx-vlan-filter: on [fixed]
> vlan-challenged: off [fixed]
> tx-gso-robust: on [fixed]
> tx-fcoe-segmentation: off [fixed]
> tx-gre-segmentation: off [fixed]
> tx-gre-csum-segmentation: off [fixed]
> tx-ipxip4-segmentation: off [fixed]
> tx-ipxip6-segmentation: off [fixed]
> tx-udp_tnl-segmentation: off [fixed]
> tx-udp_tnl-csum-segmentation: off [fixed]
> tx-gso-partial: off [fixed]
> tx-tunnel-remcsum-segmentation: off [fixed]
> tx-sctp-segmentation: off [fixed]
> tx-esp-segmentation: off [fixed]
> tx-udp-segmentation: off
> tx-gso-list: off [fixed]
> tx-nocache-copy: off
> loopback: off [fixed]
> rx-fcs: off [fixed]
> rx-all: off [fixed]
> tx-vlan-stag-hw-insert: off [fixed]
> rx-vlan-stag-hw-parse: off [fixed]
> rx-vlan-stag-filter: off [fixed]
> l2-fwd-offload: off [fixed]
> hw-tc-offload: off [fixed]
> esp-hw-offload: off [fixed]
> esp-tx-csum-hw-offload: off [fixed]
> rx-udp_tunnel-port-offload: off [fixed]
> tls-hw-tx-offload: off [fixed]
> tls-hw-rx-offload: off [fixed]
> rx-gro-hw: on
> tls-hw-record: off [fixed]
> rx-gro-list: off
> macsec-hw-offload: off [fixed]
> rx-udp-gro-forwarding: off
> hsr-tag-ins-offload: off [fixed]
> hsr-tag-rm-offload: off [fixed]
> hsr-fwd-offload: off [fixed]
> hsr-dup-offload: off [fixed]
> 
> ethtool ens18:
> Settings for ens18:
> 	Supported ports: [  ]
> 	Supported link modes:   Not reported
> 	Supported pause frame use: No
> 	Supports auto-negotiation: No
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  Not reported
> 	Advertised pause frame use: No
> 	Advertised auto-negotiation: No
> 	Advertised FEC modes: Not reported
> 	Speed: Unknown!
> 	Duplex: Unknown! (255)
> 	Auto-negotiation: off
> 	Port: Other
> 	PHYAD: 0
> 	Transceiver: internal
> netlink error: Operation not permitted
> 	Link detected: yes
> 
> 
> Kernel log (journalctl -k):
> Apr 03 19:50:37 kb-test.allod.com kernel: virtio_scsi virtio2: 4/0/0
> default/read/poll queues  
> Apr 03 19:50:37 kb-test.allod.com kernel: virtio_net virtio1 ens18:
> renamed from eth0
> 
> Let me know if you’d like comparison data from kernel 6.11 or any
> additional tests


I think let's redo bisect first then I will suggest which traces to add.

