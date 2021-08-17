Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC2C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 19:00:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB5660FC3
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 19:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECB5660FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFDBB40270;
	Tue, 17 Aug 2021 19:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id em6ZIdSvaSfe; Tue, 17 Aug 2021 19:00:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5AF424028A;
	Tue, 17 Aug 2021 19:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 342C3C001A;
	Tue, 17 Aug 2021 19:00:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8741AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 19:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 669E94028A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 19:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LivprxRKnIS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 19:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53FB84028D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629226828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Iol1jsgRv0ziz0DpHk2d1tnxir1N5aalgKy4jW+5WM=;
 b=IuvHyrBA9WcIhvbfBsAVbqZnnNP1MDDSrmivsweON1TsFfTADk1+ebjhvwDWmMqFp8xqUG
 td3vdn3+7xUzoNJygrFjrufLw91BV6OUltxK6ODMT6c92yBR1XiHs0N8LQVm3OnTwFSb84
 2xdO+kSENCumzSI+JTEaQCv0kOmUelc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-r8lDQfZ4Pwa7nOlh9tF9vQ-1; Tue, 17 Aug 2021 15:00:26 -0400
X-MC-Unique: r8lDQfZ4Pwa7nOlh9tF9vQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 r125-20020a1c2b830000b0290197a4be97b7so49409wmr.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 12:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0Iol1jsgRv0ziz0DpHk2d1tnxir1N5aalgKy4jW+5WM=;
 b=fkXfhmO3QVcjfvk6IIAABtc81Sf0ohPiV/3GQoXYpj2J9ZjzwAjiYpDA1ZkrmWRksm
 8LdmdcFRTYzin8NKCsreJyMCdP73v13e68ktl416eOt3zppdZWsNULk9iJRmx90uj+L1
 xVcSWMyBpEwpyvdMI29elfLD6fmWr80iIHTHrJ0ah2LMR4drW727B4+9cU7xQ5AEXHRC
 IXFZnV6VGEnIt3+rUxwu2ZMAgv2I4bDc0DWl0vOYD4/m88i50y8qGQADmDOQWEW9i45r
 /vDz0KsVmQFQteU0mUj0FhocCtdf6kqAHMHyOOyYqM/qhIqUM0FYGyMqPcoAkv5zNlg6
 rWxA==
X-Gm-Message-State: AOAM531S3oIkTpQQNlKQPgQRvOWVNSXDOzFz6IEgrkkqvnNF0/RQiS11
 LGgytK/VqS2z+TFYkZmTw2gLQZMx2BcVZ6N4BPCD8EY2ZMVS8fDy24SrZs3IEpP7+mZA1xS6Inu
 IzzPuJnk5QUmQrTb/SuQysSazln1fjNVnRbMq4+zhxw==
X-Received: by 2002:a05:600c:2150:: with SMTP id
 v16mr1685667wml.143.1629226825473; 
 Tue, 17 Aug 2021 12:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxusOQ+cZFh3y+xg/zSlKlSeE6vAgPMd91vC/vS1jIhfmj0ZcVTZCPWMnEslMdG8fY06LwZ+w==
X-Received: by 2002:a05:600c:2150:: with SMTP id
 v16mr1685648wml.143.1629226825276; 
 Tue, 17 Aug 2021 12:00:25 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net.
 [82.29.237.198])
 by smtp.gmail.com with ESMTPSA id z7sm2887942wmi.4.2021.08.17.12.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 12:00:24 -0700 (PDT)
Date: Tue, 17 Aug 2021 20:00:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
Message-ID: <YRwHRmL/jUSqgkIU@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20210817022347.18098-5-jefflexu@linux.alibaba.com>
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

* Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> For passthrough, when the corresponding virtiofs in guest is mounted
> with '-o dax=inode', advertise that the file is capable of per-file
> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 5b6228210f..4cbd904248 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -171,6 +171,7 @@ struct lo_data {
>      int allow_direct_io;
>      int announce_submounts;
>      int perfile_dax_cap; /* capability of backend fs */
> +    bool perfile_dax; /* enable per-file DAX or not */
>      bool use_statx;
>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>  
>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
>          conn->want |= FUSE_CAP_PERFILE_DAX;
> +	lo->perfile_dax = 1;
> +    }
> +    else {
> +	lo->perfile_dax = 0;
>      }
>  }
>  
> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
>      return 0;
>  }
>  
> +/*
> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
> + * enabled for this file.
> + */
> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
> +				 const char *name)
> +{
> +    int res, fd;
> +    int ret = false;;
> +    unsigned int attr;
> +    struct fsxattr xattr;
> +
> +    if (!lo->perfile_dax)
> +	return false;
> +
> +    /* Open file without O_PATH, so that ioctl can be called. */
> +    fd = openat(dir->fd, name, O_NOFOLLOW);
> +    if (fd == -1)
> +        return false;

Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
might stumble into a /dev node or something else we're not allowed to
open?

> +    if (lo->perfile_dax_cap == DAX_CAP_FLAGS) {
> +        res = ioctl(fd, FS_IOC_GETFLAGS, &attr);
> +        if (!res && (attr & FS_DAX_FL))
> +	    ret = true;
> +    }
> +    else if (lo->perfile_dax_cap == DAX_CAP_XATTR) {
> +	res = ioctl(fd, FS_IOC_FSGETXATTR, &xattr);
> +	if (!res && (xattr.fsx_xflags & FS_XFLAG_DAX))
> +	    ret = true;
> +    }

This all looks pretty expensive for each lookup.

Dave


> +    close(fd);
> +    return ret;
> +}
> +
>  /*
>   * Increments nlookup on the inode on success. unref_inode_lolocked() must be
>   * called eventually to decrement nlookup again. If inodep is non-NULL, the
> @@ -1038,6 +1078,9 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          e->attr_flags |= FUSE_ATTR_SUBMOUNT;
>      }
>  
> +    if (lo_should_enable_dax(lo, dir, name))
> +	e->attr_flags |= FUSE_ATTR_DAX;
> +
>      inode = lo_find(lo, &e->attr, mnt_id);
>      if (inode) {
>          close(newfd);
> -- 
> 2.27.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
