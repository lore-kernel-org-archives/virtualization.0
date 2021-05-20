Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E02C433ED
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 06:29:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5630261186
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 06:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5630261186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C52540187;
	Thu, 20 May 2021 06:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjR98vCUKbYY; Thu, 20 May 2021 06:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAAE140194;
	Thu, 20 May 2021 06:28:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A49C0022;
	Thu, 20 May 2021 06:28:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15BEEC0001;
 Thu, 20 May 2021 06:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFB2940176;
 Thu, 20 May 2021 06:28:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hp_HFCI64ZzT; Thu, 20 May 2021 06:28:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk
 [IPv6:2607:5300:60:148a::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76E7B400AB;
 Thu, 20 May 2021 06:28:56 +0000 (UTC)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1ljcAf-00GTu6-EE; Thu, 20 May 2021 06:28:37 +0000
Date: Thu, 20 May 2021 06:28:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
Message-ID: <YKYBle/F8aOgHO9p@zeniv-ca.linux.org.uk>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517095513.850-12-xieyongji@bytedance.com>
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

On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:

> +	case VDUSE_IOTLB_GET_FD: {
> +		struct vduse_iotlb_entry entry;
> +		struct vhost_iotlb_map *map;
> +		struct vdpa_map_file *map_file;
> +		struct vduse_iova_domain *domain = dev->domain;
> +		struct file *f = NULL;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&entry, argp, sizeof(entry)))
> +			break;

			return -EFAULT;
surely?
> +
> +		ret = -EINVAL;
> +		if (entry.start > entry.last)
> +			break;

... and similar here, etc.

> +		spin_lock(&domain->iotlb_lock);
> +		map = vhost_iotlb_itree_first(domain->iotlb,
> +					      entry.start, entry.last);
> +		if (map) {
> +			map_file = (struct vdpa_map_file *)map->opaque;
> +			f = get_file(map_file->file);
> +			entry.offset = map_file->offset;
> +			entry.start = map->start;
> +			entry.last = map->last;
> +			entry.perm = map->perm;
> +		}
> +		spin_unlock(&domain->iotlb_lock);
> +		ret = -EINVAL;
> +		if (!f)
> +			break;
> +
> +		ret = -EFAULT;
> +		if (copy_to_user(argp, &entry, sizeof(entry))) {
> +			fput(f);
> +			break;
> +		}
> +		ret = receive_fd(f, perm_to_file_flags(entry.perm));
> +		fput(f);
> +		break;

IDGI.  The main difference between receive_fd() and plain old
get_unused_fd_flags() + fd_install() is __receive_sock() call.
Which does nothing whatsoever in case of non-sockets.  Can you
get a socket here?

IOW, why bother with that crap at all, nevermind exporting it?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
