Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB1AC433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:24:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F9E6146D
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F9E6146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66B1B4EC8B;
	Tue,  2 Mar 2021 06:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZN5O3D_iYlK; Tue,  2 Mar 2021 06:24:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87CB64EC7E;
	Tue,  2 Mar 2021 06:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55DABC000B;
	Tue,  2 Mar 2021 06:24:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20A69C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F33442FDF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WuBI8LZyRikE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1E5C40025
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:24:14 +0000 (UTC)
IronPort-SDR: LqOuKsV0ZNJIhb8ZAQKDEDcom5fslwjK0htxjAclIQpFm6Ptrb8ogL+yAbwh+5xqSBMpY2wQ8W
 P30/+5fBhD5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186821198"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
 d="scan'208,217";a="186821198"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 22:24:13 -0800
IronPort-SDR: 2co5hRx+Fx5o4uzZlB/v/GNIDKGCtmDbHmD/Zoxz5vaFcJ9pKMqYcIKejwSLAFGEeGbcIWfp7Y
 mIo8Uv0/GE3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
 d="scan'208,217";a="444613150"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 22:24:06 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <16efea9f-d606-4cf9-9213-3c1cf9b1a906@intel.com>
 <20210302034323.gkqymzngyqofrdsr@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b99b18e1-06a5-f526-a885-dc663da3612b@intel.com>
Date: Tue, 2 Mar 2021 14:24:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302034323.gkqymzngyqofrdsr@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
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
Content-Type: multipart/mixed; boundary="===============2544111757569685075=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============2544111757569685075==
Content-Type: multipart/alternative;
 boundary="------------B1AED950BA9B64A4E7CDE09F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B1AED950BA9B64A4E7CDE09F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2021/3/2 11:43, Viresh Kumar wrote:
> On 02-03-21, 10:21, Jie Deng wrote:
>> On 2021/3/1 19:54, Viresh Kumar wrote:
>> That's my original proposal. I used to mirror this interface with "struct
>> i2c_msg".
>>
>> But the design philosophy of virtio TC is that VIRTIO devices are not
>> specific to Linux
>> so the specs design should avoid the limitations of the current Linux driver
>> behavior.
> Right, I understand that.
>
>> We had some discussion about this. You may check these links to learn the
>> story.
>> https://lists.oasis-open.org/archives/virtio-comment/202010/msg00016.html
>> https://lists.oasis-open.org/archives/virtio-comment/202010/msg00033.html
>> https://lists.oasis-open.org/archives/virtio-comment/202011/msg00025.html
> So the thing is that we want to support full duplex mode, right ?
>
> How will that work protocol wise ? I mean how would we know if we are
> expecting both tx and rx buffers in a transfer ?
Not for the full duplex. As Paolo explained in those links.
We defined a combined request called "write-read request"

"
This is when a write is followed by a read: the master
starts off the transmission with a write, then sends a second START,
then continues with a read from the same address.

In theory there's no difference between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.

So the spec should provide a way at least to support for transactions with
1 write and 1 read segment in one request to the same address.

"

 From the perspective of specification design, it hopes to provide more 
choices
while from the perspective of specific implementation, we can choose 
what we need
as long as it does not violate the specification.

Since the current Linux driver doesn't use this mechanism. I'm 
considering to move
the "struct virtio_i2c_req" into the driver and use one "buf" instead.

--------------B1AED950BA9B64A4E7CDE09F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/3/2 11:43, Viresh Kumar wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20210302034323.gkqymzngyqofrdsr@vireshk-i7">
      <pre class="moz-quote-pre" wrap="">On 02-03-21, 10:21, Jie Deng wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 2021/3/1 19:54, Viresh Kumar wrote:
That's my original proposal. I used to mirror this interface with "struct
i2c_msg".

But the design philosophy of virtio TC is that VIRTIO devices are not
specific to Linux
so the specs design should avoid the limitations of the current Linux driver
behavior.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Right, I understand that.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">We had some discussion about this. You may check these links to learn the
story.
<a class="moz-txt-link-freetext" href="https://lists.oasis-open.org/archives/virtio-comment/202010/msg00016.html">https://lists.oasis-open.org/archives/virtio-comment/202010/msg00016.html</a>
<a class="moz-txt-link-freetext" href="https://lists.oasis-open.org/archives/virtio-comment/202010/msg00033.html">https://lists.oasis-open.org/archives/virtio-comment/202010/msg00033.html</a>
<a class="moz-txt-link-freetext" href="https://lists.oasis-open.org/archives/virtio-comment/202011/msg00025.html">https://lists.oasis-open.org/archives/virtio-comment/202011/msg00025.html</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
So the thing is that we want to support full duplex mode, right ?

How will that work protocol wise ? I mean how would we know if we are
expecting both tx and rx buffers in a transfer ?
</pre>
    </blockquote>
    Not for the full duplex. As Paolo explained in those links.<br>
    We defined a combined request called "<span class="fontstyle0">write-read
      request</span>"<br>
    <pre style="overflow-x: auto; white-space: pre-wrap; overflow-wrap: break-word; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">"
This is when a write is followed by a read: the master
starts off the transmission with a write, then sends a second START,
then continues with a read from the same address.

In theory there's no difference between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.
</pre>
    <pre>So the spec should provide a way at least to support for transactions with
1 write and 1 read segment in one request to the same address.
</pre>
    <pre>"
</pre>
    From the perspective of specification design, it hopes to provide
    more choices<br>
    while from the perspective of specific implementation, we can choose
    what we need<br>
    as long as it does not violate the specification.<br>
    <br>
    Since the current Linux driver doesn't use this mechanism. I'm
    considering to move<br>
    the "struct virtio_i2c_req" into the driver and use one "buf"
    instead.<br>
    <blockquote type="cite"
      cite="mid:20210302034323.gkqymzngyqofrdsr@vireshk-i7">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------B1AED950BA9B64A4E7CDE09F--

--===============2544111757569685075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2544111757569685075==--
