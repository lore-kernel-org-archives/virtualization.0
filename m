Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F5CA6F
	for <virtualization@lists.linux-foundation.org>; Fri,  3 Jan 2025 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869014; cv=none; b=U/4OAx8lp2t1cGQvAf3A5SKMk6AV257FPOfcic6MJF42R5h/YZRwqIud+X8Y11WCeztXu2OSE8on9blosgwtvAD3tBBeMGb54qoWiJGJKAYb12yJalvybtpjoPI3qTyrRc8gg0e5iNYfYIA5KnykbWYHvSu9mXRjFKubUA8ekwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869014; c=relaxed/simple;
	bh=ugWlQcT2LvXutYN+EdP0XTdDZ2Af6oEJzyrnb6d7Lp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND4qgCY+BFy204/8QCkDvifXOneuEvZcQ28BPhxbzA01yjib9hvhqG25BqXdy68YNDTzGN6BIZhvp2xsTUofETiCjG4XcmOkDwxRof+MpbDKyOYT7XuRrKC6aHP0KKhj6SxIDISQ2maj1W0OEMHjdeG9FRnp1wEzp+P8WY2Zg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQWbpwId; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQWbpwId"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB48E60643
	for <virtualization@lists.linux-foundation.org>; Fri,  3 Jan 2025 01:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A0VS-tgNyWUW for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Jan 2025 01:50:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB54E60614
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB54E60614
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQWbpwId
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DB54E60614
	for <virtualization@lists.linux-foundation.org>; Fri,  3 Jan 2025 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735869009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcP2qJh46eUcVs5AZUyl+IUjPfN/SLun1H/+PvBG35E=;
	b=CQWbpwId9QuzvuiWoL250W65J/GCS9BQ2EfQbR7p87nCEGOQLlR7SxPi4Zk6qO6ir5H5ia
	BEQIEoYPzEiCy7gsE/S+FR2w9quzh8mtSnOUGSN+wcgU85KyaTQBZPqAp8rMDMZLxp3ifL
	nzjVGZtiWDJLNGf9l2WdLc4Bqu/LpuE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-0-M6RzwIOaaXHrTk1sKsdw-1; Thu, 02 Jan 2025 20:50:07 -0500
X-MC-Unique: 0-M6RzwIOaaXHrTk1sKsdw-1
X-Mimecast-MFC-AGG-ID: 0-M6RzwIOaaXHrTk1sKsdw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d88d37abd0so5223415a12.0
        for <virtualization@lists.linux-foundation.org>; Thu, 02 Jan 2025 17:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869006; x=1736473806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcP2qJh46eUcVs5AZUyl+IUjPfN/SLun1H/+PvBG35E=;
        b=cC7TFhEgk1brxKNfTexE3JOwaQ/c/ogoGaLeIY1v/0SzTyLj/aXXc2XgBByuEEb69U
         fh0pzk8mZ2nypTfz1Vd7gwwhvvapJKs6xGhzWRTZsbIlxxIcZs9N/zj/B3llpCo8Bdw1
         zC1fe3dN00NYkzfAaBC/jHFe8Y7AxaN/ujuq9Po7rScg+puZJinOcI/SQVPJhf4sydaY
         6r8ykJNM3ZCLxEhfyH/rNbwZFlPgoqERv3IuIpczy0YnZW5HeWXnDP8Tahl/TGl8vnsJ
         E8+N0cXWDjQgvQmrpLLgLjMzlr8arD1Q8afJBrv4d8sbo7nJwsfTZhuu7hQRs4ANxs6I
         xoPg==
X-Forwarded-Encrypted: i=1; AJvYcCXztFoAxfNBC+gE4kcnEAM1cp3fAUNQBZqP2rA9oQ7OdWCNTvEXgUhl2l0Ead70jCBF26kf5KJ6GGnlm1g17Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxL+lsmfiHhxNVB9SDDftySYdnetxpWImQixHEHX8NNZpmmTYLE
	SJ1rfKGUhzyOHykNL+ibv9lylk5JfoJJFcLUJT3dv7wmI8KLbqq+SYtoachRgEpRG726SGPGPZc
	fakuZWomUVxvJxGh9fP6oSTS74b8KHAge8g39gHzlX7s0RzMEvGRGhPvLYWbmJW3enR1x1fW2hC
	3AiTBxfkZpkzTmYG3/dt5ii/GO7HezCgVN7QrX9B4u+8uy7JyqQn7K2Q==
X-Gm-Gg: ASbGncuA59thyzygf/nUAwlZ4tAM1r3Zj2g3fWVz8+r4nrAQhFpNCBXIanx7eo4D7b0
	YcO85hjdcVwSWJbw5b4abI+pIqFpjpZhlJxJBe0k=
X-Received: by 2002:a05:6402:430f:b0:5d1:2631:b88a with SMTP id 4fb4d7f45d1cf-5d81ddacf87mr33437950a12.17.1735869006457;
        Thu, 02 Jan 2025 17:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8gbSec5MrA3LDch29C5XkdV12IqVhzmcGZKBUwF2Ovv/WSVZhgrXSG3lcLmKAzES5YNxhp1Ov1bT+JGQANA0=
X-Received: by 2002:a05:6402:430f:b0:5d1:2631:b88a with SMTP id
 4fb4d7f45d1cf-5d81ddacf87mr33437939a12.17.1735869006114; Thu, 02 Jan 2025
 17:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 3 Jan 2025 09:49:29 +0800
Message-ID: <CAPpAL=xFoJF1NiD3vbD56R+2voNOA=1m_un6KNEB9JjUPvAkZw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uM-CqnYqRUGMkPcwTM2S2m-oAR4gadNNt3aZ7wnmoK8_1735869006
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series v5 with virtio-net regression tests, everything works =
fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Mon, Dec 30, 2024 at 8:46=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> the vhost now uses vhost_task and operates as a child of the
> owner thread. This aligns with containerization principles.
> However, this change has caused confusion for some legacy
> userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> In this series, a new UAPI is implemented to allow
> userspace applications to configure their thread mode.
>
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the defa=
ult value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the defa=
ult value is true.
>  2. Add a structure for task function; the worker will select a different=
 mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
>
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function po=
inter in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
>
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to vo=
id.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add worker related functions to support kthread
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
>
>  drivers/vhost/scsi.c       |   8 ++
>  drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |   4 +
>  include/uapi/linux/vhost.h |  19 ++++
>  4 files changed, 192 insertions(+), 17 deletions(-)
>
> --
> 2.45.0
>
>

