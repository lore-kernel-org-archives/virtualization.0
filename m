Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA6C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 05:21:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F3460241
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 05:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F3460241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2BD54DF7C;
	Tue,  2 Mar 2021 05:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id loqsa0uxyhyZ; Tue,  2 Mar 2021 05:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D7764D4E0;
	Tue,  2 Mar 2021 05:21:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D99DBC000A;
	Tue,  2 Mar 2021 05:21:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44E89C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EB0483C05
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wV82KM9_vZok
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:21:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CDE183BE9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:21:35 +0000 (UTC)
IronPort-SDR: 1QX08+ZtsggSL5xGzS3VeN6mTYkYoUoISV8KQFw4vTmH4q8C+y4jgLkhQvd3VmYK1fyD3Xhrxu
 GWXqYR6cfgWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186808078"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="186808078"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 21:21:33 -0800
IronPort-SDR: 1EAGgABchDoQBsjqVttpRTIyffgxjTAGDkWJIWlE4zbkJhWrOJZDD6zxar6Xys55wm46zHlLaW
 vK286rABsECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444594676"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 21:21:26 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210302044214.gnnce5ptwehrsnpc@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <1e01448f-52f6-3d39-6794-d140637fdcc3@intel.com>
Date: Tue, 2 Mar 2021 13:21:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302044214.gnnce5ptwehrsnpc@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, rppt@kernel.org
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


On 2021/3/2 12:42, Viresh Kumar wrote:
> On 01-03-21, 14:41, Jie Deng wrote:
>> +static int virtio_i2c_send_reqs(struct virtqueue *vq,
>> +				struct virtio_i2c_req *reqs,
>> +				struct i2c_msg *msgs, int nr)
>> +{
>> +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
>> +	int i, outcnt, incnt, err = 0;
>> +	u8 *buf;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		if (!msgs[i].len)
>> +			break;
>> +
>> +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
> And this won't work for 10 bit addressing right? Don't we support that
> in kernel ?
>
>  From Spec:
>
> \begin{tabular}{ |l||l|l|l|l|l|l|l|l|l|l|l|l|l|l|l|l| }
> \hline
> Bits           & 15 & 14 & 13 & 12 & 11 & 10 & 9  & 8  & 7  & 6  & 5  & 4  & 3  & 2  & 1  & 0 \\
> \hline
> 7-bit address  & 0  & 0  & 0  & 0  & 0  & 0  & 0  & 0  & A6 & A5 & A4 & A3 & A2 & A1 & A0 & 0 \\
> \hline
> 10-bit address & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0 & 1  & 1  & 1  & 1  & 0  & A9 & A8 & 0 \\
> \hline
> \end{tabular}
Currently, to make things simple, this driver only supports 7 bit mode.
It doesn't declare "I2C_FUNC_10BIT_ADDR" in the functionality.
We may add in the future according to the need.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
