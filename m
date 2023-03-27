Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B18C7619A
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 13:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FB4281D16;
	Mon, 27 Mar 2023 13:32:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FB4281D16
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Trp5NM+n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CRNEE3OSLPeR; Mon, 27 Mar 2023 13:32:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B435D81C56;
	Mon, 27 Mar 2023 13:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B435D81C56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A2BFC0035;
	Mon, 27 Mar 2023 13:32:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB6A1C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91DD160F41
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91DD160F41
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Trp5NM+n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ay-UgwS-pIcj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:32:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9853A60881
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9853A60881
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679923942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=45ANxRXv+CmKBORJQeZkZo556TyX4xY4z1xyvoQpf7s=;
 b=Trp5NM+np1pwYOEswT4IaywUulbTOIHN1zb8YCJfH0d1d5zfl9sU4lUTAx1P7nd90AQrCz
 D94dxVo5pWd9wM//VJENKYXR2ZQYrq5uRNLgvEZLM/bwOMfcMqEuzHJAoQCGyyzHLxz4UU
 sFDv1KQf4WQ95NSEBomexfVdgfsLaGE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-vqfPG9iQOdC9AkE-l0BqAA-1; Mon, 27 Mar 2023 09:32:21 -0400
X-MC-Unique: vqfPG9iQOdC9AkE-l0BqAA-1
Received: by mail-wm1-f69.google.com with SMTP id
 n19-20020a05600c3b9300b003ef63ef4519so3243189wms.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679923940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45ANxRXv+CmKBORJQeZkZo556TyX4xY4z1xyvoQpf7s=;
 b=zyhc6GK8btfzGKBK1WY5+FTMnzMMatvTXjmFJUAcUSaLd8A6Lg4IljSXvINjLSZV0Z
 PQVTH0jPb9PPOGmwApTr8ptJJiu5qjM9KBrwontk42YnVdt05/5uONTHSufFVvVHcUTi
 +qnO96FiwJszeG48wGjkrj//9Sjb652UoUKF9AKksAJq18tYPrFBgOUv3eHgtyEI5gYo
 85U8e6I7qF6+dorje9pNCzEWMDu/Ylb6Gd8NYP+NKR/2XcApigOJBbwx/sTpLVOKEHGn
 lulG+Qc6kMTDsSD+Q+q0pZmyYv1EbulRnSD3IZq8SDUcrW78KSUSgxPmpQw7r9jwvyvv
 3bbw==
X-Gm-Message-State: AO0yUKVfC9MZYPQQ0fOlEAXm+JGBZX0XweECGpaQK5/rgF2mySBDXaJY
 0Yc/aB0vG3AbYASmzvMTdauE8NZAgVO1UBMXyGPSyCQCMogY/XzFxdiO3jnTPwjpXZmaSv0p8iR
 TTZME7vpLnFnc4MHrCSIsY783vD0jJyyHqRaG06bKiA==
X-Received: by 2002:a7b:c7d6:0:b0:3e1:f8af:8772 with SMTP id
 z22-20020a7bc7d6000000b003e1f8af8772mr9393538wmk.9.1679923940256; 
 Mon, 27 Mar 2023 06:32:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set8gdRVPXdFw2VEM14Dq51u4OtBaddjJUio2jBLT7UtvdL6xG4rHCigflYhYz9nOXRbjvmAY9g==
X-Received: by 2002:a7b:c7d6:0:b0:3e1:f8af:8772 with SMTP id
 z22-20020a7bc7d6000000b003e1f8af8772mr9393524wmk.9.1679923940000; 
 Mon, 27 Mar 2023 06:32:20 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 i6-20020a05600c354600b003ede6540190sm9086871wmq.0.2023.03.27.06.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:32:19 -0700 (PDT)
Date: Mon, 27 Mar 2023 09:32:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] vdpa: bugfix
Message-ID: <20230327093125-mutt-send-email-mst@kernel.org>
References: <20230327091947-mutt-send-email-mst@kernel.org>
 <20230327092909-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230327092909-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, elic@nvidia.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

And the issue was that the author self-nacked the single fix here.
So we'll merge another fix, later.

On Mon, Mar 27, 2023 at 09:30:13AM -0400, Michael S. Tsirkin wrote:
> Looks like a sent a bad pull request. Sorry!
> Please disregard.
> 
> On Mon, Mar 27, 2023 at 09:19:50AM -0400, Michael S. Tsirkin wrote:
> > The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:
> > 
> >   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to 8fc9ce051f22581f60325fd87a0fd0f37a7b70c3:
> > 
> >   vdpa/mlx5: Remove debugfs file after device unregister (2023-03-21 16:39:02 -0400)
> > 
> > ----------------------------------------------------------------
> > vdpa: bugfix
> > 
> > An error handling fix in mlx5.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> 
> 
> > ----------------------------------------------------------------
> > Eli Cohen (1):
> >       vdpa/mlx5: Remove debugfs file after device unregister
> > 
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
