Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13F37DE84
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260940; cv=none; b=Nnx3d+EV6n0gI7M7EH/h7sSZsqoVDXqKUy2hbgasirBsjOV0hJhogboGiI0WfgoKgSZUmEPeqekQptEa6dmyTT5E+qK5N3vIQ7G1fn4vPwdQ+XrCY2crpxKGzkJIs8XIPsK7rns5i4LRGSD1xA6mUHIHNGtAlxFUnV3FgArmj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260940; c=relaxed/simple;
	bh=acjZUGKdaecj3tiJh85zgGIvI7UQ49rmRl+qboc8Y+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dww3MRs1F4M/+qgrXHRUssCxNpp6/70zzYwNTZD2WzlzxNAJWG0FyNGYhD2QYLC6qFsEAOEgnuD0Uc1qfocrnFgnK/weF41maqOv5ocxRrV4O6m+cDZ7urM/nqyN+z4SZ0U/qtqha0HrI3S/xELTRVD7mGGCMxuS1uemTywC0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSkWMa2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSkWMa2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781260936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf0kmFuUAiZnL7ib1dVfO8bvzPtJWeke2Juu4JRQHGY=;
	b=ZSkWMa2kvgACZXbR+gPlQC50PBPO47Q0riIr+BV8BH2ysciH4Op/QneUp9QImHfmUincSr
	lZzkdCIE0SYqvLlyya2BEvGgP3c/Qsh42kxsWhmk7rD8l0vU/0SvEVCGZM8f8LVSyTeuF2
	rLLYZeEX2ldaK/eHoSvChhM6hEGgR0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-YZsItssHN8SAElsOuAWsMw-1; Fri, 12 Jun 2026 06:42:15 -0400
X-MC-Unique: YZsItssHN8SAElsOuAWsMw-1
X-Mimecast-MFC-AGG-ID: YZsItssHN8SAElsOuAWsMw_1781260934
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b3f53c81so3456145e9.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 03:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260934; x=1781865734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf0kmFuUAiZnL7ib1dVfO8bvzPtJWeke2Juu4JRQHGY=;
        b=tKxG+jJxqCxOuRPyHKRzOptVPPAip1oDAI3KEh7em7NF66yM5Pq8Y9Dsu9CSqO9SFj
         a7lir9xLoXZZkJHu4XJhg3sa5bBzF6UbmnH6c7pQSwBky9V9zfTmC0vrCOc0mlleIplP
         YjOcGh17o9IZYK8Zntj/QqpHXjmz4RRn0kk6tyI3dqxKGwRCDg1Owq7Dg7FWL6Zu0hVw
         rAvluDhu+IHz07cwtOIjMbo6VuBjIUAg1Dok6NA2FfQEAVAFwTUSYaz5w13TPSMPH63L
         Pa/bL3ydC35fOgAX0hrWiZN8owsncGLwXV2/y8gSF6OSy0gTkgL8a/YDn0184tQxm3pX
         m8xg==
X-Forwarded-Encrypted: i=1; AFNElJ8B1LSM6ug4+TGFs0Bcp8PU9x9klv9HQkDpe1MwHk4x9Ic17u22KGeZEDptAs1r3H2xUUX5cLPy30AA8JdAIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4byns9sxVKejBrGPXnx9ltVkyvb/bmBfSK1YkDzEenS41ri9k
	zRaQuyzNJxhFVyr3RqP7Z/kZCe72vvULaR+bshG8bQtsjvVttxCuJayIhHf88tu5/8amtUiHTrM
	1tTBUWnMV6qgZ842791Jiqi68yDNBjxy82OthBlXla/qGTphEz/TLatgEpDRvFQWk1zF0
X-Gm-Gg: Acq92OFOwv+af+WoPVEQNzKvzx3Au7isVAljvE9Mm1r3KnsbvG2aGFNuCrKUedvM+0w
	QJJFDSTWjxHYLjxJX89s4U406PJ+h3PMmuBF39fbFICBLVpd+ucAo2sBJ4USTikLhgKxNlJuDNC
	ACoy3P+38Qacdj+heAfFCxpub9WrSq+nrg8o6HRCDaacrMJkC7QLZXezS5yPrjHB4Bf1EuYKD4c
	uR7n+QJS7veUnHIW55v5VcG2hwJgFKVBHfO4FdcsZdE1t4h+gagYeULsxwsyIzrAbXDMB/UA+Da
	4i25nRIpWh3lf5izT/vz+I2UWQHGqOhqaEKkaYKW/smLi3Y8XWkWv76XqNr0nXeHnqBd/OAnTCy
	XMRYotajwzTMKW1i8q15kWVsbRsHhqz1v6v3s1A/dyrBdka9nvbl7/ixP2JDgP2fyK+rIYvU=
X-Received: by 2002:a05:600c:58d5:b0:490:c2a2:e91e with SMTP id 5b1f17b1804b1-490ec523a8amr17826375e9.34.1781260934163;
        Fri, 12 Jun 2026 03:42:14 -0700 (PDT)
X-Received: by 2002:a05:600c:58d5:b0:490:c2a2:e91e with SMTP id 5b1f17b1804b1-490ec523a8amr17825945e9.34.1781260933709;
        Fri, 12 Jun 2026 03:42:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d0fb23sm137795295e9.15.2026.06.12.03.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:42:13 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:42:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into
 vsock_add_pending()
Message-ID: <aividdU8rpTLexuR@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-3-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N5_XeYp03aLKdKafr5EFCOMQXGe5WDfbUw8WFD4JEiE_1781260934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:14AM +0000, Raf Dickson wrote:
>Move sk_acceptq_added() into vsock_add_pending() so callers cannot
>forget it. vmci is the only transport using the pending list and
>is updated accordingly.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c       | 1 +
> net/vmw_vsock/vmci_transport.c | 1 -
> 2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

