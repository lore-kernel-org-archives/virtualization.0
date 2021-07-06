Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B27C07E99
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 01:50:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3683E6197F
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 01:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3683E6197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E313940434;
	Tue,  6 Jul 2021 01:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qq7rteXSYEuM; Tue,  6 Jul 2021 01:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3013140412;
	Tue,  6 Jul 2021 01:50:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9EDAC001A;
	Tue,  6 Jul 2021 01:50:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC9B4C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 01:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 968B2400DC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 01:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MNUEnKlYADbs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 01:50:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45344400BD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 01:50:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="294681848"
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; d="scan'208";a="294681848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 18:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; d="scan'208";a="562831796"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2021 18:50:24 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, arnd@arndb.de,
 kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey.Semin@baikalelectronics.ru, rppt@kernel.org, loic.poulain@linaro.org,
 tali.perry1@gmail.com, u.kleine-koenig@pengutronix.de,
 bjorn.andersson@linaro.org, yu1.wang@intel.com, shuo.a.liu@intel.com,
 stefanha@redhat.com, pbonzini@redhat.com
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato> <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato> <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
 <YNr5Jf3WDTH7U5b7@ninjato> <YNr5ZRhT3qn+e9/m@ninjato>
 <20210705121832.fmye5xnlbydoc5ir@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <29f27ee2-5a65-f635-0b0a-d35d7c4839fb@intel.com>
Date: Tue, 6 Jul 2021 09:50:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210705121832.fmye5xnlbydoc5ir@vireshk-i7>
Content-Language: en-US
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


On 2021/7/5 20:18, Viresh Kumar wrote:
> On 29-06-21, 12:43, Wolfram Sang wrote:
>>>  From the spec:
>>>
>>> The case when ``length of \field{write_buf}''=0, and at the same time,
>>> ``length of \field{read_buf}''=0 doesn't make any sense.
>>>
>>> I mentioned this in my first reply and to my understanding I did not get
>>> a reply that this has changed meanwhile.
>>>
>> Also, this code as mentioned before:
>>
>>> +             if (!msgs[i].len)
>>> +                     break;
>> I hope this can extended in the future to allow zero-length messages. If
>> this is impossible we need to set an adapter quirk instead.
> Wolfram,
>
> I stumbled again upon this while working at the backend implementation.
>
> If you look at i2c_smbus_xfer_emulated(), the command is always sent via
> msgbuf0[0]. Even in the case of I2C_SMBUS_QUICK, where we set msg[0].len = 0, we
> still send the buf. This is really confusing :(
>
> Do I understand correctly that we always need to send msg[0].buf even when
> msg[0].len is 0 ?
>
> If so, it would be difficult to implement this with the current i2c virtio
> specification, as the msg.len isn't really passed from guest to host, rather it
> is inferred using the length of the buffer itself. And so we can't really pass a
> buffer if length is 0.
>
> Moreover, the driver uses i2c_get_dma_safe_msg_buf(), which also depends on the
> length parameter here to allocate the buffer and copy data to it.
>
> All in all, the latest version of the driver doesn't work with "i2cdetect -q <bus>".
>
> To make it work, I had to add this:
>
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 731267d42292..5b8bd98ae38e 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -73,6 +73,9 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>                  sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
>                  sgs[outcnt++] = &out_hdr;
>
> +               if (!msgs[i].len)
> +                       msgs[i].len = 1;
> +
>                  if (msgs[i].len) {
>                          reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
>                          if (!reqs[i].buf)
>
> which made it I2C_SMBUS_BYTE instead of I2C_SMBUS_QUICK.
>
> What should we do here Wolfram?
>
>
> Jie, while wolfram comes back and replies to this, I think you need to switch
> back to NOT supporting zero length transfer and set update virtio_i2c_func() to
> return:
>
>          I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
>
> Support for zero-length transfers and I2C_FUNC_SMBUS_QUICK can be added
> separately.
>
> Thanks.


It's OK to me. Let's see what Wolfram says when he comes back.

I will send the updated version then.

Thanks.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
