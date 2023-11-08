Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464C1113
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wk2Lqgcn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7213181B60
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 02:31:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7213181B60
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Wk2Lqgcn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iq_xlubPoTOF
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 02:31:28 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 737BA81B3E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 02:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 737BA81B3E
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d0760cd20so3370066d6.0
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Nov 2023 18:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699410687; x=1700015487; darn=lists.linux-foundation.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbkEkmaPK3/ui+Xn8VLbQvKYhD+dtLCrbQNgJWW9Ttg=;
        b=Wk2LqgcnmORpJQ0b0UXnNEk/cDZJ5C2mpDGAEfDY/+ALf0ZxvNMgxa5REJYl5UcXYb
         53+PFoGBFPTHPkBSDfoTcxRZ/K4UaFhjdC76uk4txAzFycyAX9bguRXT7qYEJB88/PrW
         VaxzUDa4xUG6OdSbkoDBE6cUZMKeb6o6mMHJJ7ErHYaRDbBaZat4t4tXUI2RBjQHK8Il
         9XQVZhrAjJmYfYkMFcRjzRa9W1AkBiLLXC4ReV41dFa/EM5pyBj4FXA3yzk3/sLlPekg
         zGsAUAIbIMNX8e26w8KDbETnQzoaaI9ws4DWQX1+nIbjHlKuL+GnNJbxmMQojDP/D/xS
         CAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410687; x=1700015487;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkEkmaPK3/ui+Xn8VLbQvKYhD+dtLCrbQNgJWW9Ttg=;
        b=nHHduFFtKV8B4o55xm3OQy8inFRrNkB8rf/Ii7doRLa/q+foBUJO6MpTYLeq+UPfN6
         9NLbh7Pkb/qVDMTgf5INqsa9bZL0BN+0mT+b11WeedK97E5T4fv7unNDylv7s8jW4Xbe
         h6OgV60mTdat/7NzaVs7UxHN5ZXVB6K4LcpoZO9mV0omFXAe+/SHFgKsE4rOtR1y/PTY
         iU3wS8NI/fPCK7iB5GuaEMs/kuVhrBLOOlIZIH9vyJDNOInhBtrOTvUjSS87e2mtpl6F
         G+N18XEZHI3X7q/5dtLcmUvPAUiqm7qbJH5xugQKl2atOVJgmWnz3wQv8jfsn3a3Cdr6
         gerg==
X-Gm-Message-State: AOJu0Yy9Sxs8PPazmLrPd9nZ1ul5MyCKFj2P0+OSke+kb9bETIRHODp4
	ywyWEr7UEz60iETKPc1hyEZn
X-Google-Smtp-Source: AGHT+IHTQ17LSA0ZChaX7vVfOq7M+l/b0UClJGf/WWYEXhjE85AkbiAYBvrrWJaZNK86n6MyC7kFYg==
X-Received: by 2002:a05:6214:b26:b0:66f:ac87:73b7 with SMTP id w6-20020a0562140b2600b0066fac8773b7mr6056996qvj.15.1699410687064;
        Tue, 07 Nov 2023 18:31:27 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m13-20020ad4504d000000b0064f3b0d0143sm548809qvq.142.2023.11.07.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:31:26 -0800 (PST)
Date: Tue, 07 Nov 2023 21:31:26 -0500
Message-ID: <2b8269b7c58ebf9b260b4e2a0676bc22.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
References: <20231020155819.24000-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-5-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Oct 20, 2023 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> This patch introduces LSM hooks for devices creation,
> destruction and opening operations, checking the
> application is allowed to perform these operations for
> the Virtio device type.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
>  include/linux/lsm_hook_defs.h       |  4 +++
>  include/linux/security.h            | 15 ++++++++
>  security/security.c                 | 42 ++++++++++++++++++++++
>  security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  6 files changed, 130 insertions(+)

My apologies for the late reply, I've been trying to work my way through
the review backlog but it has been taking longer than expected; comments
below ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2aa0e219d721..65d9262a37f7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2016 Mellanox Technologies
>   */
>  
> +#include "av_permissions.h"
>  #include <linux/init.h>
>  #include <linux/kd.h>
>  #include <linux/kernel.h>
> @@ -92,6 +93,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
>  #include <linux/io_uring.h>
> +#include <uapi/linux/virtio_ids.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>  }
>  #endif /* CONFIG_IO_URING */
>  
> +static int vduse_check_device_type(u32 sid, u32 device_id)
> +{
> +	u32 requested;
> +
> +	if (device_id == VIRTIO_ID_NET)
> +		requested = VDUSE__NET;
> +	else if (device_id == VIRTIO_ID_BLOCK)
> +		requested = VDUSE__BLOCK;
> +	else
> +		return -EINVAL;
> +
> +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
> +}
> +
> +static int selinux_vduse_dev_create(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}

I see there has been some discussion about the need for a dedicated
create hook as opposed to using the existing ioctl controls.  I think
one important point that has been missing from the discussion is the
idea of labeling the newly created device.  Unfortunately prior to a
few minutes ago I hadn't ever looked at VDUSE so please correct me if
I get some things wrong :)

From what I can see userspace creates a new VDUSE device with
ioctl(VDUSE_CREATE_DEV), which trigger the creation of a new
/dev/vduse/XXX device which will be labeled according to the udev
and SELinux configuration, likely with a generic udev label.  My
question is if we want to be able to uniquely label each VDUSE
device based on the process that initiates the device creation
with the call to ioctl()?  If that is the case, we would need a
create hook not only to control the creation of the device, but to
record the triggering process' label in the new device; this label
would then be used in subsequent VDUSE open and destroy operations.
The normal device file I/O operations would still be subject to the
standard SELinux file I/O permissions using the device file label
assigned by systemd/udev when the device was created.

> +static int selinux_vduse_dev_destroy(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVDESTROY, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
> +static int selinux_vduse_dev_open(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVOPEN, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
>  /*
>   * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>   * 1. any hooks that don't belong to (2.) or (3.) below,
> @@ -7243,6 +7295,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  #ifdef CONFIG_PERF_EVENTS
>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>  #endif
> +	LSM_HOOK_INIT(vduse_dev_create, selinux_vduse_dev_create),
> +	LSM_HOOK_INIT(vduse_dev_destroy, selinux_vduse_dev_destroy),
> +	LSM_HOOK_INIT(vduse_dev_open, selinux_vduse_dev_open),
>  };
>  
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..d3dc37fb03d4 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
>  	  { "override_creds", "sqpoll", "cmd", NULL } },
>  	{ "user_namespace",
>  	  { "create", NULL } },
> +	{ "vduse",
> +	  { "devcreate", "devdestroy", "devopen", "net", "block", NULL} },

I think we can just call the permissions "create", "open", and "destroy"
since the "dev" prefix is somewhat implied by this being a dedicated
VDUSE object class.

I don't see where you are using the "net" and "block" permissions above,
is this a leftover from a prior draft of this patch or are you planning
to do something with these permissions?

>  	{ NULL }
>    };
>  
> -- 
> 2.41.0

--
paul-moore.com
