Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1A2E5B0C
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933880; cv=none; b=VWCWBA8i8WW7teCTn4ixIfUSwIuepa1GY8h6NUg/xKe/n63QiohGTMtiRv9EYuYychjMowsWDcJiGoN2IwckS6M2RCAYOLoyT6ftJPgC/mLdmcUGe2twbjV0gIgITUc41G3rEicfBiFfARpjgNsFVLGiWkpionFopc4dtGh9Xq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933880; c=relaxed/simple;
	bh=H8a9AOknFnKTAIvE/ikaP5nTBBNK9uvX6MCcpkX9++g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu643ebP/op6h2BUCNBd0q4p9kFsXEOSi7c65VKJ1tzE6bg3did4QepcjD5TIoj1mpCESH6C8LzZj07WIMlKBugnwr2wwIknt6Ti/qG7UkW5il2NGUBUCOSgnod90zM8hG8cojPwb63BIG9I9NDVD5eylwevihn2mjeQM0ueFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so489194f8f.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 03:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933877; x=1758538677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxA92b/5xfR0qSfNO+nVmulxGyOD0T7zyHwVnXVrHGY=;
        b=A4AyOZHTelNVl4D1fCx979fZ9r5KXAsztkNI/t/K/9nZQvGdt6+bIHqH74r9EyVHhW
         yNQIAOIycbX5/529q/8RxTPn/3NfbvnGz6MpFLP+GCrI4CdNJg2A/8dUla1VUdHn5Aga
         acVA4npSQ3P1HED+X4nwZY7ysTZceND1hmnOKOxDoOF6Tuc7tG1wkz6E8sUMWCptq2GS
         QVJ1TQkfO5Ur0O/xzBoJagLNpoT4AvfYtFZS+Y1LcYdMLIxHu8iltSm5G/onul/0qfnR
         KiXDgRLx7m6Sdd9DQltxksDbEq3CSP/xi3kAe0/DPs5IKvDOCW1U84M9kvAJzg8icNPB
         VTqA==
X-Forwarded-Encrypted: i=1; AJvYcCVGFVF6pgyj1nJGoTdd6isF6OScow0rlumiksZGY/JrXds2nftdoWhCrrWYDCVfYvS6W3A0Fow8SWyQtX5VsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOHh6+oxsXll5aG2U6RZjI7Ns4R8EiTQAzbfYctku+btyEkIkZ
	cC0E1Fx20McU606K3LAFkI1sNml3ll8ttXaOT9C4AnU0M7+SQJr8uF/H
X-Gm-Gg: ASbGncuCQiHWQs1JGqBxc7nWXoEpPFYQ2QlGmkjU4bZLdWQEWdTydt7una/6Aytd6mv
	u7xWD0q2IWPn636czH5/NjEg9Pq7gGXY38iV+KYA8qMGjvigushMCp4GodXnbwq/f4PRpbst6pP
	gxCmWcm5oeFOQQZAhZRCMFCtt8jFVlx4DchNkklWlLAZ2NWGMBokF5E/ja249ZzIdYAEvqr+CEK
	uo7+q/F7poPGVLXRwXZzxq4KxMVg4fuvHatZfFqmNoRX+Mz3tex4NqLwOi+1Pu2Mv4RoqPuk85I
	TWLNd4bZU/4eZf6lhzJCkXYTOBO7Iw+ByG7tvIUVQV+ghHjMfRTE6jId+zEF5dL9ddRjYV8gmHM
	qaaT8Ab9hITvq
X-Google-Smtp-Source: AGHT+IEqBROGBlCJuMZ5Xroh5nM+yePitTdtSR2h9RagADSGmVIoyFS5fOwROqRLNyP0ZkUbkvwstg==
X-Received: by 2002:a5d:5f42:0:b0:3e8:6b2b:25e0 with SMTP id ffacd0b85a97d-3e86b2b278bmr6162260f8f.25.1757933877209;
        Mon, 15 Sep 2025 03:57:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm8998142a12.18.2025.09.15.03.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:57:56 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:57:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
 <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>

On Mon, Sep 15, 2025 at 03:55:53AM -0700, Breno Leitao wrote:
> On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> > This series of patches introduced a kernel panic bug. The tests are
> > based on the linux-next commit [1]. I tried it a few times and found
> > that if I didn't apply the current patch, the issue wouldn't be
> > triggered. After applying the current patch, the probability of
> > triggering the issue was 3/3.
> > 
> > Reproduced steps:
> > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > 2. applied this series of patches
> > 3. compile and install
> > 4. reboot server(A kernel panic occurs at this step)
> 
> Thanks for the report. Let me try to reproduce it on my side.
> 
> Is this a physical machine, or, are you using a VM with the virtio change?

Also, I've just sent v3 earlier today, let me know if you have chance to
test it as well, given it fixes the issue raised by Jakub in [1]

Link: https://lore.kernel.org/all/20250914125949.17ea0ade@kernel.org/ [1]
