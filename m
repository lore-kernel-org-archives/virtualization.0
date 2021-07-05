Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF702C07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:46:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507DB613C2
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507DB613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1689E60821;
	Mon,  5 Jul 2021 03:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyeDNlP6ILNt; Mon,  5 Jul 2021 03:46:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A16C960810;
	Mon,  5 Jul 2021 03:46:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7779BC001A;
	Mon,  5 Jul 2021 03:46:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1512C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9000A60817
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e8dZFJbfxcDF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:46:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E38A60810
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:46:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="272768727"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="272768727"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2021 20:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="562384083"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2021 20:46:41 -0700
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <2cb3e0db-f24b-bd12-c1a0-3fc7516b38c5@intel.com>
Date: Mon, 5 Jul 2021 11:46:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
Content-Language: en-US
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, conghui.chen@intel.com
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


On 2021/7/2 17:58, Andy Shevchenko wrote:
> On Fri, Jul 02, 2021 at 04:46:47PM +0800, Jie Deng wrote:
>> Add an I2C bus driver for virtio para-virtualization.
>>
>> The controller can be emulated by the backend driver in
>> any device model software by following the virtio protocol.
>>
>> The device specification can be found on
>> https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
>>
>> By following the specification, people may implement different
>> backend drivers to emulate different controllers according to
>> their needs.
> ...
>
>> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>> +				    struct virtio_i2c_req *reqs,
>> +				    struct i2c_msg *msgs, int nr,
>> +				    bool fail)
>> +{
>> +	struct virtio_i2c_req *req;
>> +	bool failed = fail;
>> +	unsigned int len;
>> +	int i, j = 0;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		/* Detach the ith request from the vq */
>> +		req = virtqueue_get_buf(vq, &len);
>> +
>> +		/*
>> +		 * Condition (req && req == &reqs[i]) should always meet since
>> +		 * we have total nr requests in the vq.
>> +		 */
>> +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
>> +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
>> +			failed = true;
> ...and after failed is true, we are continuing the loop, why?


Still need to continue to do some cleanup.


>
>> +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
>> +		if (!failed)
>> +			++j;
> Besides better to read j++ the j itself can be renamed to something more
> verbose.


Will change it to j++.


>> +	}
>> +	return (fail ? -ETIMEDOUT : j);
> Redundant parentheses.


Will remove the parentheses.


>
>> +}
> ...
>
>> +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
>> +	if (ret != num) {
>> +		virtio_i2c_complete_reqs(vq, reqs, msgs, ret, true);
> Below you check the returned code, here is not.


I will do some optimization here.


>
>> +		ret = 0;
>> +		goto err_free;
>> +	}
>> +
>> +	reinit_completion(&vi->completion);
>> +	virtqueue_kick(vq);
>> +
>> +	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
>> +	if (!time_left)
>> +		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
>> +
>> +	ret = virtio_i2c_complete_reqs(vq, reqs, msgs, num, !time_left);
>> +
>> +err_free:
>> +	kfree(reqs);
>> +	return ret;
>> +++ b/include/uapi/linux/virtio_i2c.h
>> +#include <linux/types.h>
>> +
>> +/* The bit 0 of the @virtio_i2c_out_hdr.@flags, used to group the requests */
>> +#define VIRTIO_I2C_FLAGS_FAIL_NEXT	BIT(0)
> It's _BITUL() or so from linux/const.h.
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/const.h#L28
> You may not use internal definitions in UAPI headers.


Let's use this _BITUL() from linux/const.h instead. Thank you !


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
