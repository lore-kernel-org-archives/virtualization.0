Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56341930D
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698270; cv=none; b=nDBgOW2Biq/JQE2xAsgV2Un2sW1ZvzgmCX/jbIPraa/Nk0l5vImmv8Om6+gqfMS4tCFpIiqAq6bmWGgxBSkUUb6zXh4BT1BUwAFKa9axGms2Aa1c6KWbmH2ASQQc3KqcfMyuxX3bNblxJcn+CUmfTXqU2DCQ/c1pqPUHP3a0hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698270; c=relaxed/simple;
	bh=TVKuU78In4WxRZQ7vl+bTB0idxpevDUhM2Pvt8vSg4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tbhT+RcmNwdnts4Zpv/XPVEaNyX3BO9D7PpOoXFX3q+x07dMXiF2I9tovwRJVxQb9NjVRMAvu70QijqWsIOuY0rSmqV8YGmGdEWwWq/hMIxc6fHVMrzirxuoLUoUXB+CGcj/Er7oj6XW72uCpRYrqvUMrx3P+YsJ/pBl2s2Ad+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOx653Dv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOx653Dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786698267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=331Qtlk7U5woKtN1s72ENWMljrsHjQpeFCMNumZM9Pc=;
	b=WOx653Dv4CxbYaHkK/PwLPs0giyHoL0qAIm1pvOsE2kGCyAbZNJ6/+GurYLTkp962L/olB
	WtzvjQ28S/sPehzJVucAWQ88aj7A2AZR9ZbytO4vrtc8taHM8hQAlCPVcCrQD2gmPugz26
	VO3u3VEnCUZlKMpBxIK46pXewAUW2Us=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-PXJ3M0LdPs2_ZUX8-VA10Q-1; Fri, 14 Aug 2026 05:04:26 -0400
X-MC-Unique: PXJ3M0LdPs2_ZUX8-VA10Q-1
X-Mimecast-MFC-AGG-ID: PXJ3M0LdPs2_ZUX8-VA10Q_1786698265
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so440915f8f.3
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698265; x=1787303065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=331Qtlk7U5woKtN1s72ENWMljrsHjQpeFCMNumZM9Pc=;
        b=isDD1lM7Yv70Pfnv4tTfm8EOhwjw6OZ3NPJz3LSDH1Lh+aVP6U6JheJKB1yRaCQ6lH
         sT03ClUzWabz/ozwQC9rXRcHSVe0zfjWqVWBWv02RY1O8EeHxKbfLUDeMm6x3Uh8MvMr
         JAFuVC90e2hAXJvbC1u/tF/5E9LW2hfs3qAgph7dn57KBkeR6DXGy52B/6Oftdbk7Di4
         btIcjQRnWL6Xm5gInFBH+2m8PhQcsfh2Dypbzg52mnGNzDN0WEychx8pe+zyMSlgG/5I
         cA5e9o9b3l8AMVEYettMNlcOMDyT2+qMV1SLbNFDd5l0hs5MWiMDkgKHOQBeMol6BYBM
         LnQA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8d2WHkGfP/345yK8bqNLCDZ34CPvOiYQpZkH+6HohSso7aBGYldmPD4NglR4yTuPRrLG5w0WMtgRcUYlFog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSBK64QyHrTLwGwlCfz04rlX4nOs2a5cvRKby/eg1/rTv4H/tn
	QizxliDMaN8kzVCSvyZD4UI+FXLZ0zpjq/O8jPXNrAudQmsiajORNNZVaQCYk9dQmhy6A07ushc
	NYcdFaedkEvodqjwzxR9PVabRc23qUtulhXmK7CGX51cr6C4tW5bsqvzwSmBdBS9S3ix+
X-Gm-Gg: AR+sD12iwcwWYLGbS/rOs6xeamQCw894q2bkLdnqIaVePJ0AX6i++cemL9X0rXZwa14
	o2zuv8DhO1VufR8mtiXOUo8PiT2HdbX1oUSYyDbtcif1vl87wELZlE6xBVS6Ddl5i7sFOWFhbmd
	/zo0UrhPSUx5BDEvjp2VpGe5zMnqa1ghmszqe8u2gqMI7BKfLb4Y8YW2xBvh1Nm84IBKh15gILF
	wXzevn3g63vcQh1MYDCKWXx/iSmguDl64vkQAXlCMFYydW0ZtSGi8oRFb0U1C+TJapbeT5YO7JI
	OLNnRWOYuuSD/6VHiDAYcZ9T5F5zQh3BIJeof9Isj5YqkeeFJMPE65nOvXQTYHj/YyJK2vMacu3
	Sk64ExgujVzSuEcJrkDsqjoL3dKXIkBilZf7HlHnVG8ha+pOfUjkM
X-Received: by 2002:a05:6000:250a:b0:47f:7e8f:d62d with SMTP id ffacd0b85a97d-48160732f09mr5564485f8f.10.1786698265190;
        Fri, 14 Aug 2026 02:04:25 -0700 (PDT)
X-Received: by 2002:a05:6000:250a:b0:47f:7e8f:d62d with SMTP id ffacd0b85a97d-48160732f09mr5564376f8f.10.1786698264582;
        Fri, 14 Aug 2026 02:04:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f1fff25sm10217805f8f.3.2026.08.14.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:04:24 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:04:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] vsock: remove the now-unused rejected flag
Message-ID: <an7aAsvcpoRd00ya@sgarzare-redhat>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
 <20260813173024.2362935-3-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260813173024.2362935-3-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tx26jeTlCOWmNMIY0IOKE8ZC6XpNewT7KoIyoMAGGTE_1786698265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 14, 2026 at 01:30:19AM +0800, Nguyen Dinh Phi wrote:
>After previous patch, the branch marking a socket rejected in
>vsock_accept() is unreachable, and nothing ever sets vsk->rejected
>elsewhere.
>
>In fact, since commit d021c344051a ("VSOCK: Introduce VM Sockets"),
>where `rejected` was introduced, there has never been a path that sets
>sk_err on a listening socket, so that branch has been dead code since
>the beginning.
>
>Therefore, we can remove the `rejected` field from vsock_sock structure.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> include/net/af_vsock.h   |  5 +----
> net/vmw_vsock/af_vsock.c | 46 +++++++++++++---------------------------
> 2 files changed, 16 insertions(+), 35 deletions(-)

Thanks for improving the commit description!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

