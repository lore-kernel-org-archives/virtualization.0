Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D97C433EF
	for <virtualization@archiver.kernel.org>; Sat,  8 Jan 2022 17:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C6D260A91;
	Sat,  8 Jan 2022 17:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muGK8tdcpQpr; Sat,  8 Jan 2022 17:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02EF0607F2;
	Sat,  8 Jan 2022 17:42:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4CCCC002F;
	Sat,  8 Jan 2022 17:42:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82F4AC001E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 17:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56ABE607F9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 17:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c_-UzsJHoCog
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 17:42:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9626607F2
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641663730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZVUjQiwMvhimCji0d8/xJbQ9eOHnZHI4ZJAgbXoD1Y=;
 b=AKrza62dtT6Db0iZWWzlhqZsD9zfuLybzxvLgtiZoDjEDXLRHESK0VLfaaBq09DwIqBmOx
 FYkYb+nwJ8eBqfFh3nmNO5p1cEKeOg0VRu/1aTz9i/aig2hcdWC7/WKq0F+st1Bsfy+L0w
 Ny9WLRunKB9rkKarGW9Hwk1JVB6Sd4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-hFafskTKPUid6htiRfVBhg-1; Sat, 08 Jan 2022 12:42:03 -0500
X-MC-Unique: hFafskTKPUid6htiRfVBhg-1
Received: by mail-wm1-f72.google.com with SMTP id
 j8-20020a05600c1c0800b00346504f5743so6710820wms.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 08 Jan 2022 09:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eZVUjQiwMvhimCji0d8/xJbQ9eOHnZHI4ZJAgbXoD1Y=;
 b=hu9157dXbYtthd9LWF4gH+nkT/ZJqJQ/3xpAIEr2Viuu2K940UIo1W70DiPBJdxQ1u
 +4e1dopQq2NlhgXY6eZ3vyKW+L+eSlpuJlj2X0sOlN1ILB4BH/Qq59AAsbY9tVVHGmEd
 gB/rRQ08vyF+vWUCDgAaYNJam04BjZSNp8EUXQ1wq9Wo/KfhljiWFm+NVKsdsnAHdXS4
 z4B9HD6dvqWdZQSyEwYXh61vFZuez/XFdfzzhrVJM7U9lekH/AAhSrsM/k8+PxenMwzR
 wS/lyyDPbpHE54DMoEn6ad4nPROGBgVMDN/I4nsWDF6TpVCcqo3mBI9B0utAmjmfJSuq
 O5ng==
X-Gm-Message-State: AOAM532FcC/zj/DDvD8Os0yD6bQ3Qq1Qez2MCNo8NGMGiIT4TXh/Gv3D
 O1yPTLrQPlvsU1qrRe3cjs6Pe0IksCeDZuAm2/udoN9MZsOrO7ak/LY+5urJAECDgwIchvznjFy
 RLodeHgs1vkMwKZuGGnSzPxvrolzTXvn29AfA6/Eepw==
X-Received: by 2002:a5d:428e:: with SMTP id k14mr2220371wrq.524.1641663722052; 
 Sat, 08 Jan 2022 09:42:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYKBDXf6+Z/pzYSngoalfQglop4wcw0Ierbv2oLgA5+pKSxRs/CvyEYCqC5ZnaNpSy6KPkkw==
X-Received: by 2002:a5d:428e:: with SMTP id k14mr2220359wrq.524.1641663721855; 
 Sat, 08 Jan 2022 09:42:01 -0800 (PST)
Received: from redhat.com ([2a10:800d:b77b:0:4c0a:9a47:da3d:38fd])
 by smtp.gmail.com with ESMTPSA id m5sm1939693wml.48.2022.01.08.09.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jan 2022 09:42:00 -0800 (PST)
Date: Sat, 8 Jan 2022 12:41:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [mst-vhost:vhost 30/44]
 drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast to
 restricted __le16
Message-ID: <20220108123934-mutt-send-email-mst@kernel.org>
References: <202201082258.aKRHnaJX-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202201082258.aKRHnaJX-lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 kbuild-all@lists.01.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Jan 08, 2022 at 10:48:34PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
> head:   008842b2060c14544ff452483ffd2241d145c7b2
> commit: 7620d51af29aa1c5d32150db2ac4b6187ef8af3a [30/44] vdpa/mlx5: Support configuring max data virtqueue
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220108/202201082258.aKRHnaJX-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=7620d51af29aa1c5d32150db2ac4b6187ef8af3a
>         git remote add mst-vhost https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
>         git fetch --no-tags mst-vhost vhost
>         git checkout 7620d51af29aa1c5d32150db2ac4b6187ef8af3a
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/vdpa/mlx5/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast to restricted __le16
> >> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast from restricted __virtio16
> 
> vim +1247 drivers/vdpa/mlx5/net/mlx5_vnet.c
> 
>   1232	
>   1233	static int create_rqt(struct mlx5_vdpa_net *ndev)
>   1234	{
>   1235		__be32 *list;
>   1236		int max_rqt;
>   1237		void *rqtc;
>   1238		int inlen;
>   1239		void *in;
>   1240		int i, j;
>   1241		int err;
>   1242		int num;
>   1243	
>   1244		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>   1245			num = 1;
>   1246		else
> > 1247			num = le16_to_cpu(ndev->config.max_virtqueue_pairs);

What is the correct thing to do here?  mlx5vdpa16_to_cpu?

>   1248	
>   1249		max_rqt = min_t(int, roundup_pow_of_two(num),
>   1250				1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>   1251		if (max_rqt < 1)
>   1252			return -EOPNOTSUPP;
>   1253	
>   1254		inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
>   1255		in = kzalloc(inlen, GFP_KERNEL);
>   1256		if (!in)
>   1257			return -ENOMEM;
>   1258	
>   1259		MLX5_SET(create_rqt_in, in, uid, ndev->mvdev.res.uid);
>   1260		rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>   1261	
>   1262		MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>   1263		MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>   1264		list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>   1265		for (i = 0, j = 0; i < max_rqt; i++, j += 2)
>   1266			list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
>   1267	
>   1268		MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>   1269		err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>   1270		kfree(in);
>   1271		if (err)
>   1272			return err;
>   1273	
>   1274		return 0;
>   1275	}
>   1276	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
