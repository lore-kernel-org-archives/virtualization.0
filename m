Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169BAC433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 04:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE608606BE;
	Fri, 26 Nov 2021 04:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p11UO61Opzxo; Fri, 26 Nov 2021 04:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AB5660667;
	Fri, 26 Nov 2021 04:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2782C0012;
	Fri, 26 Nov 2021 04:40:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B190C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6324940151
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6O72FBaKdIM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:40:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08A8140012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 04:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637901654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXDnhWi2lUYPDK6SyEW/Lwdc8ugbHrrHb9AhpqrT7Ds=;
 b=GOLk5PmMR/GjZ6h8Drad2RO7xB5p5ZzGE2gnm2u9jS9+qJKBcrbiWFhj+OVJNXxnWUHsTX
 EI6Fd4Er/5+Od2Y81UyMfD2POMDv4gwpt1Q9zS6+DIu+PbseyoZcAMMFbdv1MS1vjiN8W6
 bLtUSiD2EsXGYPqXs+Nu3GaTu40aWIQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-D9tONSv2Oy2Gc58XYaie7Q-1; Thu, 25 Nov 2021 23:40:51 -0500
X-MC-Unique: D9tONSv2Oy2Gc58XYaie7Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 g19-20020a2eb5d3000000b00219f21cb32bso2722197ljn.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KXDnhWi2lUYPDK6SyEW/Lwdc8ugbHrrHb9AhpqrT7Ds=;
 b=nLq1uXguPJweKc4GeLdl1fiPczY1hjtRixPsJxgQm8F9NArP2N0hYc3ZbQpGXuvWyk
 QXYPMghP4OvhZBrBjBnnNtEDSxXrX4cJrbSKXP2uxpusBC7xNSMnvppDRLY6qPpl9eq8
 jHXlSEOpD73eM/DBo9ldz7MNUm1sKw7TTB6UM6DqFT/i4nwdwUig/pi2mZoGy7Ngk5Ux
 fbczf78SdohItzOsmQiWbAa6UGoCjJKj0Y8dian1Rluel+IT2QvMdxJ58dEeXX8EitaK
 J15YMOkzPzRFwfd2khwGrPO7W9WLo4XHEyk5e5TfCRO6F5XCNJoDa+M2mlgJTw42oFVH
 Rn+g==
X-Gm-Message-State: AOAM533mFDluZck5WPp4qXeYU3ewVmLeGHa32EV+4IzNS27AtHTDKnvi
 TwqklXvknZ4BtoBf2Ph0vARRyx4/0QKToWQ+iJVAZ/YvntTkQjWhBx4jtx65IncJZeh2gQyA1+z
 sk565GZFGO0eL2kPnI5bjsbjJYJ9IDSkPyKpqlHwp8O90RP63m+LkSMZZCA==
X-Received: by 2002:a2e:2ac1:: with SMTP id
 q184mr29135780ljq.420.1637901649438; 
 Thu, 25 Nov 2021 20:40:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9I5mU3QuZFkDuRPx0Xw0T8Go262yO+nZT2CPCiRrJPdz2yhCYrQfj1jDQiyWXOOYvCeOvH2AKgtNQcLIDrW8=
X-Received: by 2002:a2e:2ac1:: with SMTP id
 q184mr29135753ljq.420.1637901649134; 
 Thu, 25 Nov 2021 20:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20211125063034.12347-1-jasowang@redhat.com>
 <202111252001.Z5tli1Np-lkp@intel.com>
In-Reply-To: <202111252001.Z5tli1Np-lkp@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Nov 2021 12:40:38 +0800
Message-ID: <CACGkMEuOGR9K4Nq++EG9RzE3F7G6Rj9P0kkOyrJHm=K-Vap9Ow@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: harden interrupt
To: kernel test robot <lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kbuild-all@lists.01.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 llvm@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>,
 mst <mst@redhat.com>
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

On Thu, Nov 25, 2021 at 8:08 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Jason,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.16-rc2 next-20211125]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Will fix this in V2.

Thanks

>
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5f53fa508db098c9d372423a6dac31c8a5679cdf
> config: mips-buildonly-randconfig-r003-20211125 (https://download.01.org/0day-ci/archive/20211125/202111252001.Z5tli1Np-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://github.com/0day-ci/linux/commit/e19a8a1a95bd891090863b2d6828b8dc55d3633f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
>         git checkout e19a8a1a95bd891090863b2d6828b8dc55d3633f
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/virtio/virtio_mmio.c:105:6: warning: no previous prototype for function 'vm_disable_cbs' [-Wmissing-prototypes]
>    void vm_disable_cbs(struct virtio_device *vdev)
>         ^
>    drivers/virtio/virtio_mmio.c:105:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void vm_disable_cbs(struct virtio_device *vdev)
>    ^
>    static
> >> drivers/virtio/virtio_mmio.c:121:6: warning: no previous prototype for function 'vm_enable_cbs' [-Wmissing-prototypes]
>    void vm_enable_cbs(struct virtio_device *vdev)
>         ^
>    drivers/virtio/virtio_mmio.c:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void vm_enable_cbs(struct virtio_device *vdev)
>    ^
>    static
>    2 warnings generated.
>
>
> vim +/vm_disable_cbs +105 drivers/virtio/virtio_mmio.c
>
>    103
>    104  /* disable irq handlers */
>  > 105  void vm_disable_cbs(struct virtio_device *vdev)
>    106  {
>    107          struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>    108          int irq = platform_get_irq(vm_dev->pdev, 0);
>    109
>    110          /*
>    111           * The below synchronize() guarantees that any
>    112           * interrupt for this line arriving after
>    113           * synchronize_irq() has completed is guaranteed to see
>    114           * intx_soft_enabled == false.
>    115           */
>    116          WRITE_ONCE(vm_dev->intr_soft_enabled, false);
>    117          synchronize_irq(irq);
>    118  }
>    119
>    120  /* enable irq handlers */
>  > 121  void vm_enable_cbs(struct virtio_device *vdev)
>    122  {
>    123          struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>    124          int irq = platform_get_irq(vm_dev->pdev, 0);
>    125
>    126          disable_irq(irq);
>    127          /*
>    128           * The above disable_irq() provides TSO ordering and
>    129           * as such promotes the below store to store-release.
>    130           */
>    131          WRITE_ONCE(vm_dev->intr_soft_enabled, true);
>    132          enable_irq(irq);
>    133          return;
>    134  }
>    135
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
