Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE710799
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090237; cv=none; b=Zg7N5154XyFNlJjxvWkQcYfkTh+BQuo/gyAzI+VDKJgls9grbPwC07HII5RG4eCVR/R7NndXFhPknvRUBfSdySgricCpFHu9vYeg+sCQCXAIXvjWWaX69Jl1Q+bNiJ2QFTsiWHxjdIulJ0glXBcq3CuCjk4t78WZGK/xCNhKvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090237; c=relaxed/simple;
	bh=zrzuAso8aeh5pC4mAiFrJhVpvOb5mnzmkaw95vJcMks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZnlfH7Lx7xYYU1tzJvdBVFumWvN5j/5a2ag/nBocZGyJzmL8EqMk1CpP9wWNfY6AXnYioLKMmUSAcNICkcNGLkor0qwQqvVXw/jYvj4xom7jjLKrkgKR2S91O/tESbK3h2YvDI8sais2s/kpeskVo1dyVFdyb1ej/+mCqtd68ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nf0vgoyt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nf0vgoyt"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d476d7972aso31007331fa.1
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711090234; x=1711695034; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lear5JurVCpdFHONteGtRS/FeuXHg1HujgyE41Ql6qk=;
        b=Nf0vgoytz8xeVZd7qc9PE0yOTBNACkvCE8atRlbnv4OIRNN3p9Q2YohTWwKctKm/Qb
         aJAEWEAoPjMPgeIsyaUeLH3gGtQ4zB8FZWfe5Eb6MaOGHtCy1GPumP+fqQdKO1JHCzMo
         1WdNNxD/z2qkuAA3svT/y18tVd9CxjtjMRrSH+Zbif+MswHUywXn0YumwdPk4DbXjFFI
         9Ucjd0s7ym7L56Zndpc0h6/V+xUKKQhWEdCMWX70hueEPAy/ytfadc3pQbSzRYhpgPn1
         T18tC2TaHA3g55gposEey2r7DEvT3ngHXWaZy9eyIq61fhx6FVQNcXOh7krDQlCQVgLD
         KLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090234; x=1711695034;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lear5JurVCpdFHONteGtRS/FeuXHg1HujgyE41Ql6qk=;
        b=J8hdcM0R7cRSgOWUDSY91RSGlnST6BL6YjWsVIR4iWGEuYguwDabkC5Saflt7am7bi
         jt58/otLvUfXVSNeBuOdwTacWaDo4jvKgZBa2v5T5LDQxdacYMUfHO8kdR16Ok0JgxqP
         g749XVqCsnrqJXaxhSn1qTnrZLImxfZ6hLUbssUos6VaLoEYiC/aIsOfJaPZia6obxUx
         zCjQ4K72V/XeCfpZ1jV0WMOuYEunMGu0WL4vu4vHftgGhQH0xmuV8JDw675EBuGZUALJ
         FHXmIqOrlfjtquZ7PyakHQlaHsZ43RWF6h5aQY3QZFs+Rp0SQ+hZTO3mxXOtNVQjytYN
         xuow==
X-Forwarded-Encrypted: i=1; AJvYcCV97fbY6H5eBv5Qh70Snjxh6/VHpDjAGfJDsuyr9bixue2KLjbucNC2R7i82ITe5sSt9XkOTchV3856uubnsFLxYKo7WPKkw38zh7w/rlE=
X-Gm-Message-State: AOJu0YyVl+NSNc39jQxjkHS8ywq/IGwj5NES7rN7Qcakr4QWMOktKOek
	Y9mgzKxJpWzoJ6qHW7oAMWYbW1Id2LYDAZbExI9xUX76k6XmQcgI6C3IK5h4AVM=
X-Google-Smtp-Source: AGHT+IFMKzopYJg1Vt6qS3sf2pwS4XyO1nc7E0ZLMHJ/MRpND18D1RLffEWtQvCiMJW2u64hmYBWrg==
X-Received: by 2002:a2e:3015:0:b0:2d2:dfd6:8335 with SMTP id w21-20020a2e3015000000b002d2dfd68335mr1126741ljw.22.1711090233349;
        Thu, 21 Mar 2024 23:50:33 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b00414659ba8c2sm2090679wmo.37.2024.03.21.23.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:50:33 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:50:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Heng Qi <hengqi@linux.alibaba.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
Message-ID: <b7392d49-5619-4653-b565-29a7c5ca6ca1@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-fix-possible-dim-status-unrecoverable/20240321-194759
base:   linus/master
patch link:    https://lore.kernel.org/r/1711021557-58116-3-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
config: i386-randconfig-141-20240322 (https://download.01.org/0day-ci/archive/20240322/202403221133.J66oueZh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202403221133.J66oueZh-lkp@intel.com/

New smatch warnings:
drivers/net/virtio_net.c:5031 virtnet_probe() warn: missing error code 'err'

vim +/err +5031 drivers/net/virtio_net.c

986a4f4d452dec Jason Wang            2012-12-07  5006  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
3f9c10b0d478a3 Amit Shah             2011-12-22  5007  	err = init_vqs(vi);
d2a7ddda9ffb1c Michael S. Tsirkin    2009-06-12  5008  	if (err)
d7dfc5cf56b0e3 Toshiaki Makita       2018-01-17  5009  		goto free;
296f96fcfc160e Rusty Russell         2007-10-22  5010  
3014a0d54820d2 Heng Qi               2023-10-08  5011  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
3014a0d54820d2 Heng Qi               2023-10-08  5012  		vi->intr_coal_rx.max_usecs = 0;
3014a0d54820d2 Heng Qi               2023-10-08  5013  		vi->intr_coal_tx.max_usecs = 0;
3014a0d54820d2 Heng Qi               2023-10-08  5014  		vi->intr_coal_rx.max_packets = 0;
3014a0d54820d2 Heng Qi               2023-10-08  5015  
3014a0d54820d2 Heng Qi               2023-10-08  5016  		/* Keep the default values of the coalescing parameters
3014a0d54820d2 Heng Qi               2023-10-08  5017  		 * aligned with the default napi_tx state.
3014a0d54820d2 Heng Qi               2023-10-08  5018  		 */
3014a0d54820d2 Heng Qi               2023-10-08  5019  		if (vi->sq[0].napi.weight)
3014a0d54820d2 Heng Qi               2023-10-08  5020  			vi->intr_coal_tx.max_packets = 1;
3014a0d54820d2 Heng Qi               2023-10-08  5021  		else
3014a0d54820d2 Heng Qi               2023-10-08  5022  			vi->intr_coal_tx.max_packets = 0;
3014a0d54820d2 Heng Qi               2023-10-08  5023  	}
3014a0d54820d2 Heng Qi               2023-10-08  5024  
d8cd72f1622753 Heng Qi               2024-03-21  5025  	INIT_LIST_HEAD(&vi->coal_list);
3014a0d54820d2 Heng Qi               2023-10-08  5026  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
d8cd72f1622753 Heng Qi               2024-03-21  5027  		vi->cvq_cmd_nums = 0;
d8cd72f1622753 Heng Qi               2024-03-21  5028  		vi->dim_loop_index = 0;
d8cd72f1622753 Heng Qi               2024-03-21  5029  
d8cd72f1622753 Heng Qi               2024-03-21  5030  		if (virtnet_init_coal_list(vi))
d8cd72f1622753 Heng Qi               2024-03-21 @5031  			goto free;

This should probably set the error code.

	err = virtnet_init_coal_list(vi);
	if (err)
		goto free;

d8cd72f1622753 Heng Qi               2024-03-21  5032  
3014a0d54820d2 Heng Qi               2023-10-08  5033  		/* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
d8cd72f1622753 Heng Qi               2024-03-21  5034  		for (i = 0; i < vi->max_queue_pairs; i++) {
d8cd72f1622753 Heng Qi               2024-03-21  5035  			vi->rq[i].packets_in_napi = 0;
3014a0d54820d2 Heng Qi               2023-10-08  5036  			if (vi->sq[i].napi.weight)
3014a0d54820d2 Heng Qi               2023-10-08  5037  				vi->sq[i].intr_coal.max_packets = 1;
3014a0d54820d2 Heng Qi               2023-10-08  5038  		}
d8cd72f1622753 Heng Qi               2024-03-21  5039  	}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

