Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC45C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 12:10:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3410E64DDE
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 12:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3410E64DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E022242FB0;
	Mon,  1 Mar 2021 12:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TcZUdQIc9q9X; Mon,  1 Mar 2021 12:10:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D95942FAC;
	Mon,  1 Mar 2021 12:10:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CECC000A;
	Mon,  1 Mar 2021 12:10:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0009CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D464E605E4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XzhX-Z9JoF7F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07792605A4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:20 +0000 (UTC)
IronPort-SDR: tk3MseF6azsv2ATpnUEpnUQLhl+JWoq+8bzmAJ1au0YTswO/JoNnrlWFOkf16lVsC4ngv6fDce
 7/WYET256Spg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="166318719"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="166318719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 04:10:19 -0800
IronPort-SDR: SPCAxCdAecMLLqoTDlPItL7K2jphc+xnG0mvpY6E/DAH8K/05t3iT+nKl4vzN1yyUbHSvp9PML
 xkFhJTXkqcuA==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="435380055"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 04:08:06 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lGhLA-0098TC-Sb; Mon, 01 Mar 2021 14:07:56 +0200
Date: Mon, 1 Mar 2021 14:07:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <YDzZHKdrpROgSdg3@smile.fi.intel.com>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 viresh.kumar@linaro.org, shuo.a.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 kblaiech@mellanox.com, tali.perry1@gmail.com, conghui.chen@intel.com,
 rppt@kernel.org
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

On Mon, Mar 01, 2021 at 02:41:35PM +0800, Jie Deng wrote:
> Add an I2C bus driver for virtio para-virtualization.
> 
> The controller can be emulated by the backend driver in
> any device model software by following the virtio protocol.
> 
> The device specification can be found on
> https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
> 
> By following the specification, people may implement different
> backend drivers to emulate different controllers according to
> their needs.

...

> +		buf = kzalloc(msgs[i].len, GFP_KERNEL);
> +		if (!buf)
> +			break;
> +
> +		if (msgs[i].flags & I2C_M_RD) {

kzalloc()

> +			reqs[i].read_buf = buf;
> +			sg_init_one(&msg_buf, reqs[i].read_buf, msgs[i].len);
> +			sgs[outcnt + incnt++] = &msg_buf;
> +		} else {
> +			reqs[i].write_buf = buf;

> +			memcpy(reqs[i].write_buf, msgs[i].buf, msgs[i].len);

kmemdup() ?

> +			sg_init_one(&msg_buf, reqs[i].write_buf, msgs[i].len);
> +			sgs[outcnt++] = &msg_buf;
> +		}

...

> +
> +

One blank line is enough.

...


> +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
> +	if (ret == 0)
> +		goto err_unlock_free;

> +	else

Redundant.

> +		nr = ret;

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
