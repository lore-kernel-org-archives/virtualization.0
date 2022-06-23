Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBFFCCA47C
	for <virtualization@archiver.kernel.org>; Thu, 23 Jun 2022 12:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19A7D613FD;
	Thu, 23 Jun 2022 12:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19A7D613FD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLGR6SK5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYzSuMiMf-x4; Thu, 23 Jun 2022 12:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3176613FB;
	Thu, 23 Jun 2022 12:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3176613FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79FA9C0032;
	Thu, 23 Jun 2022 12:48:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95AC7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68F7D40607
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:48:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68F7D40607
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLGR6SK5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tUQHIywIoSD5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:48:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A47EC400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A47EC400AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655988487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrgA3QRhrviuqlVZS1DqYvEOCwDo7gxdsScFtfx3ONI=;
 b=OLGR6SK585WEwjfClEH5A8Yu3rF2JG7eRKit9Izq8UnlMQPzxE9ct2kMuTWM8yEiN1ubML
 y9ZdBqkFt6T5RY5GhQ98oIeTu/ecBPAMQT9Id4whOAJc2Wfnh/F63r3q3WJzsZveFsbSoF
 R4wkn5B2zAdar6y46zQu2tmmb7AjcKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-pmhPhQ4JNM-M5mO90PjKCQ-1; Thu, 23 Jun 2022 08:48:02 -0400
X-MC-Unique: pmhPhQ4JNM-M5mO90PjKCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D7E5811E76;
 Thu, 23 Jun 2022 12:48:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0D19C28115;
 Thu, 23 Jun 2022 12:48:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5DF042209F9; Thu, 23 Jun 2022 08:48:01 -0400 (EDT)
Date: Thu, 23 Jun 2022 08:48:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtio_fs: Modify format for virtio_fs_direct_access
Message-ID: <YrRhAZA1Enez0WRA@redhat.com>
References: <20220622211758.4728-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622211758.4728-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, miklos@szeredi.hu
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

On Wed, Jun 22, 2022 at 05:17:58PM -0400, Deming Wang wrote:
> We should isolate operators with spaces.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Looks good to me.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..e962c29967eb 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -757,7 +757,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  {
>  	struct virtio_fs *fs = dax_get_private(dax_dev);
>  	phys_addr_t offset = PFN_PHYS(pgoff);
> -	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
> +	size_t max_nr_pages = fs->window_len / PAGE_SIZE - pgoff;
>  
>  	if (kaddr)
>  		*kaddr = fs->window_kaddr + offset;
> -- 
> 2.27.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
