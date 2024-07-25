Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6719DF74
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928302; cv=none; b=tNk20NZCA+zzpC13Qovvo26lyprEkBrk0j+CUcz9he7+BS7ccXD7+vkvKzh4asV5C0MCjaPiEIDZfaYKLxHbJolVWVAqClSJrKuR6i0TXJNUvp755cgi3IM7PwlSvxg77oToASzfNsiYTSvEPjeEXuA+m+gO4OneffpvdBs4wlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928302; c=relaxed/simple;
	bh=Xiu5K1l+G5yDdAgnFQDu+MxO88zQNvs6lad/Mc4lTS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krKH34/rxSYGHbLTfI/P/YNj4UxaMro6lmR2ioQWmZd4eqBrDcZBc9Zi08AMe32ggX0Gs1STRM/VnGN0wnvPq5k5S0fISHRbc5F3CK/PAL7k20wZ+IwLKfv/CBUEeKbjeWz2sD/zQjiCm1f4rgaBs3iCYgCWO3kqPKHrIolwzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CWwdH5Yk; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CWwdH5Yk"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAB1A40607
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puJ6eb1c_xg0 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Jul 2024 17:25:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=jdamato@fastly.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E5F9140586
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5F9140586
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=fastly.com header.i=@fastly.com header.a=rsa-sha256 header.s=google header.b=CWwdH5Yk
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5F9140586
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:24:59 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-70d2b27c115so82467b3a.2
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928299; x=1722533099; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xiu5K1l+G5yDdAgnFQDu+MxO88zQNvs6lad/Mc4lTS0=;
        b=CWwdH5Yk9RkeCnB9BSiKy+0Y+jMZvt6YTDYWDQQkXhtmYLM2CIvI9rUWgEU2EbGcni
         IbgLtGRofWHeeJFBhM2k10l0kzU1bdXrHQCfBzBsDMLJmJP87ju+33FlJLk7ZM7no9pb
         h4S7cWZlEHvQJE8GlcDaWoTYc22cv0Z1m15tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928299; x=1722533099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xiu5K1l+G5yDdAgnFQDu+MxO88zQNvs6lad/Mc4lTS0=;
        b=FcmUpAFQOcdB1ZvW6h4Z96O1bACNx2Hv/VcT/G//8Ayobo8G5Lm2RFi5D/lt4bZtB2
         Wk4JnEAhpTKvp8NZKAWcXOAZQYYWNidCgA1ucpAbM2Zrf53hwHUZyklChnOgFjMZYkoM
         1qSFHiRUY3NZtfkpdvEgDCkJF+Xi6YTDVzdtv4tWW6mpajzQfM5Kb19PYeu7VKqpaTct
         Eg29CBhT2eoJ+5fUSeqItTBoWBgFd3A9tJfkXNKoIIeijgJ6eiRl6hp04RPl+WCszsSy
         VuQ6tOd47DTvRJK9gnVbl3XezCDoDrifl6kV0v3BrHKz1ZMRyjbtdftTEl40Do1xvHg6
         YNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEPFyulk0iqpWAfpgV/pHndft7po9KpOiFpcx+x96LxtMR06djVa51WVDzAcpBB3KO91gmyjMH4EZya6jKIPHL3aoyRwxx0CKEwJI4ZLrMXEUeS1P4O14Ukw==
X-Gm-Message-State: AOJu0Yw8wF4eP0o8TZGeGh9HCkwvqHWLqnyIrdBACSqd7a0r0VjeJAjr
	rKA2OVReXyHWoxqpbHcPPtLAVHuovB7ctUDTrGG+Zd3Xo8g7q7zd+CJb05nfkZg=
X-Google-Smtp-Source: AGHT+IGuZwQXIly3rfutzxzjwTkwPGi8xr+VoRd4Gi1yFWK4HNzVU9OXfNjqAtn27yPYOkpgG8rD8A==
X-Received: by 2002:a05:6a00:21d2:b0:706:5d85:61a5 with SMTP id d2e1a72fcca58-70eae8e4676mr2894239b3a.8.1721928299106;
        Thu, 25 Jul 2024 10:24:59 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8837edsm1418937b3a.148.2024.07.25.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:24:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:24:56 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
Message-ID: <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
References: <20240725013217.1124704-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725013217.1124704-1-lulu@redhat.com>

On Thu, Jul 25, 2024 at 09:31:01AM +0800, Cindy Lu wrote:
> Add support for setting the MAC address using the VDPA tool.
> This feature will allow setting the MAC address using the VDPA tool.
> For example, in vdpa_sim_net, the implementation sets the MAC address
> to the config space. However, for other drivers, they can implement their
> own function, not limited to the config space.

[...]

Nit: the subject line has misspelled PATCH as PATH

I believe net-next is still closed so this code needs to be resent
when net-next is open again in a few days.
