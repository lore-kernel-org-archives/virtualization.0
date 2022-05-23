Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E64C433EF
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 10:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46C9F83294;
	Mon, 23 May 2022 10:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyNB9fJlRO_g; Mon, 23 May 2022 10:27:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA4FC83252;
	Mon, 23 May 2022 10:27:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 890ACC0039;
	Mon, 23 May 2022 10:27:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3465FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8A5560A93
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brRPhph-Nwv7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:27:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D75660736
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653301623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQk+7rW1KHrpPCrFUi3+ly+iMyDJ3LafNtMVWnd05zg=;
 b=VEnq6nSXE/q4nnSGeK3ZHfOS982L9l2sym0uqFqZi81ov4CtbiJCkUgSMfC/GBThPOIJqY
 SKXwR6z0Trt6CV3+sI8YfZYutzSeG8Q0NXi1u5VqBKpbHXDnT1oEhcMpP4HiEQzcDH+Yj8
 kA0NGpqjIcQpUGMUn8K/5m34+/BrxiA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-jFJQefeuOCGNz4fVXaayBw-1; Mon, 23 May 2022 06:27:02 -0400
X-MC-Unique: jFJQefeuOCGNz4fVXaayBw-1
Received: by mail-qv1-f69.google.com with SMTP id
 cf3-20020a05621403e300b00461d0bc91c3so10599031qvb.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PQk+7rW1KHrpPCrFUi3+ly+iMyDJ3LafNtMVWnd05zg=;
 b=WwXIVWC95RRI5d/Woy2p7JnBrn8KR1vn05X9zfz0hu081cRm01HV51112AtEqQWj6p
 t4BGG1tpBZ/nzA9jbCTPLJpQ3yBVJpdDEVgRUy+1R4GpLVmFg3OFIUff3on2KefQCn4q
 5/N+rnfcdwErwZKcVROMAjWobx8rrVG1scsT1MrMh/TCBM3BiFctI9yV0/FvHqWe8cMt
 Av6JaNaEqGMSYMhSWBMx/jJll4k+0jB8ygUAYlzho0eTsRP37Pv38FmMWMkYlzG5yesF
 BNGQwnnEx6O5og+fMKGGQCGMBfKu0lBJKc9mf9SJNG0w2Xun52LzWdeqG738Vbw6l1me
 /7IA==
X-Gm-Message-State: AOAM532kzMuNqYQDIdpiRHDIDnFLgdxL+7FqnKEkGyV7TK9JS12RdlR7
 3n8D2YIgLsxBpFR+xt6jNfgI/93+CAKI1Ery4L67VpwG/Az7P5LZ1EQqDkyMD4cyhnahQ7SyFAq
 ZXuP/M03MY21bCTC+pBtDetgjjad5a3z+mmasV8CYeg==
X-Received: by 2002:a05:620a:11b6:b0:6a3:2569:7a4f with SMTP id
 c22-20020a05620a11b600b006a325697a4fmr13087728qkk.666.1653301621338; 
 Mon, 23 May 2022 03:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAINHF+Idj85HABajS5ILYnCkCC1a6nQrZSRpJKsF7JdFMy26kOhPbKyOAkmAXQ/C5w4e8rQ==
X-Received: by 2002:a05:620a:11b6:b0:6a3:2569:7a4f with SMTP id
 c22-20020a05620a11b600b006a325697a4fmr13087711qkk.666.1653301621066; 
 Mon, 23 May 2022 03:27:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05620a10af00b0069fd57d435fsm4150081qkk.101.2022.05.23.03.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 May 2022 03:27:00 -0700 (PDT)
Date: Mon, 23 May 2022 12:26:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [mst-vhost:vhost 26/43] drivers/vhost/vdpa.c:1003:3-9: preceding
 lock on line 991 (fwd)
Message-ID: <20220523102654.dzcrab3u4mxftgtu@sgarzare-redhat>
References: <alpine.DEB.2.22.394.2205201835450.2929@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2205201835450.2929@hadrien>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Gautam Dawar <gautam.dawar@xilinx.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, May 20, 2022 at 06:37:01PM +0200, Julia Lawall wrote:
>Please check whether an unlock is needed before line 1003.

Yep, I think so. Same also for line 1016.

I just saw that there is already a patch posted to solve this problem:
https://lore.kernel.org/netdev/89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr/

Thanks for the report,
Stefano

>
>julia
>
>---------- Forwarded message ----------
>Date: Fri, 20 May 2022 17:35:29 +0800
>From: kernel test robot <lkp@intel.com>
>To: kbuild@lists.01.org
>Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
>Subject: [mst-vhost:vhost 26/43] drivers/vhost/vdpa.c:1003:3-9: preceding lock
>    on line 991
>
>CC: kbuild-all@lists.01.org
>BCC: lkp@intel.com
>CC: kvm@vger.kernel.org
>CC: virtualization@lists.linux-foundation.org
>CC: netdev@vger.kernel.org
>TO: Gautam Dawar <gautam.dawar@xilinx.com>
>CC: "Michael S. Tsirkin" <mst@redhat.com>
>CC: Jason Wang <jasowang@redhat.com>
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
>head:   73211bf1bc3ac0a3c544225e270401c1fe5d395d
>commit: a1468175bb17ca5e477147de5d886e7a22d93527 [26/43] vhost-vdpa: support ASID based IOTLB API
>:::::: branch date: 10 hours ago
>:::::: commit date: 10 hours ago
>config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20220520/202205201721.rGqusahl-lkp@intel.com/config)
>compiler: arceb-elf-gcc (GCC) 11.3.0
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>
>
>cocci warnings: (new ones prefixed by >>)
>>> drivers/vhost/vdpa.c:1003:3-9: preceding lock on line 991
>   drivers/vhost/vdpa.c:1016:2-8: preceding lock on line 991
>
>vim +1003 drivers/vhost/vdpa.c
>
>4c8cf31885f69e Tiwei Bie    2020-03-26   980
>0f05062453fb51 Gautam Dawar 2022-03-30   981  static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>4c8cf31885f69e Tiwei Bie    2020-03-26   982  					struct vhost_iotlb_msg *msg)
>4c8cf31885f69e Tiwei Bie    2020-03-26   983  {
>4c8cf31885f69e Tiwei Bie    2020-03-26   984  	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
>25abc060d28213 Jason Wang   2020-08-04   985  	struct vdpa_device *vdpa = v->vdpa;
>25abc060d28213 Jason Wang   2020-08-04   986  	const struct vdpa_config_ops *ops = vdpa->config;
>a1468175bb17ca Gautam Dawar 2022-03-30   987  	struct vhost_iotlb *iotlb = NULL;
>a1468175bb17ca Gautam Dawar 2022-03-30   988  	struct vhost_vdpa_as *as = NULL;
>4c8cf31885f69e Tiwei Bie    2020-03-26   989  	int r = 0;
>4c8cf31885f69e Tiwei Bie    2020-03-26   990
>a9d064524fc3cf Xie Yongji   2021-04-12  @991  	mutex_lock(&dev->mutex);
>a9d064524fc3cf Xie Yongji   2021-04-12   992
>4c8cf31885f69e Tiwei Bie    2020-03-26   993  	r = vhost_dev_check_owner(dev);
>4c8cf31885f69e Tiwei Bie    2020-03-26   994  	if (r)
>a9d064524fc3cf Xie Yongji   2021-04-12   995  		goto unlock;
>4c8cf31885f69e Tiwei Bie    2020-03-26   996
>a1468175bb17ca Gautam Dawar 2022-03-30   997  	if (msg->type == VHOST_IOTLB_UPDATE ||
>a1468175bb17ca Gautam Dawar 2022-03-30   998  	    msg->type == VHOST_IOTLB_BATCH_BEGIN) {
>a1468175bb17ca Gautam Dawar 2022-03-30   999  		as = vhost_vdpa_find_alloc_as(v, asid);
>a1468175bb17ca Gautam Dawar 2022-03-30  1000  		if (!as) {
>a1468175bb17ca Gautam Dawar 2022-03-30  1001  			dev_err(&v->dev, "can't find and alloc asid %d\n",
>a1468175bb17ca Gautam Dawar 2022-03-30  1002  				asid);
>a1468175bb17ca Gautam Dawar 2022-03-30 @1003  			return -EINVAL;
>a1468175bb17ca Gautam Dawar 2022-03-30  1004  		}
>a1468175bb17ca Gautam Dawar 2022-03-30  1005  		iotlb = &as->iotlb;
>a1468175bb17ca Gautam Dawar 2022-03-30  1006  	} else
>a1468175bb17ca Gautam Dawar 2022-03-30  1007  		iotlb = asid_to_iotlb(v, asid);
>a1468175bb17ca Gautam Dawar 2022-03-30  1008
>a1468175bb17ca Gautam Dawar 2022-03-30  1009  	if ((v->in_batch && v->batch_asid != asid) || !iotlb) {
>a1468175bb17ca Gautam Dawar 2022-03-30  1010  		if (v->in_batch 
>&& v->batch_asid != asid) {
>a1468175bb17ca Gautam Dawar 2022-03-30  1011  			dev_info(&v->dev, "batch id %d asid %d\n",
>a1468175bb17ca Gautam Dawar 2022-03-30  1012  				 v->batch_asid, asid);
>a1468175bb17ca Gautam Dawar 2022-03-30  1013  		}
>a1468175bb17ca Gautam Dawar 2022-03-30  1014  		if (!iotlb)
>a1468175bb17ca Gautam Dawar 2022-03-30  1015  			dev_err(&v->dev, "no iotlb for asid %d\n", asid);
>a1468175bb17ca Gautam Dawar 2022-03-30  1016  		return -EINVAL;
>a1468175bb17ca Gautam Dawar 2022-03-30  1017  	}
>a1468175bb17ca Gautam Dawar 2022-03-30  1018
>4c8cf31885f69e Tiwei Bie    2020-03-26  1019  	switch (msg->type) {
>4c8cf31885f69e Tiwei Bie    2020-03-26  1020  	case VHOST_IOTLB_UPDATE:
>3111cb7283065a Gautam Dawar 2022-03-30  1021  		r = vhost_vdpa_process_iotlb_update(v, iotlb, msg);
>4c8cf31885f69e Tiwei Bie    2020-03-26  1022  		break;
>4c8cf31885f69e Tiwei Bie    2020-03-26  1023  	case VHOST_IOTLB_INVALIDATE:
>3111cb7283065a Gautam Dawar 2022-03-30  1024  		vhost_vdpa_unmap(v, iotlb, msg->iova, msg->size);
>4c8cf31885f69e Tiwei Bie    2020-03-26  1025  		break;
>25abc060d28213 Jason Wang   2020-08-04  1026  	case VHOST_IOTLB_BATCH_BEGIN:
>a1468175bb17ca Gautam Dawar 2022-03-30  1027  		v->batch_asid = asid;
>25abc060d28213 Jason Wang   2020-08-04  1028  		v->in_batch = true;
>25abc060d28213 Jason Wang   2020-08-04  1029  		break;
>25abc060d28213 Jason Wang   2020-08-04  1030  	case VHOST_IOTLB_BATCH_END:
>25abc060d28213 Jason Wang   2020-08-04  1031  		if (v->in_batch && ops->set_map)
>a1468175bb17ca Gautam Dawar 2022-03-30  1032  			ops->set_map(vdpa, asid, iotlb);
>25abc060d28213 Jason Wang   2020-08-04  1033  		v->in_batch = false;
>a1468175bb17ca Gautam Dawar 2022-03-30  1034  		if (!iotlb->nmaps)
>a1468175bb17ca Gautam Dawar 2022-03-30  1035  			vhost_vdpa_remove_as(v, asid);
>25abc060d28213 Jason Wang   2020-08-04  1036  		break;
>4c8cf31885f69e Tiwei Bie    2020-03-26  1037  	default:
>4c8cf31885f69e Tiwei Bie    2020-03-26  1038  		r = -EINVAL;
>4c8cf31885f69e Tiwei Bie    2020-03-26  1039  		break;
>4c8cf31885f69e Tiwei Bie    2020-03-26  1040  	}
>a9d064524fc3cf Xie Yongji   2021-04-12  1041  unlock:
>a9d064524fc3cf Xie Yongji   2021-04-12  1042  	mutex_unlock(&dev->mutex);
>4c8cf31885f69e Tiwei Bie    2020-03-26  1043
>4c8cf31885f69e Tiwei Bie    2020-03-26  1044  	return r;
>4c8cf31885f69e Tiwei Bie    2020-03-26  1045  }
>4c8cf31885f69e Tiwei Bie    2020-03-26  1046
>
>-- 
>0-DAY CI Kernel Test Service
>https://01.org/lkp
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
