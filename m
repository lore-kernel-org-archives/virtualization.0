Return-Path: <SRS0=3jI9=N6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE086C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Sep 2021 10:35:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876B760F70
	for <virtualization@archiver.kernel.org>; Wed,  8 Sep 2021 10:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 876B760F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 515AF6073B;
	Wed,  8 Sep 2021 10:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6oJ6mCRfCSf; Wed,  8 Sep 2021 10:35:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED75460643;
	Wed,  8 Sep 2021 10:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C33CAC000F;
	Wed,  8 Sep 2021 10:35:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE6A7C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 10:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CF04606E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 10:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUUoxTnhpZT7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 10:34:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 256A960643
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 10:34:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UngnJV5_1631097293; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UngnJV5_1631097293) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 08 Sep 2021 18:34:53 +0800
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
To: Greg Kurz <groug@kaod.org>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
 <YRwHRmL/jUSqgkIU@work-vm>
 <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
 <YR5Xzw02IuVAN94b@work-vm>
 <4494052b-aff1-e2e3-e704-c8743168f62e@linux.alibaba.com>
 <20210824121515.5419d6a7@bahia.lan>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <88041d90-d170-3ae1-903e-2fa32e51027f@linux.alibaba.com>
Date: Wed, 8 Sep 2021 18:34:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824121515.5419d6a7@bahia.lan>
Content-Language: en-US
Cc: miklos@szeredi.hu, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 joseph.qi@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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



On 8/24/21 6:15 PM, Greg Kurz wrote:
> On Fri, 20 Aug 2021 13:03:23 +0800
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
>>
>> Fine. Got it. However the returned fd (opened without O_PATH) is only
>> used for FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl, while in most cases
>> for special device files, these two ioctls should return -ENOTTY.
>>
> 
> The actual problem is that a FIFO will cause openat() to block until
> the other end of the FIFO is open for writing...

Got it.

> 
>> If it's really a security issue, then lo_inode_open() could be used to
> 
> ... and cause a DoS on virtiofsd. So yes, this is a security issue and
> lo_inode_open() was introduced specifically to handle this.
> 
>> get a temporary fd, i.e., check if it's a special file before opening.
>> After all, FUSE_OPEN also handles in this way. Besides, I can't
>> understand what "race-free way" means.
>>
> 
> "race-free way" means a way that guarantees that file type
> cannot change between the time you check it and the time
> you open it (TOCTOU error). For example, doing a plain stat(),
> checking st_mode and proceeding to open() is wrong : nothing
> prevents the file to be unlinked and replaced by something
> else between stat() and open().
> 
> We avoid that by keeping O_PATH fds around and using
> lo_inode_open() instead of openat().

Thanks for the detailed explanation. Got it.

> 
> In your case, it seems that you should do the checking after
> you have an actual lo_inode for the target file, and pass
> that to lo_should_enable_dax() instead of the parent lo_inode
> and target name.
> 

Yes, that will be more reasonable. Thanks.

-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
