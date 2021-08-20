Return-Path: <SRS0=poyg=NL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED27C4338F
	for <virtualization@archiver.kernel.org>; Fri, 20 Aug 2021 05:03:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C61360FE7
	for <virtualization@archiver.kernel.org>; Fri, 20 Aug 2021 05:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C61360FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C614D81911;
	Fri, 20 Aug 2021 05:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQz2UoGYoTLK; Fri, 20 Aug 2021 05:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F5C5818C0;
	Fri, 20 Aug 2021 05:03:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2C4C0010;
	Fri, 20 Aug 2021 05:03:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0E2BC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 05:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EC3D613D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 05:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ma5RM2ZdFTIk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 05:03:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BA99613B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 05:03:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UkEzb1C_1629435803; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UkEzb1C_1629435803) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 20 Aug 2021 13:03:24 +0800
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
 <YRwHRmL/jUSqgkIU@work-vm>
 <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
 <YR5Xzw02IuVAN94b@work-vm>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <4494052b-aff1-e2e3-e704-c8743168f62e@linux.alibaba.com>
Date: Fri, 20 Aug 2021 13:03:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR5Xzw02IuVAN94b@work-vm>
Content-Language: en-US
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 virtio-fs@redhat.com, joseph.qi@linux.alibaba.com, stefanha@redhat.com,
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



On 8/19/21 9:08 PM, Dr. David Alan Gilbert wrote:
> * JeffleXu (jefflexu@linux.alibaba.com) wrote:
>>
>>
>> On 8/18/21 3:00 AM, Dr. David Alan Gilbert wrote:
>>> * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
>>>> For passthrough, when the corresponding virtiofs in guest is mounted
>>>> with '-o dax=inode', advertise that the file is capable of per-file
>>>> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
>>>>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>> ---
>>>>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
>>>> index 5b6228210f..4cbd904248 100644
>>>> --- a/tools/virtiofsd/passthrough_ll.c
>>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>>> @@ -171,6 +171,7 @@ struct lo_data {
>>>>      int allow_direct_io;
>>>>      int announce_submounts;
>>>>      int perfile_dax_cap; /* capability of backend fs */
>>>> +    bool perfile_dax; /* enable per-file DAX or not */
>>>>      bool use_statx;
>>>>      struct lo_inode root;
>>>>      GHashTable *inodes; /* protected by lo->mutex */
>>>> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>>>>  
>>>>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
>>>>          conn->want |= FUSE_CAP_PERFILE_DAX;
>>>> +	lo->perfile_dax = 1;
>>>> +    }
>>>> +    else {
>>>> +	lo->perfile_dax = 0;
>>>>      }
>>>>  }
>>>>  
>>>> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
>>>>      return 0;
>>>>  }
>>>>  
>>>> +/*
>>>> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
>>>> + * enabled for this file.
>>>> + */
>>>> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
>>>> +				 const char *name)
>>>> +{
>>>> +    int res, fd;
>>>> +    int ret = false;;
>>>> +    unsigned int attr;
>>>> +    struct fsxattr xattr;
>>>> +
>>>> +    if (!lo->perfile_dax)
>>>> +	return false;
>>>> +
>>>> +    /* Open file without O_PATH, so that ioctl can be called. */
>>>> +    fd = openat(dir->fd, name, O_NOFOLLOW);
>>>> +    if (fd == -1)
>>>> +        return false;
>>>
>>> Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
>>> might stumble into a /dev node or something else we're not allowed to
>>> open?
>>
>> As far as I know, virtiofsd will pivot_root/chroot to the source
>> directory, and can only access files inside the source directory
>> specified by "-o source=". Then where do these unexpected files come
>> from? Besides, fd opened without O_PATH here is temporary and used for
>> FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl only. It's closed when the
>> function returns.
> 
> The guest is still allowed to mknod.
> See:
>    https://lists.gnu.org/archive/html/qemu-devel/2021-01/msg05461.html
> 
> also it's legal to expose a root filesystem for a guest; the virtiofsd
> should *never* open a device other than O_PATH - and it's really tricky
> to do a check to see if it is a device in a race-free way.
> 

Fine. Got it. However the returned fd (opened without O_PATH) is only
used for FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl, while in most cases
for special device files, these two ioctls should return -ENOTTY.

If it's really a security issue, then lo_inode_open() could be used to
get a temporary fd, i.e., check if it's a special file before opening.
After all, FUSE_OPEN also handles in this way. Besides, I can't
understand what "race-free way" means.


-- 
Thanks,
Jeffle
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
