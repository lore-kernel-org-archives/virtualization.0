Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B87C433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Apr 2022 02:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD46040117;
	Fri,  8 Apr 2022 02:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dt_KFsFqgpzU; Fri,  8 Apr 2022 02:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9701341003;
	Fri,  8 Apr 2022 02:36:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63F60C001D;
	Fri,  8 Apr 2022 02:36:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 119C4C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 02:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC36D41C4F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 02:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQVGMG6-yeK2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 02:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7683341C4E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 02:36:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V9TXbj2_1649385400; 
Received: from 30.225.24.70(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9TXbj2_1649385400) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 08 Apr 2022 10:36:41 +0800
Message-ID: <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
Date: Fri, 8 Apr 2022 10:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To: Vivek Goyal <vgoyal@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yk7w8L1f/yik+qrR@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 miklos@szeredi.hu
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 4/7/22 10:10 PM, Vivek Goyal wrote:
> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
>> Move dmap free worker kicker inside the critical region, so that extra
>> spinlock lock/unlock could be avoided.
>>
>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Looks good to me. Have you done any testing to make sure nothing is
> broken.

xfstests -g quick shows no regression. The tested virtiofs is mounted
with "dax=always".

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
