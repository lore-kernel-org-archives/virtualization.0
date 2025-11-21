Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DD29ACE5
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751836; cv=none; b=f+5g7QcvyvfOXAknof9G1IsDh5rolH9+/gQ30/gm8EtUFYNhhmGalcmI+/5V+ftJfwp7ezIGjanDRPr24wTdKf/Aov6BrDjHSD+0+j4BY5YfYcz7jNPWuNYzDi7HbCq/YFuLkcQXUGF+OtxvfyvQ/WMlpoyP6jzBLEMMql8fCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751836; c=relaxed/simple;
	bh=JdSLpTVX2iWVVnKDVSvfFjbJUtvnuhLaoTLA6sfPhAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cer9MRTeyAuncN+nfzUbm5sfaZok4CmaCV69Rlc3yxXRXubLwGuHC3hn+FwCtngnGggzM9IlmNgp7xGCCc9voI2hOsctjwNpGbow2OWlYi1pxyfD9DenNqxPDjO1hYY/59dFSz4MphLBXqzVNvzQaudNM9Upnov2YpmI2OGDSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzEIG9Yu; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzEIG9Yu"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-640c9c85255so3350369d50.3
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763751833; x=1764356633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsyeuDVu3rFEqJRnWBFG2+MFZuPnp6VpaIUJkyp+gQI=;
        b=TzEIG9YuYdlp6B9ngKVVCKm4W3l5IhBHdkkAmPfETFd7KPI+1kBsYwBL5pn+7Ovlst
         UkGMMP6m/C/AQXlaoTlAwGFVmLiTsq/AfZo8VseFggQftls2T6C1SHI7EWynt1eDJFtV
         6h7ntckgh+TK+8uBFuFEtY01Rzl9srmo2D08/fkjB8swGEiHGDoZ1g/pEo+c9e4haB60
         EMLFjad91TU9/BK+nXNA/10gxLmPKKd+Whld7+yS8KquqHzmuLdv3/m7aP0I01HCpnGv
         sA4yWyQy6agKJ8vvYAEOsSzcCyj1zsPoX0kHimBd+inCyJNjXlUuNW1hIq6+dt/2M7cK
         32AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751833; x=1764356633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsyeuDVu3rFEqJRnWBFG2+MFZuPnp6VpaIUJkyp+gQI=;
        b=bsPAFWkuu7bpaLFWW8Nsvi5/bAyj35wkaZN/GyJlW+XKywU912mtel/StgZH/wd6tY
         S8Bsb7NpRXQv6UTFNcGLf+NziLRr01myZ4WdnoQwoB01KOS7UNPzaDtQqDtAQqoeeKJD
         KH5WMLMejueorLfgAd/x68j7AtdRAh7gPR8if1cXqlPwnNh4nUBYShCPOriIXDop2nvj
         G+OcOgjbEfVwyncIl0DOaE5a9ty9Qg0n+wKC7y4REhK3kyKhU5o7VcRDDOgNNw9lyYi3
         6T7RqrYorD9++77IWdDENPhKBqgIH+rZccFPrYJy7/81Tjyt/oeD9Gr/dapZs5I5amEb
         k1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgtwQA5qRFFeYn72ctqBK8QNs8+8yZnYhhMqI7ZZaZq53IsJt+ne1Y1kKo6w9ap3foU0OWUPG3plo17bhs8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk6QG/oB+4Wru+BWfep3FuRDu5aD41OCdcEBiq66t63aiZ/iC2
	Ktc+4miaDwT//LLO9T51hiuqyOdLCfgd67mJzAasiVyXTweIgkYp9da8
X-Gm-Gg: ASbGncvCWgIeEHIUiQvrGBb3zsSXCYO3ixKB+Uxv4uAIDqWUvmGKiTnBW0I0edbz6Cv
	wnyz8rKOPRrb02NBXqug0dk4ZOC7x1UxPkQbs/kV3syrcHA+fSgiHunFKs1Ibb5be4muyD53IXp
	SzRPW1IJWAptdtYxs8ANCIz7sgj9/l0YLJAWNEPGvgMfc9I0f0UtX19NiHVwBZYxjM5+L54swne
	0t/G99rbuiGr3nr6O6K7TKAGycyUJLTGbGY1ilJNOejmQf4KJ9uNKvq67lbAwPugl8U8GhzSWnT
	QBhMCKPA5xFl5piKHdmGqmuS91pFPZhZ3ijdq9PxISQlO6yAFYXytt85dpDjmQWOJT3UnOOJ85k
	b/+F2nbWGOHPwEb8hMzksQ/2sozXO08XECvjN3hcSTEpgC3w1OJzTEn11+Eyce4JWURivPN5+H/
	S3FfJkco3Y3Nqm9i2diEyV2C8xyyHq0EUvTE8kaCxXkaEY/5E=
X-Google-Smtp-Source: AGHT+IHqdQfTU4t/9nnncQ179liEt9vBvpItMsnoh0ykni1C+JgYJBg/+9EgA2A1pACRXR1G1tNPMQ==
X-Received: by 2002:a05:690e:4298:10b0:63f:aadb:397a with SMTP id 956f58d0204a3-64302ab1807mr1907945d50.55.1763751833308;
        Fri, 21 Nov 2025 11:03:53 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993e2d6sm18040287b3.39.2025.11.21.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:03:53 -0800 (PST)
Date: Fri, 21 Nov 2025 11:03:51 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 05/13] vsock: add netns support to virtio
 transports
Message-ID: <aSC3lwPvj0G6L8Sh@devvm11784.nha0.facebook.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-5-55cbc80249a7@meta.com>
 <v6dpp4j4pjnrsa5amw7uubbqtpnxb4odpjhyjksr4mqes2qbzg@3bsjx5ofbwl4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v6dpp4j4pjnrsa5amw7uubbqtpnxb4odpjhyjksr4mqes2qbzg@3bsjx5ofbwl4>

On Fri, Nov 21, 2025 at 03:39:25PM +0100, Stefano Garzarella wrote:
> On Thu, Nov 20, 2025 at 09:44:37PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add netns support to loopback and vhost. Keep netns disabled for
> > virtio-vsock, but add necessary changes to comply with common API
> > updates.
> > 
> > This is the patch in the series when vhost-vsock namespaces actually
> > come online.  Hence, vhost_transport_supports_local_mode() is switched
> > to return true.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v11:
> > - reorder with the skb ownership patch for loopback (Stefano)
> > - toggle vhost_transport_supports_local_mode() to true
> > 
> > Changes in v10:
> > - Splitting patches complicates the series with meaningless placeholder
> >  values that eventually get replaced anyway, so to avoid that this
> >  patch combines into one. Links to previous patches here:
> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-3-852787a37bed@meta.com/
> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-6-852787a37bed@meta.com/
> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-7-852787a37bed@meta.com/
> > - remove placeholder values (Stefano)
> > - update comment describe net/net_mode for
> >  virtio_transport_reset_no_sock()
> > ---
> > drivers/vhost/vsock.c                   | 47 ++++++++++++++++++------
> > include/linux/virtio_vsock.h            |  8 +++--
> > net/vmw_vsock/virtio_transport.c        | 10 ++++--
> > net/vmw_vsock/virtio_transport_common.c | 63 ++++++++++++++++++++++++---------
> > net/vmw_vsock/vsock_loopback.c          |  8 +++--
> > 5 files changed, 103 insertions(+), 33 deletions(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

If we move the supports_local_mode() changes into this patch (for virtio
and loopback, as I bring up in other discussion), should I drop this
trailer or carry it forward?

Thanks,
Bobby
