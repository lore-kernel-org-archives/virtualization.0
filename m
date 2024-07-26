Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72323A8
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978994; cv=none; b=VIP2IBb9Wgen72jRHWSi/myhMb9YaP0miFzds8Y/bxk6BFLoWRjSQ7j9y0qZhUm7YhI+nJQBu63vCcMZSLBmoFXlgd9XoLCmCSCLNiovizGDjGpx2XyEgZPP7dNkaoNCq2CtJYMiPknxjalxHSo5x8TKki4s2LFk5mdNrCrA2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978994; c=relaxed/simple;
	bh=UybNjeFZ1+FCrRiUfxH6aEuVkaSExTf6GEfaolg4r7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KujRi0THOWP2n5BImbUKtVE4HhY1hnEj+2my+1Mnxx3FmsxZI4g1sfMs/LU62wZ24U+6xgJq1oA9wreubS6MPVmwabfZnCaTMQ9H0F63gbfT0LxOpspVMtdA4J6Zj8kwGTLJVT5xZoWLsyXAcYUqVPhD1VO6sk7XRHGIP9qsIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTh4ARdV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTh4ARdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721978991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YlUUMETLR2dsXu/4gZO1W5F3Bqvvn+M4ImfPPlpjd8=;
	b=gTh4ARdVupYU5WxGnw6ZeLJ0IgqS1HgqIDqeZJsYEwWUjfstQdsz/+dcy5gdKPN3uRF/AR
	sf5Vb9dM+GSyDmFEZtlNLjrqpwwlMQTDNd9vM/0xyalhAY8+iaXvRrwpYlDyTPUdG3EG/z
	am7nqZ4AmwsLmujQ2CViRXc3Oz8IyqQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-NcJhHz4SNmO_FnDF3aMqLg-1; Fri, 26 Jul 2024 03:29:47 -0400
X-MC-Unique: NcJhHz4SNmO_FnDF3aMqLg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3686658856fso1086814f8f.0
        for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 00:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978986; x=1722583786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YlUUMETLR2dsXu/4gZO1W5F3Bqvvn+M4ImfPPlpjd8=;
        b=cjdZJ+1YBvlrZPKnvDcvMpf9xgzDryhtENSZk2tT+Zm2MzhIg8wmFhSKk8uX3G0D2I
         hsQaXT+6hTOBQaFbgiJRszRgw/5I9JOyQMs6QTTLdQSQRTszTr56Z68OfiqaklUqKmRD
         ZOxEYUUpt18gIedjX8HKLcuYVcpr47x9ZmmYCwSyRwN/55eWgZZB0fD9ke7wp02Obr9q
         1vdhY1YtfrjiMWDFAj2BzsOPlbjVL1s3Wk2zmXnfBNp8Ckbu1kcq1SQb2UlO2+KMC7Tz
         Bnn+mV7U1eB021d6i9fseoESNm2NIR9x7LjKOrMaJfrZZo3opzNy4ej8lULf70EW3nBt
         JQag==
X-Forwarded-Encrypted: i=1; AJvYcCVKFlsFQGKYAEhEE9m1FHmzgT4yxCXNMPLnUcWeAKLb/l9GRbskiVEQkLf0NGFt5aZUE21RB/8o10ancrSBPJjfbdlxI9eDZ9ovxIv/CI8=
X-Gm-Message-State: AOJu0YwsNKUrtU328uE6HZGl1Nh0QKskfvtvsbcVWFyLYgYTgEDMtFzU
	Xuk4GGG9NpGBz+e4erDkoARkePFROmYs8clzNOgamtOjP4Fk5eJA9eofchquqN+s4nAiRYE4Xpx
	dP6ntEqFNiz+RTDahndmsm4MI28L+lVwi04uT2zTka1FZkIioZ97IC1qGIaBEZLuO
X-Received: by 2002:a5d:518d:0:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36b363e6da4mr2982050f8f.7.1721978986279;
        Fri, 26 Jul 2024 00:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAMMoNkp5PS6h+xxtaSrGI0s9UEC7D4+/tpvS4eIgwXP4pna3OkpPlaDbPeiNdIKgNBo2MWQ==
X-Received: by 2002:a5d:518d:0:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36b363e6da4mr2982030f8f.7.1721978985559;
        Fri, 26 Jul 2024 00:29:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc4casm4203822f8f.52.2024.07.26.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:29:44 -0700 (PDT)
Date: Fri, 26 Jul 2024 03:29:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
	stefanha@redhat.com, virtio-dev@lists.linux.dev,
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com,
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com,
	quic_pderrin@quicinc.com, quic_cvanscha@quicinc.com,
	quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com,
	eperezma <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC] vduse config write support
Message-ID: <20240726032801-mutt-send-email-mst@kernel.org>
References: <20240724033816.GD492231@quicinc.com>
 <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240726070324.GA723942@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 12:33:24PM +0530, Srivatsa Vaddagiri wrote:
> > Maybe you can give an example for this? We cache the configuration
> > space to a faster access to that.
> 
> Yes for the same reason of faster access, we wish to have config information
> cached in hypervisor. In case of VDUSE,
> 
> Guest read -> (VM exit) -> VHOST_VDPA_GET_CONFIG -> vduse_vdpa_get_config
> 
> Basically a guest read terminates in host kernel, before resuming.
> 
> In our case,
> 
> Guest read - (VM exit) - Hyp emulates read - (VM resume)
> 
> So a guest read would terminate in hypervisor itself, before it is resumed. 
> 
> Without this optimization, guest VCPU would have stalled until VMM in host can
> emulate it, which can be long, especially a concern when the read is issued in
> hot path (interrupt handler, w/o MSI_X).

Instead of optimizing INT#x (which is futile, it's a shared interrupt
and will trigger a ton of exits anyway), just enable MSI-X.

