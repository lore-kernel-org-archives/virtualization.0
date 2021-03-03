Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88671C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 08:46:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CA164ED0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 08:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CA164ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3D147D59;
	Wed,  3 Mar 2021 08:46:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iT9QxO6W4nbS; Wed,  3 Mar 2021 08:46:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACBFA477BF;
	Wed,  3 Mar 2021 08:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82A33C000B;
	Wed,  3 Mar 2021 08:46:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D33C1C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA3B76F496
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNjzndSfyvqc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:46:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4039605AD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:46:51 +0000 (UTC)
IronPort-SDR: tDdNngLCFFHmQxXdACLZkCNRpDmQh+QCi5k4v67vqIyYYNNtbKCeE/uYzznGlc9qHMhqaT5hHN
 f868/JcpDc9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="272143589"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="272143589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 00:46:50 -0800
IronPort-SDR: fo7GEBrPHClrg6sm9qWvWgOFfNt8oKmYBf6F6DJn/Vcx0giiN4b6Xku6joiQUGPABD54MAPymk
 qprYiRrOxC1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="445169948"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 00:46:44 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210303075430.n7ewkots6cgbbabi@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <876371c3-ba9a-5176-493b-5a883cba3b07@intel.com>
Date: Wed, 3 Mar 2021 16:46:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303075430.n7ewkots6cgbbabi@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, u.kleine-koenig@pengutronix.de,
 kblaiech@mellanox.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, rppt@kernel.org
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

On 2021/3/3 15:54, Viresh Kumar wrote:

> On 01-03-21, 14:41, Jie Deng wrote:
>> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
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
>> +
>> +		if (i != nr - 1)
>> +			reqs[i].out_hdr.flags |= VIRTIO_I2C_FLAGS_FAIL_NEXT;
>> +
>> +		outcnt = incnt = 0;
>> +		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
>> +		sgs[outcnt++] = &out_hdr;
>> +
>> +		buf = kzalloc(msgs[i].len, GFP_KERNEL);
>> +		if (!buf)
>> +			break;
>> +
>> +		if (msgs[i].flags & I2C_M_RD) {
>> +			reqs[i].read_buf = buf;
>> +			sg_init_one(&msg_buf, reqs[i].read_buf, msgs[i].len);
>> +			sgs[outcnt + incnt++] = &msg_buf;
>> +		} else {
>> +			reqs[i].write_buf = buf;
>> +			memcpy(reqs[i].write_buf, msgs[i].buf, msgs[i].len);
>> +			sg_init_one(&msg_buf, reqs[i].write_buf, msgs[i].len);
>> +			sgs[outcnt++] = &msg_buf;
>> +		}
>> +
>> +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
>> +		sgs[outcnt + incnt++] = &in_hdr;
>> +
>> +		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
>> +		if (err < 0) {
>> +			pr_err("failed to add msg[%d] to virtqueue.\n", i);
>> +			if (msgs[i].flags & I2C_M_RD) {
>> +				kfree(reqs[i].read_buf);
>> +				reqs[i].read_buf = NULL;
>> +			} else {
>> +				kfree(reqs[i].write_buf);
>> +				reqs[i].write_buf = NULL;
>> +			}
>> +			break;
>> +		}
>> +	}
>> +
>> +	return i;
>> +}
>> diff --git a/include/uapi/linux/virtio_i2c.h b/include/uapi/linux/virtio_i2c.h
>> +/**
>> + * struct virtio_i2c_out_hdr - the virtio I2C message OUT header
>> + * @addr: the controlled device address
>> + * @padding: used to pad to full dword
>> + * @flags: used for feature extensibility
>> + */
>> +struct virtio_i2c_out_hdr {
>> +	__le16 addr;
>> +	__le16 padding;
>> +	__le32 flags;
>> +};
> Both this code and the virtio spec (which is already merged) are
> missing msgs[i].flags and they are never sent to backend. The only
> flags available here are the ones defined by virtio spec and these are
> not i2c flags.
>
> I also looked at your i2c backend for acrn and it mistakenly copies
> the hdr.flag, which is the virtio flag and not i2c flag.
>
> https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw/pci/virtio/virtio_i2c.c#L539
>
> I will send a fix for the specs if you agree that there is a problem
> here.
>
> what am I missing here ? This should have been caught in your testing
> and so I feel I must be missing something.
This is not a problem. My original proposal was to mirror the struct 
i2c_msg.
The code you looked at was based on that.
However, the virtio TC prefer not to mirror it. They have some concerns.
For example, there is a bit I2C_M_RD in i2c_msg.flag which has the same 
meaning with
the R/W in virtio descriptor. This is a repetition which may cause problems.
So the virtio_i2c_out_hdr.flags is used to instead of i2c_msg.flags for 
extension.

You can check this link 
https://github.com/oasis-tcs/virtio-spec/issues/88 to learn the whole story.
There are discussions about the spec (v1 ~ v7).

I'm updating these drivers step by step to make sure they finally follow 
the spec.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
