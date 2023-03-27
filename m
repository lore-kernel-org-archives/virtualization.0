Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBB4C76195
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 13:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C183540B4D;
	Mon, 27 Mar 2023 13:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C183540B4D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hOFfzCu9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-b7xH9vvYbz; Mon, 27 Mar 2023 13:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A54C400C6;
	Mon, 27 Mar 2023 13:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A54C400C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2301BC0035;
	Mon, 27 Mar 2023 13:30:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05BC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2C77416E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2C77416E8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hOFfzCu9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gFv5GXTdxT8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD943416E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD943416E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679923815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rnHz54xfyL+gglmIyJKJy5abDhVgwniJPLQmnnklQbc=;
 b=hOFfzCu9iFd7v0hSh4b+wX75wA4m+oDpUfVqyn2TINjjM/n4p78vpbQdhK30KiHc6S4qa0
 1USCshkucJLE0l5RlrXxE1qqjItL0oklCMpcBkH451AHN9h2GvjIPd4fgTF4NrqQFvc5BP
 jOEHGa9SRThhcMCYGReSetEwzhzgPis=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-1zPt93TXMo6hTWCIjrEBJw-1; Mon, 27 Mar 2023 09:30:14 -0400
X-MC-Unique: 1zPt93TXMo6hTWCIjrEBJw-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg13-20020a05600c3c8d00b003ed40f09355so4715860wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679923813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnHz54xfyL+gglmIyJKJy5abDhVgwniJPLQmnnklQbc=;
 b=eq2srR2nJbC/3OtFdtZ0nmAF+Z2yFCQaX+tJMxGQon5F0r6H/Ls5cKOvAznEX3JsX1
 O7l+1leZNN6KEg0mmMkWr873kVaomrI2MqQMWOuwjqKu7DfhHo7BErpq+BIhDVkIpimH
 fhD/yQYN4Dp3HY3P+dbSa/SI8ApyAv7QmW4JArK3aEINv3QBA7jkctRsY4XKoi6X70Eo
 bo07bVRbrvHAxgiK4HYJpSI8+07UvtOUDRP1Vw2ALPDs/NCMa/Z6PPvINAvP9ni6fHAh
 INQBGEK3YPyt3Sg3KKZ4QT4Sk01+vm+QmeuhpraIQbDHSJeGV3bvILziTgjmVSAgLO8/
 JU3A==
X-Gm-Message-State: AO0yUKXsGdyUV5AGrq/nXbW1SW/12dYCwOE7453pbc2Qs+1UGEYiod7D
 giKOX4sNKKr7TfB7ZRImLgTWc4vRebUX65zvoQTPNTBUn/Gd0mTEDf45LOT6Mz3+ShVWm6RwDtP
 +OcXOGQpXUJor3iLH3C9+dTVyC5GLMZ2CdQYPO0AtNQ==
X-Received: by 2002:a05:600c:2114:b0:3ed:492f:7f37 with SMTP id
 u20-20020a05600c211400b003ed492f7f37mr8747289wml.10.1679923813046; 
 Mon, 27 Mar 2023 06:30:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set9UiwP8XvEO+pMF2nbKcdfIrVKf+Fs5lq6Q+1t1gZjOUKhdS1XmGs2yy9FXpB/ck95uX2096g==
X-Received: by 2002:a05:600c:2114:b0:3ed:492f:7f37 with SMTP id
 u20-20020a05600c211400b003ed492f7f37mr8747274wml.10.1679923812717; 
 Mon, 27 Mar 2023 06:30:12 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 g8-20020a05600c310800b003ee610d1ce9sm8981395wmo.34.2023.03.27.06.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:30:12 -0700 (PDT)
Date: Mon, 27 Mar 2023 09:30:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] vdpa: bugfix
Message-ID: <20230327092909-mutt-send-email-mst@kernel.org>
References: <20230327091947-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230327091947-mutt-send-email-mst@kernel.org>
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

Looks like a sent a bad pull request. Sorry!
Please disregard.

On Mon, Mar 27, 2023 at 09:19:50AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:
> 
>   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 8fc9ce051f22581f60325fd87a0fd0f37a7b70c3:
> 
>   vdpa/mlx5: Remove debugfs file after device unregister (2023-03-21 16:39:02 -0400)
> 
> ----------------------------------------------------------------
> vdpa: bugfix
> 
> An error handling fix in mlx5.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>




> ----------------------------------------------------------------
> Eli Cohen (1):
>       vdpa/mlx5: Remove debugfs file after device unregister
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
