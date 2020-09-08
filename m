Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A57C433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 01:40:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A482075A
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 01:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A482075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7732686554;
	Tue,  8 Sep 2020 01:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGQTu-oxsS1a; Tue,  8 Sep 2020 01:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 84C9B86501;
	Tue,  8 Sep 2020 01:40:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CE1C0859;
	Tue,  8 Sep 2020 01:40:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6719EC088B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 01:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FDCE864D7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 01:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7I0xhBA-04xA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 01:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 348B3862DE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 01:40:49 +0000 (UTC)
IronPort-SDR: WekG7O67cs1fGRBn95KRog+nC8xcT6DLjJRBfGoSQ6ItGa4ObV5v9lJvrDgJCGFPEElJXpYCNj
 fPGRX7kc7FSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="159033065"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
 d="scan'208,217";a="159033065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 18:40:48 -0700
IronPort-SDR: Q7xwMJLePbygEkKYPjaCuXlI+Un4xd05//DwHVI3POjGlcxv6gGNU+6qzCSPujKL7JJzgr74NO
 1cNBLtcDBJUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
 d="scan'208,217";a="504200972"
Received: from unknown (HELO [10.239.154.46]) ([10.239.154.46])
 by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2020 18:40:44 -0700
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <18828d17-c3ac-31bd-2dcf-ecdbd4ad844e@redhat.com>
 <e63a96bf-65d2-ed03-dadc-42d1d8808c9d@intel.com>
 <3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <c9be298b-c51b-f7f3-994b-b7bd9ae53b99@intel.com>
Date: Tue, 8 Sep 2020 09:40:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1814372677961904867=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============1814372677961904867==
Content-Type: multipart/alternative;
 boundary="------------F67C48E26D057918B6F263E5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F67C48E26D057918B6F263E5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020/9/7 13:40, Jason Wang wrote:
>
>>
>>
>>>
>>>>
>>>> +struct virtio_i2c_msg {
>>>> +    struct virtio_i2c_hdr hdr;
>>>> +    char *buf;
>>>> +    u8 status;
>>>
>>>
>>> Any reason for separating status out of virtio_i2c_hdr?
>>>
>> The status is not from i2c_msg. 
>
>
> You meant ic2_hdr? You embed status in virtio_i2c_msg anyway.
>
>
The "i2c_msg" structure defined in i2c.h.

>> So I put it out of virtio_i2c_hdr.
>
>
> Something like status or response is pretty common in virtio request 
> (e.g net or scsi), if no special reason, it's better to keep it in the 
> hdr.
>
Mainly based on IN or OUT.

The addr, flags and len are from "i2c_msg". They are put in one 
structure as an OUT**scatterlist.
The buf can be an OUT**or an IN scatterlist depending on write or read.
The status is a result from the backend  which is defined as an IN 
scatterlis.
>

--------------F67C48E26D057918B6F263E5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020/9/7 13:40, Jason Wang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com">
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">
            <br>
            +struct virtio_i2c_msg {
            <br>
            +    struct virtio_i2c_hdr hdr;
            <br>
            +    char *buf;
            <br>
            +    u8 status;
            <br>
          </blockquote>
          <br>
          <br>
          Any reason for separating status out of virtio_i2c_hdr?
          <br>
          <br>
        </blockquote>
        The status is not from i2c_msg. </blockquote>
      <br>
      <br>
      You meant ic2_hdr? You embed status in virtio_i2c_msg anyway.
      <br>
      <br>
      <br>
    </blockquote>
    <p>The "i2c_msg" structure defined in i2c.h.<br>
    </p>
    <blockquote type="cite"
      cite="mid:3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com">
      <blockquote type="cite">So I put it out of virtio_i2c_hdr.
        <br>
      </blockquote>
      <br>
      <br>
      Something like status or response is pretty common in virtio
      request (e.g net or scsi), if no special reason, it's better to
      keep it in the hdr.
      <br>
      <br>
    </blockquote>
    <p>Mainly based on IN or OUT.<br>
    </p>
    The addr, flags and len are from "i2c_msg". They are put in one
    structure as an OUT<b> </b>scatterlist.<br>
    The buf can be an OUT<b> </b>or an IN scatterlist depending on
    write or read.<br>
    The status is a result from the backend  which is defined as an IN
    scatterlis.
    <blockquote type="cite"><br>
    </blockquote>
  </body>
</html>

--------------F67C48E26D057918B6F263E5--

--===============1814372677961904867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1814372677961904867==--
