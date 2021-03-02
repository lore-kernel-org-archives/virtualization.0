Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA83CC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 02:42:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17872614A7
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 02:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17872614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA6DE60667;
	Tue,  2 Mar 2021 02:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vM7upV9qi7yU; Tue,  2 Mar 2021 02:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D1D660674;
	Tue,  2 Mar 2021 02:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E78FFC000B;
	Tue,  2 Mar 2021 02:42:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0C02C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 914E54EF82
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfvLm01c6tEv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:42:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E8264EF53
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:42:19 +0000 (UTC)
IronPort-SDR: ouqXLuqqFNKd5UaszzKr3Y6stcARs8Jg7cO7fCjUVqF7AZPtBU0EJ/8KAj83fq+sOrJhIc4ayW
 U4A97XYvj02w==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="248071996"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
 d="scan'208,217";a="248071996"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 18:42:18 -0800
IronPort-SDR: vB3zTmu86gznhVjtNAcEME3EtFGPwIhwfdVWlEmpuWLPVpTrKi8L503ibtC7jfLWsOBfiaT5Or
 JfTPZcgQboRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
 d="scan'208,217";a="444543804"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 18:42:07 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <56fdef9a-b373-32f2-6dac-e687caa813c8@intel.com>
Date: Tue, 2 Mar 2021 10:42:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
Content-Language: en-US
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, stefanha@redhat.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============3775237761354582805=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============3775237761354582805==
Content-Type: multipart/alternative;
 boundary="------------93F4C767A327742F6D836531"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------93F4C767A327742F6D836531
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2021/3/1 23:19, Arnd Bergmann wrote:
> On Mon, Mar 1, 2021 at 7:41 AM Jie Deng <jie.deng@intel.com> wrote:
>
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_i2c.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note =
*/
>> +/*
>> + * Definitions for virtio I2C Adpter
>> + *
>> + * Copyright (c) 2021 Intel Corporation. All rights reserved.
>> + */
>> +
>> +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
>> +#define _UAPI_LINUX_VIRTIO_I2C_H
> Why is this a uapi header? Can't this all be moved into the driver
> itself?
>
>> +/**
>> + * struct virtio_i2c_req - the virtio I2C request structure
>> + * @out_hdr: the OUT header of the virtio I2C message
>> + * @write_buf: contains one I2C segment being written to the device
>> + * @read_buf: contains one I2C segment being read from the device
>> + * @in_hdr: the IN header of the virtio I2C message
>> + */
>> +struct virtio_i2c_req {
>> +       struct virtio_i2c_out_hdr out_hdr;
>> +       u8 *write_buf;
>> +       u8 *read_buf;
>> +       struct virtio_i2c_in_hdr in_hdr;
>> +};
> In particular, this structure looks like it is only ever usable between=

> the transfer functions in the driver itself, it is shared with neither
> user space nor the virtio host side.
>
>         Arnd

Please check this link.

https://lists.linuxfoundation.org/pipermail/virtualization/2020-October/0=
50222.html

Jason/Stefan, could you please double confirm about the following ?

*************************************************************************=
*

>>>>>/I think following definition in uAPI for the status is enough. />>>=
>>/There is no need to provide a "u8" status in the structure. />>>>>//>>=
>>>//* The final status written by the device */ />>>>>/#define VIRTIO_I2=
C_MSG_OK=C2=A0=C2=A0=C2=A0 0 />>>>>/#define VIRTIO_I2C_MSG_ERR=C2=A0=C2=A0=
=C2=A0 1 />>>>>//>>>>>/You can see an example in virtio_blk. />>>>>//>>>>=
>/In the spec: />>>>>//>>>>>/struct virtio_blk_req { />>>>>/le32 type; />=
>>>>/le32 reserved; />>>>>/le64 sector; />>>>>/u8 data[]; />>>>>/u8 statu=
s; />>>>>/}; />>>>>//>>>>>/In virtio_blk.h, there is only following defin=
itions. />>>>>//>>>>>/#define VIRTIO_BLK_S_OK=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 0 />>>>>/#define VIRTIO_BLK_S_IOERR=C2=A0=C2=A0=C2=A0 1 />>>>>/=
#define VIRTIO_BLK_S_UNSUPP=C2=A0=C2=A0=C2=A0 2 />>>>>//>>>>//>>>>/virtio=
-blk is a bad example, it's just too late to fix. For any new />>>>/intro=
duced uAPI it should be a complete one. />>>>//>>>>/Thanks />>>>//>>>/I c=
hecked a relatively new device "virtio_fs". />>>/I found following defini=
tion in spec but not in uAPI also. />>>//>>>/struct virtio_fs_req { />>>/=
// Device -readable part />>>/struct fuse_in_header in; />>>/u8 datain[];=
 />>>/// Device -writable part />>>/struct fuse_out_header out; />>>/u8 d=
ataout[]; />>>/}; />>>//>>>/So is this also a bad example which has not b=
een fixed yet. />>//>>//>>/Cc Stefan for the answer. />>//>>//>>>/Or what=
's your mean about "complete" here ? Is there any definition />>>/about "=
complete uAPI" ? />>//>>//>>/My understanding it should contain all the f=
ields defined in the />>/virtio spec. />>//>>/Thanks />>//>/OK. I noticed=
 this isn't strictly implemented in the current virtio />/codes. />/I'm n=
ot sure if this is already a consensus. I will follow it if this />/is th=
e opinion of the majority. /

Please do that, this forces us to maintain uABI compatibility which is
what Linux try to maintain for ever.

*************************************************************************=
*****


--------------93F4C767A327742F6D836531
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/3/1 23:19, Arnd Bergmann wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Mon, Mar 1, 2021 at 7:41 AM Jie Deng <a class="moz-txt-link-rfc2396E" href="mailto:jie.deng@intel.com">&lt;jie.deng@intel.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">--- /dev/null
+++ b/include/uapi/linux/virtio_i2c.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/*
+ * Definitions for virtio I2C Adpter
+ *
+ * Copyright (c) 2021 Intel Corporation. All rights reserved.
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_I2C_H
+#define _UAPI_LINUX_VIRTIO_I2C_H
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why is this a uapi header? Can't this all be moved into the driver
itself?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+/**
+ * struct virtio_i2c_req - the virtio I2C request structure
+ * @out_hdr: the OUT header of the virtio I2C message
+ * @write_buf: contains one I2C segment being written to the device
+ * @read_buf: contains one I2C segment being read from the device
+ * @in_hdr: the IN header of the virtio I2C message
+ */
+struct virtio_i2c_req {
+       struct virtio_i2c_out_hdr out_hdr;
+       u8 *write_buf;
+       u8 *read_buf;
+       struct virtio_i2c_in_hdr in_hdr;
+};
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
In particular, this structure looks like it is only ever usable between
the transfer functions in the driver itself, it is shared with neither
user space nor the virtio host side.

       Arnd</pre>
    </blockquote>
    <p>Please check this link.<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://lists.linuxfoundation.org/pipermail/virtualization/2020-October/050222.html">https://lists.linuxfoundation.org/pipermail/virtualization/2020-October/050222.html</a></p>
    <p>Jason/Stefan, could you please double confirm about the following
      ?<br>
    </p>
    <p>**************************************************************************<br>
    </p>
    <pre style="white-space: pre-wrap; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">&gt;&gt;&gt;&gt;&gt;<i> I think following definition in uAPI for the status is enough.
</i>&gt;&gt;&gt;&gt;&gt;<i> There is no need to provide a "u8" status in the structure.
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;&gt;<i> /* The final status written by the device */
</i>&gt;&gt;&gt;&gt;&gt;<i> #define VIRTIO_I2C_MSG_OK    0
</i>&gt;&gt;&gt;&gt;&gt;<i> #define VIRTIO_I2C_MSG_ERR    1
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;&gt;<i> You can see an example in virtio_blk.
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;&gt;<i> In the spec:
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;&gt;<i> struct virtio_blk_req {
</i>&gt;&gt;&gt;&gt;&gt;<i> le32 type;
</i>&gt;&gt;&gt;&gt;&gt;<i> le32 reserved;
</i>&gt;&gt;&gt;&gt;&gt;<i> le64 sector;
</i>&gt;&gt;&gt;&gt;&gt;<i> u8 data[];
</i>&gt;&gt;&gt;&gt;&gt;<i> u8 status;
</i>&gt;&gt;&gt;&gt;&gt;<i> };
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;&gt;<i> In virtio_blk.h, there is only following definitions.
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;&gt;<i> #define VIRTIO_BLK_S_OK        0
</i>&gt;&gt;&gt;&gt;&gt;<i> #define VIRTIO_BLK_S_IOERR    1
</i>&gt;&gt;&gt;&gt;&gt;<i> #define VIRTIO_BLK_S_UNSUPP    2
</i>&gt;&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;<i> virtio-blk is a bad example, it's just too late to fix. For any new 
</i>&gt;&gt;&gt;&gt;<i> introduced uAPI it should be a complete one.
</i>&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;&gt;<i> Thanks
</i>&gt;&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;<i> I checked a relatively new device "virtio_fs".
</i>&gt;&gt;&gt;<i> I found following definition in spec but not in uAPI also.
</i>&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;<i> struct virtio_fs_req {
</i>&gt;&gt;&gt;<i> // Device -readable part
</i>&gt;&gt;&gt;<i> struct fuse_in_header in;
</i>&gt;&gt;&gt;<i> u8 datain[];
</i>&gt;&gt;&gt;<i> // Device -writable part
</i>&gt;&gt;&gt;<i> struct fuse_out_header out;
</i>&gt;&gt;&gt;<i> u8 dataout[];
</i>&gt;&gt;&gt;<i> };
</i>&gt;&gt;&gt;<i>
</i>&gt;&gt;&gt;<i> So is this also a bad example which has not been fixed yet.
</i>&gt;&gt;<i>
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> Cc Stefan for the answer.
</i>&gt;&gt;<i>
</i>&gt;&gt;<i>
</i>&gt;&gt;&gt;<i> Or what's your mean about "complete" here ? Is there any definition 
</i>&gt;&gt;&gt;<i> about "complete uAPI" ?
</i>&gt;&gt;<i>
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> My understanding it should contain all the fields defined in the 
</i>&gt;&gt;<i> virtio spec.
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> Thanks
</i>&gt;&gt;<i>
</i>&gt;<i> OK. I noticed this isn't strictly implemented in the current virtio 
</i>&gt;<i> codes.
</i>&gt;<i> I'm not sure if this is already a consensus. I will follow it if this 
</i>&gt;<i> is the opinion of the majority.
</i>

Please do that, this forces us to maintain uABI compatibility which is 
what Linux try to maintain for ever.</pre>
    <p>******************************************************************************<br>
    </p>
    <blockquote type="cite"
cite="mid:CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------93F4C767A327742F6D836531--

--===============3775237761354582805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3775237761354582805==--
