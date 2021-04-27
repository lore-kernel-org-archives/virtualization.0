Return-Path: <SRS0=gqJU=JY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EBC433B4
	for <virtualization@archiver.kernel.org>; Tue, 27 Apr 2021 17:12:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92121613D0
	for <virtualization@archiver.kernel.org>; Tue, 27 Apr 2021 17:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92121613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3685B83D52;
	Tue, 27 Apr 2021 17:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1vwZQ-w5Abyj; Tue, 27 Apr 2021 17:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC87383D43;
	Tue, 27 Apr 2021 17:12:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E689C0019;
	Tue, 27 Apr 2021 17:12:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 687C0C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 17:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55D686080B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 17:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaPibHVV9EVG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 17:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61DAC60625
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619543532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q5VotXzwzULTsEKcuKaXK6CIlCbj0EuIydSPvYrjm/o=;
 b=dTjDwvt5jBvGcO0WK18H+xx+iI898D/p29CHaeJ899b/Jqr2F/pb3RSWXpQIhjy7yG60b/
 9LzrZ6CVbWQAIqPi/BBSvSLRJJRCzmtaKKP24VXRk5Tbu1CpXvhdoA7c13Zmyz3x6X7Cy4
 wcGR8AjS/4C9j22UfQgAzJC0PD5afPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-POCC_mPhOmakedK8QEL2FA-1; Tue, 27 Apr 2021 13:12:08 -0400
X-MC-Unique: POCC_mPhOmakedK8QEL2FA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D572F10AAEA3;
 Tue, 27 Apr 2021 17:12:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-178.rdu2.redhat.com [10.10.117.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96C7E60C0F;
 Tue, 27 Apr 2021 17:12:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 22F20220BCF; Tue, 27 Apr 2021 13:12:06 -0400 (EDT)
Date: Tue, 27 Apr 2021 13:12:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] virtiofs: propagate sync() to file server
Message-ID: <20210427171206.GA1805363@redhat.com>
References: <20210426151011.840459-1-groug@kaod.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426151011.840459-1-groug@kaod.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Robert Krawitz <rlk@redhat.com>
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

On Mon, Apr 26, 2021 at 05:10:11PM +0200, Greg Kurz wrote:
> Even if POSIX doesn't mandate it, linux users legitimately expect
> sync() to flush all data and metadata to physical storage when it
> is located on the same system. This isn't happening with virtiofs
> though : sync() inside the guest returns right away even though
> data still needs to be flushed from the host page cache.
> 
> This is easily demonstrated by doing the following in the guest:
> 
> $ dd if=/dev/zero of=/mnt/foo bs=1M count=5K ; strace -T -e sync sync
> 5120+0 records in
> 5120+0 records out
> 5368709120 bytes (5.4 GB, 5.0 GiB) copied, 5.22224 s, 1.0 GB/s
> sync()                                  = 0 <0.024068>
> +++ exited with 0 +++
> 
> and start the following in the host when the 'dd' command completes
> in the guest:
> 
> $ strace -T -e fsync /usr/bin/sync virtiofs/foo
> fsync(3)                                = 0 <10.371640>
> +++ exited with 0 +++
> 
> There are no good reasons not to honor the expected behavior of
> sync() actually : it gives an unrealistic impression that virtiofs
> is super fast and that data has safely landed on HW, which isn't
> the case obviously.
> 
> Implement a ->sync_fs() superblock operation that sends a new
> FUSE_SYNC request type for this purpose. Provision a 64-bit
> flags field for possible future extensions. Since the file
> server cannot handle the wait == 0 case, we skip it to avoid a
> gratuitous roundtrip.
> 
> Like with FUSE_FSYNC and FUSE_FSYNCDIR, lack of support for
> FUSE_SYNC in the file server is treated as permanent success.
> This ensures compatibility with older file servers : the client
> will get the current behavior of sync() not being propagated to
> the file server.
> 
> Note that such an operation allows the file server to DoS sync().
> Since a typical FUSE file server is an untrusted piece of software
> running in userspace, this is disabled by default.  Only enable it
> with virtiofs for now since virtiofsd is supposedly trusted by the
> guest kernel.
> 
> Reported-by: Robert Krawitz <rlk@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> v2: - clarify compatibility with older servers in changelog (Vivek)
>     - ignore the wait == 0 case (Miklos)
>     - 64-bit aligned argument structure (Vivek, Miklos)
> 
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           | 35 +++++++++++++++++++++++++++++++++++
>  fs/fuse/virtio_fs.c       |  1 +
>  include/uapi/linux/fuse.h | 10 +++++++++-
>  4 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 63d97a15ffde..68e9ae96cbd4 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -755,6 +755,9 @@ struct fuse_conn {
>  	/* Auto-mount submounts announced by the server */
>  	unsigned int auto_submounts:1;
>  
> +	/* Propagate syncfs() to server */
> +	unsigned int sync_fs:1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b0e18b470e91..ac184069b40f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -506,6 +506,40 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return err;
>  }
>  
> +static int fuse_sync_fs(struct super_block *sb, int wait)
> +{
> +	struct fuse_mount *fm = get_fuse_mount_super(sb);
> +	struct fuse_conn *fc = fm->fc;
> +	struct fuse_syncfs_in inarg;
> +	FUSE_ARGS(args);
> +	int err;
> +
> +	/*
> +	 * Userspace cannot handle the wait == 0 case. Avoid a
> +	 * gratuitous roundtrip.
> +	 */
> +	if (!wait)
> +		return 0;
> +
> +	if (!fc->sync_fs)
> +		return 0;
> +
> +	memset(&inarg, 0, sizeof(inarg));
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(inarg);
> +	args.in_args[0].value = &inarg;
> +	args.opcode = FUSE_SYNCFS;
> +	args.out_numargs = 0;
> +
> +	err = fuse_simple_request(fm, &args);
> +	if (err == -ENOSYS) {
> +		fc->sync_fs = 0;
> +		err = 0;
> +	}
> +
> +	return err;
> +}
> +
>  enum {
>  	OPT_SOURCE,
>  	OPT_SUBTYPE,
> @@ -909,6 +943,7 @@ static const struct super_operations fuse_super_operations = {
>  	.put_super	= fuse_put_super,
>  	.umount_begin	= fuse_umount_begin,
>  	.statfs		= fuse_statfs,
> +	.sync_fs	= fuse_sync_fs,
>  	.show_options	= fuse_show_options,
>  };
>  
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4ee6f734ba83..a3c025308743 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1441,6 +1441,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	fc->release = fuse_free_conn;
>  	fc->delete_stale = true;
>  	fc->auto_submounts = true;
> +	fc->sync_fs = true;
>  
>  	fsc->s_fs_info = fm;
>  	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 54442612c48b..1265ca17620c 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -179,6 +179,9 @@
>   *  7.33
>   *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
>   *  - add FUSE_OPEN_KILL_SUIDGID
> + *
> + *  7.34
> + *  - add FUSE_SYNCFS
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -214,7 +217,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 33
> +#define FUSE_KERNEL_MINOR_VERSION 34
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -499,6 +502,7 @@ enum fuse_opcode {
>  	FUSE_COPY_FILE_RANGE	= 47,
>  	FUSE_SETUPMAPPING	= 48,
>  	FUSE_REMOVEMAPPING	= 49,
> +	FUSE_SYNCFS		= 50,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> @@ -957,4 +961,8 @@ struct fuse_removemapping_one {
>  #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
>  		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
>  
> +struct fuse_syncfs_in {
> +	uint64_t flags;
> +};
> +

Hi Greg,

Will it be better if 32bits are for flags and reset 32 are
padding and can be used in whatever manner.

struct fuse_syncfs_in {
	uint32_t flags;
	uint32_t padding;
};

This will increase the flexibility if we were to send more information
in future.

I already see bunch of structures where flags are 32 bit and reset
are padding bits. fuse_read_in, fuse_write_in, fuse_rename2_in etc.

Thanks
Vivek

>  #endif /* _LINUX_FUSE_H */
> -- 
> 2.26.3
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
