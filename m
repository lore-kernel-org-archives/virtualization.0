Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97661C7EE43
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 20:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20714610E5;
	Wed,  7 Jun 2023 20:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20714610E5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXhTQEck
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WAcvsAwA3fPL; Wed,  7 Jun 2023 20:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 170EA60FE7;
	Wed,  7 Jun 2023 20:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 170EA60FE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE66AC007A;
	Wed,  7 Jun 2023 20:22:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 632C8C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A392405AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A392405AE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXhTQEck
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nM__uziGS6F7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5D0940558
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5D0940558
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686169360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJaDw9PIKzzmjubjaxdp/mu5TOsNNzSJfWAKsgK4+ks=;
 b=PXhTQEcklp6/tb2l2MBt35rUxeFibj9qIREBKswHtWIXQ6fScyzWtByCQ8oLq5atQ4oyyM
 TtdkJMYrY735ADN2EDKwi9Tfle7Q2jInTl6L957bSQ8rfEasSC440PWpgWdcEAtVuFQwNK
 /AN8knaK/9bgnsC8ziUnsY0tTU74W04=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-c4hkwltmP2KuWWbK82n42w-1; Wed, 07 Jun 2023 16:22:39 -0400
X-MC-Unique: c4hkwltmP2KuWWbK82n42w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so37025945e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 13:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686169358; x=1688761358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJaDw9PIKzzmjubjaxdp/mu5TOsNNzSJfWAKsgK4+ks=;
 b=ISrD/jlZBpRo282OA26sg0QEF9qMv0OHnG4uCl2gi8cKLY1IxyNh96S9sNXNz0htIE
 6RTS/OxDhVHwmxZ1QgmjAKDrp8Gt+yABlZ2gbv2C369AO/peQRXKnlym8atpqtBinYrM
 P6r5gp3T4O52Jour3s2WX1zIrlqOZmEZuxJV4faPCoePVhN7l5Ku9wYOsqlS6ocV0MVT
 6SXuXPqa+URas1q8TL3OdBMHk5jMCtchOx64YSV1dhCuQ2aeOwyD/RswbA5kZ4fFI3mL
 AuMQVuCt//UG7KPwoux5t3pK98r31T8/O1zOfvQgHu7yUg+RBGwuTjwOOYB9nCS1J68T
 xBgg==
X-Gm-Message-State: AC+VfDyqBDuj+egDhUngz0bJ/WR2Qkp3cXulQre0WR4lnTyNrnJcvp7z
 HBSBSvChEVq847VZQDh2VAtisEyQGzjIFYckVAr9OuOaQ3Kgw5qaleQfmomMWpJvwPkSu8Kh6zO
 Q9LYAcz70wHdqTjlmoltX6fm3SO59BkUVUcsYmwmraA==
X-Received: by 2002:a7b:cb45:0:b0:3f5:d313:db68 with SMTP id
 v5-20020a7bcb45000000b003f5d313db68mr5363564wmj.5.1686169357921; 
 Wed, 07 Jun 2023 13:22:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66+xyiRRvxo34cOUfBgk5HPO46o6l93XV7jcpQzah2P4VV9VJ7YL4jKNgHssRHMH5QsV66rA==
X-Received: by 2002:a7b:cb45:0:b0:3f5:d313:db68 with SMTP id
 v5-20020a7bcb45000000b003f5d313db68mr5363555wmj.5.1686169357656; 
 Wed, 07 Jun 2023 13:22:37 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 21-20020a05600c025500b003f78fd2cf5esm3229126wmj.40.2023.06.07.13.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 13:22:37 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: vhost: Fix vhost_task regressions in 6.4-rc
Message-ID: <20230607162028-mutt-send-email-mst@kernel.org>
References: <20230607192338.6041-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230607192338.6041-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Wed, Jun 07, 2023 at 02:23:36PM -0500, Mike Christie wrote:
> The following patches were made over Linus's tree which contains a
> vhost change missing in mst's vhost branch. These patches fix two
> issues caused by the vhost_task patches:
> 1. I was setting dev->worker too early and this caused crashes when
> vsock would queue work before VHOST_SET_OWNER.
> 
> 2. The patch that Linus's tree contains which vhost does not yet
> have converted vhost_tasks to use CLONE_THREAD. That required a
> change to how we set the task state, but I completely messed up
> and moved when we set ourself to interruptible too late.
> 

Right. and that's in rc5 yes?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
