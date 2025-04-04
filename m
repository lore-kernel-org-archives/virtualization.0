Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AC1A23A9
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755382; cv=none; b=ml2dqg0FDsqRe6SSbJIjlMuRdUuaLSxu0vA6BHnXnvIoGYXrzAmjQmm7ET25P68c82W8LVO7iC1/yPmFZmxITTsqGHb9qYsy8AmWLxkqZjLLyZYL8AKIa2zJn/zAJBsETkuBUz0KjItB0XKHNyhegDkBDXqTl9Z4RVpNRHuFJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755382; c=relaxed/simple;
	bh=e1FSULY5KvnOwyIVIx9HUIgr9X/BcL5fROFXUFNAlac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ri0q+nKwICWgPfyIR+yC/SZIhrUuK2+9Vn9bO9q1NFsCkbS//5y3+Q5poLEuyVAiooCQPJ+J9rFtnskJpKft3KuKnMlfiBv26Jqb+ceN5w7q2GvJKM0Elyz61AyOTE+5JJuGf5Ygzlciidd3kUSZYSOYmIpbXjhxv9Iq5dl3NbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xk4y+VAQ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk4y+VAQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96B5E40C01
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 08:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lENwylxclod for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 08:29:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9520D40BCD
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9520D40BCD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xk4y+VAQ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9520D40BCD
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YWsT0d4jRBoSmkqfsRAr3G4OSF/rm5hMiqgTWy5/Z4=;
	b=Xk4y+VAQwbTZKyA3syYsjMJ6VgIap4TgwdmV9EkOpbY8gfPhkl3JykVqvOltFJ/TSxYDNk
	QqypO/Opy0cqkLjxzAosco5LYma4Kip3Ia9hGYz/TLNQa8sHJZiIXGa6Q+fbaxGlC35NXO
	9xH07IVccnfupRu72YO6bSBK/SJVLcc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-3Tq_RfjvMluYOrr1GzPsxA-1; Fri, 04 Apr 2025 04:29:36 -0400
X-MC-Unique: 3Tq_RfjvMluYOrr1GzPsxA-1
X-Mimecast-MFC-AGG-ID: 3Tq_RfjvMluYOrr1GzPsxA_1743755375
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so9943715e9.0
        for <virtualization@lists.linux-foundation.org>; Fri, 04 Apr 2025 01:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755375; x=1744360175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YWsT0d4jRBoSmkqfsRAr3G4OSF/rm5hMiqgTWy5/Z4=;
        b=AxfppgL20nP5aiN1ZrgnBWVJH765C1RsDy7wHJnIPFQNJGtULlB8rvBiq+zg6ssjlP
         XE/NrOrimoRWSMMmq/YZmJt8zyzY45CdTvpEPR/MJvbJgj/EiWpDJbE6CpRdLepCr3yx
         L1DGmIMmSIteZXzLpF5R8qKKZ2uYb6gNXNruddf+5n8vW+wG7SFe0Lq8/043Ev7W7E92
         G9dVe56ik37p84u1qhYSN3q04TOuMubWyEQiF/WmwqimpSkckZNLn16byZW4Z9/Q6Qma
         eYFtRZ0zfB/DVF6iMcTlK2PL4cBo+Ozxm6i3fG/306rGClp/o6V7czUkNiJbRLH9FPhd
         B2xQ==
X-Gm-Message-State: AOJu0YykmcgbB01hrKwnU8chWD8TjLVY60XDZ/H8BqSnEP0/xa7zG15w
	GPP+JuZIuNoI/CTIbtaJg7dbXf8+82TAAdf+ocdnOQYXHH4WUVThg40X4gSxMrLNnAUZHPz+QFm
	tJepr0OIpJheor95orzQ1xCydl8KTvvAu4/ZT8kFq2CP84JPUvPtpF4Hjz/ruwTEPFHc8UdnP0e
	8mYR4=
X-Gm-Gg: ASbGncuY5KwRnM8dBeJkUWiCJc8wtQekztBWO9BC+dQ9EOh30OH4JA8a96b5WXRwjwb
	FhiCu2oI3Hot++gwGFOdzzqLlooP04iYVUIAZtyG8+3mudWPgONewwTPlDR1wotQRdPWCC5Cfwy
	BQfCUn/GkgNZ7c2B6uyxD4KjqY0JZTQaeVuV+C4Vj/CwQbIomtxojZTgR/1+kSAMJzHGSFKb3g8
	O4XUYIWumSguApw9dd2GyDTV7+17eJO7N2Dlhfo6EMXVYOapgnovcbK49ytHBSKogH9gEkzfUmP
	YHmspb9QMw==
X-Received: by 2002:a05:6000:144f:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-39d0de3b210mr1674688f8f.33.1743755374650;
        Fri, 04 Apr 2025 01:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnYsRndkAe+SDCxu/OU7SkDG2ml903xm0A48L5uKmulL1m95vbIvM9r/KA5itpPLalSiFVUQ==
X-Received: by 2002:a05:6000:144f:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-39d0de3b210mr1674658f8f.33.1743755374142;
        Fri, 04 Apr 2025 01:29:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bbc64sm39017415e9.21.2025.04.04.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:29:33 -0700 (PDT)
Date: Fri, 4 Apr 2025 04:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250404042711-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eweKNabErgJ0Oa7HMcoVM6gTPGKym4v4zShF8-JIgkk_1743755375
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
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
> I added the following printk inside virtio_net_hdr_to_skb():
> 
>     if (skb_transport_offset(skb) < nh_min_len){
>         printk(KERN_INFO "virtio_net: 3 drop, transport_offset=%u,
> nh_min_len=%u\n",
>                skb_transport_offset(skb), nh_min_len);
>         return -EINVAL;
>     }
> 
> Built and installed the kernel, then triggered a large download via:
> 
>     wget http://speedtest.belwue.net/10G
> 
> Relevant output from `dmesg -w`:
> 
> [   57.327943] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.428942] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.428962] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.553068] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.553088] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.576678] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.618438] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.618453] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.703077] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.823072] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.891982] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   57.946190] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  
> [   58.218686] virtio_net: 3 drop, transport_offset=34, nh_min_len=40  

Hmm indeed. And what about these values?
                u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
                u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
                u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
print them too?



> I would now do the test with commit
> 49d14b54a527289d09a9480f214b8c586322310a and commit
> 49d14b54a527289d09a9480f214b8c586322310a~1
> 

Worth checking though it seems likely now the hypervisor is doing weird
things. what kind of backend is it? qemu? tun? vhost-user? vhost-net?

-- 
MST

