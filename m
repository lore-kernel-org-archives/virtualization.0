Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B624EAA1
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688996; cv=none; b=LYbkcB3ETcqLNHS0thET3II298uPxCwHPga9VgQtM9qooIIUYdmNq2HgcdHEUhJe7MGCzRVDXXaLebghancUlBPHbOOsmmYxoM5qlVbzUDQXpIhOR2BmO6V3c6SF1BtSNuKc1farN00sTw2cSma4FClNSCM87UZ/SxBu/3dB69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688996; c=relaxed/simple;
	bh=PLIry9I5MN5+p97bRNx+HoFhgLJY0z5+1qZUMALAcao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S6bjSv4KeSvjUc85qu9/sNaTX4KC2+ryo6ZJ0P4r9MNyof2lrroG2vdk85olUZbmMMEHSg89VV8lDeA9EmYF4iKlPJzJcZfnEIrMv8SGEQJ0kYS5WQSOv3CqpiTHlsOu0ZYH5GBAtmvDCfftC18sY/rrvLXLeor0hl3Z3iPEoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHrkdbz9; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHrkdbz9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29E68419CD
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 14:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glU0gfhhRuqP for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 14:03:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3ABF8412B4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3ABF8412B4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QHrkdbz9
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3ABF8412B4
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WBThcQneZqddzRwqfMjSBi+IuLp0YfEk4vsedSbljI=;
	b=QHrkdbz9EH0rkLbUJNLilqo0NWelASc77EzLP8YHhUG7tEVVGPG9zkK6bZMj/Fk9Dh5lPk
	Bo3fgJUihyY5vJ2JAJeADRtAErlfmjgyObpEKmrnskuNVaC5Vwej1pc/bqQ2+uWuz4f+it
	L1Cop9X7QDE9SYvGRrMxzimEvhczNtY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-9Wbc4aKmNWWP2W3YoAqi4A-1; Thu, 03 Apr 2025 10:03:11 -0400
X-MC-Unique: 9Wbc4aKmNWWP2W3YoAqi4A-1
X-Mimecast-MFC-AGG-ID: 9Wbc4aKmNWWP2W3YoAqi4A_1743688990
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39130f02631so399838f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 03 Apr 2025 07:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688990; x=1744293790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WBThcQneZqddzRwqfMjSBi+IuLp0YfEk4vsedSbljI=;
        b=lJLeKP1FSMZ3n8F/dHgKy23wIBlq7IQ14cbdR5jJX3z8/rV4Jl+DrpTK4tMzRSyWAD
         9Cs2xOKoXwCJ2XdvHpzEDAMfrrE1y0719ajjvKsr9xnU4VvkHkzMNNhDg80JwsT+PC/W
         7fgbTFMd+2SIQ8B9Tlizo5WIK2ZULnUq3F+TwW0L7NXp++XJbQrSWdC0A8jCrAtqbOFR
         m0zWfw0uO/kpW4BRV1ycbpmIKqwtPM8zcydh/k29n0wEBxn9JnK3XQiW8T2KP05xPygw
         s03SKWvhTn46ihPFsnXXDKJaWvQ0nuZtiiqDWNf9OFKUiZzC8BTYu5hdoNT7lFKLdYZA
         YGaw==
X-Gm-Message-State: AOJu0Yy84SbpU7pNQ43yfREFlw+H3KskGf7m8E365MI8M/A920+XwEyF
	AF1BsWj/qkFoJMv1OuwTA+0PFeSmPpGQNeCwpnnsXeK6gcIqtAZZ1orp5dl8Z9M/foMVic+JM1F
	8o1LGpLbgXjT00YuH/2qwaZWtYExYq/Zkz1yRDiKxGZbp0CWZjtPhl7HfRR0lfI5gzo54cGjsCb
	ceHMs=
X-Gm-Gg: ASbGncv0TFRcAh6l63NOEg5hZXIDLpaK55olx8uZicu1SYlT4mNmu74VZAYKpEvwwaS
	CVsFyAJR6vKvPQOIdhHgyjyqx3S3szqQOzCfnNJ/PDasXuu04eauv/fHHWzsbjrzCQRUtqEXnk0
	fGuktCJwQnThRgjhq4hbNSrEluacWzhc0crJ/CRC04xm/sy9MRvFR1MA040cjgPY36Ftfg0CKGI
	Bjec4Kb7/Ry4M+1SiHsVWzi1hoXUjWUWoOyPBNWiLfLw2/9wFMQfgLyYOJPPDb/51VvZMkS0v4/
	FBUxQcRGYA==
X-Received: by 2002:a05:6000:250e:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39c30338008mr2275598f8f.25.1743688990035;
        Thu, 03 Apr 2025 07:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC2+/8ybqHkABA5XplMD4M48h+miairALBzMuE16io0YC/ba6y7OVR2eUT30wn6NDVL3wRjQ==
X-Received: by 2002:a05:6000:250e:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39c30338008mr2275550f8f.25.1743688989617;
        Thu, 03 Apr 2025 07:03:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea9a88b70sm44441485e9.3.2025.04.03.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:03:09 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:03:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250403100206-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qVqvJE4wC0VlArB0cFG2a08D-EEyxxerp78RnbZtlsU_1743688990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> Tsirkin:
> > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > Hi,
> > > 
> > > I'm observing a significant performance regression in KVM guest VMs
> > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > 
> > > When running on a host system equipped with a Broadcom NetXtreme-E
> > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > > guest drops to 100–200 KB/s. The same guest configuration performs
> > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > > moved to a host with Intel NICs.
> > > 
> > > Test environment:
> > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > - Guest: Linux with virtio-net interface
> > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level)
> > > - CPU: AMD EPYC
> > > - Storage: virtio-scsi
> > > - VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
> > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > 
> > > This issue is not present:
> > > - On 6.8.0 
> > > - On hosts with Intel NICs (same VM config)
> > > 
> > > I have bisected the issue to the following upstream commit:
> > > 
> > >   49d14b54a527 ("virtio-net: Suppress tx timeout warning for small
> > > tx")
> > >   https://git.kernel.org/linus/49d14b54a527
> > 
> > Thanks a lot for the info!
> > 
> > 
> > both the link and commit point at:
> > 
> > commit 49d14b54a527289d09a9480f214b8c586322310a
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Sep 26 16:58:36 2024 +0000
> > 
> >     net: test for not too small csum_start in virtio_net_hdr_to_skb()
> >     
> > 
> > is this what you mean?
> > 
> > I don't know which commit is "virtio-net: Suppress tx timeout warning
> > for small tx"
> > 
> > 
> > 
> > > Reverting this commit restores normal network performance in
> > > affected guest VMs.
> > > 
> > > I’m happy to provide more data or assist with testing a potential
> > > fix.
> > > 
> > > Thanks,
> > > Markus Fohrer
> > 
> > 
> > Thanks! First I think it's worth checking what is the setup, e.g.
> > which offloads are enabled.
> > Besides that, I'd start by seeing what's doing on. Assuming I'm right
> > about
> > Eric's patch:
> > 
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 276ca543ef44d8..02a9f4dc594d02 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct
> > sk_buff *skb,
> >  
> >  		if (!skb_partial_csum_set(skb, start, off))
> >  			return -EINVAL;
> > +		if (skb_transport_offset(skb) < nh_min_len)
> > +			return -EINVAL;
> >  
> > -		nh_min_len = max_t(u32, nh_min_len,
> > skb_transport_offset(skb));
> > +		nh_min_len = skb_transport_offset(skb);
> >  		p_off = nh_min_len + thlen;
> >  		if (!pskb_may_pull(skb, p_off))
> >  			return -EINVAL;
> > 
> > 
> > sticking a printk before return -EINVAL to show the offset and
> > nh_min_len
> > would be a good 1st step. Thanks!
> > 
> 
> 
> Hi Eric,
> 
> thanks a lot for the quick response — and yes, you're absolutely right.
> 
> Apologies for the confusion: I mistakenly wrote the wrong commit
> description in my initial mail.
> 
> The correct commit is indeed:
> 
> commit 49d14b54a527289d09a9480f214b8c586322310a
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Sep 26 16:58:36 2024 +0000
> 
>     net: test for not too small csum_start in virtio_net_hdr_to_skb()
> 
> This is the one I bisected and which causes the performance regression
> in my environment.
> 
> Thanks again,
> Markus


I'm not Eric but good to know.
Alright, so I would start with the two items: device features and
printk.

-- 
MST

