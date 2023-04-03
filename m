Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A1C76196
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 18:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 926AD60F8D;
	Mon,  3 Apr 2023 18:09:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 926AD60F8D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqk/Cqam
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8hc-yc35vhb; Mon,  3 Apr 2023 18:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 132D560E19;
	Mon,  3 Apr 2023 18:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 132D560E19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA03C0036;
	Mon,  3 Apr 2023 18:09:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7B5FC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B49081CD0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B49081CD0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqk/Cqam
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q8FoNdkt1IfO
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:09:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C39381CBA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C39381CBA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680545389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agPsP1zdg7munpT7HN1LrxN+rqK/h3lZCmhkqo/cyeY=;
 b=iqk/Cqam1UxKNsSRHOWKD+TUgPjBqYRDlr3eJc7OT8bvDliImml57xoNGz9FP38gfZAnsR
 EntF8FV5HDoYE1CRHv6uLUsqs8XrbcZotfdfZyacgNgKZkBzoPVTod+GaR+YRp5nBdyt0m
 Hb3QeWNx2vsBVAEAVzLGwSjZYDWYlHI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-5zuhmy89OtqQXYh-qz3eUw-1; Mon, 03 Apr 2023 14:09:48 -0400
X-MC-Unique: 5zuhmy89OtqQXYh-qz3eUw-1
Received: by mail-ed1-f70.google.com with SMTP id
 v1-20020a50d581000000b0050291cda08aso8742386edi.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 11:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680545387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agPsP1zdg7munpT7HN1LrxN+rqK/h3lZCmhkqo/cyeY=;
 b=zzu1hSTsDy8DdZQJB3n2HPv7MMJq0+f2cgvjEOotQlJ9bPmjpoFjZo445b+FMXCRBp
 KBK0R4VWqBvKOtaixi884Ozz5AC3sx0EDxi3XliNDBVmNnsp9//eDQPo9MlszCjSVzfY
 H+EdUB85ue79Oc9Rpmiq805KVg621hkYZLOEctkOKWLt8MH/zTP+GArTAuSmosIMQd8z
 dHpwCo9tlKV8xP+MLLlcMMtZZLoeaB1szNz81gsGTgsGw3wL5KrQpa8pBoCM/RuHx+su
 DH2u8q7CrvzHrXWCbtpMXV8y6JenvR6CPQXQ78i6JkHBufS/xWib5CH2np9WyY6bJDw1
 tgQA==
X-Gm-Message-State: AAQBX9eSVTRbbSqI924AMqxWkxUeSF/6ApWZ3tbz6+q2j6/XRm1C5jTs
 MVwUY0VSqcsBlBfgymVuoauV1+0CrSk+VBcBzy12POiDN9QwYTGo/pz0l7aM0SYt5fQVGxBuWcB
 GgDTLtkLzHK21LOxXX2IDdqWaKIfeXScRKi7A19zSyw==
X-Received: by 2002:a17:907:a406:b0:947:54ae:806 with SMTP id
 sg6-20020a170907a40600b0094754ae0806mr18002631ejc.1.1680545386837; 
 Mon, 03 Apr 2023 11:09:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRV/7HD4c13nAvkdGoB4FYstVSvpNuYniOS5ue8YLuKWrHV0nX5QFB+Tsbb6Ub4sCxiJl/qA==
X-Received: by 2002:a17:907:a406:b0:947:54ae:806 with SMTP id
 sg6-20020a170907a40600b0094754ae0806mr18002606ejc.1.1680545386465; 
 Mon, 03 Apr 2023 11:09:46 -0700 (PDT)
Received: from redhat.com ([213.152.162.235]) by smtp.gmail.com with ESMTPSA id
 y27-20020a170906519b00b009473bbe5f7dsm4822618ejk.208.2023.04.03.11.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 11:09:45 -0700 (PDT)
Date: Mon, 3 Apr 2023 14:09:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 0/1] posted interrtups support for mlx5
Message-ID: <20230403140728-mutt-send-email-mst@kernel.org>
References: <20230403162039.18932-1-elic@nvidia.com>
 <9db042bd-1bf9-9664-cb01-419be1a2f209@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <9db042bd-1bf9-9664-cb01-419be1a2f209@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: parav@mellanox.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eli Cohen <elic@nvidia.com>
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

On Mon, Apr 03, 2023 at 01:00:16PM -0400, Parav Pandit wrote:
> 
> 
> On 4/3/2023 12:20 PM, Eli Cohen wrote:
> > Hi,
> > 
> > the single patch in this series adds support for posted interrupts in
> > mlx5.
> > 
> > It depends on the patch series already accpted can be seen here:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20230324231341.29808-1-saeed@kernel.org/
> > 
> > git pull  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
> > tags/mlx5-updates-2023-03-20
> > 
> > Eli Cohen (1):
> >    vdpa/mlx5: Support interrupt bypassing
> > 
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 139 ++++++++++++++++++++++++++++--
> >   drivers/vdpa/mlx5/net/mlx5_vnet.h |  14 +++
> >   2 files changed, 144 insertions(+), 9 deletions(-)
> > 
> In subject
> 
> s/interrtups/interrupts/

In fact if we are splitting hairs, this is a reduced relative (full form
would be "support of posted interrupts") so it should not use a plural
form. Also pls use a prefix in the patch subject. In the end:
	mlx5: posted interrupt support
would be better.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
