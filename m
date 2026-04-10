Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA1351C09
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810190; cv=none; b=KhohtbbLvTd4E+amsNse94UcScmK8hTwUZwhjIk1zNkCv7yppdtNuYZbjosX6/ovqCz9h7meP2d43p4IWwjXswnjGmsNvumturX+dCJpE3s5Oo5jro1d12xge56qlIKgo4FhKsSoxyYHJDqlYJRi/FAik+8GeXDg3yHTwg02FZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810190; c=relaxed/simple;
	bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lhptjtI4ycp7A6Z8dffXiKQobkjy4jkc0ugoDnwE9ZUCM0OFki+ggn/wUPgQqF675m2mGxDLwk5dPkUauCPFVTv7YkRQAPFM7vWDoHPiocMfe4uQ2SsFr/cOxNxvL/LRlWK2WDJwed98xJll3S5JX4NY1s4/pwSDQkblIcX9tC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4dMTgia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4dMTgia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775810187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
	b=H4dMTgiaaZ/0nGsemDGuSy5/XiJOFnKkFb2ghNoZzaBCF3FjgXI13Kmrv7HQ78hM4zeof9
	REsstwXGrY1FFrk364iLdt2UgDCoL+7+EYNg3rogp+pI/DcXXKmZ4/pFwqFb1MPMk93iPl
	vZhZ5X6kR/Ruc6qDQ7MeWTrHpNq9oOc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-MmyYmA1OPwKKRde_oH42yA-1; Fri, 10 Apr 2026 04:36:26 -0400
X-MC-Unique: MmyYmA1OPwKKRde_oH42yA-1
X-Mimecast-MFC-AGG-ID: MmyYmA1OPwKKRde_oH42yA_1775810185
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d60e50887so1147820f8f.2
        for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775810185; x=1776414985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
        b=VUriaOcEE3NmCGzlY0ZPNWzBOd0ac+GW5BWw58dGR3qRSlzFmYEBb1OWCfaZ2JBP3u
         Hx2+OF8xvGtsXfU/xqmpPsj3uDAWVB6eW6Ydt7An1rLmZ+VZq6pUV/jcYJdmJ3On2f4K
         JeCcOtxox4lAMs7RhDkGBQjapuOkFa4vziFKb7jNv85+cMjpeVVJ62HD3+lRw4mUIP3M
         A2iNCIJ7Sbqn5JyKLvzYOYvfUERN7mVfSb3RX6zS02SpIsWFA+R1PWrmoGJVn7eZ0fSW
         i8G6P04Y0SewFlPR0GSG1kBUdTGaNvTmrKCB4CaXy9jb7Lxjv7vw+6XtG/D+CDrmc2Bu
         pS6w==
X-Forwarded-Encrypted: i=1; AJvYcCWp+SOFq8cm2rkZuFwm/BvzZxcWVpNIJ5uh0ByCFKyjL71ZPrMztRZdAfon+vALAJg76TLppm+kdWmOMrI87A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoPe3Of29ltFxOCR2jLzeaj+pi+z/+bUMolcg/L42+gMqmXC2o
	6hCBVqAa8CFxtCQQOW9wXWP5cMV+VUUYc/jVGgW+K9XpMh2SqUxK+1GXxE1f1iNtscHIW5QkiGX
	hDU1Da0cLThgIzaQ9B90Irtk8a1REn6u1DqIz80YzFtX2g6N2BW2wnAperlGLwWfyVt/V
X-Gm-Gg: AeBDiet0uzA/KHQeJzA2APji0fYuQabxlWR+X8aewAQHUibZoiFUCZyRWJcwwDcytx0
	Y3rY0zh7aiGevWivCwVsT073j3qYUD/76P6DjTQIupnBBf4Jkr5YidGkZLgl3os8DXUU5TVec6c
	jXy9TNOZ7CbEJc91TxJZpMcqzs7UsXaW+Jpw7DdAgdis8S4Gore6MBCe2mUdbgRwqmdOkB9vcmA
	CPzg7Ne8YdZwCPF4hzFxrQxD+/HCYigWN6WJQ3KuEePLrkHiZuMCt/nPck79ubpgXrLgyatdnSn
	5wr4DorwXUeRwGU+X0ktiTDsp81MrRat+6zhUxqNjeEjunhJ2rqRvQ4zixlAfBdnKjsLwPDqlLJ
	mDptJukOXNnrWrkJ/oE+LV7x6NvTulFDy5VTZWPkmLxdJkR2NXOGsd5Hr+ztV+ZnlvaW3PRZ4Hw
	==
X-Received: by 2002:a05:600c:8209:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488d684ba0emr25033315e9.21.1775810184727;
        Fri, 10 Apr 2026 01:36:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8209:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488d684ba0emr25032745e9.21.1775810184278;
        Fri, 10 Apr 2026 01:36:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d525c931sm56045695e9.0.2026.04.10.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:36:23 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:36:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
Message-ID: <adi2chLOGW0pms1Y@sgarzare-redhat>
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aZtSxuBm8ck6cE32EZDZTnbNFls9f0c6U6cyXfTGMmU_1775810185
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 09, 2026 at 06:34:12PM +0200, Norbert Szetei wrote:
>In vsock_update_buffer_size(), the buffer size was being clamped to the
>maximum first, and then to the minimum. If a user sets a minimum buffer
>size larger than the maximum, the minimum check overrides the maximum
>check, inverting the constraint.
>
>This breaks the intended socket memory boundaries by allowing the
>vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>
>Fix this by checking the minimum first, and then the maximum. This
>ensures the buffer size never exceeds the buffer_max_size.
>
>Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>---
>v3:
> - Added Fixes and Suggested-by tags.
>
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

