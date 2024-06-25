Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6F158A23
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355823; cv=none; b=UfQw9SAEkw/QKuEUReAy2EWtyiyidkUs+IjmOjSYjJhDLyx8sksr+hdwzG8uhV67NxokNv7kkXInamDinGzn6M2bXor03USu1kf4Sun8joMK1UiwG5wFEkWYk7Op11tPKaSS8/zmKmdmonF/gtRLbsQ8w3/FRCJrv7FXqTuFSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355823; c=relaxed/simple;
	bh=OMJJqsWmMXsLxDpb09oJZ90ADbUHbE/I6p9lu0Syvfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UA8t5z+A9Ck9v21Q93m8uajeUjP36JV4pQfzvzibDrkhJNTC+GkDXiZ3j05gg22b+fF7h+9rUxEemxgptvtjdlEZr/L/dcFt1v3mV5HVJ5ePTvHIewPsCpJqzkf8Y54x8agLLt5YB40G6LdVlM4vONDKtJX0Nf94rzUMJYtbN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtF5ZS32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtF5ZS32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719355820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oU8QrkeYhtfgg4G8OaEsau9ozz7JUXSqzMXGT4kRNJM=;
	b=PtF5ZS32bmil8ABSpZ+WQNPunpJixZiAzr/JyX3gFbQyRlICsG+Zew6KvK26tT1jSvrBC0
	6JHJjpzqD1pft3/c2nfm2XAwinfk6zaAQ1xqBfXrx+sBzEqXWkPOy+2q+ME84PZIW17XKI
	YXHBqyaBUnY5FOcuJ5TDeyWZhkTdk4c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-YE7HuKcBOn6YccSVvZgb9g-1; Tue, 25 Jun 2024 18:50:18 -0400
X-MC-Unique: YE7HuKcBOn6YccSVvZgb9g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-364b75a8194so3039277f8f.0
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 15:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719355817; x=1719960617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU8QrkeYhtfgg4G8OaEsau9ozz7JUXSqzMXGT4kRNJM=;
        b=iNQ4D4K+N/HMzKlbgx5fXYzwug/qEMHnG5lL1qakGG106N1QI7SLtmaIQNnKnuEpQU
         2RFxpER/PYJRtnTFhLBKV5benmMfRg+aX2DKWSMYx3HfBLj2xc18hNGwjw+5vOAuqzKo
         dziX++QlIC8iLQGf/x/x1wVufR2Ln+XOvFNGJlcxvMIwpsq7sRvpXXCEh5t/jXESrIof
         yocM1kewTB3SV8zD/Me1kBmK8qHXQkeuOWm/EzqbQbw+E2SCe0D5uLS2wSerOChQf+pO
         BLM1ssIPhR8E7LYu3Az+VkhNYEh2LX8LOYhWvQccYAy2xB2YIEpOQP9GsbXJHBEEn2Un
         0VPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS8emH5CzJhKDh0y2jFC5osfaWwK8lvbnEbK5McEbihrKsaKdeZc86XIdFiZjMx9Mu/PRZwYGCvtbmGHMiQmTcymOEkBIK/Gzta1bU3VI=
X-Gm-Message-State: AOJu0YzGqFpUCRpH+pviXBqo3mR4L8IbwjHGIV4uJOvfVlmay+EWnNaL
	IhUo7Qa6ka2QVIJvqvYJ6FYHLWMWLJOR9DMgZTzvbs1EvkfXHdc0lT7Uw6SpCQZ3EQTvU8SGeDp
	ACpNP/mgSOh3StC7h0W0Efu10Mu+zmyjqlmyrW6LvF1nPVr9bnXmNUgkt/86Llc2i
X-Received: by 2002:a5d:4bc5:0:b0:35f:2067:2072 with SMTP id ffacd0b85a97d-366e96b2398mr6698746f8f.52.1719355817111;
        Tue, 25 Jun 2024 15:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdr5Ed132jV7cV1Dq86qNW68UOd+n6d3b/DQMkB0QVx0Q/gO7pu5FkpmnKYZrbw8RdUc9qqQ==
X-Received: by 2002:a5d:4bc5:0:b0:35f:2067:2072 with SMTP id ffacd0b85a97d-366e96b2398mr6698734f8f.52.1719355816391;
        Tue, 25 Jun 2024 15:50:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f693fsm14083543f8f.69.2024.06.25.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 15:50:15 -0700 (PDT)
Date: Tue, 25 Jun 2024 18:50:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sahanlb <sahanb@bu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	drepper@redhat.com
Subject: Re: [PATCH] virtio-pci: PCI extended capabilities for virtio
Message-ID: <20240625154900-mutt-send-email-mst@kernel.org>
References: <20240625184043.10658-1-sahanb@bu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240625184043.10658-1-sahanb@bu.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 02:39:37PM -0400, sahanlb wrote:
> PCI legacy configuration space does not have sufficient space for a device
> that supports all kinds of virtio structures via PCI capabilities. This is
> especially true if one were to use virtio drivers with physical devices.
> Link: https://par.nsf.gov/servlets/purl/10463939
> A physical device may already have many capabilities in the legacy space.
> 
> This patch adds support to place virtio capabilities in the PCI extended
> configuration space and makes the driver search both legacy and extended
> PCI configuration spaces.
> 
> Add new argument to vp_modern_map_capability to indicate whether mapping
> a legacy or extended capability.
> Add new function virtio_pci_find_ext_capability to walk extended
> capabilities and find virtio capabilities.
> 
> Modify vp_modern_probe to search both legacy and extended configuration
> spaces.
> If virtio_pci_find_capability fails to find common, isr, notify, or device
> virtio structures, call virtio_pci_find_ext_capability.
> 
> Notify virtio structure can get mapped either in vp_modern_probe or in
> vp_modern_map_vq_notify. Add new attribute 'notify_ecap' to
> struct virtio_pci_modern_device to indicate whether the notify capability
> is in the extended congiguration structure.
> 
> Add virtio extended capability structures to
> "include/uapi/linux/virtio_pci.h".
> Format for the extended structures derived from
> Link: https://lore.kernel.org/all/20220112055755.41011-2-jasowang@redhat.com/
> 
> This patch has been validated using an FPGA development board to implement 
> a virtio interface.
> 
> Signed-off-by: sahanlb <sahanb@bu.edu>


Thanks for the patch! As any UAPI change, this one has to also
be accompanied by a spec patch documenting the capabilities.


...

> +struct virtio_pci_cfg_ecap {
> +	struct virtio_pci_ecap cap;
> +	__u8 pci_cfg_data[4]; /* Data for BAR access. */
> +};

Hmm, a weird thing to do. The reason we have it is because
a legacy bios has trouble accessing BAR directly (e.g. if BAR
is 64 bit).  Is there still an issue even for bios with
support for pcie extended config space?


> +
>  /* Macro versions of offsets for the Old Timers! */
>  #define VIRTIO_PCI_CAP_VNDR		0
>  #define VIRTIO_PCI_CAP_NEXT		1


This comes at an interesting time, there is an interest
in order to get virtio working over EP protocol,
in exposing all this information as part of a BAR
as opposed as a capability. I wonder whether that's
also palatable.


> -- 
> 2.42.0

