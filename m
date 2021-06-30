Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B61C11F68
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 08:07:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFD361D07
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 08:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFD361D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE00A402A4;
	Wed, 30 Jun 2021 08:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCUZnKloHFkF; Wed, 30 Jun 2021 08:07:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C1B84023E;
	Wed, 30 Jun 2021 08:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67A26C001A;
	Wed, 30 Jun 2021 08:07:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67CC0C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 745A0605B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t61ulmFrc_la
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:07:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A9706065C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:07:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208257333"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; d="scan'208";a="208257333"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2021 01:07:33 -0700
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; d="scan'208";a="641620819"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2021 01:07:28 -0700
Received: from andy by smile with local (Exim 4.94.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lyVFj-006W5i-Cc; Wed, 30 Jun 2021 11:07:23 +0300
Date: Wed, 30 Jun 2021 11:07:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <YNwmO0LhcS//hvc5@smile.fi.intel.com>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <05cc9484-f97b-0533-64fe-ff917c6b87ee@intel.com>
 <YNwd/t3DMKSOrTAT@ninjato>
 <3016ab8b-cbff-1309-6a1f-080703a4130f@intel.com>
 <CAK8P3a0Ew+RS_1buR+1OneH8XEqVjPOr0FGCF5d6CvFQuJqg6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Ew+RS_1buR+1OneH8XEqVjPOr0FGCF5d6CvFQuJqg6g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>, yu1.wang@intel.com
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

On Wed, Jun 30, 2021 at 09:55:49AM +0200, Arnd Bergmann wrote:
> On Wed, Jun 30, 2021 at 9:51 AM Jie Deng <jie.deng@intel.com> wrote:

...

> On a related note, we are apparently still missing the bit in the virtio bus
> layer that fills in the dev->of_node pointer of the virtio device. Without
> this, it is not actually possible to automatically probe i2c devices connected
> to a virtio-i2c bus. The same problem came up again with the virtio-gpio
> driver that suffers from the same issue.

Don't we need to take care about fwnode handle as well?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
