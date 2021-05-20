Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C1C43460
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 19:45:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47026611AD
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 19:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47026611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C3D0405AF;
	Thu, 20 May 2021 19:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsGtvDbERvTV; Thu, 20 May 2021 19:45:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4B4A40577;
	Thu, 20 May 2021 19:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FA36C000D;
	Thu, 20 May 2021 19:45:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D7D6C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 19:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50379844A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 19:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttQRlDLQdxVn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 19:45:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk
 [IPv6:2607:5300:60:148a::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B29E844B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 19:45:23 +0000 (UTC)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ljobZ-00Gvlp-Bb; Thu, 20 May 2021 19:45:13 +0000
Date: Thu, 20 May 2021 19:45:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error
 path
Message-ID: <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
References: <20210520154654.1791183-1-groug@kaod.org>
 <20210520154654.1791183-2-groug@kaod.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210520154654.1791183-2-groug@kaod.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
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

On Thu, May 20, 2021 at 05:46:50PM +0200, Greg Kurz wrote:
> Some rollback was forgotten during the addition of crossmounts.

Have you actually tested that?  Because I strongly suspect that
by that point the ownership of fc and fm is with sb and those
should be taken care of by deactivate_locked_super().
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
