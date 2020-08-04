Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C8C433E0
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 12:22:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D67822BED
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 12:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiXJ6tlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D67822BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 566CE87E1D;
	Tue,  4 Aug 2020 12:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdbhSCENKC43; Tue,  4 Aug 2020 12:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 62DA685325;
	Tue,  4 Aug 2020 12:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5020FC0051;
	Tue,  4 Aug 2020 12:22:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF9AC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 698E387D41
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPxDwzNrQnkg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D63185325
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596543761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cfhrqb6pBBQzVJy0vxTB4jGpyV61Q7QFxMfhI7EBCL4=;
 b=BiXJ6tlbBw6/Mhei/OPQcMfxXY8iwDUXfL0tM/+A/5cmJXo2koYCbmlh3NQdO6M919hyyY
 whFJKp7haNccHm0IvWXQK0WTL/mgiyL5bsPGPD71Vqzj2/bk9BZ0AqFn1pLF0M7aR1UddE
 3a3TiFIFTAa3LNvMATfLEkNx2MNbe3E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-RUdSownuPjakJIjYNrpdUg-1; Tue, 04 Aug 2020 08:22:14 -0400
X-MC-Unique: RUdSownuPjakJIjYNrpdUg-1
Received: by mail-qt1-f198.google.com with SMTP id s29so9299690qtc.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 05:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cfhrqb6pBBQzVJy0vxTB4jGpyV61Q7QFxMfhI7EBCL4=;
 b=fZAPgqn5FkEokuVo8tzegcgJUmc0j+SJ9a1iDTNzpl5R4sGCVHGv16f/ksLO69L42j
 2aB2/RSZIAzqnJ1fs1dsNLI8Lf+MkNmHbr4Sm8wVVQEX/Bv8lsFFGmrgIGfI6ruIOt+7
 4L648LZYxI5FnbJJXOxOUPFCovGgp8eqk3z0n1RsLVGJNm3ANANjEDJXOVTHhxwzUDq+
 5w+1n+BnHrdt5U5dhAuXlxjdA/4ODKCvQC+Yi5iTTQtQR61jvCrA4EBg5mSdMc3Q24A5
 43DoBE4kETmUgXPsvpXG+wJwkZ/1UV45WFdCLXc7oXtL8POzQn5VUmZYdwlVYCA0HLin
 fjpg==
X-Gm-Message-State: AOAM5310YISsebTErKXdOUBtxBj55u6xyY27os3JlLDb+AnBcy4ojkO5
 zRFPclcw0D4XPMbNMpgN9E7O/OHyjmiF4Ay1PNF+e6gLr0byAVogeKbGD+2nOLcl9M6IclqSP3U
 MRfrDBjSrFyT4z441TXd/MzP8WPMpQQeh5QAoMcciTQ==
X-Received: by 2002:ac8:4c9a:: with SMTP id j26mr20753976qtv.373.1596543734013; 
 Tue, 04 Aug 2020 05:22:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1VSzNyJdnAOf5o8b1wWZrFayNX+EyfmsmRxHvnhM/cQRo+DnGnJjhUuY1MZ5p7Z/aKPVM7Q==
X-Received: by 2002:ac8:4c9a:: with SMTP id j26mr20753950qtv.373.1596543733713; 
 Tue, 04 Aug 2020 05:22:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id p123sm20548192qkd.26.2020.08.04.05.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 05:22:12 -0700 (PDT)
Date: Tue, 4 Aug 2020 08:22:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH V3 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200804081501-mutt-send-email-mst@kernel.org>
References: <20200728060539.4163-11-eli@mellanox.com>
 <202007282108.S8MkTrap%lkp@intel.com>
 <20200804115419.GA6326@nps-server-21.mtl.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200804115419.GA6326@nps-server-21.mtl.labs.mlnx>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Shahaf Shuler <shahafs@mellanox.com>,
 "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 kernel test robot <lkp@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Saeed Mahameed <saeedm@mellanox.com>, Parav Pandit <parav@mellanox.com>
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

On Tue, Aug 04, 2020 at 02:54:19PM +0300, Eli Cohen wrote:
> On Tue, Jul 28, 2020 at 04:43:00PM +0300, kernel test robot wrote:
> > Hi Eli,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on next-20200727]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Eli-Cohen/VDPA-support-for-Mellanox-ConnectX-devices/20200728-140938
> > base:    e9a523ff8f76de0768857f02ea76437d3b39d151
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
> > >> ERROR: modpost: "__udivdi3" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!
> 
> I don't know where this complaint comes from. When I follow the steps
> above to reproduce, I find myself failing on code unrelated to my patch
> set so I can get my code compiled:
> 
> drivers/rpmsg/virtio_rpmsg_bus.c:88:8: error: redefinition of 'struct rpmsg_hdr'
>    88 | struct rpmsg_hdr {
>       |        ^~~~~~~~~
> In file included from drivers/rpmsg/virtio_rpmsg_bus.c:28:
> ./include/linux/virtio_rpmsg.h:21:8: note: originally defined here
>    21 | struct rpmsg_hdr {
>       |        ^~~~~~~~~
> drivers/rpmsg/virtio_rpmsg_bus.c:109:8: error: redefinition of 'struct
> rpmsg_ns_msg'
>   109 | struct rpmsg_ns_msg {
>       |        ^~~~~~~~~~~~
> In file included from drivers/rpmsg/virtio_rpmsg_bus.c:28:
> ./include/linux/virtio_rpmsg.h:42:8: note: originally defined here
>    42 | struct rpmsg_ns_msg {
>       |        ^~~~~~~~~~~~
> 

Hmm more conflicts. My bad :(


> I think the reason for the complaint comes from usage of DIV_ROUND_UP()
> which somehow does not work on mips.
> 
> I can try to avoid using this macro and implement something of my own,
> unless someone has a better idea what's going on here.
> 
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
