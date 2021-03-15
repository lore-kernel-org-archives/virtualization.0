Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F29C433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 01:14:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D154064DFD
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 01:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D154064DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8044E4016A;
	Mon, 15 Mar 2021 01:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8_NfmUv6EScT; Mon, 15 Mar 2021 01:14:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37A08400CC;
	Mon, 15 Mar 2021 01:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA04C000A;
	Mon, 15 Mar 2021 01:14:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF679C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 01:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9683C4016A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 01:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FU7r6yKYXP7L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 01:14:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DA5B400CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 01:14:44 +0000 (UTC)
IronPort-SDR: b084t5rn2rIlddNAnt9VzSFKZARE32y+pAbWYZrMZtAH4HNVjTOQd8faZtJFVFaER38P/2F5nS
 IdmZmrBN849w==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="189112846"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="189112846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2021 18:14:43 -0700
IronPort-SDR: 6WehyGfaZkgN3csKE1b1b22pkbFj42af9jfpdGakLe0uNVVQ5rKAYCG99RlHI6oErO2bfhEPnz
 aGsgOE7aPyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="601256882"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga006.fm.intel.com with ESMTP; 14 Mar 2021 18:14:38 -0700
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
 <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <8070f03d-8233-636b-5ea9-395e723f7a2c@intel.com>
Date: Mon, 15 Mar 2021 09:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>
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


On 2021/3/12 16:58, Arnd Bergmann wrote:
> On Fri, Mar 12, 2021 at 2:33 PM Jie Deng <jie.deng@intel.com> wrote:
>
>> +
>> +/**
>> + * struct virtio_i2c_req - the virtio I2C request structure
>> + * @out_hdr: the OUT header of the virtio I2C message
>> + * @buf: the buffer into which data is read, or from which it's written
>> + * @in_hdr: the IN header of the virtio I2C message
>> + */
>> +struct virtio_i2c_req {
>> +       struct virtio_i2c_out_hdr out_hdr;
>> +       uint8_t *buf;
>> +       struct virtio_i2c_in_hdr in_hdr;
>> +};
> The simpler request structure clearly looks better than the previous version,
> but I think I found another problem here, at least a theoretical one:
>
> When you map the headers into the DMA address space, they should
> be in separate cache lines, to allow the DMA mapping interfaces to
> perform cache management on each one without accidentally clobbering
> another member.
>
> So far I think there is an assumption that virtio buffers are always
> on cache-coherent devices, but if you ever have a virtio-i2c device
> backend on a physical interconnect that is not cache coherent (e.g. a
> microcontroller that shares the memory bus), this breaks down.
>
> You could avoid this by either allocating arrays of each type separately,
> or by marking each member that you pass to the device as
> ____cacheline_aligned.
>
>        Arnd
The virtio devices are software emulated. The backend software may need to
consider this since it may exchange data with physical devices. But I 
don't think
we need it for this interface, because no DMA operation is involved 
between the
frontend driver and backend driver.

Regards,

Jie


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
