Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69092E6CC0
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342205; cv=none; b=mKuCOcl8Bf5qC8xLbXAwNE4JiIvI5RIZMXA9jShDHWbIEn43XgjzaO73kSqvKIADWBt+OQeqi/a3Z60NZQ8+TPMJgaWAk+oWHzmOfj/LHyjuKPoo5IcYi98hl1i3trlOuJoQvrR7yBzUyGH64/mFb47CngsIr/8IJTaVFzWiju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342205; c=relaxed/simple;
	bh=NpLaP+rsLewThnjQB4w1PUgdf62FT8lHd6eNEqewl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NrtFFL7bpw5VuTE8WB1zmGYBC1dJBiZA4gHIGpEcSIQOWr9io5gD/BtbfTC8kT7CurA75bF2UH5KAj3xkOPGp6rCIZTiULufptS1CdzduB6SwVOtFBejB0ZKipo+0n5qEC1QfkxQqr7fiw6o7lUVlzFygFD2+T28zKB28q0jrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmlpaA4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmlpaA4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COB7VRuwmjnty8tx1CERez8NmWoPvxynkLju3lUiCLM=;
	b=LmlpaA4q+HRnThexAKfYY06mZh4I1I75uR+mpb2QiqJhds4niS6U3z0KD/q1B1D7i+B01m
	QOsT+wCzFWq/P9tYGaBuqo7M9nO4v7ioWIMCNTbfVJNh8RsRKDohLMbWTJtWCw1ASvB8aX
	kGHapUa+9youvmBBOHyKFWH1RVaplkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-DfHAA26KNImghT7CzNYu7Q-1; Mon, 13 Oct 2025 03:56:41 -0400
X-MC-Unique: DfHAA26KNImghT7CzNYu7Q-1
X-Mimecast-MFC-AGG-ID: DfHAA26KNImghT7CzNYu7Q_1760342200
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso29735955e9.0
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 00:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342199; x=1760946999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COB7VRuwmjnty8tx1CERez8NmWoPvxynkLju3lUiCLM=;
        b=ctysbaCzRYdsPPo6iBy2glbTrSIaJqYbXg1VYRtQgIaz0940lkoQ8Q6243D8NOGpKx
         zGx+0j7g2MZS1/K5mQLVS21qsd/cRvfMa/+tU9wwfPf1X+7BoRCh6Z0N4qsjcO58nR3N
         MT5jc62AE9lmJ5AcBLnlsKETlDPvyFb0xQ+JDA+gZWsxPwtq7r4ojTj8odWVPkLKeADx
         S0Vx3wgcobhPI1VarkZ1KzXaWV/8J00KsjmpFmtpju/QWQSq5wpGV0Tkvr0/Dh4EHnTR
         bEy1nzkC1dIKVJ96Ovygl210vHuOlQFWTkfCxqbR58pMFegwcJ2OmG0Qqj7C2J6OfnfF
         A9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUX/+RBvXRFHVTJPx/1laVP10teIiuZkSUQRZJEd/U/igB+5fajV1qiCfYCFh+9o1APQoLz+nX7PRiZhGLrqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUmJ8eAKfKjAC9C9zX5ZPEGjVQ4jcbIYYCI4ssGPj18U5wg/gq
	aCUnc4eNXvJcPm1MFqu2aP2B7i9rpmfRW86W7jgSCvNkI651FsVjFxjt+fGhUZOisaPWYrc/gOg
	Duh6fhzGuHqY0uVZuR4Ur+aX7O6Xu67PBKv/80myJkUuL5k3Ol7NjtrzrEHNBRitZElq8
X-Gm-Gg: ASbGnctY8+PblNRkdlxNHLtyaZHoOPaYqZ+0BogEr3Tyo5wVtuafNJ6NZyZYP2GaAla
	CRl2U5XxtZfBTfHUsvrKrLvnh9DO/evC8cHIiOg8MiRszJzsOXjejiThEEtAcMcKOQZeeex1t+E
	F5OeOufD1uhZrzoYh8PLkdI3kUlTSZdx3EbbJJURhzohoiPKKaDywh0GDAyS6BBzcS7gi7A8csq
	z2XpNjlKTrgBhzxt+u3N/VBBWGDPKCQXC9mewSB0WkZHF79JBzxRThbdPp4s4pT7qZD0Mtrj2I2
	qX891OWy6D0H4wKXtIjZfWDag4Km+Q==
X-Received: by 2002:a05:600c:4586:b0:46e:45d3:82fd with SMTP id 5b1f17b1804b1-46fa9b086e1mr152062315e9.31.1760342199387;
        Mon, 13 Oct 2025 00:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mWHcHxbSz7cXD/T4m4MEkNzKAin9UCeRsZR4UXAfwmea+Xa32Gmelt4UQkO7u0wdOAsgNA==
X-Received: by 2002:a05:600c:4586:b0:46e:45d3:82fd with SMTP id 5b1f17b1804b1-46fa9b086e1mr152062125e9.31.1760342198918;
        Mon, 13 Oct 2025 00:56:38 -0700 (PDT)
Received: from redhat.com ([31.187.78.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b25sm172918555e9.7.2025.10.13.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 00:56:38 -0700 (PDT)
Date: Mon, 13 Oct 2025 03:56:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Message-ID: <20251013035059-mutt-send-email-mst@kernel.org>
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: he-apmR3eKm957DQQcJx3pfTG11oQw2dQ32AFUHNf7A_1760342200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 13, 2025 at 10:06:26AM +0800, Xuan Zhuo wrote:
> As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
> Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
> small amount of code duplication.


How were commits 1 and 2 tested?


> Commit #3 is new to fix the hdr len in tunnel gso feature.
> 
> Hi @Paolo Abenchi,
> Could you please test commit #3? I don't have a suitable test environment, as
> QEMU doesn't currently support the tunnel GSO feature.
> 
> Thanks.


AFAIK host_tunnel and guest_tunnel flags enable exactly that.


> Xuan Zhuo (3):
>   virtio-net: fix incorrect flags recording in big mode
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
> 
>  drivers/net/virtio_net.c   | 16 ++++++++-----
>  include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 12 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

