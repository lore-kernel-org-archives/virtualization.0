Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F04E36C5
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607663; cv=none; b=Pd11OzxG3BGGIUCVlXcIyAGUEnaTj8WI09MgH9VsG6C0AK8SjUuI9n1HOfctm159EF6X7OmbVHzulw9Qsa6juTEGuriYYrGigXMYRLvXQZKovZPFlG9nQYLwZVXByJ0Wzusomzu+BA8m7VV9uvQQPGZsT5ZrbNhMhfEqhrPmBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607663; c=relaxed/simple;
	bh=nGJsllp8L7sqYAKIQ2/Hr/XmIXmSD+YY1xB0lRGMVQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pAf+deBru9kP/NWZnbjjr2bklQwFAlHiAgJuncXEALwbjghju+uKpFS6qrwAFqbGxayG/5GCtMPG/6u7UbtPG9eHOcnGR9Z/4+rd0p5vR64vgySQ32R+y47ipt+HEf9avK4nT1IfOxqug/WFJ2K/0iko1nRvshN2SdQYnwLGzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rk4EwnOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rk4EwnOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790607660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKOeRv5jdbU0/NaEiGEDb5uvk7fcRI56Q4PTcfyI8cI=;
	b=Rk4EwnOtkmNrRZZsWXiE8+L687mRyvyFOK2OSJfFwKbRB75/PIDA7vonKsri0R4CmDJr2Q
	iTcsoKBWKJKW5PV4sjAl7RriX/+Ruh0c/Dh8cVJfOYssPHcCvfg+UtV4Qzvje35SAsIYqj
	9HcaJ6xjlTcEsFej6qN/quDz49O/PzY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-oBUDCUI2Nj6lj-eOTRBS_A-1; Mon, 28 Sep 2026 11:00:57 -0400
X-MC-Unique: oBUDCUI2Nj6lj-eOTRBS_A-1
X-Mimecast-MFC-AGG-ID: oBUDCUI2Nj6lj-eOTRBS_A_1790607656
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e635a6002so38218255e9.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 08:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607656; x=1791212456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vKOeRv5jdbU0/NaEiGEDb5uvk7fcRI56Q4PTcfyI8cI=;
        b=j+LK8NPvd3qP/BPMxNk7+H+f0p+rrpSMklrtRkFGnR7gnH/bswb4T/2eAVg9paLjcb
         Fs/UeKOD4aaw9zDCSVXw90o7q+soO8PnAg8taRrb7tpK7mTc+iHyurnr+YV56P4Pxhfj
         vge7s7nELy8OPWxynHDZ7Cawe/2Hj2HNi/cIlocvNqlwlZSLUwcZcBZdcrVQeAtxG90k
         suCqIln18CDm1Ysr/RF3SuHcXjL5NDUWNXGyBBtyuWfpX2YWunGOHUFaO002+AG/i2/o
         kZP21t77kXELzAXeVj+LW58M5hEuEfrjCDbDUt7NTHX/TTj5k7OoRF1IH6XLnOCZlMwi
         QqVA==
X-Forwarded-Encrypted: i=1; AKwUvBw9DHXTJYlkOokdgraEYehBIYT3a/7vpIxMgPE3Dfwpu4kLuW6CDXPb79E+zDyrLIqdEYpViG2fgoVyogg3Qw==@lists.linux.dev
X-Gm-Message-State: AFuF++nCs0MrYArjv92xHLSKTSByErrLHPcLLYfM+PZkDSUljGzPnUWl
	Cy7g6JwAkHEF4zIZwYMReeISo3JWKmyi5/eEfFNZUvt+nVpvk21swl1/d1dROFSPmO76ZtiTtsf
	cunHTs+8kzTX4hUR+2ivB2WD7vqEQgjaw+YO6yRAZsop/vilLoQTzpZdTimTnSivA6sxv
X-Gm-Gg: AYBFou1D8a2XGvI9CjTgUtKEjnDB6kyBvChd6Z45V8jGXUrP6oF5dRD/aG9RLXnhGBk
	nKN8tkB/YttJSrvTiiO+e5MjgpRaTgddHe+pofJlT3ZD52/3fATHXSFgmy7DDouc8xmYIZ6uXxw
	pJiMjoFiSUwpjB2tXZM3/Y8YTKgVKlfrNgB44eIF5qsSBSXJvVo56WDhun/NiWfDHZvFUZU5GAa
	PQG6yyDB3Pf++rK8ycO0Jwoe9+M+VRpq1JdpV3VJGXKsSYDRC98GKwLV9xLv6NZNdek9qApjkrW
	q7OdyeEIq+vYwvutXHmCOfnnF8nz+Tt1kuSkVQys3QLGjU4/Cq9hEL/5n6dVHH6rbaOoaf/osfw
	rqL4=
X-Received: by 2002:a05:600c:46c6:b0:49f:fe88:e7d1 with SMTP id 5b1f17b1804b1-49ffe88e87dmr94650205e9.15.1790607651105;
        Mon, 28 Sep 2026 08:00:51 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:49f:fe88:e7d1 with SMTP id 5b1f17b1804b1-49ffe88e87dmr94649615e9.15.1790607650593;
        Mon, 28 Sep 2026 08:00:50 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.146.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001922102sm151770215e9.15.2026.09.28.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:00:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:00:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover receive queue hints
Message-ID: <arqBCldsgfzf1nUW@sgarzare-redhat>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260923184008.153541-3-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zf9tm_4iwCKKc5u__H1K-MJOBUxhQoGohzuWgASsXWs_1790607656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2026 at 07:40:08PM +0100, David Carlier wrote:
> Add io_uring receive tests checking IORING_CQE_F_SOCK_NONEMPTY across a
> partial receive, draining while the peer stays connected, EOF, a
> nonblocking receive on an empty queue, a zero-length request, and a
> multishot receive with provided buffers.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  tools/testing/vsock/util.c             |   9 +
>  tools/testing/vsock/util.h             |   1 +
>  tools/testing/vsock/vsock_uring_test.c | 391 +++++++++++++++++++++++++
>  3 files changed, 401 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

