Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F52C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 13:57:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C31461100
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 13:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C31461100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B076814A1;
	Thu, 19 Aug 2021 13:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JSBfG6nwV1b6; Thu, 19 Aug 2021 13:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2ACB81069;
	Thu, 19 Aug 2021 13:57:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B50B9C0010;
	Thu, 19 Aug 2021 13:57:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C651C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5556D8106A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mH6JE4xmK-BV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:57:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF79281069
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629381452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FeQUTOQZFedjwKHUiIdbPnfehFdeVRFseWj/JjhYKq0=;
 b=JmWxT7YhtCO75/aOFP0y3fWdp2Ec65mWTeaWxI14YTP1gzq7wBT5VRRMJlUlMs8yxBUazs
 2hSJnZ5B9mr7BD0ur7uIZePFrDixD+Y8YbUmHuRAt6hCyjRAKTVvirrCG2eHf8FMvikzVl
 SBotARnxBp2KTZ9OweezBFAArmLLz60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-MvOuCN7sN9S8oxgYpeSEqg-1; Thu, 19 Aug 2021 09:57:31 -0400
X-MC-Unique: MvOuCN7sN9S8oxgYpeSEqg-1
Received: by mail-wm1-f71.google.com with SMTP id
 j33-20020a05600c1c21b02902e6828f7a20so1572478wms.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 06:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FeQUTOQZFedjwKHUiIdbPnfehFdeVRFseWj/JjhYKq0=;
 b=P1BkwFbvkQhgG1MJ/72nwREdbIXrd3teNZZHyKGykJP+4j9hl52+z8fUzBl16y6+7+
 ymPFIaWZT78/6OPA8Xv6hK/qL3n3H+uy/qC3CHHP+0tOw1aJEzu/hgSRqlH3EiKo6X+Q
 rK6XfhnREzel3+nH/7CEe85XUS0L8BmdBYKsB31zxQGaj1ei7G5ji2wen6iU5uWU10hY
 YD3uFQ6eYUc+jbABS5vMwwAOHXnBAyiRyNOCy6Ai8TKBlmGxrsUa2aaQnpPmI8xCgjMS
 wZ31bYFe6mczqI32OTMTMaW0V3UhpJcd/Io/biQGlxdJs8Cz1WlfogWkx6cPZJgHwM9z
 oITQ==
X-Gm-Message-State: AOAM532rsrNMbo4J9l4evTOaE9xBC6/84TUqyihhV18z1nt7FQSzSnfk
 eTvj1qV/zm3SsMeuj78m68z9/+HcDDKVmZrDv+syaB8YutpfykXKH1A/L0iTrsY96lLSn2L1m6r
 tUwtwTXGqDB/d9/AwTGSSc2XZRPQz0MTt9SK5xbjvmQ==
X-Received: by 2002:adf:e746:: with SMTP id c6mr3970201wrn.276.1629381450162; 
 Thu, 19 Aug 2021 06:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPnPPiuPzwm8tAhF9mEQ0DkA/msxGcayzoUv7cKBC+BcIMzN4u6pCJ7sEyf0pjKKrp3rXIVw==
X-Received: by 2002:adf:e746:: with SMTP id c6mr3970164wrn.276.1629381449837; 
 Thu, 19 Aug 2021 06:57:29 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net.
 [82.29.237.198])
 by smtp.gmail.com with ESMTPSA id j7sm7793993wmi.37.2021.08.19.06.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Aug 2021 06:57:29 -0700 (PDT)
Date: Thu, 19 Aug 2021 14:57:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 3/4] virtiofsd: support per-file
 DAX negotiation in FUSE_INIT
Message-ID: <YR5jRwVNeZfZVLh3@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-4-jefflexu@linux.alibaba.com>
 <YRvuzrRo2t2SyQk/@work-vm>
 <e6426e51-7a2c-57a1-8d7b-3cb0cff89fb9@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <e6426e51-7a2c-57a1-8d7b-3cb0cff89fb9@linux.alibaba.com>
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
> On 8/18/21 1:15 AM, Dr. David Alan Gilbert wrote:
> > * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> >> In FUSE_INIT negotiating phase, server/client should advertise if it
> >> supports per-file DAX.
> >>
> >> Once advertising support for per-file DAX feature, virtiofsd should
> >> support storing FS_DAX_FL flag persistently passed by
> >> FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
> >> FUSE_LOOKUP accordingly if the file is capable of per-file DAX.
> >>
> >> Currently only ext4/xfs since linux kernel v5.8 support storing
> >> FS_DAX_FL flag persistently, and thus advertise support for per-file
> >> DAX feature only when the backend fs type is ext4 and xfs.
> > 
> > I'm a little worried about the meaning of the flags we're storing and
> > the fact we're storing them in the normal host DAX flags.
> > 
> > Doesn't this mean that we're using a single host flag to mean:
> >   a) It can be mapped as DAX on the host if it was a real DAX device
> >   b) We can map it as DAX inside the guest with virtiofs?
> 
> Yes the side effect is that the host file is also dax enabled if the
> backend fs is built upon real nvdimm device.
> 
> The rationale here is that, fuse daemon shall be capable of *marking*
> the file as dax capable *persistently*, so that it can be informed that
> this file is capable of dax later.

Right, so my worry here is that the untrusted guest changes both it's
own behaviour (fine) and also the behaviour of the host (less fine).

> I'm not sure if xattr (extent attribute) is a better option for this?

Well, if you used an xattr for it, it wouldn't clash with whatever the
host did (especially if it used the xattr mapping).

Dave

> 
> > 
> > what happens when we're using usernamespaces for the guest?
> > 
> > Dave
> > 
> > 
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  tools/virtiofsd/fuse_common.h    |  5 +++++
> >>  tools/virtiofsd/fuse_lowlevel.c  |  6 ++++++
> >>  tools/virtiofsd/passthrough_ll.c | 29 +++++++++++++++++++++++++++++
> >>  3 files changed, 40 insertions(+)
> >>
> >> diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
> >> index 8a75729be9..ee6fc64c23 100644
> >> --- a/tools/virtiofsd/fuse_common.h
> >> +++ b/tools/virtiofsd/fuse_common.h
> >> @@ -372,6 +372,11 @@ struct fuse_file_info {
> >>   */
> >>  #define FUSE_CAP_HANDLE_KILLPRIV_V2 (1 << 28)
> >>  
> >> +/**
> >> + * Indicates support for per-file DAX.
> >> + */
> >> +#define FUSE_CAP_PERFILE_DAX (1 << 29)
> >> +
> >>  /**
> >>   * Ioctl flags
> >>   *
> >> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> >> index 50fc5c8d5a..04a4f17423 100644
> >> --- a/tools/virtiofsd/fuse_lowlevel.c
> >> +++ b/tools/virtiofsd/fuse_lowlevel.c
> >> @@ -2065,6 +2065,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
> >>      if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
> >>          se->conn.capable |= FUSE_CAP_HANDLE_KILLPRIV_V2;
> >>      }
> >> +    if (arg->flags & FUSE_PERFILE_DAX) {
> >> +        se->conn.capable |= FUSE_CAP_PERFILE_DAX;
> >> +    }
> >>  #ifdef HAVE_SPLICE
> >>  #ifdef HAVE_VMSPLICE
> >>      se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
> >> @@ -2180,6 +2183,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
> >>      if (se->conn.want & FUSE_CAP_POSIX_ACL) {
> >>          outarg.flags |= FUSE_POSIX_ACL;
> >>      }
> >> +    if (se->op.ioctl && (se->conn.want & FUSE_CAP_PERFILE_DAX)) {
> >> +        outarg.flags |= FUSE_PERFILE_DAX;
> >> +    }
> >>      outarg.max_readahead = se->conn.max_readahead;
> >>      outarg.max_write = se->conn.max_write;
> >>      if (se->conn.max_background >= (1 << 16)) {
> >> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> >> index e170b17adb..5b6228210f 100644
> >> --- a/tools/virtiofsd/passthrough_ll.c
> >> +++ b/tools/virtiofsd/passthrough_ll.c
> >> @@ -53,8 +53,10 @@
> >>  #include <sys/syscall.h>
> >>  #include <sys/wait.h>
> >>  #include <sys/xattr.h>
> >> +#include <sys/vfs.h>
> >>  #include <syslog.h>
> >>  #include <linux/fs.h>
> >> +#include <linux/magic.h>
> >>  
> >>  #include "qemu/cutils.h"
> >>  #include "passthrough_helpers.h"
> >> @@ -136,6 +138,13 @@ enum {
> >>      SANDBOX_CHROOT,
> >>  };
> >>  
> >> +/* capability of storing DAX flag persistently */
> >> +enum {
> >> +    DAX_CAP_NONE,  /* not supported */
> >> +    DAX_CAP_FLAGS, /* stored in flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
> >> +    DAX_CAP_XATTR, /* stored in xflags (FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR) */
> >> +};
> >> +
> >>  typedef struct xattr_map_entry {
> >>      char *key;
> >>      char *prepend;
> >> @@ -161,6 +170,7 @@ struct lo_data {
> >>      int readdirplus_clear;
> >>      int allow_direct_io;
> >>      int announce_submounts;
> >> +    int perfile_dax_cap; /* capability of backend fs */
> >>      bool use_statx;
> >>      struct lo_inode root;
> >>      GHashTable *inodes; /* protected by lo->mutex */
> >> @@ -703,6 +713,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
> >>          conn->want &= ~FUSE_CAP_HANDLE_KILLPRIV_V2;
> >>          lo->killpriv_v2 = 0;
> >>      }
> >> +
> >> +    if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
> >> +        conn->want |= FUSE_CAP_PERFILE_DAX;
> >> +    }
> >>  }
> >>  
> >>  static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
> >> @@ -3800,6 +3814,7 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
> >>      int fd, res;
> >>      struct stat stat;
> >>      uint64_t mnt_id;
> >> +    struct statfs statfs;
> >>  
> >>      fd = open("/", O_PATH);
> >>      if (fd == -1) {
> >> @@ -3826,6 +3841,20 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
> >>          root->posix_locks = g_hash_table_new_full(
> >>              g_direct_hash, g_direct_equal, NULL, posix_locks_value_destroy);
> >>      }
> >> +
> >> +    /*
> >> +     * Currently only ext4/xfs since linux kernel v5.8 support storing
> >> +     * FS_DAX_FL flag persistently. Ext4 accesses this flag through
> >> +     * FS_IOC_G[S]ETFLAGS ioctl, while xfs accesses this flag through
> >> +     * FS_IOC_FSG[S]ETXATTR ioctl.
> >> +     */
> >> +    res = fstatfs(fd, &statfs);
> >> +    if (!res) {
> >> +	if (statfs.f_type == EXT4_SUPER_MAGIC)
> >> +	    lo->perfile_dax_cap = DAX_CAP_FLAGS;
> >> +	else if (statfs.f_type == XFS_SUPER_MAGIC)
> >> +	    lo->perfile_dax_cap = DAX_CAP_XATTR;
> >> +    }
> >>  }
> >>  
> >>  static guint lo_key_hash(gconstpointer key)
> >> -- 
> >> 2.27.0
> >>
> >> _______________________________________________
> >> Virtio-fs mailing list
> >> Virtio-fs@redhat.com
> >> https://listman.redhat.com/mailman/listinfo/virtio-fs
> >>
> 
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
