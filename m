Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239A0C432BE
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:34:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAD8610E6
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCAD8610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BC6C80F13;
	Wed, 18 Aug 2021 17:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_DbNIVlMMbR; Wed, 18 Aug 2021 17:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 317CB80E22;
	Wed, 18 Aug 2021 17:34:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18EB2C001A;
	Wed, 18 Aug 2021 17:34:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13090C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01F0C60BBA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qPfnvzxrI35p
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:33:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24F3E60BAA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629308038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2YmipCDl8vwbAwu1PzrQO5U8OiwrNEdg94kk0PE0Ak=;
 b=Y5HCaiIVh2RkjUmG5nF4JVoQyV8rWdKRb2SMintZ64EP7yEp+wOEyhaiRTmK5gxGtyrzUN
 Wdx4rSuTGLcSv2COwNofeJH21y3vojLZRwUgE5Hbs+AluRXof7lD1I1luRHcLO04GaYR1k
 dj5afFfI7L+iTeaDYMW1lG6xs1hHRbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-HQCEE9nkPfiAXF8hX_7zlw-1; Wed, 18 Aug 2021 13:33:54 -0400
X-MC-Unique: HQCEE9nkPfiAXF8hX_7zlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D570824F8C;
 Wed, 18 Aug 2021 17:33:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF1025C1A3;
 Wed, 18 Aug 2021 17:33:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 72573223863; Wed, 18 Aug 2021 13:33:45 -0400 (EDT)
Date: Wed, 18 Aug 2021 13:33:45 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [virtiofsd PATCH v4 1/4] virtiofsd: add .ioctl() support
Message-ID: <YR1EeX/yD4V2cSOq@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817022347.18098-2-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 virtio-fs@redhat.com, joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

On Tue, Aug 17, 2021 at 10:23:44AM +0800, Jeffle Xu wrote:
> Add .ioctl() support for passthrough, in prep for the following support
> for following per-file DAX feature.
> 
> Once advertising support for per-file DAX feature, virtiofsd should
> support storing FS_DAX_FL flag persistently passed by
> FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
> FUSE_LOOKUP accordingly if the file is capable of per-file DAX.
> 
> When it comes to passthrough, it passes corresponding ioctls to host
> directly. Currently only these ioctls that are needed for per-file DAX
> feature, i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
> FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported. Later we can restrict
> the flags/attributes allowed to be set to reinforce the security, or
> extend the scope of allowed ioctls if it is really needed later.

Dave had concerns about which attrs should be allowed to be set by
guest. And we were also wondering why virtiofs is not supporting
ioctl yet.

It think that it probably will make sense that supporting ioctls,
is a separate patch series for virtiofs. Anyway, we probably will
need to add it. 

Vivek
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  tools/virtiofsd/passthrough_ll.c      | 53 +++++++++++++++++++++++++++
>  tools/virtiofsd/passthrough_seccomp.c |  1 +
>  2 files changed, 54 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index b76d878509..e170b17adb 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -54,6 +54,7 @@
>  #include <sys/wait.h>
>  #include <sys/xattr.h>
>  #include <syslog.h>
> +#include <linux/fs.h>
>  
>  #include "qemu/cutils.h"
>  #include "passthrough_helpers.h"
> @@ -2105,6 +2106,57 @@ out:
>      fuse_reply_err(req, saverr);
>  }
>  
> +static void lo_ioctl(fuse_req_t req, fuse_ino_t ino, unsigned int cmd, void *arg,
> +                  struct fuse_file_info *fi, unsigned flags, const void *in_buf,
> +                  size_t in_bufsz, size_t out_bufsz)
> +{
> +    int fd = lo_fi_fd(req, fi);
> +    int res;
> +    int saverr = ENOSYS;
> +
> +    fuse_log(FUSE_LOG_DEBUG, "lo_ioctl(ino=%" PRIu64 ", cmd=0x%x, flags=0x%x, "
> +	     "in_bufsz = %lu, out_bufsz = %lu)\n",
> +	     ino, cmd, flags, in_bufsz, out_bufsz);
> +
> +    /* unrestricted ioctl is not supported yet */
> +    if (flags & FUSE_IOCTL_UNRESTRICTED)
> +        goto out;
> +
> +    /*
> +     * Currently only those ioctls needed to support per-file DAX feature,
> +     * i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
> +     * FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported.
> +     */
> +    if (cmd == FS_IOC_SETFLAGS || cmd == FS_IOC_FSSETXATTR) {
> +        res = ioctl(fd, cmd, in_buf);
> +        if (res < 0)
> +            goto out_err;
> +
> +	fuse_reply_ioctl(req, 0, NULL, 0);
> +    }
> +    else if (cmd == FS_IOC_GETFLAGS || cmd == FS_IOC_FSGETXATTR) {
> +	/* reused for 'unsigned int' for FS_IOC_GETFLAGS */
> +	struct fsxattr attr;
> +
> +        res = ioctl(fd, cmd, &attr);
> +        if (res < 0)
> +            goto out_err;
> +
> +        fuse_reply_ioctl(req, 0, &attr, out_bufsz);
> +    }
> +    else {
> +	fuse_log(FUSE_LOG_DEBUG, "Unsupported ioctl 0x%x\n", cmd);
> +	goto out;
> +    }
> +
> +    return;
> +
> +out_err:
> +	saverr = errno;
> +out:
> +	fuse_reply_err(req, saverr);
> +}
> +
>  static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
>                          struct fuse_file_info *fi)
>  {
> @@ -3279,6 +3331,7 @@ static struct fuse_lowlevel_ops lo_oper = {
>      .create = lo_create,
>      .getlk = lo_getlk,
>      .setlk = lo_setlk,
> +    .ioctl = lo_ioctl,
>      .open = lo_open,
>      .release = lo_release,
>      .flush = lo_flush,
> diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
> index 62441cfcdb..2a5f7614fc 100644
> --- a/tools/virtiofsd/passthrough_seccomp.c
> +++ b/tools/virtiofsd/passthrough_seccomp.c
> @@ -62,6 +62,7 @@ static const int syscall_allowlist[] = {
>      SCMP_SYS(gettid),
>      SCMP_SYS(gettimeofday),
>      SCMP_SYS(getxattr),
> +    SCMP_SYS(ioctl),
>      SCMP_SYS(linkat),
>      SCMP_SYS(listxattr),
>      SCMP_SYS(lseek),
> -- 
> 2.27.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
