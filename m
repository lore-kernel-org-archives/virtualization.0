Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317229402
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814266; cv=none; b=a/gy7BM22qo6n6NXpD2SGwvSOllvZQn2VgNz8sqyPJGwevCAZ+dCuVjS+K2tC5tMfh4i1SzdCk0F/VBVdHdf5/mAfJDliGBbaTQZ/ArjMcPcqjVLLzeuzYTJVGyIkHGh2JXjBSImA9CIG86cU3Mjb8H7cV9Z4Dqp6TnbhBYNS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814266; c=relaxed/simple;
	bh=wSshsgGED8HPu10U3N0UkRgySoxyARkIZVNYAB+8/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anxpRpyKDfwR5IpHuT1YgnI7SNdqUw7xh88GfXBM54U1c1BArrVhjbsLkLIykdZQDXMY2InJuxTYp15/6Zil77S1Aza/5CYBsTf0W/RG3JOl1uPinV6WhI4S4FAnVYUfvHSdVNlBkQ0aLAegWXfkv7Kb3yhQ6flk8Xs5WMXJcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yn0i+74x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yn0i+74x"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36799fb93baso1340605f8f.0
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720814262; x=1721419062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsMYxX3ARgmF2dcWznWm0q60TUYZFPMB1J4kCza84kA=;
        b=yn0i+74xX2d5ROXSp6t37ykE0f0FOZQ8FRirXmKKko9OwTacOodUWmJXqZuMXgYg/k
         3bMP78wHWM8bfo48yaLAD94f6SlVEbL8TT264UjgsxrcGOAOoe64VFgeTqsHGGo3Lcbi
         Rkc89NcgwQcbYVpTFLJkENZLufmaI5d9N3ARs4hCjFLWNcRrNec8L3Gi+ej06ojaw9Em
         ixjoCOj3X7IOa1RK8/63JpxeXAkcn+sRPZxDBNeJLVRYgsH0CEM2egM3oaeZEAalGyae
         F1wn4dZAomo3uAQFw5q3SqS3qR2XsD1tR+4ZLJIFZa0DskeOjABN0FoBB/lNrX16FyF2
         XlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720814262; x=1721419062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsMYxX3ARgmF2dcWznWm0q60TUYZFPMB1J4kCza84kA=;
        b=pG//OV0/AQ/n8TxiQiMI0GG1TRFJeu1oXi+0n9ECVVVfld83QzPG2a9etLVWzNp/qO
         QvL9JY1v/WrwhiT7D12qN3J7RrePlLjrqnWWbNXYBGVPDNIAii1YojxnYVtAB1PIMDr3
         c09UcJ2XJxOn702WvmZv1SNZIxMv+e0UW+mN7eKjT8HebHPUq5mNkDrDbFeiuRUQSyMy
         UtwCgX8m6ghymjWHNPij5waJYlSvLYN0Z3VpX3y7WXZk6gnJiBOfOvUvMfPxglDup+uW
         E1bNrVd1hQZm1yUevLHKzd8cip6bYXGo85zwhXIFzyj0HpIajhifebourJs274/hGVsD
         3Dhg==
X-Forwarded-Encrypted: i=1; AJvYcCVoDjk61uHbHzgzEFQh9xPOBRn6Z+8+cewUJeR9Y2YFJ5LyJfoMnWxT/iLG5LQ62Xu1RxJY75iPv+I2dQSfZkk2b176JJTUHbnME5nvlho=
X-Gm-Message-State: AOJu0Yw7JD2vqRtWZK+WxEnOpA6n3CFwQm+U+RHNR71jlgtXkT7gbuYY
	kVWUWhvkvVQtnj91iMqxjJLtnT0Twq77dGb5zM1JlbyIzWdtMd5Qn0S3lwke5Bs=
X-Google-Smtp-Source: AGHT+IG3l5o5+v6d2/YWNdG57jy0GH9496uZjsVKZv+F5Bh1e+Q20sQIL9icSK4kLKf/YCbIMoS55g==
X-Received: by 2002:adf:e7cf:0:b0:367:8f81:f9fc with SMTP id ffacd0b85a97d-367cead1615mr8665684f8f.50.1720814262341;
        Fri, 12 Jul 2024 12:57:42 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab815sm10819916f8f.110.2024.07.12.12.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:57:41 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:57:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats
 initialization
Message-ID: <20240712195759.GA2972562@myrica>
References: <20240712080329.197605-2-jean-philippe@linaro.org>
 <20240712064019-mutt-send-email-mst@kernel.org>
 <20240712182021.GC120802@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712182021.GC120802@kernel.org>

On Fri, Jul 12, 2024 at 07:20:21PM +0100, Simon Horman wrote:
> On Fri, Jul 12, 2024 at 06:41:34AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 09:03:30AM +0100, Jean-Philippe Brucker wrote:
> > > Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > added two new fields to struct virtnet_sq_free_stats, but commit
> > > 23c81a20b998 ("net: virtio: unify code to init stats") accidentally
> > > removed their initialization. In the worst case this can trigger the BUG
> > > at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
> > > random value as count. Initialize the whole structure.
> > > 
> > > Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
> > > Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > > ---
> > > Both these patches are still in next so it might be possible to fix it
> > > up directly.
> > 
> > I'd be fine with squashing but I don't think it's done in net-next.
> 
> True, but this patch doesn't apply to net-next.
> And 23c81a20b998 ("net: virtio: unify code to init stats")
> isn't present in net-next.

Oh right, it's in linux-next but it looks like it came from
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Thanks,
Jean
