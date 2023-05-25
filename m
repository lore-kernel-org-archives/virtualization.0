Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E5C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 07:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8E3F42A81;
	Thu, 25 May 2023 07:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8E3F42A81
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axrwksA8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TLzB4acpbNn; Thu, 25 May 2023 07:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 567D641524;
	Thu, 25 May 2023 07:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 567D641524
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 336C1C0035;
	Thu, 25 May 2023 07:46:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2E41C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80AB083AAE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80AB083AAE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=axrwksA8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r_Hzzu76Cy7k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D339683A5C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D339683A5C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685000756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hxihn5MvJp1k9amFLZx8DIAvEjfASYEqP9tbQw550jY=;
 b=axrwksA8vNl6i+/dps4mmtqw1LhXjGxuxlDR3uMI25d0KEoI2k4rOoLfR0W6PgKxanCBVF
 4PCGujNUDAqfQcBzwTErzCCie7TJrJrAOZ1GzMTqTP4UDZbEZNrrJcSvFvtH5np0/2RnGn
 bmPXxJRBEAOMeB3i0uI6LPJGGFNQtNY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-_cxGRyxuM7KhbPvZx_vobA-1; Thu, 25 May 2023 03:45:54 -0400
X-MC-Unique: _cxGRyxuM7KhbPvZx_vobA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f4deee3ec6so11995871cf.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 00:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685000754; x=1687592754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hxihn5MvJp1k9amFLZx8DIAvEjfASYEqP9tbQw550jY=;
 b=aM9f/pR4xYD8HJyVrrs34QNl0AOgZGaj3X+DM1WgimTGOxtClGKHXez/fvxk7WJKKF
 GZbiCff92RkWrqFbvJ/goVPoofhsATgpIGIyF7wklc7/RRTuYR5+HqlYOlOg0gWtDYLh
 h9tuTHm8WcUEeo+0jnV/BmD2mAvKBsWOtoK9ECYeLZpAr7HYxL/0M/aMUcw5lmtKXskn
 nBhwGqmlcfSo0VNZegeDtzekaMjdesHSxrZPAl6CZow5dlN52GEBfx0Gt7S/A/+QwYhP
 Ci0M3obGXGwF3z5PLadnmOzu4c+ybPzlVYw/3oOy+FzzLiNZEog+sCgn5RIqSyMwZLgJ
 HIYQ==
X-Gm-Message-State: AC+VfDwvtb2dxaSr73IN236+DBS/XbYauHq4Jrm+GdmIOpiJUg3BE8oP
 +MNiFAixnXZ6odLI24VM2fkunMZ4ZM2DFnKOxHwNvhpAs5xXG2Zfe0DWuoXOigEIxNfc39DhBFs
 d5w09e3wKvtBrJGRKPfx13PskkWy3sudqOgsVUvN3cQ==
X-Received: by 2002:ac8:7e86:0:b0:3f6:9473:7799 with SMTP id
 w6-20020ac87e86000000b003f694737799mr28852603qtj.55.1685000754506; 
 Thu, 25 May 2023 00:45:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79HwPB3ChFKJ7SuFGYhJbVkKZLWrv+0vEbTM6L29n+LMt7qKoBZHFzUSxiE+6oG07CCgQQxA==
X-Received: by 2002:ac8:7e86:0:b0:3f6:9473:7799 with SMTP id
 w6-20020ac87e86000000b003f694737799mr28852596qtj.55.1685000754187; 
 Thu, 25 May 2023 00:45:54 -0700 (PDT)
Received: from redhat.com ([191.101.160.247]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac87ca1000000b003f517e1fed2sm216383qtv.15.2023.05.25.00.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:45:53 -0700 (PDT)
Date: Thu, 25 May 2023 03:45:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Message-ID: <20230525034526-mutt-send-email-mst@kernel.org>
References: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 open list <linux-kernel@vger.kernel.org>
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


Subject should be "for ringtest" not "to ringtest".

On Wed, May 24, 2023 at 08:36:12PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Ignore executions for ringtest.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/virtio/ringtest/.gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/virtio/ringtest/.gitignore
> 
> diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
> new file mode 100644
> index 000000000000..100b9e30c0f4
> --- /dev/null
> +++ b/tools/virtio/ringtest/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +/noring
> +/ptr_ring
> +/ring
> +/virtio_ring_0_9
> +/virtio_ring_inorder
> +/virtio_ring_poll
> -- 
> 2.39.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
