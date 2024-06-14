Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC50EAE4
	for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376013; cv=none; b=ngC49eaQQfGeCqhJog2UPTatve/dPagAqGXdQquwhDO/N93XaqW4YJ0vjJXc8EnfcYPPj4Hq5V7b48hQFpeuB2CZgLhCWGyu2nyEyWp1QXzdQkVf5Q6PhsaGTXulZ4K7zeLz/eiC6n98047YVFpCaBejVVQg2FKJAssCGq3mdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376013; c=relaxed/simple;
	bh=V+j0eTBGfNMTjfAN5fGbwz4kgOLveZl9pdrHD3yNXXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QaG+g2t6mG3nCqn7m4E/gcSVnfT28ArRwrTwf9lmfIt5yKY0KN7IAe7tq89lISWj1iiWZ2Pf7/BOW7NB25LsxIFexZS764QZVs5cW6tpkPLhT4OnG/DYN5kbBdISdZggD11yZ0dgLIypczG1b0Zd0qEalCkX4+iQb24fFOuN5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJftpeaU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJftpeaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718376011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qt5NcoDJbY+6/rjcnHVm1O4k+qFDbB1MVLu9nqhSjFs=;
	b=YJftpeaU95fEI+KyXSthC50JQTqHHzfhggwykE1/tZo4GSH4ezD32crAe/+9g7kmMS2iYw
	XJ1o6/hwLM3U5y9HWXK69XmX5bNvqLB4jJNC1h/d4meGcrS1Rrn+ptDb2KOYt2A+jkkewy
	cdKQRPK/dxHJhcPugN5vWLZlQ34rLRY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-xOfDPADtOcyK9CDBhLKTQQ-1; Fri, 14 Jun 2024 10:40:10 -0400
X-MC-Unique: xOfDPADtOcyK9CDBhLKTQQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c82e67810so1756908e87.3
        for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 07:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376008; x=1718980808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt5NcoDJbY+6/rjcnHVm1O4k+qFDbB1MVLu9nqhSjFs=;
        b=eafl241RDsHBnsonIuapHCg9ixNSyvpcIO96OlfLSy7vpKOlJL0hPXge6kdBzxxu2f
         ZMJlG2AGvgLvCldAZwzT7GG/Ylp/wGhUWCc/GnYyXJK33VyBA//vspQ5OqIyzJZra2ai
         tpu7R00I5WoIGmRkhZeZBVovBXsy8HHNXOIyrdKxMp/sYsRWU6UlnEaRiR6dy44j13OP
         IACZ7Ikeb7pX2Cftw152+TrF69Ey++34/6jaSSzKGuw2ZlXE5W1S6hOWYcFE1lIBCETo
         2YSO2d2atiXAzGD1OXvUVaVPoEyaz93TlbWEPDre8ggpOAZ4ehDxOgygLPQhcflyGZ0f
         EB0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMPiawqXIrbZZhqhwkv/undK9PHEXdJeou48SszKKEn+69AS2Ld9B7ziSU/WVR2ZlB34IwAzY1WNyzsKwuT3fp0dF+pRC8RHcMMBCLTxk=
X-Gm-Message-State: AOJu0YxFuTIsQ0M4AYX25B5NU+VCVW8rnm+zsMmgQ9D8ufMN7NkgFOqV
	aOOTqPx0F3YQJGi2B6wmlai6/YJvcazrrhMWnqYs5TAls6fk/IozpuTkHIED7eOOO+xo+Hf0vJ3
	MV8HaHxw+Gc/vpyeZhIiDylGYJG2qXbiaeOh1JN55jPoKvk4mZaWOeuNW7SO8nwRr
X-Received: by 2002:a19:e014:0:b0:52c:98b1:36d9 with SMTP id 2adb3069b0e04-52ca6e9da28mr2241962e87.62.1718376008744;
        Fri, 14 Jun 2024 07:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX3v8Wn+67KK53vRvZL7N4S0NTRO/vH3/5y85IBEbKT1mz68C2tnhNAWikvnfX+3y8Ft3XvQ==
X-Received: by 2002:a19:e014:0:b0:52c:98b1:36d9 with SMTP id 2adb3069b0e04-52ca6e9da28mr2241946e87.62.1718376008400;
        Fri, 14 Jun 2024 07:40:08 -0700 (PDT)
Received: from sgarzare-redhat ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed39ddsm196069566b.142.2024.06.14.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:40:07 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:40:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, 
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next 0/2] vsock: avoid queuing on workqueue if
 possible
Message-ID: <mfhi5is5533xyt4nlbpifrg6mpx3rye4n4vfg736irsae5tfx6@2aiorapp2uos>
References: <AS2P194MB2170EB1827729FB1666311FA9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AS2P194MB2170EB1827729FB1666311FA9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 14, 2024 at 03:55:41PM GMT, Luigi Leonardi wrote:
>This patch series introduces an optimization for vsock/virtio to reduce latency:
>When the guest sends a packet to the host, and the workqueue is empty,
>if there is enough space, the packet is put directly in the virtqueue.

Thanks for working on this!!

I left few small comments.
I'm at DevConf this weekend, so I'll do a better review and some testing
next week.

Stefano

>
>The first one contains some code refactoring.
>More details and some performance tests in the second patch.
>
>Marco Pinna (2):
>  vsock/virtio: refactor virtio_transport_send_pkt_work
>  vsock/virtio: avoid enqueue packets when work queue is empty
>
> net/vmw_vsock/virtio_transport.c | 166 +++++++++++++++++++------------
> 1 file changed, 104 insertions(+), 62 deletions(-)
>
>-- 
>2.45.2
>

