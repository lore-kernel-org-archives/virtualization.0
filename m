Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434D283FC8
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357460; cv=none; b=p8YqQNj0KZM//Tlh6IY/OPIeNvBlTUbznmNLjWlsRk4lONMhow6X/gvKjWfmOqtd8uk30I3cx7vxk3mNn8I5L3DKx8VeviJJ79xR84IN30K+5IAZuvXJE6EvsVXm6CPbXs0a67eWlfz0Qu0P3tqlnK085eW5nBES33wA8zoXuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357460; c=relaxed/simple;
	bh=UNHgjoyZ51ap8r7LImW5vtuU+H0nsCJC9r+s/D3IjEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I+SweDrgK6LinUsenmgLGweiX0GoGEQVyImN+/xUl1WmoILReDtQ8ROVXKE5KnzdzVBNDGWwKnXfzwlvfeg9BLUNU1ZKR5Xi8gcmGpnen9cYnkcYyQYJ1kZIxB+uZbdfNeRmsij15poi3Chd/fPr9/gN1AIW1P+KID3rcdwwaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5vjsSGi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5vjsSGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765357451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0KS117F+NgZYtcjzFELlU2meRxc1l3OK/LGflnMPek=;
	b=Z5vjsSGi4ZsUWl0N2N3ApjfT22lDIifsK+D4JNc5bK5YBHLfvShN8mYvV5U2CmiVPKaDUw
	QYKbqYyo0X1jAMUZQPWlIpgb0V1qFAVqR1X7IGX7oIoYtBLWvH7NwmHIiMZs/3GRY357qX
	CkyJq/RHI4y3hkEJa/xiBL8TZKOk+M0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-OsVDG5KUMDu8JBHoQrlCMA-1; Wed, 10 Dec 2025 04:04:10 -0500
X-MC-Unique: OsVDG5KUMDu8JBHoQrlCMA-1
X-Mimecast-MFC-AGG-ID: OsVDG5KUMDu8JBHoQrlCMA_1765357449
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so41641565e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 01:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357449; x=1765962249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0KS117F+NgZYtcjzFELlU2meRxc1l3OK/LGflnMPek=;
        b=KJeMnb3BU9JabBeKEP0M25Wnx6wRiuKD9ntWOi27pxr+C27HbZDxa1xchZeN0pZ2Ot
         lVmvOk9XcnoqkZEpxkDjy3wB4K6GKrJXM6fyRsYNVgaZQowRNstpkrD3TfkWCPSCeZCI
         Kwn7MLboyt4oJVBjIlXOj2emJdhzGdcbfeAru0UghoCCfTQl8/KayoQkuGaU3TUdX1oL
         cvw/Q/q2ta0Q5jqXfzkD1p4SyRljB7OcNn3WiA/9qrTq0npYoRze3Un0lpxVbtP7QrJA
         YDvXHrYjV/dgYRXi4tNjJtsdgyvZ9tkEjUxa6XoyyGZa/NZ6UvE6sA1U3rG8EAPB87RR
         uODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA7+AjW8NsC68J8dHfCmFSpNY96wUzgH2yuFu98IMfJky4Ft1kPyEfUGOLT2fgph+5pxaXMkPWfL9XYPtgCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyvwmt3YGdMBHTvaPHjY3hqF6T/p5YKS33SiuPhPbgo6pQLbx8T
	wikIULD5s6qKPM/7Fnl1ELFJHYKcRxSom14HBsM7PPximTwW1DiKCv0BtQux0lTLShhYdZzcDGw
	mOVHmett0iPQrSiG4CKlfVLmTbfKeDBd9tlYiZ+r4bQHPr6ZEeispE8AO8raKNpKplZDEw+Ycq+
	eI
X-Gm-Gg: ASbGncunuH/81TGWn+CsW9+xJq16dmqWbSwADUMWIV9nYcmO6JbYiG6PGXuRBBiUze6
	N5GsGdSXEYLnz5RylroVJGF6DDEIgcoDbSvo83P4/txUTQ7kV7PWp5h2U8gMQonfk9e2sl6wzUF
	EO451a0Ew/IADwaJOfZwy+cfDWMEp6QUoIIuB4flWvA4rC8Fy4aUPSeOhUtoR0wV64bzsAiLvH6
	Am/qB5oW/25D+UxPpjxPoD6X8rlJPPoNpQMuy2bp/kzZ1DJW5lEmnj+XrAjXnxd1oYWh7NK/qpI
	Qg2WmeVIOV8lwcKAizOLTu8DkH8VaJ4763Wjy3A8EttvXWlExto+/0Fpu4XfS2wgYt7WwuPjkMN
	QI+yip6HGHUADjnEltf/1fa+5nJOZLRs=
X-Received: by 2002:a05:600c:630c:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47a83790ca0mr15961455e9.18.1765357448824;
        Wed, 10 Dec 2025 01:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkJWPS5T7QgdeqCYGMDb4AL3a/D2vtdNJ/uuectRC03LK+ryXFkocwvXLr7qAIGdU/n0hAOQ==
X-Received: by 2002:a05:600c:630c:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47a83790ca0mr15961015e9.18.1765357448381;
        Wed, 10 Dec 2025 01:04:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-33-27.inter.net.il. [80.230.33.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d935d4sm33633575e9.15.2025.12.10.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 01:04:06 -0800 (PST)
Date: Wed, 10 Dec 2025 04:04:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
Message-ID: <20251210040328-mutt-send-email-mst@kernel.org>
References: <20251127032407.33475-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251127032407.33475-1-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NT-V4bpl6wVq99yjyb3-rFyp3KCl7EF2eA2k-4ZHD4E_1765357449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> From: Tang Longjun <tanglongjun@kylinos.cn>
> 
> hi,
> virtnet_mon is used to monitor the data packets of the virtio_net driver 
> and the related parameters of virtqueue, useful for tracking its status 
> and troubleshooting faults.
> 
> pls review. tks
> 
> Best regard.

what does this achieve that direct use of tracing would not?

> Tang Longjun (7):
>   tools/virtio/virtnet_mon: create misc driver for virtnet_mon
>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
>   tools/virtio/virtnet_mon: add kprobe start_xmit
>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_done
>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> 
>  tools/virtio/virtnet_mon/Makefile      |   10 +
>  tools/virtio/virtnet_mon/README        |   35 +
>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 ++++++++++++++++++++++++
>  3 files changed, 1093 insertions(+)
>  create mode 100644 tools/virtio/virtnet_mon/Makefile
>  create mode 100644 tools/virtio/virtnet_mon/README
>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> 
> -- 
> 2.43.0

