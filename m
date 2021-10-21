Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA81C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 03:30:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2151D611C7
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 03:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2151D611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2DE060BC4;
	Thu, 21 Oct 2021 03:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BLBAKqAm-YGH; Thu, 21 Oct 2021 03:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83D6A606B9;
	Thu, 21 Oct 2021 03:30:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5748EC000F;
	Thu, 21 Oct 2021 03:30:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0527C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8169F40141
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YFoiAyDLG87G
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:30:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9863D4012E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:30:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="228882607"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; d="scan'208";a="228882607"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 20:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; d="scan'208";a="444616242"
Received: from unknown (HELO [10.239.154.68]) ([10.239.154.68])
 by orsmga006.jf.intel.com with ESMTP; 20 Oct 2021 20:30:29 -0700
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6pHkXOPvtidtwS@kroah.com> <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
 <YW8LFTcBuN1bB3PD@ninjato> <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
 <YW+q1yQ8MuhHINAs@kroah.com> <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com> <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <df7e6127-05fb-6aad-3896-fc810f213a54@intel.com>
Date: Thu, 21 Oct 2021 11:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
Content-Language: en-US
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
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


On 2021/10/20 19:03, Viresh Kumar wrote:
> On 20-10-21, 12:55, Vincent Whitchurch wrote:
>> If the timeout cannot be disabled, then the driver should be fixed to
>> always copy buffers and hold on to them to avoid memory corruption in
>> the case of timeout, as I mentioned in my commit message.  That would be
>> quite a substantial change to the driver so it's not something I'm
>> personally comfortable with doing, especially not this late in the -rc
>> cycle, so I'd leave that to others.
> Or we can avoid clearing up and freeing the buffers here until the
> point where the buffers are returned by the host. Until that happens,
> we can avoid taking new requests but return to the earlier caller with
> timeout failure. That would avoid corruption, by freeing buffers
> sooner, and not hanging of the kernel.


It seems similar to use "wait_for_completion". If the other side is 
hacked, the guest may never

get the buffers returned by the host, right ?


For this moment, we can solve the problem by using a hardcoded big value 
or disabling the timeout.

Over the long term, I think the backend should provide that timeout 
value and guarantee that its processing

time should not exceed that value.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
