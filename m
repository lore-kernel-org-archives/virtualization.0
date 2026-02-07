Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951833321D7
	for <virtualization@lists.linux.dev>; Sat,  7 Feb 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460620; cv=none; b=ZgZRyWrZJx2GtDNybszmpR0NxAY0cvKNXRouZUBKhnLHFsJrI76yZYcE9rRYqHJ1W6VG8yKb+xU1YmBa3cQ57rhanD8DlaQLcAkt6aFDWDHL8Drs6lND3s78GoWmqrFoECxpuyrhrNcoXRwHSQtZhprxcmwMlPYNTuk7XAjrTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460620; c=relaxed/simple;
	bh=LSToBen3PC7STn5LIO5y4sRfmIQC6eXFBNpCr3/T+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YH7r8SvkuMrEkCa37MUsop1oOBNaa2wrkl1an10C4XSN43YQEb+8delH5OmiiHf14nUz6lmxWN8gIkkC/2KeaIauon+uHWlbtgSuNcHB8RENggHPPi7gEshX/MqBhTCnoJAbYCxNRynlVG8paXt2EZZX13U8tbwKeJGiycHVqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lnk4xgc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lnk4xgc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770460619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kh3D9klgXXKO9Bcq7zAYbqELTISjbIQTe+oHD7vW69Q=;
	b=Lnk4xgc4hE3Od5d2fdV/TXSCL3I7Uo8CgsKTDtjjfLm+QCYihWvH0bW2s8hiH4kJkB0K5P
	wXYsmZxKux+w9p6fEAQ1bo8yhHIbNPtkp+crx+LUzgOqRBJiXsTwcWAj2e9XLaw3b+Zo+j
	Be5qf/g30oFNTm8US5rriNbb8H/bUmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-qFXvsGBROkmGtbeS9hzXMA-1; Sat, 07 Feb 2026 05:36:58 -0500
X-MC-Unique: qFXvsGBROkmGtbeS9hzXMA-1
X-Mimecast-MFC-AGG-ID: qFXvsGBROkmGtbeS9hzXMA_1770460617
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-482ef3af991so18397365e9.0
        for <virtualization@lists.linux.dev>; Sat, 07 Feb 2026 02:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770460617; x=1771065417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kh3D9klgXXKO9Bcq7zAYbqELTISjbIQTe+oHD7vW69Q=;
        b=QMk5bMnddqXgV2Et2MeZ8IbMfYW5emgsj2xDEhCD5RotUQ9hSzZOTC2CoHaLutBsTn
         cZmOWcto/dMkUTLksb2JMJtsB9W/GigywFowlXaf9A/ZZKvXpndiuWuoMEcuQCp2SD7a
         r7bYYSKXHWyjp5HiwIc9lV2R0aU2D1xAtJHFkN7OJgnSgMWCk7nGd3Mc/G7juP5NAwWb
         +AK0xAQ5OsUI0OjZk4CWXIEIWrCQ6jXGNG7oYJ4gwqYXE0IE30DjwiWnauJnjDv6HJsd
         14musn1QPoOApvm9ahCrMqptLvh00uHTuqT/rVs1s6YluyFZUaWUaO48T2JT9YY14Qft
         jvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv45OUeP6IEbIouPOPvTuLhUvIpVnU99Vx2NboR+IkaI5Vz5weOU7kbMR0SKyL6IV72a5LJnb8LjA7s9221Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8lckSSGASMmFCnaYbylyYnvjbc52OFjAc6tn136PWJ+cmjDuf
	2/xCI/3zwZA9/SR9QQnxRF1tPsm+j7dhE8975K24PJbPGMsE/bNUaxnIr09tnPpcN/s0TysjY7u
	s0zcvmW0x1I9SkClxAEhlyVPnTmMI5KE54wmNtOhVsx5mYQ1rN4M77uC9pqOMVPKYBX0d
X-Gm-Gg: AZuq6aJmWghtY8KHmfgkTjMO1Rkbg20f5pj1D6KYNfnNNXIWiZNAT62xAbRnf8HnOis
	dbgbHR7NOrc0ZYUjRP5JlIQ+ORFpF9He0bI0bsFKPdAH2geNs96gl9QXN3h68B+VNVdTyWgkJXb
	tqdfvwhd6ekeE0W35O2XOtWcjViyfSpS7Zsx4Bb0VitAmU7k2oOy2JTPujWBzzFWb67UuuVrGzN
	i/ZFi9d0rkgG8TKJE5Whc1blPn9bbV61fjoVsRJ9PyJGClk9fx0HBhA6YQRgLUfFof9wt21em39
	jCedx950j76t7lBMRc2xDcMVILfxKVdxMtvuRBa0RE+3j6arcW3lEHctDLq7iAnD7Kr7xE4z8Tz
	wci8rdUPojt00tJYo5C3ThNnwLpwMqnzBpQ==
X-Received: by 2002:a05:600c:810c:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-483203ab857mr91768485e9.8.1770460617158;
        Sat, 07 Feb 2026 02:36:57 -0800 (PST)
X-Received: by 2002:a05:600c:810c:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-483203ab857mr91768265e9.8.1770460616804;
        Sat, 07 Feb 2026 02:36:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719bf4sm107581565e9.10.2026.02.07.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:36:56 -0800 (PST)
Date: Sat, 7 Feb 2026 05:36:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, pabeni@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260207052531-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260206191308.7fdbfef4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A_tJhvHqd6EvWXnAnFSzZa-hOFg9WfldJ0OdQVrwuI4_1770460617
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > align with kernel's standard RSS key length. Add validation for RSS
> > key size against spec minimum (40 bytes) and driver maximum. When
> > validation fails, gracefully disable RSS features and continue
> > initialization rather than failing completely.
> 
> Hm, FWIW clang says:
> 
> drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
>  6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Which is kinda annoying because the value was increased in net-next.
> If Machael wants this backported then we need to keep the check
> and follow up in net-next? We could try to cast the u32 away but
> that feels dirty..


for net next we will presumably replace with 
	BUILD_BUG_ON(type_max(vi->rss_key_size) > NETDEV_RSS_KEY_LEN) 

and I think we should get rid of VIRTIO_NET_RSS_MAX_KEY_SIZE while
we are at it.

-- 
MST

