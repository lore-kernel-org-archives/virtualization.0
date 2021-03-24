Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA5C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 00:53:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E744619B3
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 00:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E744619B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3C4084857;
	Wed, 24 Mar 2021 00:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tap6BuCGIID4; Wed, 24 Mar 2021 00:53:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D0DA84850;
	Wed, 24 Mar 2021 00:53:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60D31C000E;
	Wed, 24 Mar 2021 00:53:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC24BC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 00:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CE65405AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 00:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJ8bvf__jXGT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 00:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2632405AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 00:53:42 +0000 (UTC)
IronPort-SDR: Rp9fDV1U+ivpn3cgiwHgRv4e3f7rEkTrrW/EjWLgoqdiVJr4ZZ+M4HpC6gf7sam962C/ULZDYX
 gSF7y0YneALQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="178159459"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="178159459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2021 17:53:41 -0700
IronPort-SDR: AYUOOpG1XUognPuZnimdo4CPPCLZYHUifyfk2hiTiY9LSTG4F2iUFi/YfSHAzbNwsVCNuobBS5
 8XOkYFitOEpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="441963415"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2021 17:53:35 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323090108.ygx76exdgzudeeqi@vireshk-i7>
 <20210323093839.n7cq7f5poebqdwit@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <5a415dbe-8e3b-2731-cc52-19aeadda1a17@intel.com>
Date: Wed, 24 Mar 2021 08:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323093839.n7cq7f5poebqdwit@vireshk-i7>
Content-Language: en-US
Cc: mst@redhat.com, bjorn.andersson@linaro.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, wsa@kernel.org,
 andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 virtualization@lists.linux-foundation.org, arnd@arndb.de, stefanha@redhat.com,
 tali.perry1@gmail.com, conghui.chen@intel.com, loic.poulain@linaro.org,
 linux-kernel@vger.kernel.org, Sergey.Semin@baikalelectronics.ru,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com, pbonzini@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 2021/3/23 17:38, Viresh Kumar wrote:
> On 23-03-21, 14:31, Viresh Kumar wrote:
>> On 23-03-21, 22:19, Jie Deng wrote:
>>> +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>>> +{
>>> +	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>>> +	struct virtqueue *vq = vi->vq;
>>> +	struct virtio_i2c_req *reqs;
>>> +	unsigned long time_left;
>>> +	int ret, nr;
>>> +
>>> +	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
>>> +	if (!reqs)
>>> +		return -ENOMEM;
>>> +
>>> +	mutex_lock(&vi->lock);
>>> +
>>> +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
>>> +	if (ret == 0)
>>> +		goto err_unlock_free;
>>> +
>>> +	nr = ret;
>>> +	reinit_completion(&vi->completion);
>> I think I may have found a possible bug here. This reinit_completion() must
>> happen before we call virtio_i2c_send_reqs(). It is certainly possible (surely
>> in corner cases) that virtio_i2c_msg_done() may get called right after
>> virtio_i2c_send_reqs() and before we were able to call reinit_completion(). And
>> in that case we will never see the completion happen at all.
>>
>>> +	virtqueue_kick(vq);
> I may have misread this. Can the actually start before virtqueue_kick() is
> called ?


No. It starts when wait_for_completion_timeout is called.

So it should be fine here.


>   If not, then completion may be fine where it is.
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
