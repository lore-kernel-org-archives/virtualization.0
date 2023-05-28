Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD010C77B7E
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 06:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3336C41E0D;
	Sun, 28 May 2023 06:27:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3336C41E0D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VoAnEOLv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MEs_IkpPnzFY; Sun, 28 May 2023 06:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 432F741DD3;
	Sun, 28 May 2023 06:27:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 432F741DD3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD367C0036;
	Sun, 28 May 2023 06:27:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE7FC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C76A60B58
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:27:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C76A60B58
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VoAnEOLv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i2fcpGzd03LN
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:27:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FE8660B51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FE8660B51
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685255245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qd1HsDPoIQCA1W8M9wRkc4OBlzVkt6/Jqm85Xt985zA=;
 b=VoAnEOLvwQPpXS7B1WHtXlhuhwwb8FtoIkCfqONequm3c0nt43u38jndYC3IzGvBzZddwI
 PK6vwicUSxnFkmcECyV6RKj+R0SbDdzShYT/AKvVoDCzDGjiKOQIOCpXJ78N909NUlBYHV
 8P9YwER4v8rKONczqqfAw0gJc4cqyaU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-gfm4Pka-NdS_1_wp866OYA-1; Sun, 28 May 2023 02:27:23 -0400
X-MC-Unique: gfm4Pka-NdS_1_wp866OYA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so1259748f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 23:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685255242; x=1687847242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qd1HsDPoIQCA1W8M9wRkc4OBlzVkt6/Jqm85Xt985zA=;
 b=ezFZHMVKbx+RLZJAeSWfxQKRdRB1qoPD/3xxT44SSUdSpa8JTdxQteMHh0Szs5NCAg
 WzXoA91UPWmSFGaurfbFmEFQJub8QqOzXZdTGRnLs77mNqlj+WshaSieAYYiRqmherCU
 mChXkor4TwcZH0iWvrOFZaOtdMfRGQKMI8Jj8Qjj8aaTgXkEOnB4lFQQ5koPEDwLaObl
 Ne9dF6bO7LGPu02fnpY6T0W8M9PVq4ukdGkLShiUD1bJBhfDefDRykzmDHW153kv2iu0
 pE9yG9d/XRIFV8xWWWxkF4TRYPshqFp+vu5e8xOe6zBjpx6USvm4RgHm7ywF3vCIdgL8
 yyDw==
X-Gm-Message-State: AC+VfDwWIfkCB4FNLxypjabg8G+j43tJkTuQ2FNfNyOqVuVGWvyp5ACm
 UN/7d9HCZ1jUvgWBsz7LREXYPMmqdDXcRJXzzSauDQwMb9Auc0LMeibhRIv6UZU6Um0EVXebwkd
 7CJxKs1d+Gq14rodHyASVXqi8GcuyHgD3ZhJD9y3+CA==
X-Received: by 2002:a5d:4746:0:b0:307:a36b:e7b1 with SMTP id
 o6-20020a5d4746000000b00307a36be7b1mr6251110wrs.5.1685255242762; 
 Sat, 27 May 2023 23:27:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45TZmWQVMRhP5RvxBOirJj2cEFa5HQb7lqFSHk19mNXmZUM8pT5LmgfgqJSeZVjSeHHK6LuA==
X-Received: by 2002:a5d:4746:0:b0:307:a36b:e7b1 with SMTP id
 o6-20020a5d4746000000b00307a36be7b1mr6251097wrs.5.1685255242491; 
 Sat, 27 May 2023 23:27:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 q1-20020a1ce901000000b003f423dfc686sm10083677wmc.45.2023.05.27.23.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 23:27:21 -0700 (PDT)
Date: Sun, 28 May 2023 02:27:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to
 improve performance
Message-ID: <20230528022658-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-2-liangchen.linux@gmail.com>
 <202305262334.GiFQ3wpG-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202305262334.GiFQ3wpG-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

On Sat, May 27, 2023 at 12:11:25AM +0800, kernel test robot wrote:
> Hi Liang,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230526054621.18371-2-liangchen.linux%40gmail.com
> patch subject: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve performance
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230526/202305262334.GiFQ3wpG-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/bfba563f43bba37181d8502cb2e566c32f96ec9e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
>         git checkout bfba563f43bba37181d8502cb2e566c32f96ec9e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305262334.GiFQ3wpG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: vmlinux.o: in function `virtnet_find_vqs':
> >> virtio_net.c:(.text+0x901fb5): undefined reference to `page_pool_create'
>    ld: vmlinux.o: in function `add_recvbuf_mergeable.isra.0':
> >> virtio_net.c:(.text+0x905618): undefined reference to `page_pool_alloc_pages'
>    ld: vmlinux.o: in function `xdp_linearize_page':
>    virtio_net.c:(.text+0x906b6b): undefined reference to `page_pool_alloc_pages'
>    ld: vmlinux.o: in function `mergeable_xdp_get_buf.isra.0':
>    virtio_net.c:(.text+0x90728f): undefined reference to `page_pool_alloc_pages'


you need to tweak Kconfig to select PAGE_POOL I think.

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
