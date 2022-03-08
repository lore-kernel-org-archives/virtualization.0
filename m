Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF6C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 16:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F666415E1;
	Tue,  8 Mar 2022 16:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OhsadFtJ_FQK; Tue,  8 Mar 2022 16:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9412415A6;
	Tue,  8 Mar 2022 16:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91324C001D;
	Tue,  8 Mar 2022 16:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD801C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB56E8420E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8bYQY3EiE-Uf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C80EF84203
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646756795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2AL3azyXwS+YdQGr7WwE+BEYV704EZWT30IdZo6h2w=;
 b=ifhSZUsoqEP1i7gb1QZ1UfYUYvV2Rne29FZ2f3Nqe4yz5rDfwuToeQBAkkzNYBqkdav7hc
 WNWRQFdYDQRoLezRv/YCNI+b9usobgzC+JUMNsW4Iyc7+8S9Oy2hoqwdBCOaq/zRNZo8cg
 ZmlIObvmm9FlmWDrekFKqR08KJmqyoY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-PAYKykIeMf6nr8niaw7WpA-1; Tue, 08 Mar 2022 11:26:25 -0500
X-MC-Unique: PAYKykIeMf6nr8niaw7WpA-1
Received: by mail-wr1-f70.google.com with SMTP id
 a16-20020adff7d0000000b001f0473a6b25so5368462wrq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 08:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T2AL3azyXwS+YdQGr7WwE+BEYV704EZWT30IdZo6h2w=;
 b=L4J4u3lQ9t35tdUV5zCug8Brw8w6W/iTk8ztqQFPC/GP1PKTEBfD5puv/w15ILN8sl
 v44xvVkPyE02c2DACBHpHTWwEF2ABVRZEIn8/EgNb6XDGWFxIdgtWCmOkrz7qFwGRlxb
 t+f82JUEZnSGy8WLJRWrQgPmIMfrzW1WG6d/TXEWi0rzuLj3y/dnTdD8O0pqZQ1texqz
 Y/rEaBiIn0RgzAqhgOJHZNkPNsYGEy4haDRBOxIltgMv5fU6Qzaf1AXuJWFGRzY2wIcO
 1r7ILkfKgqw1mbe2S9dzAp3x/Zd/mlRsJ1Q/COjwrBCPIZ8OKKozYEYcHAq5Swlecsf5
 Sb5g==
X-Gm-Message-State: AOAM530Yww+OTyJn75ASZhB7Ps3oC9pgmVGluyl3vd+C+w2JIOETOpjz
 H/u/uu1UYdMWr8/GoVEo4AkXQc3NYCqS0FWv0bT4DSAXzncNRfs2DmKImB4aHLKLy8kcoA0pyFo
 qvUkwj4q4qwT/7msAbWGSxzhy4YRtXk9K5xXyERX+Uw==
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id
 u5-20020adfeb45000000b001ef60707641mr13354534wrn.301.1646756784448; 
 Tue, 08 Mar 2022 08:26:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhnyFnkO7umByqQJsfdzQVHFeLrYMLRMWEEu3NiZVMI6SXrE3spWUAqmE+Oa2Azw0YWMSP3w==
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id
 u5-20020adfeb45000000b001ef60707641mr13354522wrn.301.1646756784232; 
 Tue, 08 Mar 2022 08:26:24 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 m3-20020a5d6243000000b001e33760776fsm14270303wrv.10.2022.03.08.08.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 08:26:23 -0800 (PST)
Date: Tue, 8 Mar 2022 11:26:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [mst-vhost:vhost 28/60] nios2-linux-ld:
 virtio_crypto_akcipher_algs.c:undefined reference to `rsa_parse_pub_key'
Message-ID: <20220308112417-mutt-send-email-mst@kernel.org>
References: <202203090014.ulENdnAQ-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202203090014.ulENdnAQ-lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, lei he <helei.sig11@bytedance.com>,
 kvm@vger.kernel.org, netdev@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
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

On Wed, Mar 09, 2022 at 12:10:30AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
> head:   c5f633abfd09491ae7ecbc7fcfca08332ad00a8b
> commit: 8a75f36b5d7a48f1c5a0b46638961c951ec6ecd9 [28/60] virtio-crypto: implement RSA algorithm
> config: nios2-randconfig-p002-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090014.ulENdnAQ-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=8a75f36b5d7a48f1c5a0b46638961c951ec6ecd9
>         git remote add mst-vhost https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
>         git fetch --no-tags mst-vhost vhost
>         git checkout 8a75f36b5d7a48f1c5a0b46638961c951ec6ecd9
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    nios2-linux-ld: drivers/crypto/virtio/virtio_crypto_akcipher_algs.o: in function `virtio_crypto_rsa_set_key':
>    virtio_crypto_akcipher_algs.c:(.text+0x4bc): undefined reference to `rsa_parse_priv_key'
>    virtio_crypto_akcipher_algs.c:(.text+0x4bc): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_priv_key'
> >> nios2-linux-ld: virtio_crypto_akcipher_algs.c:(.text+0x4e8): undefined reference to `rsa_parse_pub_key'
>    virtio_crypto_akcipher_algs.c:(.text+0x4e8): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_pub_key'

I guess we need to select CRYPTO_RSA  ?

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
