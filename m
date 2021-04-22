Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A7C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 00:44:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB016144E
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 00:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB016144E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9653405C6;
	Thu, 22 Apr 2021 00:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sVSuX2F9XnEN; Thu, 22 Apr 2021 00:44:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B8F7405C2;
	Thu, 22 Apr 2021 00:44:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 199E6C000E;
	Thu, 22 Apr 2021 00:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C60A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 00:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DF8C82B1B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 00:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2hOaYOeBvHU2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 00:44:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk
 [IPv6:2607:5300:60:148a::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F91C82AB9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 00:44:17 +0000 (UTC)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lZNRw-007B5f-KZ; Thu, 22 Apr 2021 00:44:08 +0000
Date: Thu, 22 Apr 2021 00:44:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] fuse: Avoid potential use after free
Message-ID: <YIDG2MOSITJxJBqd@zeniv-ca.linux.org.uk>
References: <20210406235332.2206460-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406235332.2206460-1-pakki001@umn.edu>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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

On Tue, Apr 06, 2021 at 06:53:32PM -0500, Aditya Pakki wrote:
> In virtio_fs_get_tree, after fm is freed, it is again freed in case
> s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
> a double free, set fm to NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/fuse/virtio_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4ee6f734ba83..a7484c1539bf 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	if (fsc->s_fs_info) {
>  		fuse_conn_put(fc);
>  		kfree(fm);
> +		fm = NULL;
>  	}
>  	if (IS_ERR(sb))
>  		return PTR_ERR(sb);

NAK.  The only cases when sget_fc() returns without having ->s_fs_info
zeroed are when it has successfull grabbed a reference to existing live
superblock or when it has failed.  In the former case we proceed straight
to
        fsc->root = dget(sb->s_root);
	return 0;
and in the latter we bugger off on IS_ERR(sb).  No double-free in either
case.  Said that, the logics in there (especially around the cleanups
on virtio_fs_fill_super() failures) is bloody convoluted, but sorting
that out would take a lot more RTFS than I'm willing to start right now.

In any case, this patch does not fix any bugs and does not make the
thing easier to follow, so...

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
