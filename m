Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D8125B6
	for <virtualization@lists.linux-foundation.org>; Sat,  9 Dec 2023 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLxzU37U"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B897060BA5
	for <virtualization@lists.linux-foundation.org>; Sat,  9 Dec 2023 10:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B897060BA5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLxzU37U
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxQk6-C8HWo9
	for <virtualization@lists.linux-foundation.org>;
	Sat,  9 Dec 2023 10:27:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76DD860B10
	for <virtualization@lists.linux-foundation.org>; Sat,  9 Dec 2023 10:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76DD860B10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702117667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sgSSZVoHbtMUxorEO7aIxD48351b/dT2/kcqCclHl8=;
	b=KLxzU37USw+je945nCwWlOIxZ84xCdZOMKml0zgye3DHa4nTZKHbv8BKVm3nSCOGXyDxD+
	HqiVvz5lDCh3izbpE6XsWbodthaX3iqM20OOlK5ANibeLyq2+uMYQJ+XjH5mAf2VxmZnx8
	Bf7mWHJ10UeypG627fodUq6EVho5eWM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-pNSLJUDFPJSWPN0DKRGHfg-1; Sat, 09 Dec 2023 05:27:43 -0500
X-MC-Unique: pNSLJUDFPJSWPN0DKRGHfg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333405020f3so2390916f8f.1
        for <virtualization@lists.linux-foundation.org>; Sat, 09 Dec 2023 02:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702117662; x=1702722462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sgSSZVoHbtMUxorEO7aIxD48351b/dT2/kcqCclHl8=;
        b=BV0u0z6CCOCBpOj73KELhDRaIEeyfq9tPqAjwwTnHUaVvGO5NzwJD17fRNK/8HYSLs
         VJ374f1nxViQmv11FFzVzpkP123+4X1fMq0EGVa6fdemtyBoKU6cJ5J14IsRnmz0AeHS
         f45eLlEffwX6PFX9BCBe3DOtU0ips5JJ6irNqkx8HnFUQ5x/GcNX/zQF+jkPdyrIwupP
         pUjE3FFBF38VnaQSLecJlYZEg+tAO+cd6qS1CwMSqsL2A6fnte+gl9yEPJ7uXwUh8m4+
         DwpoVs5ynZpiLoyxv9XRHxHypQcyrkItNgh4aSF2g5DSxDZOq7TCM5j3fSzYybVDiGaU
         DmjQ==
X-Gm-Message-State: AOJu0YwAoeHo05e4Ieh85sxpuCkZgR8f3CnQKSPnvBb17nCD+DoI7v92
	8WoFhGlmG8vRmWyhdAonWB7dlvHOXawGh4sH22SzfeNDLY9QEfcuknD6yjdTW88DDBg5bMOCQ0r
	HBNs59l33kJXEMx9yLEne9XUt20QFZvHvHzZV1pIdEw==
X-Received: by 2002:a5d:6611:0:b0:333:4896:100d with SMTP id n17-20020a5d6611000000b003334896100dmr664685wru.8.1702117662543;
        Sat, 09 Dec 2023 02:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDiHXF4XIUOFxXmVXFha/8eTa6nHvn907AvowQMaqP0gK0hvBFBHsptrwJMLI54FcKEUH+MQ==
X-Received: by 2002:a5d:6611:0:b0:333:4896:100d with SMTP id n17-20020a5d6611000000b003334896100dmr664676wru.8.1702117662230;
        Sat, 09 Dec 2023 02:27:42 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id m1-20020a056000008100b00334b3208700sm3961093wrx.49.2023.12.09.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:27:41 -0800 (PST)
Date: Sat, 9 Dec 2023 05:27:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	oe-kbuild-all@lists.linux.dev, jasowang@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com,
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org,
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v7 4/4] virtio-net: support rx netdim
Message-ID: <20231209052724-mutt-send-email-mst@kernel.org>
References: <9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi@linux.alibaba.com>
 <202312091132.7eR6Cbs9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202312091132.7eR6Cbs9-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2023 at 11:22:11AM +0800, kernel test robot wrote:
> Hi Heng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-returns-whether-napi-is-complete/20231207-143044
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi%40linux.alibaba.com
> patch subject: [PATCH net-next v7 4/4] virtio-net: support rx netdim
> config: nios2-randconfig-r064-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312091132.7eR6Cbs9-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_work':
>    virtio_net.c:(.text+0x21dc): undefined reference to `net_dim_get_rx_moderation'
> >> virtio_net.c:(.text+0x21dc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim_get_rx_moderation'
>    nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_poll':
>    virtio_net.c:(.text+0x97bc): undefined reference to `net_dim'
> >> virtio_net.c:(.text+0x97bc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim'


Looks like select DIMLIB is missing?

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

