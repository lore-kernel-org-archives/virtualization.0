Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4B29408
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199371; cv=none; b=F/jghPVYZwmX2Yz3p7vNJAt3JlO4X2D9UFarLqVm8VB2Yyojg7TvjjCTqmGks1yuhz6hRMxmjUkfQRD/PWXat6mNHcNBth/XL3tXrpefOMcSZ6jcI8gYrICofjjsYQARxDaqwe0RhmQl7EiNPI1yQZQpjspvudDMI+J3KwiLpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199371; c=relaxed/simple;
	bh=XVP7VgwmFS1l8OgeV7xL1TtOBdkcTzkbgWgi4SDvNdM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qJLj6Qa8wuxUNV2uc50m/tl4DZfDPLYUjh1/ErqIElCuwNuL3LCQRsiaORDT0URWIi5AAOnB4cCPY4jkau5J1qkUfxLKy4r/rHrmZ3EKfESv3ezdGRCqYrJmXPbeHdQxqHkzezg9LNJeFznk4vR4zip6RglA5fpmYXb5Yh/zn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG7+nkOy; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG7+nkOy"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5da7a39e584so180338e0c.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792199369; x=1792804169; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XeNbXablXhJqiCV04B7oY6//U0VnicAkT7qj9GdtyP4=;
        b=ZG7+nkOyQvOwZkWpLZE5XlaTCAQtvnLABtvCbqcELbPw8XAgy0j0UimqVo/PvTjfzM
         XfNKlTWswiR9f/MovDp+cg/1XZ9f58nnsoifseKghNP7dNS5euz8UtAaSt7aBxGKNjr3
         2jONyb+ZGfze3/jgwZP2h3I8jG3LEfx2wYoixQVPhkJixVOvty+Oy06GyAiqXdN6aDcy
         +WPQf8CKmKTQv/3KQLQ44mfU15oxC59Sn2HW5fDIIDu73OO4gHg0j57PVwfQ/ilxyN0K
         PqMSs4UtXv0ZTXy5J8SGKtkKTOVc3fXqDQtF+T/xxEHhqZqGmpfF0k5y0+OrzoPtZ2DH
         /dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792199369; x=1792804169;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeNbXablXhJqiCV04B7oY6//U0VnicAkT7qj9GdtyP4=;
        b=Mhhc8zZUIACzxMeoPyDk28I29XC1z5+/4gLjTI42A8THL0iYRbGbmbbn7AUXIwcvEy
         L+H6aDg3TMstWX+8+RMO7H4ZH2umcgKAhuLsGN1v1DTCk1tr9KLNUNg1x8/xWt1QQwut
         q7ENlH0HTI18mT68GFDQ58M68hzNEm9u/bYBKhqc7jGfC3mqQICIHDPtb9d3Vf4sSaLm
         UKqil8oeNLnVG9FLTXPnldScN7JDmAAGYjvXNesNTmBKtnCa6BIjDo043TNE/NpF6H0J
         1P8FBEEZU+ArA/Qck5MLe3UgJ5Fp7ykw9xcFM6Ik7yYp43lWySe/+C2bMbKKcMtTcJRl
         I7tg==
X-Forwarded-Encrypted: i=1; AKwUvBxh+1wEbJlRvXhq2moZuqB2KLLQvZqfaLF9EDFqz0qmyGh6xWkHsI7uEAeqZ5XRb6I50exN1A0HVcO9jExMMg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJni/SLQYARB23gcxY5I8skrKuU/1cJJ7FUqim7gfeGSft1CFP2
	+BDGHjVSy5UK8tyz50jlv9rA/WAL+sGvdlUm1KMcci5C37QQ/K8HC/LR
X-Gm-Gg: AYBFou1Y3PHi+97COw3bc5x0R0MUFKVFwgxr8zVcJm73ALAcvo9AG3KQA9ETboyhjqS
	meusaWtcUOhsxdCcH/IusVjyLIY9THjNtMQvMhAf3Wvr/B57t+qi67+r7AGvYhT0G/xPVm+4YGJ
	N9F/7dH0DGmUYhPy76yJUluVs4TsqhmQKTcf8rtjnsCvOXK7oAtSB4mkGiBBU0ADbnLcNC/p8sZ
	9HSRWJZZ4fFk9qXh6enDL+Jy4gKXnje6Fl/Ty4a37hcWFmIOlwlp+YhTrdBhEPHAbvc5TcqvwZG
	bWZVOCHFw7HwrkTTvE3AR+LJlfD1/SS1+qTZyfWJtQQ4PpC9EQgU5PquEWA8Fmwfdw0ZBD++SOF
	vvhE/88MYk/CzbI3qHH+wMjg7zRcoQymBTRqtgVY72vD94fV3RmjX/eIT+A23uKTgjTczYyO3tL
	c+YX7xQfHLvQNaVmAJYA6FUV+fdbTMl15eug5D/kS4lOq3HKXsQ56ezIDNkrZzytErrdeWltCGp
	lszUUmNcsrWjdTvssp11Z1P8knROHgwFruAOmMoNyc+AVfCf6N69nv1n4SGpzro/IansDFbmjQB
	AC4RUPWHSe6mThwkuCBKOuXjAwSOj6r1gPH5iFM=
X-Received: by 2002:a05:6102:6d0:b0:7cc:285d:4df7 with SMTP id ada2fe7eead31-7cc3699ca12mr344286137.16.1792199368918;
        Fri, 16 Oct 2026 18:09:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc1987c95csm3579604137.11.2026.10.16.18.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:09:28 -0700 (PDT)
Date: Fri, 16 Oct 2026 21:09:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.32f6b1ecd121a@gmail.com>
In-Reply-To: <20261016143944-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
 <20261016134823-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2deaddfb31bd9@gmail.com>
 <20261016143944-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > > > > Should this be a global sysctl, rather than per netns?
> > > > > 
> > > > > 
> > > > > For customers I work with, it would be much less useful.
> > > > 
> > > > Third option: make it an integer rather than a boolean.
> > > > 
> > > > 0: no validation
> > > > 1: current level of validation
> > > > 2 and beyond: if we have to extend it later
> > > > 
> > > > Not pretty, I'll admit. So fine to keep as is too if you prefer.
> > > > But I do foresee more changes in this area, if history is a guide.
> > > >  
> > > > > 
> > > > > > Even if per-netns, most likely do not want it writable by netns root
> > > > > > with user namespaces.
> > > > > >
> > > > > > That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> > > > > > of many crashes due to bad packets ingested by, e.g., a packet socket.
> > > > > 
> > > > > Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
> > > > > on by default?
> > > > 
> > > > A single system wide field is simplest.
> > > > 
> > > > Is there a benefit to making this configurable on a per netns basis?
> > > 
> > > As I tried to explain: a specific container breaks, you decide to trust it,
> > > you do not need to trust all.
> > 
> > Ok
> > 
> > > > If so, that's fine too. As long as root-in-namespace cannot modify it,
> > > > so readonly indeed.
> > > 
> > > 
> > > Right. So I envision along the lines of:
> > > 
> > > net.core.virtio_net_hdr_validate_all - validate packets from any netns,
> > > netns root can not change it, only host root
> > > 
> > > net.core.virtio_net_hdr_validate - per netns
> > 
> > Then skip the global option, as it's just a convenience: the same can be
> > achieved by iterating over all the per-netns settings.
> > 
> > Per netns validation, but only settable by root, not by root-in-namespace.
> 
> Hmm I don't know how to achieve that. Are there examples of such
> options?

Two examples, both basically make the sysctl writable by root-in-ns,
but then add an extra capable() check in the write handler.

ipvs max_conn: in proc_do_conn_max()

        if (write && !rc && val != unset) {
                struct netns_ipvs *ipvs = table->extra2;
                bool priv = capable(CAP_NET_ADMIN);
                int max;

                mutex_lock(&ipvs->service_mutex);
                /* Unprivileged admins can not go above the hard limit */
                max = priv ? IP_VS_CONN_MAX : ipvs->conn_max_limit;
                if (val < 0 || val > max) {
                        rc = -EINVAL;

ns_last_pid, which in its original commit b8f566b04d3c ("sysctl: add
the kernel.ns_last_pid control")had a direct capable check (it was
later relaxed):

        static int pid_ns_ctl_handler(struct ctl_table *table, int write,
                       void __user *buffer, size_t *lenp, loff_t *ppos)
        {
               struct ctl_table tmp = *table;
        
               if (write && !capable(CAP_SYS_ADMIN))
                       return -EPERM;


