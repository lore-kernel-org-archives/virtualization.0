Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C88280324
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927585; cv=none; b=iknyRd4YnzeMDf02jR5X/PCvXcxMND+xcddyENqtKkdDKRb0Vr+va5pps62UcANq1weg0WEOdiJ/4+6sEceHUr9L6+v6k379QoVcWAd6VPHAosL+VKnbuSTfcuXVMBEcLZMNfchkMnZZ1bex6M1McWT1SPz8Leufly50z4eoJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927585; c=relaxed/simple;
	bh=7+kB8ZMerG7yaoGrdsJ+/bImc0MjKYSjj9HksU+tMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfdnsYNuIrpPEamjYZi3+HP1Ea6ZO7iVHt28hUSArABo9xiLanAyA9eG8hxbC0TKZ/6JMKEAf4MAEp9jZzi5DBtc3gN8Mg9kGwjzBkdROJPilReUr3XyYkBGTWR1wHgWAYu9Hj7GozHGFnzr3YEMvfjD4VzDT/0EZFBLnE6Gq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-624fdf51b44so4714624a12.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 02:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927581; x=1758532381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtNRcJRwwCKEIJqf9/whpSBRpMqLegKM6RuT3nM+mBg=;
        b=H1UFy4/M5pn1zn5G4Z1rjSfylPXhulekMEKr8vdFIvmj28rVJJau976Qcc/VNwuZA9
         kSQKDBNOmu21JN0CKADDsu47oO5H9J2DCoFQz/f4AbwvmtsEbliafCQWjvTzTaivndqN
         Ps021l9FKlXqzHqXFCeCRnBymCP1KhJh6YfVJ2nPEjsnIGiH5XlmOOvf2X9G6kQ0Jg9W
         YCgOmSLh0+7G+oPh9RZtR68D7IRWlGmkQvUBPWHH/B/El5DYnfe/MLHfxda3BY70PuCz
         yzygmI9n8bBT4vAWO70ITqusoHUTMHXzU00k42LDuhtQ2tm0Z2i3HtwIjcNApXyIir0c
         T5bA==
X-Forwarded-Encrypted: i=1; AJvYcCViGb3bwxmX6ap8VmQW4BlMy3U+3+Rm9NKfwToc3L1w2pPM2qFcfEmSeZTGTxqjZrPvMNP05/Q0vj/vf807nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGTAg5Qj7AU9tOENWelp3fuVcDBeLAKdaWTcXYv1BpwTOZ/pMM
	tFzxMBeRO/YIIRNEu7BM0U05IXtHXVVYevbCwGpbCljdhvlB+Gkh2bnw
X-Gm-Gg: ASbGncti6v0s/0Xo2RDHu54fhMCXhdxTsQZwA8LecgFGzwBO6d0KfLUtwCGHSZWpf21
	CSKJwX/SZufPClgyoqy56Vt221vcDUlCSrqNWctDCMeCkb/Z+uRoyY6bHBwpCj2QGt6u3NqsMDx
	Htkmku+NUFKBx/vGUWC+Npb4UGky41gkOaHnd2SIZxwh8dM21+E5iSXdmSLFdlqKMRFaj5CBZfQ
	3MaH9XsJqDK4x3X3xjJSQ6KUVp9qlMNoYwic9OXj3752c0CAkPCQjvgN1uRc1QMj2hzBBLhg0bl
	Txk+hUNeltwlJttKXdyQNxrrBwrMdB6fFiQWN8QxwPu6RFet/sruRkD0xWHP/2cH5XUHKdMBwsU
	iUgr2exnncilbhDf1TWWxZ2Np
X-Google-Smtp-Source: AGHT+IEAqk1Bgc7JcF+1aQKWXD0BySjNrACtXO/rAEWZU4UuzJsWjT8CX+gGJiPIKhaccM3UW22mlQ==
X-Received: by 2002:a05:6402:2742:b0:61e:c750:1ef2 with SMTP id 4fb4d7f45d1cf-62ed82c6d29mr11320958a12.36.1757927581094;
        Mon, 15 Sep 2025 02:13:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f0dae0140sm4601341a12.48.2025.09.15.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:13:00 -0700 (PDT)
Date: Mon, 15 Sep 2025 02:12:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <zskbmdjunfamn3x3kmxcjeamnckfh4icb7emwkkwhqwstlzt2e@nqjcg5h6hgsv>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
 <20250914125949.17ea0ade@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914125949.17ea0ade@kernel.org>

On Sun, Sep 14, 2025 at 12:59:49PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 08:59:13 -0700 Breno Leitao wrote:
> > @@ -1225,9 +1242,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = ops->get_rxnfc(dev, &info, NULL);
> > -	if (ret < 0)
> > -		return ret;
> > +	info.data = ethtool_get_rx_ring_count(dev);
> 
> Is there a reason we're no longer checking for negative errno here?
> It's possible that none of the drivers actually return an error, but
> we should still check. For consistency with the other patches / paths
> if nothing else.

Agree, we need to check the result of ethtool_get_rx_ring_count, and
return it if negative. I will update the patchset.
