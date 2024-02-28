Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20373515
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123786; cv=none; b=Q1WX6fdvkkMN2DJ0xVGeYrE7aOLhMtzUVVFEAoTv8k0Y/Re0vw1N3IPQw3dii40gUR02vztOmNRqiRMlSjAlvPNapVHJIvYrOupFN9NSTePB9bXq0CTVd65Tmuw8c6rpDWXKTMHKF8uYBWsTQ1aZ4OrWHzRX8mQWfAWc9Q+Wkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123786; c=relaxed/simple;
	bh=JV34Rsk9Ud6TAluSh/NNnx0sR4WyEiQcLsdy9DEB4qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsZlxh0UNc1txqNdKOxmwaQzmTM0u4cnUcZOyjy/vGuFy6g80x2BAbiSGwUZ5MigxvKkyJJGReOXIRrcOFE2rR/YTyEd4+CGjerByf805XjMOoNPYNyaxLUH++3YA7CUjIIQB6kQ/+G033enAkNPbjAMYnc30VKmyyBooR/O9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lfOopEHs; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lfOopEHs"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d27184197cso68364581fa.1
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709123783; x=1709728583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1r218cPQs+vQGXk5W8TMf0lKe2Qttm/rc570dURd+N8=;
        b=lfOopEHs2n9rLOdmnBctjvC6BhMHsIwRlrF0AFdX+NAXW64JSrlFdfl+m956+NQdCw
         zAMPKiptddWU+sqcreDQ7yCNxliIjMM669CPINwq33M9WJUxcL5aHsVJvQYpBkB42XxG
         pZ1mhw+wa43QxvbmxspoAPF6DCJMvuMQeFoEIutI564+FEbmkuUmuwMLy27u+jdyad0x
         43xpjJADgk8rx7hoP6q3FyUmEKQyMwxbSLkAjZUuft3teqHv+DUgm6pdde8FhqTFK841
         MQSOV4jgXPtzjCwfWRg7x+HFqe91x6o1pBeyY5PGRhFEC7hwAvlKf8q4ymQbrYPL2PXG
         sQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123783; x=1709728583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r218cPQs+vQGXk5W8TMf0lKe2Qttm/rc570dURd+N8=;
        b=Y1PHm4GAa6nObOKuhG4q9ACsUxrV8EY9f6ibovOyqJ6BzrE+dDkP5RS1wVhIBSixNa
         1BG+ArZ1cpsZJh7Ik8N2FodbMsNEno1t/hwURHFPX3WpSFnqd2zoXE/FIC9mgIshpu3B
         tXX6JVBrGI81CQQkeLKsOLnCY2L5Y9frAxV30o0P/u7jC8WvMQGCP1PbNig/VC4sTGA+
         W3fj90c1yXG4p3PvPPlGKYGT00+IKh7dyp8yU4SBB+Ma/hNM27Fz82Y3yOQ9W4j0NZrP
         e6XORtbg5sRUzLSYRV1tcz/vjf/JQz7PSMPw+QwI29Y/c6RaIm3hr7mqWfO7RuS04rfR
         fi+g==
X-Forwarded-Encrypted: i=1; AJvYcCU0QFdQ1+TjudoL12cquuZIqZcW5BPsoMmybMibm/qSRk8gQQShSkIu2TNJ3OiHDNPw97oNi7NptFouk6kF7/ir8AajWqqYdkKe0ldGmEM=
X-Gm-Message-State: AOJu0Yybc5nG3M/x6wUtKfdYiZQAzqOz29bBTlJMBnqgG8HKBlE1euII
	jE9+HkBxMMGV55g88G/MZbISePcq5MoC9ajJArjEle3/KBt7b4nwEJQ/PfGbn4I=
X-Google-Smtp-Source: AGHT+IFb88pLzc0mMMHFWr4GGKTyW9NIU1Fk+9L4Orhc7J610CrnBoBIDGq7iYcyyvZI2ScWuygMWw==
X-Received: by 2002:a2e:99d5:0:b0:2d0:b758:93a5 with SMTP id l21-20020a2e99d5000000b002d0b75893a5mr7831033ljj.18.1709123783116;
        Wed, 28 Feb 2024 04:36:23 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c230900b004129018510esm1949803wmo.22.2024.02.28.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:36:22 -0800 (PST)
Date: Wed, 28 Feb 2024 13:36:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: mst@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, xudingke@huawei.com,
	liwei395@huawei.com
Subject: Re: [PATCH net-next v2 0/3] tun: AF_XDP Tx zero-copy support
Message-ID: <Zd8ow_KkdzAfnX8l@nanopsycho>
References: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>

Wed, Feb 28, 2024 at 12:04:41PM CET, wangyunjian@huawei.com wrote:
>Hi all:
>
>Now, some drivers support the zero-copy feature of AF_XDP sockets,
>which can significantly reduce CPU utilization for XDP programs.
>
>This patch set allows TUN to also support the AF_XDP Tx zero-copy
>feature. It is based on Linux 6.8.0+(openEuler 23.09) and has
>successfully passed Netperf and Netserver stress testing with
>multiple streams between VM A and VM B, using AF_XDP and OVS.
>
>The performance testing was performed on a Intel E5-2620 2.40GHz
>machine. Traffic were generated/send through TUN(testpmd txonly
>with AF_XDP) to VM (testpmd rxonly in guest).
>
>+------+---------+---------+---------+
>|      |   copy  |zero-copy| speedup |
>+------+---------+---------+---------+
>| UDP  |   Mpps  |   Mpps  |    %    |
>| 64   |   2.5   |   4.0   |   60%   |
>| 512  |   2.1   |   3.6   |   71%   |
>| 1024 |   1.9   |   3.3   |   73%   |
>+------+---------+---------+---------+
>
>Yunjian Wang (3):
>  xsk: Remove non-zero 'dma_page' check in xp_assign_dev
>  vhost_net: Call peek_len when using xdp
>  tun: AF_XDP Tx zero-copy support

Threading of the patchset seems to be broken. Did you by any chance send
this with "--nothread" git-send-email option?
pw seems to cope fine with this though.


>
> drivers/net/tun.c       | 177 ++++++++++++++++++++++++++++++++++++++--
> drivers/vhost/net.c     |  21 +++--
> include/linux/if_tun.h  |  32 ++++++++
> net/xdp/xsk_buff_pool.c |   7 --
> 4 files changed, 220 insertions(+), 17 deletions(-)
>
>-- 
>2.41.0
>
>
