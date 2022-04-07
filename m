Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B17C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 14:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C502F60DF0;
	Thu,  7 Apr 2022 14:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0aacmaB7yGm1; Thu,  7 Apr 2022 14:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6364061201;
	Thu,  7 Apr 2022 14:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35F7AC001D;
	Thu,  7 Apr 2022 14:11:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07900C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 14:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E964140333
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 14:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ag4KGy375V-0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 14:11:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A744B419DB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649340665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9gNLvj+RzSmMEWWNqwab09rZ5taTtgxhPO2/45pSnk=;
 b=eOMHt8Dt1+9yMqS8QoX/g+eR1WBbjZejKix2auESwBlPuB60LxvoXLCwjlGtR9zmRNOCeM
 AC9cYa/HmAHDzRo77L4RTcK0Rxwyuf8OAZf03vsCfwgFr1TFh3D7mtwgyIMPJqIY5XWtbQ
 yHUF7+sK74gYON0115mNBBGoxrAZz2w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-PPuv8H_HPQWzTK4AvKUwfA-1; Thu, 07 Apr 2022 10:11:02 -0400
X-MC-Unique: PPuv8H_HPQWzTK4AvKUwfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6858629DD9B0;
 Thu,  7 Apr 2022 14:11:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E07052024CB9;
 Thu,  7 Apr 2022 14:10:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 8D3BE220EFF; Thu,  7 Apr 2022 10:10:56 -0400 (EDT)
Date: Thu, 7 Apr 2022 10:10:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <Yk7w8L1f/yik+qrR@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 miklos@szeredi.hu
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

On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> Move dmap free worker kicker inside the critical region, so that extra
> spinlock lock/unlock could be avoided.
> 
> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Looks good to me. Have you done any testing to make sure nothing is
broken.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index d7d3a7f06862..b9f8795d52c4 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -138,9 +138,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn_dax *fcd)
>  		WARN_ON(fcd->nr_free_ranges <= 0);
>  		fcd->nr_free_ranges--;
>  	}
> +	__kick_dmap_free_worker(fcd, 0);
>  	spin_unlock(&fcd->lock);
>  
> -	kick_dmap_free_worker(fcd, 0);
>  	return dmap;
>  }
>  
> -- 
> 2.27.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
