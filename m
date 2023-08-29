Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370A8C83F12
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 17:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A19A66112C;
	Tue, 29 Aug 2023 17:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A19A66112C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMBNjZIT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUPBiuPq2E0V; Tue, 29 Aug 2023 17:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 35355610EF;
	Tue, 29 Aug 2023 17:05:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35355610EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 076A7C0039;
	Tue, 29 Aug 2023 17:05:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CD95C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 17:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A54541511
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 17:05:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A54541511
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMBNjZIT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1olbOsJ2Mhy1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 17:05:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64C4B4149D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 17:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64C4B4149D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693328742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wp+lO0Za9L1acZGmo62Fhb05kvKx8z5CE6eXi+DCnBs=;
 b=dMBNjZIT6gOMdczQBlPnDUsRDj6O+FwZC4tFi2eQpm9Yxk3kCz2KFKfh1ZMtXmXbxJiCAK
 Zj4NPo7LLEJ+o2cpfKTdpKNE+SW9SJ+uXOwR1TgdBSUFy40UJSlLMShAW1ttpL31jChplv
 7aRyI179175PU81nwFbHNfUorVt+urw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-3cxz6fAoOAqiQ8mQbjdVYA-1; Tue, 29 Aug 2023 13:05:40 -0400
X-MC-Unique: 3cxz6fAoOAqiQ8mQbjdVYA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a5c0f8134eso125412866b.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 10:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328739; x=1693933539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wp+lO0Za9L1acZGmo62Fhb05kvKx8z5CE6eXi+DCnBs=;
 b=lQQnJ+c9LaKhcIwU9z+VdkBjOlND0ZEJm64fPqSTsEzXcci/kBQhe4DJYNmiIUecaw
 C6R2zAf062pez8qwZWDSWVYG3TcM+80lfqRPwHQWTwCrvN7u9QZXTNgcs5ikFVyrV+Qc
 o3/JDjumt51fAj1w7Pzjk1dLuzU90IwkxXVJ7YWm9LbkAIr4e8DpxYtoIpXARrBm6Ko6
 zDsmHYv9TIeb+KC7GOSYaT8s1n9n2X2r+NHcx3ayJBg8Zi7Lm0LBPOPNAy8/ATZoa62V
 qfmfKkO1pqTovre4B3wo7u7cPio5cqnwWmpOc3h9PLNLHZcQUaJhh9YuoCp6fuif/5S6
 liiA==
X-Gm-Message-State: AOJu0YzG/2YZxGQKS3jCUQ7ndRL3gxVk718dApnxeZ/4mJM3PYzzj9u8
 V9ixXMmbjNN/eZyK9r8zVzDJVOu5qLX6dtMRnMYLR4SHsqo9yKuq47iaoEejezCUhYf/DuyDden
 tsx4USBTqjxZrhUa4LP47S/Ha+3Z6pQxmq69xQJzDLA==
X-Received: by 2002:a17:907:2ccc:b0:99c:c50f:7fb4 with SMTP id
 hg12-20020a1709072ccc00b0099cc50f7fb4mr22020869ejc.1.1693328739785; 
 Tue, 29 Aug 2023 10:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUG9QCLSRWNIOZmLbNMXZrQdhj8bqgWsaIjevUAoHBLvB/ItbfFf7wUUc51DKfYBWhoiJfog==
X-Received: by 2002:a17:907:2ccc:b0:99c:c50f:7fb4 with SMTP id
 hg12-20020a1709072ccc00b0099cc50f7fb4mr22020850ejc.1.1693328739454; 
 Tue, 29 Aug 2023 10:05:39 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 ju26-20020a17090798ba00b00982a352f078sm6146254ejc.124.2023.08.29.10.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:05:38 -0700 (PDT)
Date: Tue, 29 Aug 2023 13:05:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230829130430-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Jakub Kicinski <kuba@kernel.org>, david.marchand@redhat.com
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

On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
> 
> 
> On 8/11/23 00:00, Jakub Kicinski wrote:
> > On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > > > Directly into the stack? I thought VDUSE is vDPA in user space,
> > > > meaning to get to the kernel the packet has to first go thru
> > > > a virtio-net instance.
> > > 
> > > yes. is that a sufficient filter in your opinion?
> > 
> > Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> > and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> > experience with virt so no strong opinion, perhaps it does make sense
> > for someone's deployment? Dunno..
> > 
> 
> I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
> devices, as the device could be attached to vhost-vDPA and so not
> visible to the Kernel networking stack.
> 
> However, CAP_NET_ADMIN should be required to attach the VDUSE device to
> virtio-vdpa/virtio-net.
> 
> Does that make sense?
> 
> Maxime

OK. How are we going to enforce it?
Also, we need a way for selinux to enable/disable some of these things
but not others.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
