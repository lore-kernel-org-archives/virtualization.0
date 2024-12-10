Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB4210F6A
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829009; cv=none; b=hVtaLILCfkcRisUn1oE3fdVV0N9Q3vXo8p0m1KqC0frhEPwmkvhVBEkApKVU54fAaLCmvvk3H3xhLGZbzbPEEkJKIeWHJ920etAs3Vttc3+t6/UHuAMeltsDzP9q0fj95KnaDF2aROAQJJ187mwIMzKoff7MjEZpC2q+D1hzFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829009; c=relaxed/simple;
	bh=FMEKrToJmfBes2IkIWI0FUbZrDzX9gRWI0fGcz6poD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3XNHzQLSgmLm7ULyWUyeZ6T77M1yyZ6kuVJwSLM9DbbITpvN4NIDtjab8piKkmzasTXGGpg2JekrIJ8lgcm+hrgwDoSlvaBmDlUNSqxkOhbls+sPWuj882iBb9n5S2P7Lp9ImplGPha+FdLt+uPx3HNQdU7n+SKrtV+Bv963d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWaxPpjE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWaxPpjE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90CCA6082F
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 11:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxelyGf2d1Is for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 11:10:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A77F56081A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A77F56081A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KWaxPpjE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A77F56081A
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUiqFq4GdwpAzAF+gSyIYQSFTlqcU1aOkiz1L8FVzVk=;
	b=KWaxPpjEaJ5TNziZqxawZ4e6YalXPyOL3uJbtDOseAxmoDel0QH26sTCnEgDPkSIU/z9AC
	b5WfigAmZbmdSoNPIB3YOwlfhEQXflNGyFzerD6fISTpd3mTbewisvqRQU5g0aoFXhBFE2
	X2Z/DiAMUqho7ehA4AFrCW47y0SlYQs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427--I_i-k-hP1CA6o0mW6nI_A-1; Tue, 10 Dec 2024 06:10:03 -0500
X-MC-Unique: -I_i-k-hP1CA6o0mW6nI_A-1
X-Mimecast-MFC-AGG-ID: -I_i-k-hP1CA6o0mW6nI_A
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d401852efcso2316690a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 03:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829001; x=1734433801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUiqFq4GdwpAzAF+gSyIYQSFTlqcU1aOkiz1L8FVzVk=;
        b=lkwP5UUoaeXSe4ii9ImrKvYAv3fV7A5wgqndWm/mTBJ9/h/lZbxayOSgi2t5s8p9Lq
         bm4JumdQhHNZ1kpUBySX8lisil899tPJefEXnqFOxtVESNv2rZhD9cK3X3O7R/BSTNnA
         wccms6+we84UHVkqGKDfjDNoD4OchxM6j87y/zuIOnWi0M+qKatfqMkddI41qY352DnA
         K/DfGGkq+ihiXDEF+u9BaqUGJFyLCuXdLrV/K51cgRIME/SZm0a81OOotVbCE2NItyAS
         k/fV3/QzhIxJO4iV2BslL1Q45wITzJuQL9KE+aZaaex4I7Cx2u23IBQL+EkcDed/NFt4
         QrSg==
X-Forwarded-Encrypted: i=1; AJvYcCXC/WTpXanIQpwwSiJgHDcrYq1KF5UqVoozOvjrk5KQeAhi5H/Lru8kUb7FTH0akLPCJ4lGG/+Lf5tEsal6OA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxw4VVQhz2UL7iu0Ura6Alb2U6Rd1LK66nOz1/DCmGPGLm69glm
	ZDn+ho7Pxz/Do6tl3aHUJfKL22+fwbqRLueXZk0HL+vLW5XAWLvOmj4FmU9su5kVQ6jCh9F7kTu
	1Wn7s54VKoxSEajzz2HekqNMrOF5uc3AUQnfV30XYvvtD5hPaYRCXlvMyLq7UVyi8WFUFUP1O2d
	R+JmSB1h1NUkiNKrBG1XguTS7taXEXvwl1Iqb7+chPSU1hWMMqdK35xA==
X-Gm-Gg: ASbGncvb5dgnxmN/lwwKonhMH0vHGCKFIwb+k7T+uNlSWJihUKAnjFbr00B4jwhrmsq
	+ahSJYPBij75KoWAwnElQgWHKZ11sS3j9PDn8
X-Received: by 2002:a05:6402:2115:b0:5d3:ce7f:ac05 with SMTP id 4fb4d7f45d1cf-5d41862e26fmr4233954a12.31.1733829001635;
        Tue, 10 Dec 2024 03:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaVJmbf9FsFzQlv76BIkK6pJvh123nB+XTw7CeGSQecbDCarRu6td/3KUmrwW2b7PdOi/34sbWrQxNNyd1r0o=
X-Received: by 2002:a05:6402:2115:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5d41862e26fmr4233925a12.31.1733829001213; Tue, 10 Dec 2024
 03:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 10 Dec 2024 19:09:24 +0800
Message-ID: <CAPpAL=zqL9qmaa=4XW8fu-nMgbh+LkDc1OUCfYOuYv7vVcp7rA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eYF7FxOwIGEdFkShmKy8TEksuabU-3lM2JZl3j5GEc0_1733829002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> The vhost now use vhost_task and workers working as a child of the owner =
thread,
> which aligns with containerization principles. However, this change has c=
aused
> confusion for some legacy userspace applications.
> Therefore, we are reintroducing support for the kthread API.
>
> In this patch, we introduce a module_param that allows users to select th=
e
> operating mode. Additionally, a new UAPI is implemented to enable
> userspace applications to set their desired mode
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
> Tested with QEMU.
>
> Cindy Lu (9):
>   vhost: Add a new parameter to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_worker_destroy()
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
>   vhost: Expose the modparam inherit_owner_default
>
>  drivers/vhost/scsi.c       |   5 +
>  drivers/vhost/vhost.c      | 194 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |   7 ++
>  include/uapi/linux/vhost.h |   2 +
>  4 files changed, 193 insertions(+), 15 deletions(-)
>
> --
> 2.45.0
>
>

