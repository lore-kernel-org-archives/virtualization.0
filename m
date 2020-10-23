Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E6C4363A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:43:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085A820797
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLN8Cptl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085A820797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5EBA821080;
	Fri, 23 Oct 2020 15:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SH8YXAx13iRq; Fri, 23 Oct 2020 15:43:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 78E952036E;
	Fri, 23 Oct 2020 15:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49038C088B;
	Fri, 23 Oct 2020 15:43:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B7F1C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F2C04878FD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhHOnuBs4ald
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:43:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6AC65878FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNSGPrDZt0KFZ/gEfGLt+00ZQJB1j+rqXJsHwi7p7Tw=;
 b=ZLN8Cptl5zbQTag+xTd+V/7IdQr8gH84bl85oADoVThHwlzRrLIvvC94kgJ47wgtnQEUk6
 1teBjWfegqy3yMbsegaXD1roC3/V+s8oSq4dnXHbsxOumsBuIZQbVlyQc8FmE6YZ71FIQM
 T9aanqzcOlt0ZsZhUBLhd2b36NXXEM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-P7gkMaW6MZ6sGX5cfiMobA-1; Fri, 23 Oct 2020 11:43:27 -0400
X-MC-Unique: P7gkMaW6MZ6sGX5cfiMobA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6999B86ABD9;
 Fri, 23 Oct 2020 15:43:25 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A19FA27CC2;
 Fri, 23 Oct 2020 15:43:18 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:43:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 14/16] vhost: poll support support multiple workers
Message-ID: <20201023114247-mutt-send-email-mst@kernel.org>
References: <1602104101-5592-15-git-send-email-michael.christie@oracle.com>
 <202010080822.dOGbzKC9-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202010080822.dOGbzKC9-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com,
 Mike Christie <michael.christie@oracle.com>
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

On Thu, Oct 08, 2020 at 08:46:42AM +0800, kernel test robot wrote:
> Hi Mike,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on vhost/linux-next]
> [also build test ERROR on next-20201007]
> [cannot apply to v5.9-rc8]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Mike-Christie/vhost-fix-scsi-cmd-handling-and-IOPs/20201008-045802
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> config: m68k-allyesconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/c9bcafefcac3c32ade0ba533609d7b1ddc343c54
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Mike-Christie/vhost-fix-scsi-cmd-handling-and-IOPs/20201008-045802
>         git checkout c9bcafefcac3c32ade0ba533609d7b1ddc343c54
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> m68k-linux-ld: drivers/vhost/scsi.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here
>    m68k-linux-ld: drivers/vhost/vsock.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here
>    m68k-linux-ld: drivers/vhost/vdpa.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here
>    m68k-linux-ld: drivers/vhost/vhost.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here

Mike, what's going on with these failures?
Can you figure it out pls?

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
