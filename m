Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5AAC0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 16:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA01D606B0;
	Wed, 25 Oct 2023 16:28:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA01D606B0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TxBRh4Gp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2KZswRWD6fQ9; Wed, 25 Oct 2023 16:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4868E606AA;
	Wed, 25 Oct 2023 16:28:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4868E606AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 191DDC0071;
	Wed, 25 Oct 2023 16:28:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D611EC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A958C40135
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A958C40135
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TxBRh4Gp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gMWQuI3GDY-n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:28:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25DAD400D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25DAD400D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698251326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7f29laoIijhonXA1qplGzkrij7Cw17Yg8oi2F3zZn44=;
 b=TxBRh4GpSSPBGUnRbHmmsBmYb5LsdA27vfLPeUEFUOsh7CZmh3T5d4Lsk6SJT7zs19bbPy
 IbKJb6NYgDar/ZGwbpCRUlimO1y8XBP6Uau8ITlZge1rGdvdmnJxAqTfjv6kFWmrGfn4ZI
 JupOSa7FWOjAIFgEVry6a+d8JaZ/oUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-1dUh4cFuMOKuI28R98fxcQ-1; Wed, 25 Oct 2023 12:28:45 -0400
X-MC-Unique: 1dUh4cFuMOKuI28R98fxcQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d933caa8eso2381107f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 09:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698251324; x=1698856124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7f29laoIijhonXA1qplGzkrij7Cw17Yg8oi2F3zZn44=;
 b=F8FACdAyQFnzK72lpPu4SE0f7/26u4qjUxsAieTHu9ALkD9n1FCeO0vdySB4aLKmU/
 SVhDA/BTuUl5lBH1APANZ/HaHDz7vs4CqHFL78KgiTr+huftltH1D+GvVAdBoSJW5AFF
 SpbGJ3iLAjhhL6FpUCsGVQyBtKaQ1qQlMyjjYxqRYvT3Kw4WmLH1z1yRey+J7sf4CEox
 55bQXsZy9bdGB9tsQN4R4sGLc4FpvkO4xpTt7FONUBdvDNYY+sU9iplZwMHpq8Yfwzwu
 vAOgRBXeoXWTyny38l8XTfa4+pYmsD1NLr3OF16oVUSiBXqs/9TzPRQ2udLM/9Z8S8sU
 2k0w==
X-Gm-Message-State: AOJu0YwjkQUsQnvQ8Pzm4OqUXCmZMNR7SQ2NqXtzQsgtKcPdxQRnh82V
 ZApRhQvrvI3zEuTcQ53qk3vzhEti6vfdm3I6dcXKNHFUlWZ2mmYIBXO8PGSO/NYK+2UqtkcsVA7
 Fdx3kXQlhi1H8XMriUN3Q3fTgUA4AW9balqTcGipkPA==
X-Received: by 2002:a05:6000:1109:b0:32d:a41b:bd47 with SMTP id
 z9-20020a056000110900b0032da41bbd47mr11542328wrw.59.1698251324165; 
 Wed, 25 Oct 2023 09:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwFCy0YoDnDfGZABBJQyL64nt6U4pb11zgcVmczDFn3yanVZ8VhqJb6BqWxJQhAbRpcW+bJw==
X-Received: by 2002:a05:6000:1109:b0:32d:a41b:bd47 with SMTP id
 z9-20020a056000110900b0032da41bbd47mr11542301wrw.59.1698251323829; 
 Wed, 25 Oct 2023 09:28:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
 by smtp.gmail.com with ESMTPSA id
 c14-20020adfe74e000000b0032d72f48555sm12387495wrn.36.2023.10.25.09.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:28:43 -0700 (PDT)
Date: Wed, 25 Oct 2023 12:28:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231025122625-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Wed, Oct 25, 2023 at 05:35:51PM +0300, Yishai Hadas wrote:
> > Do we want to make this only probe the correct subsystem vendor ID or do
> > we want to emulate the subsystem vendor ID as well?  I don't see this is
> > correct without one of those options.
> 
> Looking in the 1.x spec we can see the below.
> 
> Legacy Interfaces: A Note on PCI Device Discovery
> 
> "Transitional devices MUST have the PCI Subsystem
> Device ID matching the Virtio Device ID, as indicated in section 5 ...
> This is to match legacy drivers."
> 
> However, there is no need to enforce Subsystem Vendor ID.
> 
> This is what we followed here.
> 
> Makes sense ?

Won't work for legacy windows drivers.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
