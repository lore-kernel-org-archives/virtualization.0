Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981A1EE034
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975970; cv=none; b=KdCU54YQgrOISlL8D2rgB7wAJtH9h+6wglghDJyMAiuFAYWXV4MhBYSH0+IrOLqiAb9PSkY9HtgY+ZndCgiM/VBHoOxwE7VmJd8jz/SfuoHyG6Axt+AblgUoOplpPkKYPJljiiqq6Lilbcg/UMlGZjhaB5YoOxDYUEhk06hWWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975970; c=relaxed/simple;
	bh=lJMdumzOaAkNiNGo6zimgII+G/snXw0TvT8mnuAxvk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pR30z1o+eklSVrTp6HVlaKfVzSQzNyBOekATZ/bCdl2DD0gH5cVGyDocAsFCL5BPCmICiU3bXkQc8vtLKHw8cNsABjdyJcl1FX/EvGOv5wfHqH9W31UJSU03Zh2nmMOGSCJN6b3OrV3UNudOKIuyAPLQiiEZ7awHFeonQEHYqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sHPtVtCB; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHPtVtCB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA70661085
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82A3FT5Y96y0 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 10:39:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=dan.carpenter@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6B59461053
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B59461053
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sHPtVtCB
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B59461053
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:39:01 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso656538e87.1
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Nov 2024 02:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730975939; x=1731580739; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JH98gemjJTaUPfUlmHX1OFqIrt84z9GbUn53JGi6HVE=;
        b=sHPtVtCBSP7secuu/qjfQIYYLvhhV8F5BZONfEtsbCJWRLWqSestC4Qp16F4BoWKRj
         eI7CsO9HBg8ycq5S5S6VCsugBe/JSr9KW80vHPJ9nSsbehBUTTVEALRQ4Dp8znpxPKH+
         2S3uBkB2tkVEVQ7JaWWpV2VI4+GXbgycQ3pS0S8KfRYf4T6vrj4BdHmDQvjJLA9rNuNT
         X+L7XRyWSBduRCBBcW2fnG6k4NbzHTOjaQ3GDUBrr9Ewcvs5mL81izfCKkMsE9GVju+a
         NY2RtaZptobnD7fDiHe2QBz9vdUle6W5uipnV/Ux3FQv/oHUI40HLCEjWDPLOUG/gDxf
         FFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975939; x=1731580739;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JH98gemjJTaUPfUlmHX1OFqIrt84z9GbUn53JGi6HVE=;
        b=hlPpEqVqOD7S2soTQNU2M2cOpMdbvRJBk3LYJXTTQ3/KmCFRgeVsnXYMdTFZPEgozO
         uU7NeL/VCupDdB1gqWQ1pLhQ6AA+JYzr+MkONMwyNeR3zxK+LT+VjoA4f2kpJJ8XtCzp
         GjWQXmP6hogBALN0FMD4d8o1Cs2bb7dK9M7P9aROF4NLtWn0DHHkvNgMT4745egdIDVQ
         hfNkSnLm1ZWrWZAFLRWjoGQun76VRMS8AWJ9zpHDmMQGxhgfIW9zoYN+j5+XcitD3dCq
         YiLM0g8fHm/D4jYq7FvoLaw3nvC6hxM/u4oIK8sTAMPyjLanUCI7VWg8mUhhRHU2tI7u
         2u7A==
X-Forwarded-Encrypted: i=1; AJvYcCW+8ifWZXjVB7CIlgDF/tljSkSc8l6urRSJNnn3CLjI0r2yR8akR73YKfV1lrvXWOH7Qtp8jIf+vOVe5H2ocg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzx5WBMQfE20eMnBDvxUy0uUPEoSD4ctARyWmpRFEZ8UOccraQ8
	HPO9yYd+KBXF3ABNVHZsWmt/Kez4fNwmN1TtY86BnR7dGXPGl5iTPS6Wj4u3sWc=
X-Google-Smtp-Source: AGHT+IGso3elzbiaDw8i00w0KjqQ5KFuPi/CIIkjajhtEha2FDZ5ZKCSRCL4vAbs4WzAVjhcuNJGcQ==
X-Received: by 2002:a05:6512:158f:b0:539:8a7d:9fbf with SMTP id 2adb3069b0e04-53d8409e39bmr376911e87.46.1730975939310;
        Thu, 07 Nov 2024 02:38:59 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a2ccsm58130555e9.31.2024.11.07.02.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:38:58 -0800 (PST)
Date: Thu, 7 Nov 2024 13:38:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <247f4cd6-5653-4eef-9436-5699b44c4b82@suswa.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-6-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-to-allow-user-select-kthread/20241105-153254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20241105072642.898710-6-lulu%40redhat.com
patch subject: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
config: x86_64-randconfig-161-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071251.tQLG8K6C-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411071251.tQLG8K6C-lkp@intel.com/

New smatch warnings:
drivers/vhost/vhost.c:241 vhost_worker_queue() error: we previously assumed 'worker' could be null (see line 241)

Old smatch warnings:
drivers/vhost/vhost.c:311 vhost_dev_flush() warn: iterator 'i' not incremented
drivers/vhost/vhost.c:678 vhost_attach_cgroups() error: uninitialized symbol 'ret'.
drivers/vhost/vhost.c:673 vhost_attach_cgroups() warn: iterator 'i' not incremented

vim +/worker +241 drivers/vhost/vhost.c

228a27cf78afc63 Mike Christie      2023-06-26  238  static void vhost_worker_queue(struct vhost_worker *worker,
0921dddcb589803 Mike Christie      2023-06-26  239  			       struct vhost_work *work)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  240  {
001268765c12bbf Cindy Lu           2024-11-05 @241  	if (!worker && !worker->fn)

|| was intended instead of &&.

001268765c12bbf Cindy Lu           2024-11-05  242  		return;
001268765c12bbf Cindy Lu           2024-11-05  243  
04b96e5528ca971 Jason Wang         2016-04-25  244  	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
04b96e5528ca971 Jason Wang         2016-04-25  245  		/* We can only add the work to the list after we're
04b96e5528ca971 Jason Wang         2016-04-25  246  		 * sure it was not in the list.
635abf01918157e Peng Tao           2016-12-07  247  		 * test_and_set_bit() implies a memory barrier.
04b96e5528ca971 Jason Wang         2016-04-25  248  		 */
0921dddcb589803 Mike Christie      2023-06-26  249  		llist_add(&work->node, &worker->work_list);
001268765c12bbf Cindy Lu           2024-11-05  250  		worker->fn->wakeup(worker->dev->inherit_owner ?
001268765c12bbf Cindy Lu           2024-11-05  251  					   (void *)worker->vtsk :
001268765c12bbf Cindy Lu           2024-11-05  252  					   (void *)worker->task);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  253  	}
ac9fde2474d04bd Qin Chuanyu        2013-06-07  254  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

