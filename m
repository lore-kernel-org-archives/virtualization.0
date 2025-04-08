Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436E265633
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105610; cv=none; b=erRtsy4G1p4hik70eKEkn7CEgc0jYmWRbhhVUwf4cXItoetzg4YLn3OBNbtRuTTkfYbS1l2Bu7koTfcwbMx/ubcbWUUEaEogEEaqVSXHLrv452VjvShN7Og3nls3jy+8xf6KdxrTByqVT/e4jl5VQIU9My3SkfMOn68CiIu5iaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105610; c=relaxed/simple;
	bh=kFJHApLzkjjQTZd748UbOGNjaj3R6uugruxTfXbZkHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcS6vcJqpkegQvysJJ0DPnq7MRDbrdrT57rLvwfMnitRY59XymfS88cE4Lh98OmlEgh2b0a62aUGcZWiFcmqs5EvEtCAWIDoLghvp2fsNxobGV1GGt4J7G8QLH9vAYNpgX7yFxehDdf1uk24esCI1t6y7s0dAuTtxC7C2DWoTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkA6KqER; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkA6KqER"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD559610DA
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 09:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zR9xOcLh-DPR for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Apr 2025 09:46:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 42241605A8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42241605A8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PkA6KqER
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42241605A8
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744105606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFJHApLzkjjQTZd748UbOGNjaj3R6uugruxTfXbZkHU=;
	b=PkA6KqER8YJkXNODKomHLkiuSyNXmuuEhloqMqqb9n18Hd6LQoXUEW0nqzn2m5RBzj6ZPl
	frrhwOIZRTtQiML9ZngGhmPLoBWiehrSPIrb9n3QByp9pXQE6xtKGCI2S78R0NixYRXXCy
	LZfT/eZQalOyzYNF8K/yOnGVPm50Rgg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-xQ5Y2mSAO-Co8gtmQmzH3w-1; Tue, 08 Apr 2025 05:46:45 -0400
X-MC-Unique: xQ5Y2mSAO-Co8gtmQmzH3w-1
X-Mimecast-MFC-AGG-ID: xQ5Y2mSAO-Co8gtmQmzH3w_1744105604
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4767348e239so105368591cf.0
        for <virtualization@lists.linux-foundation.org>; Tue, 08 Apr 2025 02:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105604; x=1744710404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFJHApLzkjjQTZd748UbOGNjaj3R6uugruxTfXbZkHU=;
        b=Dqh7VrTKs2SKBQG30ZTAGrCCNpciQjeTns5CLPYMzNjxadl+RJxAqlbMoOEhoJiCSY
         0pKcwtKnzXlFNt5Qef7Z1UIB9iRcRvufNanh6EW9mHk8QpiAZZvcA58xj6EZx99ZEhw7
         0uqqg9fxm0GPUK6EeOaRFkH7FGGMwtCk6P3Fhvv2J7e4ZOD5EAswp9nHcx7z+8hZRcyY
         k+7MRlyELqBsOOnKNKPBnK2tQ0ZIBIyFk9CblDuralPCxKFk3UA55Ljs1c7DbYtfTu/+
         wqcFha6Cm3kJvjhizneE9GoIkyGrMx5uz1Kobia9vctRTLJGVRCP6SK6bCi8vm4nA+en
         JanA==
X-Forwarded-Encrypted: i=1; AJvYcCUSX5wi2GFhEGd79hdnCTM/7pLqmwFBV/zSzfrfsDhPGTS0FnETr+w6ShCvJ7wSOFhIOdFDatceDihf+/E51Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwXcBtwiAqaH6hMtXO75QMNFuOlf4HMDzuuj8Ib6UayrlKVh+JB
	xjBgd3f1IR/7TGoOB7dJNDLfrsXYYjLUPxI02OO13aR+/s5HHJUZXJlYoUbSJgZqz0mngX3cJRT
	fB9V62draxH2Az+p1UvMWEGKqMVhEGm9/+XG7hrqjEPy8tIpUB6PqH2odvJ0mr7nkQAJZ8pGp6t
	FxOv9GQ0u8hCSLtgJGgljJk0LAPwhEC70xFchxcWmHLia/CHpGZDLZgQ==
X-Gm-Gg: ASbGncusk0GNagK/3oG4sj1PYu9PGNaNlbLZD9Q+LVIByIfJbrPG9W+2oAiCh4AwtNL
	Oii3Dydxwa4utFduxlLqIIvlYmQj+VtpLEnri3TFqyi7PLM6pEgebvOygYVQqX118p33yKcZ/RQ
	==
X-Received: by 2002:ac8:5987:0:b0:477:4224:9607 with SMTP id d75a77b69052e-47930f92246mr194565671cf.12.1744105604569;
        Tue, 08 Apr 2025 02:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUGe1WMgdw3266Ixamciimi7c04VwM13sorCvBAziX4GsTGnRMZpS8YF7Y0r3w9ErgRv4v1FDTdG6BwI33w3U=
X-Received: by 2002:ac8:5987:0:b0:477:4224:9607 with SMTP id
 d75a77b69052e-47930f92246mr194565531cf.12.1744105604319; Tue, 08 Apr 2025
 02:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-5-lulu@redhat.com>
 <20250407041540-mutt-send-email-mst@kernel.org> <76a7e782-6a7c-4704-b7c1-2459254c1362@oracle.com>
In-Reply-To: <76a7e782-6a7c-4704-b7c1-2459254c1362@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 8 Apr 2025 17:45:58 +0800
X-Gm-Features: ATxdqUEdI-_9frRvmATT_TQ83vcEeyygOtNToq3q3kw5ZPITDti5dWdb32chlc4
Message-ID: <CACLfguXfRvLLiCF7ysidPLcn7GftU1Jyuem2Q9xr_SMGnP_16A@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IgrETJ6bVN9YCvPnOFsa6Wx5VTPc6ERYVNaw3aHFmow_1744105604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:06=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 4/7/25 3:17 AM, Michael S. Tsirkin wrote:
> > On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> >> Abstract vhost worker operations (create/stop/wakeup) into an ops
> >> structure to prepare for kthread mode support.
> >>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > I worry about the overhead of indirect calls here.
> >
> > We have the wrappers, and only two options,
> > why did you decide to add it like this,
> > with ops?
> >
> That was from my review comment. Originally, I thought we
> could share more code. For example I thought
> vhost_run_work_kthread_list from patch 2 in this thread and
> kernel/vhost_task.c:vhost_task_fn could be merged.
>
Hi Mike
I guess you mean function vhost_run_work_list and vhost_run_work_kthread_li=
st?
sure, I will try to merge these two functions in next version
Thanks
Cindy

