Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72245C11F69
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 06:46:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BACE61D08
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 06:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BACE61D08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0CE34062E;
	Wed, 30 Jun 2021 06:46:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQIZxk71jsIV; Wed, 30 Jun 2021 06:46:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3332540602;
	Wed, 30 Jun 2021 06:46:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 046D9C0010;
	Wed, 30 Jun 2021 06:46:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D08B0C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE84D83AA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LK7S3kzZ9QtU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:46:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5292983A60
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:46:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195452693"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; d="scan'208";a="195452693"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2021 23:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; d="scan'208";a="641596945"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2021 23:45:56 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, arnd@arndb.de, kblaiech@mellanox.com,
 jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
 rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
 u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
 yu1.wang@intel.com, shuo.a.liu@intel.com, viresh.kumar@linaro.org,
 stefanha@redhat.com, pbonzini@redhat.com
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <05cc9484-f97b-0533-64fe-ff917c6b87ee@intel.com>
Date: Wed, 30 Jun 2021 14:45:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNrw4rxihFLuqLtY@ninjato>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2021/6/29 18:07, Wolfram Sang wrote:

> Hi,
>
> so some minor comments left:
>
>> +		if (!msgs[i].len)
>> +			break;
> I hope this can extended in the future to allow zero-length messages. If
> this is impossible we need to set an adapter quirk instead.


Yes, we can support it by removing this check and call it zero-length =

request.
It don't think it will break anything.


>
>> +		err =3D virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNE=
L);
>> +		if (err < 0) {
>> +			pr_err("failed to add msg[%d] to virtqueue.\n", i);
> Is it really helpful for the user to know that msg5 failed? We don't
> even say which transfer.


OK. I will remove this print.


>> +static u32 virtio_i2c_func(struct i2c_adapter *adap)
>> +{
>> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> You are not emulating I2C_FUNC_SMBUS_QUICK, so you need to mask it out.


I will remove the check of=A0 zero-length message.


>
>> +	snprintf(vi->adap.name, sizeof(vi->adap.name), "Virtio I2C Adapter");
> Is there something to add so you can distinguish multiple instances?
> Most people want that.


I find the I2C core will set a device name "i2c-%d" for this purpose, right?

I think this name can be used to distinguish the adapter types while =

"i2c-%d" can be used to

distinguish instances. Does it make sense ?


>> +	vi->adap.class =3D I2C_CLASS_DEPRECATED;
>> +	vi->adap.algo =3D &virtio_algorithm;
>> +	vi->adap.dev.parent =3D &vdev->dev;
>> +	vi->adap.timeout =3D HZ / 10;
> Why so short? HZ is the kinda default value.


Ah... I didn't know the I2C core had already set a default value.
I will remove this line to use the default one.


>
>> +	i2c_set_adapdata(&vi->adap, vi);
>> +
>> +	/* Setup ACPI node for controlled devices which will be probed through=
 ACPI */
>> +	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));
>> +
>> +	ret =3D i2c_add_adapter(&vi->adap);
>> +	if (ret) {
>> +		virtio_i2c_del_vqs(vdev);
>> +		dev_err(&vdev->dev, "failed to add virtio-i2c adapter.\n");
> Won't the driver core print that for us?


Yes. It seems unnecessary. Will remove it.


>
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/* The bit 0 of the @virtio_i2c_out_hdr.@flags, used to group the reque=
sts */
>> +#define VIRTIO_I2C_FLAGS_FAIL_NEXT	0x00000001
> BIT(0)?


That's better. Thank you.


>
> Happy hacking,
>
>     Wolfram
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
