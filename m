Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F731D516A
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975978; cv=none; b=XZQLkDKuh3j5z1WNX5gXxRSP2bgrLagRVGJYM1XbkjfHBKEqw9u4vcH//NasYpw5gsJSEcAjMdgOEqE6wK3YsKNMZ0QESLZayTVHhdg4qUsu4rz2jUxYD84fIjfvZMkGILEzjNvvfgEIsw+ZNfI8cEEpjHs9376dLJTd+f53k9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975978; c=relaxed/simple;
	bh=C5iL4+UgEfYtFgc0oU8GEsbInCv6xJrYflTOLd9mLlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/uULfHC6ey0athQDtfmxeUK3Fwz/eUsrh8RKEsFikl/wAtZYDYzhMmjkPm9lSrnoibGRecTfcnopn1ahZ0Z5KzAkI+GAD+z7cMpHggET2jBa9xzj5eHb83qKIK6V1B3ZMy4xc+7JZN35ou3cw5U/AALuMBg7gmlhCSmAxdzuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsLhjoyU; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsLhjoyU"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF49981401
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 04:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPj2eZDMGMc3 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 04:26:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F9E3813BA
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F9E3813BA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LsLhjoyU
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F9E3813BA
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 04:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740975973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5dSGTpmLn97joWduARVp0cs22gFzxB4/mv/r4vqwy8=;
	b=LsLhjoyUTfXwLuCQJUhkN2qQuHYKwhzjFRmhXRujSUG5fAPhthskqrPm7gCRY3BTU88Koo
	QOTtbZ0bttn9J0fkH+2eh1JXRebH9mzGYal/mAP4fwQeqRCzogyvFR3zCs3SCFI/IpOr3T
	kqh0AV61ejkBSPGhX3paqYRW0EpX5g8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-AJGm1u7YP-y865MzRTb_bw-1; Sun, 02 Mar 2025 23:26:12 -0500
X-MC-Unique: AJGm1u7YP-y865MzRTb_bw-1
X-Mimecast-MFC-AGG-ID: AJGm1u7YP-y865MzRTb_bw_1740975971
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac1e109f006so11932766b.2
        for <virtualization@lists.linux-foundation.org>; Sun, 02 Mar 2025 20:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740975971; x=1741580771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5dSGTpmLn97joWduARVp0cs22gFzxB4/mv/r4vqwy8=;
        b=PUdrC0R9+JEknMDWS3eAtLGGCQDpeDPsfgtVf1maNV7A+BTNfNGzW6BEoeCspRZSOB
         yVfNYcJS2lhgYL2DTqN861rkZFS97GcCLlU2oX44uH9F92fSeqDMgb+r024skxPZGVPI
         Bv4T0YZoE0KKxlXG6kJgTNbk0yhLi3up7SGrCNA67nMgNkwBURLzW/+ZPppFe3vWRswT
         UYYzGjy5/hwOkNe0TIMaUHEuUjfUWtBwaUAp7BrDddwFY8sSLRZI03PCBRu0dGddeDkD
         mWdtCmXJy9FgxN7pt++pxjUPVBl12qMTYSceb4jdtYCFZi50PR1k62pe7ZFfUizz9sn8
         R6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWT4iSfJuHLWUdpS64DX4JsqLhDMvlT44NcEHBLSJI5d1dhmRpvb7iMk/O5pY0xQ10FgNOa2DaZMloV6cG/Hg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzZ5CStCPJpdtNA8049+z/6t/ycvepRhTLMc9rKYGUfSfJCWbLy
	ppZqhDqa9bLl3+6sG0WdCiV+gCQK1fPKlNljlcBQwSRqmftOZfW/siO6IWJP2DihYvO2C1eBhEd
	kfQzBQh7/PdN6x8IRImRADLoFwgbK1jv7JWoAn3kG5xMD/eDPN4qjcx1psiAWyGCsY1R6c0XaZv
	F2U44WHxwHbePIctHAm3hIQAgyaw1vkcXAMaKjA7Ur/vuuEInbq2C03g==
X-Gm-Gg: ASbGncsMHQ/v+TArCP7DW5Frt1lQLjtAh79IenQjV9pofl9KpWcW6hMHK5s8Fl9c8Y+
	h+R97Ey09iXzxjQdWnQdOzto/Y7h4ap8uvKmo61zgd1Wf3EYk1seFTOUVvR5v9YmrHirl4ZTKUQ
	==
X-Received: by 2002:a17:906:f587:b0:abf:7a26:c470 with SMTP id a640c23a62f3a-abf7a26c65emr198736766b.51.1740975970952;
        Sun, 02 Mar 2025 20:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0DZmam62M33CFchi6Iot8/yKD5WtjQeX8AZY42o8lCmFpVtXhHd6dmyoN1uMg3/AghFVz73sYvs21PnyxwaA=
X-Received: by 2002:a17:906:f587:b0:abf:7a26:c470 with SMTP id
 a640c23a62f3a-abf7a26c65emr198735166b.51.1740975970622; Sun, 02 Mar 2025
 20:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Mar 2025 12:25:34 +0800
X-Gm-Features: AQ5f1JrtDM4meGmqZ71iruwsh2y39gPiEVFEaxe4BlZl8h_Xwrnd5iQqMoRKc2E
Message-ID: <CAPpAL=yGBNWYCCEKi049_yBQs0QjSCCA=AjiT-9NoMZikCOKjw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6glCKHRuRTSdsi-VUzSNkXo_sTg-Ee8Nj8M4mFzPA-w_1740975971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Mar 2, 2025 at 10:33=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM=
_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner s.
>
> Changelog v7:
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops an=
d add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (8):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Introduce vhost_worker_ops in vhost_worker
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: uapi to control task mode (owner vs kthread)
>   vhost: Add check for inherit_owner status
>   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
>
>  drivers/vhost/Kconfig      |  15 +++
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  21 ++++
>  include/uapi/linux/vhost.h |  15 +++
>  4 files changed, 259 insertions(+), 19 deletions(-)
>
> --
> 2.45.0
>
>

