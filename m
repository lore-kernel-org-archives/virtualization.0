Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3414C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 03:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64456416ED;
	Wed, 13 Apr 2022 03:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xp7E6GuBck5P; Wed, 13 Apr 2022 03:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AFBD241727;
	Wed, 13 Apr 2022 03:10:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8182DC0033;
	Wed, 13 Apr 2022 03:10:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECC93C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB3F6830C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tx0a3x8TKHRx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:10:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 836A7830AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:10:01 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0V9xUX8f_1649819396; 
Received: from 30.225.24.103(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9xUX8f_1649819396) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 11:09:57 +0800
Message-ID: <6d6ac8d4-5c25-a0ec-fc03-38546ab41f75@linux.alibaba.com>
Date: Wed, 13 Apr 2022 11:09:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To: Vivek Goyal <vgoyal@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
 <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
 <YlQWkGl1YQ+ioDas@redhat.com>
 <3f6a9a7a-90e3-e9fd-b985-3e067513ecea@linux.alibaba.com>
 <afc2f1ec-8aff-35fa-5fde-75852db7b4a8@fastmail.fm>
 <YlQ0cT/BOzHi8Q1b@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YlQ0cT/BOzHi8Q1b@redhat.com>
Cc: stefanha@redhat.com, miklos@szeredi.hu,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org, Dharmendra Singh <dsingh@ddn.com>,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
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



On 4/11/22 10:00 PM, Vivek Goyal wrote:
> On Mon, Apr 11, 2022 at 03:20:05PM +0200, Bernd Schubert wrote:
> 
> So for testing DAX, I have to rely on out of tree patches from qemu
> here if any changes in virtiofs client happen.
> 
> https://gitlab.com/virtio-fs/qemu/-/tree/virtio-fs-dev
> 
> Jeffle is probably relying on their own virtiofsd implementation for DAX
> testing.
> 

Actually I also use the C version virtiofsd in the above described
repository for testing :)

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
