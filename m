Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD5C433DF
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 02:45:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62CD2072C
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 02:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62CD2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4B01720522;
	Mon, 12 Oct 2020 02:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pmr+MArRPJ6k; Mon, 12 Oct 2020 02:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3DB2520501;
	Mon, 12 Oct 2020 02:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14DC2C0052;
	Mon, 12 Oct 2020 02:45:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A8CDC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 02:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2B42F873C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 02:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dDB627n7Orq3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 02:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F19D587108
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 02:45:30 +0000 (UTC)
IronPort-SDR: XPRKijZA9ZT9/Su/VCaRk5bUx9ldghTJ+PKDMgpglZalOITpL/IpuD+atwOoXgrUi8iNTtXV0f
 i6ZhVDHX6OUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="229864768"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
 d="scan'208,217";a="229864768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2020 19:45:21 -0700
IronPort-SDR: qwvm1pyGtSlhZuclBUcQ4I72778xdi3ObhLfQJByy8okodaJOyeHsN0uWT8tpuYtF8dk+OqN4F
 a1AQEdqXFlIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
 d="scan'208,217";a="299146390"
Received: from unknown (HELO [10.239.154.47]) ([10.239.154.47])
 by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2020 19:45:16 -0700
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <958b69c3-0321-d5cb-4c12-702795925583@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <2dc4bd12-9f23-7caa-b1ec-f3403d36e065@intel.com>
Date: Mon, 12 Oct 2020 10:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <958b69c3-0321-d5cb-4c12-702795925583@redhat.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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
Content-Type: multipart/mixed; boundary="===============6879545460114193807=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============6879545460114193807==
Content-Type: multipart/alternative;
 boundary="------------0D99ECCE2C2D8963B2CCD197"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0D99ECCE2C2D8963B2CCD197
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020/10/10 11:14, Jason Wang wrote:
>
>> +
>> +        virtqueue_kick(vq);
>> +
>> +        time_left = wait_for_completion_timeout(&vi->completion, 
>> adap->timeout);
>> +        if (!time_left) {
>> +            dev_err(&adap->dev, "msg[%d]: addr=0x%x timeout.\n", i, 
>> msgs[i].addr);
>> +            break;
>> +        }
>
>
> You don't set error number here. Is this intended?
>
> And using a timeout here is not good, and if the request is finished 
> just after the timeout, in the next xfer you may hit the following check.
>
> It's better to use either interrupt here.
>
Could you check the I2C drivers in the kernel ? The 
"wait_for_completion_timeout" mechanism
is commonly used by I2C bus drivers in their i2c_algorithm.master_xfer.


>
>> +
>> +        vmsg = (struct virtio_i2c_msg *)virtqueue_get_buf(vq, &len);
>> +        /* vmsg should point to the same address with &vi->vmsg */
>> +        if ((!vmsg) || (vmsg != &vi->vmsg)) {
>> +            dev_err(&adap->dev, "msg[%d]: addr=0x%x virtqueue 
>> error.\n",
>> +                i, msgs[i].addr);
>> +            break;
>> +        }
>
>
> So I think we can remove this check. Consider only one descriptor will 
> be used at most, unless there's a bug in the device (and no other 
> driver to the similar check), we should not hit this.
>
> Btw, as I replied in the previous version, the device should be 
> cacpable of dealing of a batch of requests through the virtqueue, 
> otherwise it's meaningless to use a queue here.
>
We should not assume there is no bug in the device. I don't think we can 
remove this check if we want our code to be robust.
As I said, currently, we are using the virtqueue to send the msg one by 
one to the backend. The mechanism is described in the spec.

Thanks.


>
>> +
>>
>> +
>> +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
>> +#define _UAPI_LINUX_VIRTIO_I2C_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/virtio_ids.h>
>> +#include <linux/virtio_config.h>
>> +
>> +/**
>> + * struct virtio_i2c_hdr - the virtio I2C message header structure
>> + * @addr: i2c_msg addr, the slave address
>> + * @flags: i2c_msg flags
>> + * @len: i2c_msg len
>> + */
>> +struct virtio_i2c_hdr {
>> +    __le16 addr;
>> +    __le16 flags;
>> +    __le16 len;
>> +};
>
>
> I'm afraid this is not complete. E.g the status is missed.
>
> I suspect what virtio-scsi use is better. Which split the in from the 
> out instead of reusing the same buffer. And it can ease the uAPI 
> header export.
>
> Thanks
>
>

I think following definition in uAPI for the status is enough.
There is no need to provide a "u8" status in the structure.

/* The final status written by the device */
#define VIRTIO_I2C_MSG_OK    0
#define VIRTIO_I2C_MSG_ERR    1

You can see an example in virtio_blk.

In the spec:

struct virtio_blk_req {
le32 type;
le32 reserved;
le64 sector;
u8 data[];
u8 status;
};

In virtio_blk.h, there is only following definitions.

#define VIRTIO_BLK_S_OK        0
#define VIRTIO_BLK_S_IOERR    1
#define VIRTIO_BLK_S_UNSUPP    2

Thanks.




--------------0D99ECCE2C2D8963B2CCD197
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020/10/10 11:14, Jason Wang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:958b69c3-0321-d5cb-4c12-702795925583@redhat.com">
      <br>
      <blockquote type="cite">+
        <br>
        +        virtqueue_kick(vq);
        <br>
        +
        <br>
        +        time_left =
        wait_for_completion_timeout(&amp;vi-&gt;completion,
        adap-&gt;timeout);
        <br>
        +        if (!time_left) {
        <br>
        +            dev_err(&amp;adap-&gt;dev, "msg[%d]: addr=0x%x
        timeout.\n", i, msgs[i].addr);
        <br>
        +            break;
        <br>
        +        }
        <br>
      </blockquote>
      <br>
      <br>
      You don't set error number here. Is this intended?
      <br>
      <br>
      And using a timeout here is not good, and if the request is
      finished just after the timeout, in the next xfer you may hit the
      following check.
      <br>
      <br>
      It's better to use either interrupt here.
      <br>
      <br>
    </blockquote>
    Could you check the I2C drivers in the kernel ? The
    "wait_for_completion_timeout" mechanism<br>
    is commonly used by I2C bus drivers in their
    i2c_algorithm.master_xfer.<br>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:958b69c3-0321-d5cb-4c12-702795925583@redhat.com">
      <br>
      <blockquote type="cite">+
        <br>
        +        vmsg = (struct virtio_i2c_msg *)virtqueue_get_buf(vq,
        &amp;len);
        <br>
        +        /* vmsg should point to the same address with
        &amp;vi-&gt;vmsg */
        <br>
        +        if ((!vmsg) || (vmsg != &amp;vi-&gt;vmsg)) {
        <br>
        +            dev_err(&amp;adap-&gt;dev, "msg[%d]: addr=0x%x
        virtqueue error.\n",
        <br>
        +                i, msgs[i].addr);
        <br>
        +            break;
        <br>
        +        }
        <br>
      </blockquote>
      <br>
      <br>
      So I think we can remove this check. Consider only one descriptor
      will be used at most, unless there's a bug in the device (and no
      other driver to the similar check), we should not hit this.
      <br>
      <br>
      Btw, as I replied in the previous version, the device should be
      cacpable of dealing of a batch of requests through the virtqueue,
      otherwise it's meaningless to use a queue here.
      <br>
      <br>
    </blockquote>
    We should not assume there is no bug in the device. I don't think we
    can remove this check if we want our code to be robust. <br>
    As I said, currently, we are using the virtqueue to send the msg one
    by one to the backend. The mechanism is described in the spec.
    <p>Thanks.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:958b69c3-0321-d5cb-4c12-702795925583@redhat.com">
      <br>
      <blockquote type="cite">+
        <br>
        <br>
        +
        <br>
        +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
        <br>
        +#define _UAPI_LINUX_VIRTIO_I2C_H
        <br>
        +
        <br>
        +#include &lt;linux/types.h&gt;
        <br>
        +#include &lt;linux/virtio_ids.h&gt;
        <br>
        +#include &lt;linux/virtio_config.h&gt;
        <br>
        +
        <br>
        +/**
        <br>
        + * struct virtio_i2c_hdr - the virtio I2C message header
        structure
        <br>
        + * @addr: i2c_msg addr, the slave address
        <br>
        + * @flags: i2c_msg flags
        <br>
        + * @len: i2c_msg len
        <br>
        + */
        <br>
        +struct virtio_i2c_hdr {
        <br>
        +    __le16 addr;
        <br>
        +    __le16 flags;
        <br>
        +    __le16 len;
        <br>
        +};
        <br>
      </blockquote>
      <br>
      <br>
      I'm afraid this is not complete. E.g the status is missed.
      <br>
      <br>
      I suspect what virtio-scsi use is better. Which split the in from
      the out instead of reusing the same buffer. And it can ease the
      uAPI header export.
      <br>
      <br>
      Thanks
      <br>
      <br>
      <br>
    </blockquote>
    <p><br>
      I think following definition in uAPI for the status is enough.<br>
      There is no need to provide a "u8" status in the structure.<br>
    </p>
    <p>/* The final status written by the device */<br>
      #define VIRTIO_I2C_MSG_OK    0<br>
      #define VIRTIO_I2C_MSG_ERR    1</p>
    <p>You can see an example in virtio_blk.</p>
    <p>In the spec:</p>
    <p><span class="fontstyle0"><span class="fontstyle0">struct
          virtio_blk_req {<br>
          le32 type;<br>
          le32 reserved;<br>
          le64 sector;<br>
          u8 data[];<br>
          u8 status;<br>
          };</span></span></p>
    <p><span class="fontstyle0"><span class="fontstyle0">In
          virtio_blk.h, there is only following </span></span><span
        class="fontstyle0"><span class="fontstyle0">definitions. </span></span></p>
    <p><span class="fontstyle0"><span class="fontstyle0">#define
          VIRTIO_BLK_S_OK        0<br>
          #define VIRTIO_BLK_S_IOERR    1<br>
          #define VIRTIO_BLK_S_UNSUPP    2</span></span><br>
    </p>
    <p>Thanks.</p>
    <p><br>
    </p>
    <br>
  </body>
</html>

--------------0D99ECCE2C2D8963B2CCD197--

--===============6879545460114193807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6879545460114193807==--
