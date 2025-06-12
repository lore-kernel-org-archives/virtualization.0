Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F991F0E39
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708799; cv=none; b=Zad8uKrQeTJRxcgzXJajvfS5FnlEwqFR/yinPjCOWh262CYQygGZz0lTOlNMxSXnD57eQir98bbj6GfTFMM81JrHVHx/0AxLfhp9j9wj1qul7CDBUiVfxIo/4vGgV0NHBQzUHiFtXWVR+5oFi8QsncWJKaY0DC2h3SO7BrAhVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708799; c=relaxed/simple;
	bh=EJKWY9PXO9AEb/f1L2N3iMJtGt3gECQJ/G5K4KX8CuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWBtyC1sKlIxXIOFwElyI2VpnFplNE97JTQatk+ApzAiNSPxKSLvC+V8vjbLBmQMru4gzZFkN+uMsiIWNdHDZdvPdb0olacX12pj79H59j1kE5fWVK7/AxW8Cgtxmi6/LeYUxUTjLKeh+4JnbVC2oOi+I08Umwm9oPuqt5zgUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/hKtq33; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/hKtq33"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2C47406D2
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctWYDsNDHQnn for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jun 2025 06:13:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3A199406C6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A199406C6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/hKtq33
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A199406C6
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749708796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=In8v1EfpVjcg2E248nCE4I3xXAAON+cdnDkylyyJFH8=;
	b=I/hKtq33tqeRJciOT7PkDckL4+FUPoeNpsmDwdBY8nv+FrKeFtLBWnLF4aQ1QCe08Bq1WH
	wfe7ZaFYpKmgVplylJLvOFjZlbW7Lgse4QoW+PBEg+CqFhE61y724qTLwwEtgdeBCUaetq
	vSdU+x3fvgglP2n4M7zh7UBh6hbVN+M=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-3wC9Z2V1Mpu4jYSSuP09JA-1; Thu, 12 Jun 2025 02:13:14 -0400
X-MC-Unique: 3wC9Z2V1Mpu4jYSSuP09JA-1
X-Mimecast-MFC-AGG-ID: 3wC9Z2V1Mpu4jYSSuP09JA_1749708793
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74858256d38so468236b3a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 23:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708793; x=1750313593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In8v1EfpVjcg2E248nCE4I3xXAAON+cdnDkylyyJFH8=;
        b=QXmH96GKkwx0kefSwrnLsbOgQl1xGmSGVWfeO6PFaDb+RwUSbOB7LFk2gtZ8m+Ixfg
         KEFV4T+qhNDcOI0p9Oo+bTSp5CeYlALSOPMcXX/kmwB81vK+QbVSzApZrRTCFZATrsgz
         3dks/o6fFbAkFnJtRZRLhxAn4J1g3WEngjKGoPgQSkweo8FxNjWJB/kr+664r8/nIhfY
         Y9TvQCQxUOS4BJlFISVRCygEfquZ7W0uaELmkMso6Ljw1qtWhbfc8KEDZOqLVVw8zVmN
         hMPY1e7127/MouaQV/lBlf1mZQhlW+EnazlR8ZWhL1axfcEtK8WyTnS12QO8BeMvNUmU
         Axsg==
X-Forwarded-Encrypted: i=1; AJvYcCXb1XAUkJLrCNzMqM8igfA7vF2vTIXSPtkf+6qtAOyVof55bS6AkMfVa8za0X7OXSogxL+/i3iSxcwo6y47bA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxgdXX3W5qRhCmuLPrZrnUY0wAReyhF3mBTVoP+PHL5jfVRlee3
	CvbsB+5jyi2BLPcBDzEnXQ1CIWhvfZNKV5Rdw1ZADuxeIjRK6+x3f0bTpLFpYr/ckWEpyd0mbRv
	7+ntVTXkZ8lPbxJ6ujXEE/+ZTM1UpU9AuRavQ0O12+0wFAsivh/AA148Ulty7pF7+06EgwM5HSR
	yhwtG+MPhgbgPfjua642jvn2nfdJ9M9OSIDc6OIwdd9FzBR37MkOlCf+eX2Q==
X-Gm-Gg: ASbGncvFPNBaEkaqNIGUux/5dDYhhdYIGQoK58nzr7BQX34+sjw9JfaRcbM8UUbKN/y
	5fdUAN2HN+yoxvutwcCdrnN+P0XbkRJrsahTMWS5fzRU10NBwZRQEoixurVt6r6H5yGG22ol2Zm
	7VY8gH
X-Received: by 2002:a05:6a00:189b:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7487e10153dmr2269236b3a.6.1749708793578;
        Wed, 11 Jun 2025 23:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6GGvfSmuAQ9kMEV18/KRIrYuFrvcTgJ6zriYOViLm9mz7ikKRvCvtL51y/UBgyEUqoyUT9U0TXEnim8kM7c4=
X-Received: by 2002:a05:6a00:189b:b0:736:450c:fa54 with SMTP id
 d2e1a72fcca58-7487e10153dmr2269210b3a.6.1749708793175; Wed, 11 Jun 2025
 23:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-3-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 14:13:00 +0800
X-Gm-Features: AX0GCFvcFRxL8oSigntqa1RjBnlkRGKNKVefC9UxsmF9GK_By08eLAA_95tszrM
Message-ID: <CACGkMEvargUzv3DpAYZ+wS1fi_kNVmXppcX0Qtmy85F22z=OLw@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] vhost: Reintroduce kthread mode support in vhost
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vjqH8rfAEpfkz1ORPvZEysB0mfa9DPkP36w-P6fkH_Q_1749708793
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode support in vhost,
> It also introduces struct vhost_worker_ops to abstract
> worker create/stop/wakeup operations.
>
> * Bring back the original vhost_worker() implementation,
>   and renamed to vhost_run_work_kthread_list().
>
> * Add cgroup support for the kthread
>
> * Introduce struct vhost_worker_ops:
>   - Encapsulates create / stop / wake=E2=80=91up callbacks.
>   - vhost_worker_create() selects the proper ops according to
>     inherit_owner.
>
> This partially reverts or improves upon:
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

