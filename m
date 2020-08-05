Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA7C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 23:51:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D939821D95
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 23:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjWB/6Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D939821D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C1D686B7E;
	Wed,  5 Aug 2020 23:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MojBkTPE3_d; Wed,  5 Aug 2020 23:51:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B25786B7A;
	Wed,  5 Aug 2020 23:51:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C09AC0051;
	Wed,  5 Aug 2020 23:51:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF3BC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 23:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4857885074
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 23:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Ws7HW2kqgaQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 23:51:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0A40984EB0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 23:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596671496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ymAmVIHHL+Dhhj1h1m9JWFZK2nhEhBDWELf2pfbLxZ0=;
 b=bjWB/6XdU8poP2a0AyjUc8E9ntQyBMTVme9zWfV92UiCsTz3yOVLBe6KXAqv/sEz+ZRjN3
 MtFgujSwsLKVHAGODh04PmIf3sy0mRI63hKAcbkQijCrsKqwz+ehqUJTs0mYI1/cswM3rf
 wTzZh1DdtjE3uGtyxdXbustIH3YBw+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-lyM8FAvJP6KOUE3yUEVDfQ-1; Wed, 05 Aug 2020 19:51:25 -0400
X-MC-Unique: lyM8FAvJP6KOUE3yUEVDfQ-1
Received: by mail-wm1-f72.google.com with SMTP id f74so3366822wmf.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 16:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ymAmVIHHL+Dhhj1h1m9JWFZK2nhEhBDWELf2pfbLxZ0=;
 b=ozcHe0dgoylRB4T39J8vHX4F3ijHEW4MWWHcGNyiXk03adDjfRROEZv15uplEa/UnY
 9nh+VmysfAYgqHYg3/9RiRSAH3ILKoustlhyqQmmZqlBg2kclRgCCe9qExI3q+uny7iX
 saptHiryNGpQA2k3hiB/upJwnwiexQHbemQR3OT4SEbIT5apt+niyVrJdACzs1a99J1g
 hrwiqG5kE2apMZd3SBcPvTN2CLAIjgcVQR5DtYLemE1K+lwE6YgiyKpDoMNPYkTmuFLi
 OGSSbCF48A6hA9Tt2+3VUXG2JlImNCj3MtAKroaY/d+nP4F8hkTA0GGJGZ+bZCNrYvHW
 jmYA==
X-Gm-Message-State: AOAM530m32nx1p1wuY6Pmp8Pxy6HEaiRleSbZicLh4O8JUGm45WathOP
 LYbeVP4qhIZr9j40YSggjUMpq7YtrRJ2yi8udQywu9YFZ/t2pqSkjk/bL3HvVkakyVPlEK408Wf
 uPTAfnOP0PkF1FBTOlOvBupS7fugtIEjDZevW3hdRww==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr5641566wmc.13.1596671483704; 
 Wed, 05 Aug 2020 16:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhju1ve0kkpCATUrgTYIgXrE3GBjo7F/ffCZhO4W/DdC3nDfToWjShQ/n9PBezQv2u+xI/jA==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr5641553wmc.13.1596671483427; 
 Wed, 05 Aug 2020 16:51:23 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id v15sm4525545wrm.23.2020.08.05.16.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 16:51:22 -0700 (PDT)
Date: Wed, 5 Aug 2020 19:51:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [vhost:vhost 32/52] include/linux/typecheck.h:12:18: warning:
 comparison of distinct pointer types lacks a cast
Message-ID: <20200805190937-mutt-send-email-mst@kernel.org>
References: <202008060456.M9GRXltb%lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202008060456.M9GRXltb%lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kbuild-all@lists.01.org, kvm@vger.kernel.org,
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

On Thu, Aug 06, 2020 at 04:17:13AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
> head:   4c05433bc6fb4ae172270f0279be8ba89a3da64f
> commit: b025584098e621d88894d28e80af686958e273af [32/52] virtio_input: convert to LE accessors
> config: parisc-randconfig-r003-20200805 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b025584098e621d88894d28e80af686958e273af
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

Weird. So the following fixes it:


diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index ecb166c824bb..8fe857e27ef3 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -357,10 +357,10 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
  */
 #define virtio_le_to_cpu(x) \
 	_Generic((x), \
-		__u8: (x), \
-		 __le16: le16_to_cpu(x), \
-		 __le32: le32_to_cpu(x), \
-		 __le64: le64_to_cpu(x) \
+		__u8: (u8)(x), \
+		 __le16: (u16)le16_to_cpu(x), \
+		 __le32: (u32)le32_to_cpu(x), \
+		 __le64: (u64)le64_to_cpu(x) \
 		)
 
 #define virtio_cpu_to_le(x, m) \
@@ -400,7 +400,6 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 		*(ptr) = virtio_le_to_cpu(virtio_cread_v);		\
 	} while(0)
 
-/* Config space accessors. */
 #define virtio_cwrite_le(vdev, structname, member, ptr)			\
 	do {								\
 		typeof(((structname*)0)->member) virtio_cwrite_v =	\


How could this be? le16_to_cpu doesn't return a u16?
I suspect this compiler gets confused by _Generic.
Let's hope it does not also miscompile the code :)


> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/irqflags.h:15,
>                     from include/asm-generic/cmpxchg-local.h:6,
>                     from arch/parisc/include/asm/cmpxchg.h:89,
>                     from arch/parisc/include/asm/atomic.h:10,
>                     from include/linux/atomic.h:7,
>                     from arch/parisc/include/asm/bitops.h:13,
>                     from include/linux/bitops.h:29,
>                     from include/linux/kernel.h:12,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:12,
>                     from drivers/virtio/virtio_input.c:2:
>    drivers/virtio/virtio_input.c: In function 'virtinput_probe':
> >> include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
>       12 |  (void)(&__dummy == &__dummy2); \
>          |                  ^~
>    include/linux/virtio_config.h:405:3: note: in expansion of macro 'typecheck'
>      405 |   typecheck(typeof(virtio_le_to_cpu(virtio_cread_v)), *(ptr)); \
>          |   ^~~~~~~~~
>    drivers/virtio/virtio_input.c:247:3: note: in expansion of macro 'virtio_cread_le'
>      247 |   virtio_cread_le(vi->vdev, struct virtio_input_config,
>          |   ^~~~~~~~~~~~~~~
> >> include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
>       12 |  (void)(&__dummy == &__dummy2); \
>          |                  ^~
>    include/linux/virtio_config.h:405:3: note: in expansion of macro 'typecheck'
>      405 |   typecheck(typeof(virtio_le_to_cpu(virtio_cread_v)), *(ptr)); \
>          |   ^~~~~~~~~
>    drivers/virtio/virtio_input.c:249:3: note: in expansion of macro 'virtio_cread_le'
>      249 |   virtio_cread_le(vi->vdev, struct virtio_input_config,
>          |   ^~~~~~~~~~~~~~~
> >> include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
>       12 |  (void)(&__dummy == &__dummy2); \
>          |                  ^~
>    include/linux/virtio_config.h:405:3: note: in expansion of macro 'typecheck'
>      405 |   typecheck(typeof(virtio_le_to_cpu(virtio_cread_v)), *(ptr)); \
>          |   ^~~~~~~~~
>    drivers/virtio/virtio_input.c:251:3: note: in expansion of macro 'virtio_cread_le'
>      251 |   virtio_cread_le(vi->vdev, struct virtio_input_config,
>          |   ^~~~~~~~~~~~~~~
> >> include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
>       12 |  (void)(&__dummy == &__dummy2); \
>          |                  ^~
>    include/linux/virtio_config.h:405:3: note: in expansion of macro 'typecheck'
>      405 |   typecheck(typeof(virtio_le_to_cpu(virtio_cread_v)), *(ptr)); \
>          |   ^~~~~~~~~
>    drivers/virtio/virtio_input.c:253:3: note: in expansion of macro 'virtio_cread_le'
>      253 |   virtio_cread_le(vi->vdev, struct virtio_input_config,
>          |   ^~~~~~~~~~~~~~~
> 
> vim +12 include/linux/typecheck.h
> 
> e0deaff470900a4 Andrew Morton 2008-07-25   4  
> e0deaff470900a4 Andrew Morton 2008-07-25   5  /*
> e0deaff470900a4 Andrew Morton 2008-07-25   6   * Check at compile time that something is of a particular type.
> e0deaff470900a4 Andrew Morton 2008-07-25   7   * Always evaluates to 1 so you may use it easily in comparisons.
> e0deaff470900a4 Andrew Morton 2008-07-25   8   */
> e0deaff470900a4 Andrew Morton 2008-07-25   9  #define typecheck(type,x) \
> e0deaff470900a4 Andrew Morton 2008-07-25  10  ({	type __dummy; \
> e0deaff470900a4 Andrew Morton 2008-07-25  11  	typeof(x) __dummy2; \
> e0deaff470900a4 Andrew Morton 2008-07-25 @12  	(void)(&__dummy == &__dummy2); \
> e0deaff470900a4 Andrew Morton 2008-07-25  13  	1; \
> e0deaff470900a4 Andrew Morton 2008-07-25  14  })
> e0deaff470900a4 Andrew Morton 2008-07-25  15  
> 
> :::::: The code at line 12 was first introduced by commit
> :::::: e0deaff470900a4c3222ca7139f6c9639e26a2f5 split the typecheck macros out of include/linux/kernel.h
> 
> :::::: TO: Andrew Morton <akpm@linux-foundation.org>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
