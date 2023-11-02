Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A2C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 19:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D627824E2;
	Thu,  2 Nov 2023 19:00:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D627824E2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K9S2d68G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaPOQOlieCPG; Thu,  2 Nov 2023 19:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02AD4824EF;
	Thu,  2 Nov 2023 19:00:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02AD4824EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8332AC0DD5;
	Thu,  2 Nov 2023 19:00:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B86F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 19:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74AFA43541
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 19:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74AFA43541
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K9S2d68G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9G8NXEb6C_j2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 18:59:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0271943549
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 18:59:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0271943549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698951597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEm2sns0/+Gc/wAqvpwT2aL5eohIrGGeBjAVrS1qrIg=;
 b=K9S2d68GxUV1MPcAih0FHh3RY6kw+/DuIy+BdKcVSc0CW8yT1HTjJ1kocC4PvlPtGMAsPV
 uxF2mmE7aS86MmTg4JVvXp2jL6AXjYEbnOy/NFHQVa5m8UV2k8dNV1ldwRIUVZyofCbFHX
 397g7W5Nw4X5mED7x1ZJd3m/TLEjnyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-nIc9Z2x5NSWzwL-ivYaN8w-1; Thu, 02 Nov 2023 14:59:55 -0400
X-MC-Unique: nIc9Z2x5NSWzwL-ivYaN8w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084d08235fso7998415e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Nov 2023 11:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698951594; x=1699556394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEm2sns0/+Gc/wAqvpwT2aL5eohIrGGeBjAVrS1qrIg=;
 b=Fk5xMGaTB2h5Pd+IwWCJ0DvxMJnqiYRxK+FJ8ZkmOQVXcPgO+ufJEEzCheCGV2z8AN
 G72kZy8AFxzb37Z2mY/yYwEatKZTAAqPjJ/8kEhhTFgiKK0x9LacyhYeDbdeZyoeOeyc
 W9zO5zf0pTk1F3yORy2frkMKrKfrzjxWZWtQ8Ac7pCxh6acgETwNzlSVMXGPJ2vwIcGc
 +PETjVgTdV+mK5JsNmkbsNgESibBNU6fQydhKFtgZzYaydXtm68H2oo/Sv61cVKkWGOu
 eyF3dZpxudc7FlrY7+wvCeClULoCZ+ir4Yh3ZlG8XQ384LfePnF+PMApC2HbPGM/XNyB
 psxg==
X-Gm-Message-State: AOJu0YyKFd1xT6lT3FkFOU2SVx1s6Zltukgv2nHGevXcVYw6sXQY8uiu
 b4VbPfh41uJl5/0SvnGfBuzXEyB+pUFRrzb3v8zl2TYU+yFtcnqkWoxyz8kHzlYDDPrmzjvTSnw
 oh/Od/dlLHuKLAy20QfW3kxeLcIJ13XTgd58GDPmeJQ==
X-Received: by 2002:a05:600c:354c:b0:408:4cf7:4f91 with SMTP id
 i12-20020a05600c354c00b004084cf74f91mr16063498wmq.16.1698951593776; 
 Thu, 02 Nov 2023 11:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVTJzaSJ0vkl4qcwzTZ0JUe1Z1QgiS+92pttSKu/xQqyJpNN5GsaGvuUhusOPQ1kxeMxjXtw==
X-Received: by 2002:a05:600c:354c:b0:408:4cf7:4f91 with SMTP id
 i12-20020a05600c354c00b004084cf74f91mr16063485wmq.16.1698951593366; 
 Thu, 02 Nov 2023 11:59:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00405c7591b09sm31517wmq.35.2023.11.02.11.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:59:52 -0700 (PDT)
Date: Thu, 2 Nov 2023 14:59:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Message-ID: <20231102145932-mutt-send-email-mst@kernel.org>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <c8f189e6-c79b-429a-ab36-2193bb68e3e9@schaufler-ca.com>
 <923f87a1-1871-479e-832e-db67b5ae87fd@redhat.com>
 <64626db9-e37a-4c65-a455-fc3985382216@schaufler-ca.com>
 <7524dee3-7c48-4864-8182-1b166b0f6faa@redhat.com>
 <b307ec62-7cfd-4a58-88ef-ea549c64e75e@schaufler-ca.com>
 <76572500-5f90-46fe-9bf2-b090bf1b616b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <76572500-5f90-46fe-9bf2-b090bf1b616b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, paul@paul-moore.com, lulu@redhat.com,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org, jmorris@namei.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>, eparis@parisplace.org,
 david.marchand@redhat.com, stephen.smalley.work@gmail.com, serge@hallyn.com
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

On Thu, Nov 02, 2023 at 06:56:59PM +0100, Maxime Coquelin wrote:
> 
> 
> On 10/24/23 17:30, Casey Schaufler wrote:
> > On 10/24/2023 2:49 AM, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 10/23/23 17:13, Casey Schaufler wrote:
> > > > On 10/23/2023 12:28 AM, Maxime Coquelin wrote:
> > > > > 
> > > > > 
> > > > > On 10/21/23 00:20, Casey Schaufler wrote:
> > > > > > On 10/20/2023 8:58 AM, Maxime Coquelin wrote:
> > > > > > > This patch introduces LSM hooks for devices creation,
> > > > > > > destruction and opening operations, checking the
> > > > > > > application is allowed to perform these operations for
> > > > > > > the Virtio device type.
> > > > > > 
> > > > > > Why do you think that there needs to be a special LSM check for virtio
> > > > > > devices? What can't existing device attributes be used?
> > > > > 
> > > > > Michael asked for a way for SELinux to allow/prevent the creation of
> > > > > some types of devices [0].
> > > > > 
> > > > > A device is created using ioctl() on VDUSE control chardev. Its type is
> > > > > specified via a field in the structure passed in argument.
> > > > > 
> > > > > I didn't see other way than adding dedicated LSM hooks to achieve this,
> > > > > but it is possible that their is a better way to do it?
> > > > 
> > > > At the very least the hook should be made more general, and I'd have to
> > > > see a proposal before commenting on that. security_dev_destroy(dev)
> > > > might
> > > > be a better approach. If there's reason to control destruction of vduse
> > > > devices it's reasonable to assume that there are other devices with the
> > > > same or similar properties.
> > > 
> > > VDUSE is different from other devices as the device is actually
> > > implemented by the user-space application, so this is very specific in
> > > my opinion.
> > 
> > This is hardly unique. If you're implementing the device
> > in user-space you may well be able to implement the desired
> > controls there.
> > 
> > > 
> > > > 
> > > > Since SELinux is your target use case, can you explain why you can't
> > > > create SELinux policy to enforce the restrictions you're after? I
> > > > believe
> > > > (but can be proven wrong, of course) that SELinux has mechanism for
> > > > dealing
> > > > with controls on ioctls.
> > > > 
> > > 
> > > I am not aware of such mechanism to deal with ioctl(), if you have a
> > > pointer that would be welcome.
> > 
> > security/selinux/hooks.c
> 
> We might be able to extend selinux_file_ioctl(), but that will only
> covers the ioctl for the control file, this patch also adds hook for the
> device file opening that would need dedicated hook as the device type
> information is stored in the device's private data.
> 
> Michael, before going further, I would be interested in your feedback.
> Was this patch what you had in mind when requesting for a way to
> allow/deny devices types for a given application?
> 
> Regards,
> Maxime


Yes, this is more or less what I had in mind.

> > 
> > > 
> > > Thanks,
> > > Maxime
> > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Maxime
> > > > > 
> > > > > [0]:
> > > > > https://lore.kernel.org/all/20230829130430-mutt-send-email-mst@kernel.org/
> > > > > 
> > > > > 
> > > > 
> > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
