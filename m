Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D66C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 22:40:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F96264F95
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 22:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F96264F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BEEB18726C;
	Thu,  4 Feb 2021 22:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07lWTFSP9bTL; Thu,  4 Feb 2021 22:40:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 097878722C;
	Thu,  4 Feb 2021 22:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0E14C0174;
	Thu,  4 Feb 2021 22:40:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64062C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 22:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B391868D9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 22:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JfA1pwhmm0oz
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 22:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 01F4F868BC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612478411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBsjjTZzpZzHtjldrpCw+SVyqxdXjpA9LJZmLvdvn/s=;
 b=BfHBTa/+Yy44luLsd5IyqRcCqbhUSVuHNKphaYvaFhcXC4eAQljqN4vs0uZqi8g6ACdFqj
 aSZyPpV6ASC0jO5ITDnPMy1DU0QbhdRvjgIaJjWf4KM2F03kcTZd+PMV0baMRRLByEpDwk
 djmLRPsPgrP72S3Bd922C/r8+aDbBrM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-fjsVs0s-MP2bZdiUypoQPQ-1; Thu, 04 Feb 2021 17:40:01 -0500
X-MC-Unique: fjsVs0s-MP2bZdiUypoQPQ-1
Received: by mail-wr1-f71.google.com with SMTP id x7so3753228wrp.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Feb 2021 14:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GBsjjTZzpZzHtjldrpCw+SVyqxdXjpA9LJZmLvdvn/s=;
 b=lEUCBKDiEZseFvJGJjrJComjUrNliS6/NUOJl7ZdLjqEBbT+gVcV2xrcxaYAhVJfFy
 DRfiIo7bJKfdWUojeKtXpQPbdWTOHBXk9rMwqtDfuxfSlprprDcSfE4hKVp67LwqHksu
 9RrqfTkqfTlga9d2kb/UUYKZ7Iiqny9WvnYPkMgmvOoFT4+JSrTT0WqNJTR0IyxbvZOo
 +S/VZiEtAPRnn5YIcdPdww3AxmAw3osqIb8FqDKG9OLcFZ9iMZRK/UtAVNlM8PWU7JcM
 0p+zfFOYA90cl2CQCzjzA33qxQ7WtnRtiRTtygQJuLXmC/RDv6IUI4isKJjCsG2IK1KI
 kXEg==
X-Gm-Message-State: AOAM5333XNvVlRkQza3Sd1pEXw8YmouMHxu9Pz4Tw2pKohWYlGhl1jWM
 o8IRpSqZely/lYaOb2d2wNHC/8Ox1vaQlXTF3DQ9+G0x9+BZiWwY89rRDvLZlwNyY1j85eqq9Pp
 /i7z+5baqBNgKh5kp/w2j81vxtSmJToGFNF/F0ftL0A==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr1574964wrx.81.1612478399886; 
 Thu, 04 Feb 2021 14:39:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiACX91olwg//Ry6RmfPnaxN+GPPpFshRzxO/ndAyxdguZIlrYaq6Fu7Iphb/KQ4Lb7+60iQ==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr1574948wrx.81.1612478399709; 
 Thu, 04 Feb 2021 14:39:59 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id d10sm9665506wrn.88.2021.02.04.14.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 14:39:59 -0800 (PST)
Date: Thu, 4 Feb 2021 23:39:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 08/13] vdpa: add return value to get_config/set_config
 callbacks
Message-ID: <20210204223956.3uuo7xskjpii3fvw@steredhat>
References: <20210204172230.85853-9-sgarzare@redhat.com>
 <202102050632.J7DMzsOi-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202102050632.J7DMzsOi-lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kbuild-all@lists.01.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Fri, Feb 05, 2021 at 06:31:20AM +0800, kernel test robot wrote:
>Hi Stefano,
>
>I love your patch! Yet something to improve:
>
>[auto build test ERROR on vhost/linux-next]
>[also build test ERROR on linus/master v5.11-rc6 next-20210125]
>[If your patch is applied to the wrong git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch]
>
>url:    https://github.com/0day-ci/linux/commits/Stefano-Garzarella/vdpa-add-vdpa-simulator-for-block-device/20210205-020448
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
>config: parisc-randconfig-r005-20210204 (attached as .config)
>compiler: hppa-linux-gcc (GCC) 9.3.0
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://github.com/0day-ci/linux/commit/17cf2b1e6be083a27f43414cc0f2524cf81fff60
>        git remote add linux-review https://github.com/0day-ci/linux
>        git fetch --no-tags linux-review Stefano-Garzarella/vdpa-add-vdpa-simulator-for-block-device/20210205-020448
>        git checkout 17cf2b1e6be083a27f43414cc0f2524cf81fff60
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All errors (new ones prefixed by >>):
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'mlx5_vdpa_get_config':
>>> drivers/vdpa/mlx5/net/mlx5_vnet.c:1810:10: error: expected ';' before '}' token
>    1810 |  return 0
>         |          ^
>         |          ;
>    1811 | }
>         | ~


Ooops, I forgot to add mlx5_vnet.c on my .config.

Sorry for that, I'll fix in the next release and I'll build all vDPA 
related stuff.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
