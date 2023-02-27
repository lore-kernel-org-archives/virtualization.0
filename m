Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181BDC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 18:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 974A041759;
	Mon, 27 Feb 2023 18:07:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 974A041759
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVMM4qnT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3weZigx1qFfV; Mon, 27 Feb 2023 18:07:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB8204175E;
	Mon, 27 Feb 2023 18:07:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB8204175E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87D86C0033;
	Mon, 27 Feb 2023 18:07:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ADACC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E5054175E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:07:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E5054175E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7IcjMCrSG9dH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D01C41759
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D01C41759
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677521216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0XiMaVk2NRHD3G7gBjNzwZV65APgDc5PN3bQr3CxgQ=;
 b=AVMM4qnTgdNqkCYPMVZKJdAzwJu68r2UvobHcMOvJpjLYUwx4F3uhPLISrRoXDNnWDEJxu
 QUJ++UQa2ZLes116fnJtLH1WNv8jvJUbsWqrYDlDDPvjeRnYoroAWRP2+OrD8r9IET++mR
 qbwYPf+axEqm5hKz8trLOUrsbsqmBhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-xsKvlzbSMLCqXzj1QpnMwQ-1; Mon, 27 Feb 2023 13:06:52 -0500
X-MC-Unique: xsKvlzbSMLCqXzj1QpnMwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FD97802D2E;
 Mon, 27 Feb 2023 18:06:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A71062026D4B;
 Mon, 27 Feb 2023 18:06:51 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id 40EAF139788; Mon, 27 Feb 2023 13:06:51 -0500 (EST)
Date: Mon, 27 Feb 2023 13:06:51 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RESEND v2 PATCH] init/do_mounts.c: add virtiofs root fs support
Message-ID: <Y/zxO9PMaES8SenN@redhat.com>
References: <20230224143751.36863-1-david@ixit.cz>
 <Y/zSCarxyabSC1Zf@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y/zSCarxyabSC1Zf@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: David Heidelberg <david@ixit.cz>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, wsa+renesas@sang-engineering.com,
 helen.koike@collabora.com, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

On Mon, Feb 27, 2023 at 10:53:45AM -0500, Stefan Hajnoczi wrote:
> On Fri, Feb 24, 2023 at 03:37:51PM +0100, David Heidelberg wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Make it possible to boot directly from a virtiofs file system with tag
> > 'myfs' using the following kernel parameters:
> > 
> >   rootfstype=virtiofs root=myfs rw
> > 
> > Booting directly from virtiofs makes it possible to use a directory on
> > the host as the root file system.  This is convenient for testing and
> > situations where manipulating disk image files is cumbersome.
> > 
> > Reviewed-by: Helen Koike <helen.koike@collabora.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > v2: added Reviewed-by and CCed everyone interested.
> > 
> > We have used this option in Mesa3D CI for testing crosvm for
> > more than one years and it's proven to work reliably.
> > 
> > We are working on effort to removing custom patches to be able to do 
> > automated apply and test of patches from any tree.                              
> > 
> > https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-runner.sh#L85
> >  init/do_mounts.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Vivek, do you remember where we ended up with boot from virtiofs? I
> thought a different solution was merged some time ago.

We merged a patch from Christoph Hellwig to support this.

commit f9259be6a9e7c22d92e5a5000913147ae17e8321
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jul 14 16:23:20 2021 -0400

    init: allow mounting arbitrary non-blockdevice filesystems as root

Now one should be able to mount virtiofs using following syntax.

"root=myfs rootfstype=virtiofs rw"

IIUC, this patch should not be required anymore.

Thanks
Vivek

> 
> There is documentation from the virtiofs community here:
> https://virtio-fs.gitlab.io/howto-boot.html
> 
> Stefan
> 
> > 
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 811e94daf0a8..11c11abe23d7 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -578,6 +578,16 @@ void __init mount_root(void)
> >  			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
> >  		return;
> >  	}
> > +#endif
> > +#ifdef CONFIG_VIRTIO_FS
> > +	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> > +		if (!do_mount_root(root_device_name, "virtiofs",
> > +				   root_mountflags, root_mount_data))
> > +			return;
> > +
> > +		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
> > +		      root_device_name);
> > +	}
> >  #endif
> >  	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
> >  		if (mount_nodev_root() == 0)
> > -- 
> > 2.39.1
> > 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
