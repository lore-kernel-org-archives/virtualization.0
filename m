Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF61EA6E
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145071; cv=none; b=OZKKtmz311JmAkpX4g87w4Sxz+jb69AJR0i2DZqKwKycpQOAgZad7QeGFiY1bDtwItCmLW2LRM4X+2C5nSlIJHaS+245njbhVNHCRlzq8XGqgtIUHJLu8esl6lTb1g9Bab3HHXM6DMp8+cQLEF6gBQEjKII/A+u/z/fMKC2nTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145071; c=relaxed/simple;
	bh=s/2MSjG8UyaUs97mrM1q6zQgCW0Xk0or22c3BdoaHmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J1MPenmPgu+/6mYjYqaEqFqlN3iy4UgBGlKKUC1A6SHg59eOXnrR38ledhEj40UwylaxzJZE1MoijHT8z5I7KoYwTAgXWUF28Ol9cakW2EXP1pGqtcOeBQKle55f/u9PZsy3RkzlPD3hzySrB/yPkRN9/8PD9aAfOzdtluf5qeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbG9uOYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbG9uOYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709145068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weArB08m8SQ4hme6AVbC9RsZWLdEnvH6fsjtADsJEm8=;
	b=bbG9uOYs5e/eFxyr/drVE+4CE8YHANICxX4H6wuIpnNSDHTUjQCLg9ZnKVE9887VIqyuwb
	P/8TNB8ng9Hv412MjXs3zY53kpvOZHezrxqK+zZypRFk8FahYX3GgwgGij+KgjKl2+pnc5
	gv5RrJuidaVw6+h9TzEmK0xcIB3r2w8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-XNHudXVBMd6w-DoaRmcj0Q-1; Wed, 28 Feb 2024 13:31:07 -0500
X-MC-Unique: XNHudXVBMd6w-DoaRmcj0Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-337a9795c5cso41555f8f.2
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 10:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145066; x=1709749866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weArB08m8SQ4hme6AVbC9RsZWLdEnvH6fsjtADsJEm8=;
        b=fcahbNEbS346dFSo98FI2Hn1IuoUU2USqLoeU5+Bs9sNZZwdULk/AZE8Hxh2+f26jw
         oWZX9fjpooec4yGwtQ3R3a+tNx1fxMux66MEF2HbnzrR0BaqDooCg4V3VAUxZkb/QpEs
         3i2WMKl1pHqDwZoQICBEtb2/XiKcX4y8S4gz+4aUGG8yoYAk4QDZi8sLmIFkXePPxOOY
         V/P9jBLza1TqvliL3ruOHc2bsD2SldI0c/WKhCold7GUuhPNTs43EURG6hG2bUXA4i0s
         rjmG2xei3EDg0U9GIYOx4ewMvf9APWoy670ak4J+iyRI6vU3aRwapbvCCjcwa7BujmPq
         Zj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs80cgZirSoe+28AiR0Ogg/L1oQ+bIk7YE4MMoI4JWy6LINwbFjBKiP8Ozjhuoma9Y/xEknUgid2EbxM1ZsOhEOPlRdOSXCdoq8JSDt4o=
X-Gm-Message-State: AOJu0YxRyDk0IOE9/byZ9zxze7ZZLZtBnU/9ptA+U8w/PPB35GfvD7T/
	Dpf8JKZfgGLpoc2Ty23jhQUCD9D4SfbQf1NI9ORuzVm1cjT49but/8QknyXgU+IFKGsjWGsSkND
	DcxmGrdCVL0HOCvqtpXcB5aoIZA2gBe+ilG35+Ex5GUAHv11qAileiooni+jwzT7q
X-Received: by 2002:adf:9bdc:0:b0:33d:50cd:4672 with SMTP id e28-20020adf9bdc000000b0033d50cd4672mr256192wrc.21.1709145066138;
        Wed, 28 Feb 2024 10:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbucOOcYdc5E7w1hWPrlSDUK3hHwk9fJn5afQ97oLMcIn3c+BDLdxi5c2NUzfMbk+v1xT5yw==
X-Received: by 2002:adf:9bdc:0:b0:33d:50cd:4672 with SMTP id e28-20020adf9bdc000000b0033d50cd4672mr256168wrc.21.1709145065820;
        Wed, 28 Feb 2024 10:31:05 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:d6b0:a21c:61c4:2098:5db])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0033b2799815csm15646500wrb.86.2024.02.28.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:31:05 -0800 (PST)
Date: Wed, 28 Feb 2024 13:31:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, xudingke@huawei.com,
	liwei395@huawei.com
Subject: Re: [PATCH net-next v2 0/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240228133035-mutt-send-email-mst@kernel.org>
References: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 07:04:41PM +0800, Yunjian Wang wrote:
> Hi all:
> 
> Now, some drivers support the zero-copy feature of AF_XDP sockets,
> which can significantly reduce CPU utilization for XDP programs.
> 
> This patch set allows TUN to also support the AF_XDP Tx zero-copy
> feature. It is based on Linux 6.8.0+(openEuler 23.09) and has
> successfully passed Netperf and Netserver stress testing with
> multiple streams between VM A and VM B, using AF_XDP and OVS.
> 
> The performance testing was performed on a Intel E5-2620 2.40GHz
> machine. Traffic were generated/send through TUN(testpmd txonly
> with AF_XDP) to VM (testpmd rxonly in guest).
> 
> +------+---------+---------+---------+
> |      |   copy  |zero-copy| speedup |
> +------+---------+---------+---------+
> | UDP  |   Mpps  |   Mpps  |    %    |
> | 64   |   2.5   |   4.0   |   60%   |
> | 512  |   2.1   |   3.6   |   71%   |
> | 1024 |   1.9   |   3.3   |   73%   |
> +------+---------+---------+---------+
> 
> Yunjian Wang (3):
>   xsk: Remove non-zero 'dma_page' check in xp_assign_dev
>   vhost_net: Call peek_len when using xdp
>   tun: AF_XDP Tx zero-copy support


threading broken pls repost.

vhost bits look ok though:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


>  drivers/net/tun.c       | 177 ++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/net.c     |  21 +++--
>  include/linux/if_tun.h  |  32 ++++++++
>  net/xdp/xsk_buff_pool.c |   7 --
>  4 files changed, 220 insertions(+), 17 deletions(-)
> 
> -- 
> 2.41.0

