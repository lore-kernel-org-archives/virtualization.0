Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66130C433B4
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 06:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B386D61001
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 06:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B386D61001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF9F831F2;
	Thu, 20 May 2021 06:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQ6dUUg99mXq; Thu, 20 May 2021 06:19:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33CC282A72;
	Thu, 20 May 2021 06:19:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9D41C0022;
	Thu, 20 May 2021 06:19:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2293C0001;
 Thu, 20 May 2021 06:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB28783C43;
 Thu, 20 May 2021 06:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AgLQWPLlVFd; Thu, 20 May 2021 06:19:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk
 [IPv6:2607:5300:60:148a::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EB1683B65;
 Thu, 20 May 2021 06:19:16 +0000 (UTC)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1ljc1B-00GTlF-Uy; Thu, 20 May 2021 06:18:50 +0000
Date: Thu, 20 May 2021 06:18:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v7 02/12] file: Export receive_fd() to modules
Message-ID: <YKX/SUq53GDtq84t@zeniv-ca.linux.org.uk>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-3-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517095513.850-3-xieyongji@bytedance.com>
Cc: axboe@kernel.dk, corbet@lwn.net, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 rdunlap@infradead.org, iommu@lists.linux-foundation.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 christian.brauner@canonical.com, bcrl@kvack.org, mika.penttila@nextfour.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, joro@8bytes.org,
 dan.carpenter@oracle.com
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

On Mon, May 17, 2021 at 05:55:03PM +0800, Xie Yongji wrote:
> Export receive_fd() so that some modules can use
> it to pass file descriptor between processes without
> missing any security stuffs.

Which tree is that against?  Because in mainline this won't even build, let
alone work.

> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1135,6 +1135,12 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
>  	return new_fd;
>  }
>  
> +int receive_fd(struct file *file, unsigned int o_flags)
> +{
> +	return __receive_fd(-1, file, NULL, o_flags);
> +}
> +EXPORT_SYMBOL_GPL(receive_fd);

fs/file.c:1097:int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
