Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36948C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 14:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A189D41FB0;
	Tue,  7 Nov 2023 14:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A189D41FB0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Of4PASZj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pvzvZowezyfU; Tue,  7 Nov 2023 14:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDA7A41FB5;
	Tue,  7 Nov 2023 14:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDA7A41FB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85A98C0071;
	Tue,  7 Nov 2023 14:30:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB34C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C9CD61257
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C9CD61257
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Of4PASZj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUwNHhM4gNxn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:30:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA20360A94
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:30:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA20360A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699367431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BEK4Nq2797qPXi5hUhUOD+w7Yxl1Y5y6keCDboqBnw=;
 b=Of4PASZjPYtpcx7NaEMxBZk8sa21j4tPyCox960KCw1SRFDq6fyBYirTpQwXvG56TRQ5ZO
 Rdphcb1uqHZisgU16dif/C64RhKLCAnMjCYPSnFnplKf0zuzF+G9lRODXNg3XqML5bAMWc
 4UaX0SLfU+fezPOAkyOpD9LxwxnXvVs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ZCGAvc6TOYOFwmK-_vTWlg-1; Tue, 07 Nov 2023 09:30:27 -0500
X-MC-Unique: ZCGAvc6TOYOFwmK-_vTWlg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507b9078aaaso6199827e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Nov 2023 06:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367426; x=1699972226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BEK4Nq2797qPXi5hUhUOD+w7Yxl1Y5y6keCDboqBnw=;
 b=hjrF/GI4kgRohw94ESE83HSTvIWYYGUxGK7qBBGE4A0Yquyd1Ww0/nGDBk7p7SGz0u
 N1df8yaWvGgIlXj7aFzP9Ne6G+SLHp/LyllajqTAPd3CvdLliScpBwIH2LPMYFIDr3mE
 0FpdTtSOaiquM1KWTi79YgMa7H3HBxWJlwUXvPlN/F7U1hHb7H2wSTqOiVmJNFFWVBSB
 Ss2wocrxv7zmDLG+CZqpKTvHvCOTCEeQwKKVOHnUJE9h8008gr97aYRiN6pwoMD1FX2L
 0xfbPblmKQGqcE1ES/pawH2WF4IOsxqanMgXv0qJI41U9YWTxiiyimijK2He3ZHb4H98
 rL+A==
X-Gm-Message-State: AOJu0Yw4Ie+yd5TJpVHbvmdxF661Hp6Wz/EEWdXR0DTa4LWhBrXiZYlb
 YNq4vqF6CYEGQInQlkcwDCC6xXu+iEKv6xkB/xPamX3bf7lVTVt6/JASWpVyBq0d/mm4dQklK5f
 nNj49uDPZNV/r4rZfRKc/xXZqWYs2unFoaXkGttdO+w==
X-Received: by 2002:ac2:488e:0:b0:500:7cab:efc3 with SMTP id
 x14-20020ac2488e000000b005007cabefc3mr23998203lfc.11.1699367426353; 
 Tue, 07 Nov 2023 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJy8gOlznCOc9sukgGEsAedAcGzp6nnH6baVR5lODsEIZgCRdZq2T6s/WT4PvnZAwy92AFJA==
X-Received: by 2002:ac2:488e:0:b0:500:7cab:efc3 with SMTP id
 x14-20020ac2488e000000b005007cabefc3mr23998175lfc.11.1699367425918; 
 Tue, 07 Nov 2023 06:30:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a056000100600b0031984b370f2sm2499881wrx.47.2023.11.07.06.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:30:25 -0800 (PST)
Date: Tue, 7 Nov 2023 09:30:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107092551-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231107141237.GO4488@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, Cindy Lu <lulu@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> Big company's should take the responsibility to train and provide
> skill development for their own staff.

That would result in a beautiful cathedral of a patch. I know this is
how some companies work. We are doing more of a bazaar thing here,
though. In a bunch of subsystems it seems that you don't get the
necessary skills until you have been publically shouted at by
maintainers - better to start early ;). Not a nice environment for
novices, for sure.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
