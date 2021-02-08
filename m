Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CEC433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:57:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69D864E56
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69D864E56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F40D867A8;
	Mon,  8 Feb 2021 09:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3rAolzya7T8a; Mon,  8 Feb 2021 09:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8388867EC;
	Mon,  8 Feb 2021 09:57:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90682C0174;
	Mon,  8 Feb 2021 09:57:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72494C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 65B51867EC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BnnmG719bo84
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7FA5D867A8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612778248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RvZB2MDYfZF1qZTLhRJJTQFx3HJrD/c9ga0gap1r0Iw=;
 b=SY4IsF6SbgAXHXwZXWd/uot+WYhV2HiugtUpgGTcGriZF3p8N89XasnQEsYrcLIyRt1WA/
 RMwqzBbegV3EHaJKHmPYoVW7I3FO/WTf67Rt5WGbL+8r26TJH/Q7T4yL6Ar+/wP16NwmUj
 9Td+r8CmfXgwIiXyMdeDSNlUD+cjxfc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-lNvRhOwqNDavk7p9bJyDtQ-1; Mon, 08 Feb 2021 04:57:25 -0500
X-MC-Unique: lNvRhOwqNDavk7p9bJyDtQ-1
Received: by mail-ed1-f70.google.com with SMTP id o21so827085edq.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 01:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RvZB2MDYfZF1qZTLhRJJTQFx3HJrD/c9ga0gap1r0Iw=;
 b=p4/NZnG9sHscECvLkLjJjVBrawYEVN7fouAYukR94GDunIEpQstJQpUPYF5/BOwPHF
 WSyhwyEf1XmEhtS1FwVZoUikBtd+aWiCuaYUQyY4mlMX5nmUZETmlTUoa5gn9B5fWr8s
 Nwg7/ncwh1JgtjcmajXeW0OFZNztgc9wXL5vzdiNsEylnGPB3ka1juMoOHy8JpXEVVKx
 3zMXUYN9CYnzMy/QFmS4nutSNmK4vh0geKSNLyNwQmaEnglhQ+2iSJYUlq4kHEX1guLN
 DKSqtC4jbWgKJzuTivpN6eFX6Bp3+t9ee0nwcd4ofCpUHj2CEt87JXpHyTM/z/485lQ7
 sJ7g==
X-Gm-Message-State: AOAM531tlgOgJSf+6zjc03NPQc+6bMNOhD4MCTgRgIxv2jpySYBa/9Zb
 oRwf0G4DDuFsEu/jzrlIwWmDx2Otw1X5Sdj9ekDHlmAM4hilQhV/I/cHqDM9a05/S21ZVhjh72g
 90r9nYm1nnKrp0BtA92TYubSRm4SMnLYXguaWYWC/Eg==
X-Received: by 2002:a17:906:69c2:: with SMTP id
 g2mr15591531ejs.249.1612778244679; 
 Mon, 08 Feb 2021 01:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuMkDMU86Gua486YyYkyE3So25auj8KdRwJTxDrTGf27Ev7G+jbzxJNKOribW4cbFKzGSizw==
X-Received: by 2002:a17:906:69c2:: with SMTP id
 g2mr15591508ejs.249.1612778244420; 
 Mon, 08 Feb 2021 01:57:24 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id mh4sm5533387ejb.122.2021.02.08.01.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 01:57:23 -0800 (PST)
Date: Mon, 8 Feb 2021 04:57:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <oliver.sang@intel.com>
Subject: Re: [vdpa_sim_net] 79991caf52:
 net/ipv4/ipmr.c:#RCU-list_traversed_in_non-reader_section
Message-ID: <20210208045641-mutt-send-email-mst@kernel.org>
References: <20210123080853.4214-1-dongli.zhang@oracle.com>
 <20210207030330.GB17282@xsang-OptiPlex-9020>
MIME-Version: 1.0
In-Reply-To: <20210207030330.GB17282@xsang-OptiPlex-9020>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: aruna.ramakrishna@oracle.com, lkp@intel.com, kvm@vger.kernel.org,
 joe.jin@oracle.com, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, lkp@lists.01.org,
 stefanha@redhat.com, netdev@vger.kernel.org, pbonzini@redhat.com,
 Eli Cohen <elic@nvidia.com>
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

On Sun, Feb 07, 2021 at 11:03:30AM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 79991caf5202c7989928be534727805f8f68bb8d ("vdpa_sim_net: Add support for user supported devices")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git Dongli-Zhang/vhost-scsi-alloc-vhost_scsi-with-kvzalloc-to-avoid-delay/20210129-191605
> 
> 
> in testcase: trinity
> version: trinity-static-x86_64-x86_64-f93256fb_2019-08-28
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 

Parav want to take a look?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
