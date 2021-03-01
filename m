Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96601C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 12:10:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CFB64DDE
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 12:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CFB64DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE501605A4;
	Mon,  1 Mar 2021 12:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRdLj7po-APY; Mon,  1 Mar 2021 12:10:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FD93605A5;
	Mon,  1 Mar 2021 12:10:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C34BC000A;
	Mon,  1 Mar 2021 12:10:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 896FEC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 784A78401B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NxsD0zqJSTza
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C539B83F98
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 12:10:19 +0000 (UTC)
IronPort-SDR: EhALaw6OJ/3i/YiSpejUK7iPut9NUSPoSnC3+xAtZ+UD4P//qLCmKLjGJxII4WOJ9oroiornxr
 cYrWcpzbhFIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="250493743"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="250493743"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 04:10:18 -0800
IronPort-SDR: 5488qTZDkrJOb0JWeQLFscBSDvn5H9ZcBjmR2goKsdf2y0/p9SPszcJCphYul6dnphziaNR8fY
 XcYR7xrsMm6w==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="406195141"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 04:10:13 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lGhNJ-0098UW-Sb; Mon, 01 Mar 2021 14:10:09 +0200
Date: Mon, 1 Mar 2021 14:10:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <YDzZocYCA8UC1FCW@smile.fi.intel.com>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <YDzZdc9+6hEvIDS1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YDzZdc9+6hEvIDS1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com, tali.perry1@gmail.com,
 conghui.chen@intel.com, rppt@kernel.org, yu1.wang@intel.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 01, 2021 at 02:09:25PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 01, 2021 at 05:24:41PM +0530, Viresh Kumar wrote:
> > On 01-03-21, 14:41, Jie Deng wrote:
> > > +/**
> > > + * struct virtio_i2c_req - the virtio I2C request structure
> > > + * @out_hdr: the OUT header of the virtio I2C message
> > > + * @write_buf: contains one I2C segment being written to the device
> > > + * @read_buf: contains one I2C segment being read from the device
> > > + * @in_hdr: the IN header of the virtio I2C message
> > > + */
> > > +struct virtio_i2c_req {
> > > +	struct virtio_i2c_out_hdr out_hdr;
> > > +	u8 *write_buf;
> > > +	u8 *read_buf;
> > > +	struct virtio_i2c_in_hdr in_hdr;
> > > +};
> > =

> > I am not able to appreciate the use of write/read bufs here as we
> > aren't trying to read/write data in the same transaction. Why do we
> > have two bufs here as well as in specs ?
> =

> I=B2C and SMBus support bidirectional transfers as well. I think two buff=
ers is
> the right thing to do.

Strictly speaking "half duplex".

-- =

With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
