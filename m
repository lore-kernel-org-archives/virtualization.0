Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904727877F
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571362; cv=none; b=cwk7Zv8+RpVfl3O6ZhQJwNwDBHeLRRYiWnzgOBtCQKO75NWaWlBlKw4wW6MeRn35g5aN4OvB8/bAtoJ4SrwJqLfr6NZq3mt9VegozeOWl74tXyqDwwe9cXEJQSJp51FDEodLrNZdkE8gwNnIZKNS4q/ABBiMAgKOAjUhuoYF73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571362; c=relaxed/simple;
	bh=JPwZSVWVaVLW3Z6YpXhW5lIznLWTsro9+6GytsHoeZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CDUE4nKmQLfw+kqplK9NltoWZK7EGERmilPnWL1p4WAOJV9bAPmtL4HCcQ7cQYmMsHCZtHBBCNxqPw9RGFt3muyKiXFVBs3rRxzUa8JLtkTIckFApPIM0Kmwod9Dg1fEzfVy+ZtN1G7iwQUF7SUCpvtXYbpmMrl7ZbfIUdm2zE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1ACnuNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1ACnuNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770571361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6s5bPoEQnlqdP44WdUaieNNRs46yqXjX0mEOzw8uNXw=;
	b=a1ACnuNWS+E7PG+iybW75z4bBDR4wERNHjOji9muCHuscrgx+w0PFY85eetKVyfsasslog
	7cU+MsiBO2fMSyCemFS5aKrGCfJ8M5QOQ9M3UsirRrmUvkJL+7/IXbXnwwFkRyugEFnSy0
	l54SvlIrZTWDHf43qzEx0xH3+we6MtM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-APdYpDO4N4akGZfiPVLkdA-1; Sun, 08 Feb 2026 12:22:40 -0500
X-MC-Unique: APdYpDO4N4akGZfiPVLkdA-1
X-Mimecast-MFC-AGG-ID: APdYpDO4N4akGZfiPVLkdA_1770571359
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so53915275e9.2
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 09:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770571359; x=1771176159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s5bPoEQnlqdP44WdUaieNNRs46yqXjX0mEOzw8uNXw=;
        b=iI0LOdaf//Qf6rxKa7vSXD27UewZj0w0hbEaAYl+HXRdhryzKuVVE8IXHYZv0Yrcad
         ZB5dPj4p6IXTi1NMTeDGcZ8CrJNoZ3blqg/tzCIp1sNwAZSx2x92BvcYdFBXsOHjsqKk
         Bds3S/a4NerxGKyhIz/WVBJ4PyuDn+sVm8nEFJOFjk5bRB5MoGY5huf4zBohhltvIsjp
         NE97m7ZALW4IdxWvMFiwfqQi13XvZuHKG9xyrA6MrZB6Ponj1as3zisUsQ31rI4tGsJt
         7tXNgj7yIruVmYFk7qklNsmlCxAgIBCR2AlFnitm4pQsIDGj3g7FBf9TD7PKA9LbgWlZ
         hN0g==
X-Forwarded-Encrypted: i=1; AJvYcCVmQD7pUZ4KvzJKg+TubuYEQhkkmE645UtMPoXdwuOlqGRIUHqmMEGURJXxPC1dL7wjXQTk8ZNBRex/6fFHdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO7N31vUStocjM0mTOFIXJYVEU06P8N+QihMye70mWOMIpTCSM
	mkt+8HVVqup6ZZcLTFEj8SoOG6eidavKs1RnJmLrccXyNDF0rFUsG+v3/SBIry/6nT0GAF1FUaK
	r/GPt1TVn0znuwVY0tnq0X0b631umXv34mrW4RIUTjpFW6+XnPqXG239UqYYPcAQgQkx/
X-Gm-Gg: AZuq6aJTIBMo4mZ6fTsJgP4i2du10ZDO4JwLkuBgJ4DqBq9w558KvAwz7HpvtK1GZDI
	HVMW0Kx4wOir2EXnVX1w1T3bHdLtMlT2U3padGWgYVbic/UNFqW13i9nJ7XepwIFFTnMqGnJ8io
	sgajVGrRsUd30VgLP2poNgi8W4f+ME66lv2L9FiO/m6E7CA8c/iSGWKjME4dbqLS2R4Wskx05kt
	LDJMVN+9FRtPCb2UYNTbzQFAZtP9xz4ppqkTH47PUhcxFMlKAAQgxsODKZ2mWD0LHHQE3qONHey
	bbAJTZZRya6Lq6IjmVDNUDMKQwIMv5NxD52I+T210uL6Pqp+Z6rNiWdp51LVUfPKpo4265MMyR/
	ySyUQcQkjHMDa5g+kk4E5Pya4mkvNDiUGzA==
X-Received: by 2002:a05:600c:c4a7:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48320236645mr128388785e9.25.1770571358892;
        Sun, 08 Feb 2026 09:22:38 -0800 (PST)
X-Received: by 2002:a05:600c:c4a7:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48320236645mr128388475e9.25.1770571358429;
        Sun, 08 Feb 2026 09:22:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756bc3sm19208702f8f.39.2026.02.08.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:22:37 -0800 (PST)
Date: Sun, 8 Feb 2026 12:22:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260208122211-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260208065456-mutt-send-email-mst@kernel.org>
 <3512ccd8-650f-4c05-b2dc-1c4588b39c87@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3512ccd8-650f-4c05-b2dc-1c4588b39c87@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5uCla-rCot57NaT6Yjq1eLBtOP1f2jtT770tlo-NVz0_1770571359
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 08, 2026 at 07:57:33AM -0600, Dan Jurgens wrote:
> On 2/8/26 5:55 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 05, 2026 at 04:46:55PM -0600, Daniel Jurgens wrote:
> >> v15:
> >>   - In virtnet_restore_up only call virtnet_close in err path if
> >>     netif_running. AI
> > 
> > what was this AI specifically?
> > 
> 
> It was the AI review bot, forwarded by Jakub on v16:

oh sorry i think i meant to ask about the "style fixes" one.

