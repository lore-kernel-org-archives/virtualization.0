Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B70C43214
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 13:08:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763AC6108D
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 13:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 763AC6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C8CC400FD;
	Thu, 19 Aug 2021 13:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUpV0cmDHJMh; Thu, 19 Aug 2021 13:08:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE4E6400F2;
	Thu, 19 Aug 2021 13:08:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD962C0010;
	Thu, 19 Aug 2021 13:08:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD970C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9B0E40752
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8dp6Ch-P157X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:08:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB32B40611
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629378518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbUbOPKdaOv0H6GJNKk7luvurk7xDCBvY4WXdh7nI3c=;
 b=NgdKtVa7t+tjoTZqDW0j4FwMgC+4NUNbPwCbpsGUPR2+4NT5/jGyJc8CPzlPm5aVIFRvcl
 u5cKFeJ00cgD79hvBJoRTEk2lCL6AdqIDrPUHmzoLfK2J1e6XZtII5p1iP7SaKqNDifegi
 EbBqPcjMkooltjzbqYHR3AeEyZ2ZnA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Cq9IEMG4No2eK1kqH3lh4Q-1; Thu, 19 Aug 2021 09:08:35 -0400
X-MC-Unique: Cq9IEMG4No2eK1kqH3lh4Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 b3-20020a1c80030000b02902e6a7296cb3so1315167wmd.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 06:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cbUbOPKdaOv0H6GJNKk7luvurk7xDCBvY4WXdh7nI3c=;
 b=CgJ7K2RYbuuh3vV/MUDoXWEHqGTbqBsY0HZO4SQJYSRJz5f/nwM9tmJdEJRK+WWdPK
 FOaJGm9oM/3U2G2pJmLJiR7cNAWtp8Woz5KD7j3PH9E+dUnKFzBlLiMngdYxLawj+Qj0
 TpFtV4QVHtigBoj5SfzLHiHX+UgjFCBvQrkdiBmLwOFr47phzDMtUqLJygx3Lem1z+Lb
 uGtz1xPgNAHgG3QuU7P7EOHWsCQaCQfUiCgFvAgORaTK0B2/tYg9KQkzgcGJr6SzTBEf
 d4hK7HoBak4bKWiRHtLxE6U/jN2JyInUUHPOTqVcqaUN4UvvT8jpqKe504ete3sWmBjt
 QUwQ==
X-Gm-Message-State: AOAM533svp7USCiCYfWkMFT74sY1/iQRQxASeNLUleh4FQPp88rL2k7p
 VDRtZ6VrWznJSbNxlZISrlY33ola5H7eK+txB4zSX9IHPXHABVdvWaVAtPnK9tbuA/b7zvabKPe
 zXBEZ4ipmxBoXbHc3JNaI/zo2BxV8MOfycRn+IOjAbA==
X-Received: by 2002:a1c:9a42:: with SMTP id c63mr13975165wme.184.1629378513653; 
 Thu, 19 Aug 2021 06:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza67HWrGxP2aUgu3rckgOAHvNq7+jdQQoJn1HcsGEdV1L59q0EUqs3+sIOE01BsDUVL5TJDQ==
X-Received: by 2002:a1c:9a42:: with SMTP id c63mr13975147wme.184.1629378513422; 
 Thu, 19 Aug 2021 06:08:33 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net.
 [82.29.237.198])
 by smtp.gmail.com with ESMTPSA id d4sm2942475wrp.57.2021.08.19.06.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Aug 2021 06:08:32 -0700 (PDT)
Date: Thu, 19 Aug 2021 14:08:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
Message-ID: <YR5Xzw02IuVAN94b@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
 <YRwHRmL/jUSqgkIU@work-vm>
 <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

* JeffleXu (jefflexu@linux.alibaba.com) wrote:
> 
> 
> On 8/18/21 3:00 AM, Dr. David Alan Gilbert wrote:
> > * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> >> For passthrough, when the corresponding virtiofs in guest is mounted
> >> with '-o dax=inode', advertise that the file is capable of per-file
> >> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> >> index 5b6228210f..4cbd904248 100644
> >> --- a/tools/virtiofsd/passthrough_ll.c
> >> +++ b/tools/virtiofsd/passthrough_ll.c
> >> @@ -171,6 +171,7 @@ struct lo_data {
> >>      int allow_direct_io;
> >>      int announce_submounts;
> >>      int perfile_dax_cap; /* capability of backend fs */
> >> +    bool perfile_dax; /* enable per-file DAX or not */
> >>      bool use_statx;
> >>      struct lo_inode root;
> >>      GHashTable *inodes; /* protected by lo->mutex */
> >> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
> >>  
> >>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
> >>          conn->want |= FUSE_CAP_PERFILE_DAX;
> >> +	lo->perfile_dax = 1;
> >> +    }
> >> +    else {
> >> +	lo->perfile_dax = 0;
> >>      }
> >>  }
> >>  
> >> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
> >>      return 0;
> >>  }
> >>  
> >> +/*
> >> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
> >> + * enabled for this file.
> >> + */
> >> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
> >> +				 const char *name)
> >> +{
> >> +    int res, fd;
> >> +    int ret = false;;
> >> +    unsigned int attr;
> >> +    struct fsxattr xattr;
> >> +
> >> +    if (!lo->perfile_dax)
> >> +	return false;
> >> +
> >> +    /* Open file without O_PATH, so that ioctl can be called. */
> >> +    fd = openat(dir->fd, name, O_NOFOLLOW);
> >> +    if (fd == -1)
> >> +        return false;
> > 
> > Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
> > might stumble into a /dev node or something else we're not allowed to
> > open?
> 
> As far as I know, virtiofsd will pivot_root/chroot to the source
> directory, and can only access files inside the source directory
> specified by "-o source=". Then where do these unexpected files come
> from? Besides, fd opened without O_PATH here is temporary and used for
> FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl only. It's closed when the
> function returns.

The guest is still allowed to mknod.
See:
   https://lists.gnu.org/archive/html/qemu-devel/2021-01/msg05461.html

also it's legal to expose a root filesystem for a guest; the virtiofsd
should *never* open a device other than O_PATH - and it's really tricky
to do a check to see if it is a device in a race-free way.


> > 
> >> +    if (lo->perfile_dax_cap == DAX_CAP_FLAGS) {
> >> +        res = ioctl(fd, FS_IOC_GETFLAGS, &attr);
> >> +        if (!res && (attr & FS_DAX_FL))
> >> +	    ret = true;
> >> +    }
> >> +    else if (lo->perfile_dax_cap == DAX_CAP_XATTR) {
> >> +	res = ioctl(fd, FS_IOC_FSGETXATTR, &xattr);
> >> +	if (!res && (xattr.fsx_xflags & FS_XFLAG_DAX))
> >> +	    ret = true;
> >> +    }
> > 
> > This all looks pretty expensive for each lookup.
> 
> Yes. it can be somehow optimized if we can agree on the way of storing
> the dax flag persistently.

Dave

> -- 
> Thanks,
> Jeffle
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
