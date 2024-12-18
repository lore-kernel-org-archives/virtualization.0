Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C7175D34
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511159; cv=none; b=Rz1CIqsuo8xYLqVC+GMrPXqy+ULB30RU3pkdv9BghlY/4VouxiaRuGiwTk4ulxCJeqPxTqx3VM74v6pEAx/00d6Bwlw826UouSNAOq7c+7EplssOPKznjVO5v+p496iEub9d9UZvwEwEuiFX1XI5gJNh/h01J3jwru8R48DxfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511159; c=relaxed/simple;
	bh=kvEZgLfuKpBIL6UXFHvWj4fhMBsAebQHK+DO4sBMdwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTSH8kJfQIrqjrIU3/+6r4tqvFXfUGrku2qII1XhL9QSm1I7J/NueNAwRwMpICGzUdt2eZganWWfTz4Qsc05Pcs4z7lEKlWHPX4spnEIubO65tQ1b1pKn+/isSvPW+6+jFSwBisUQBCh4hae5DiKJ6YhHtMCySm7dRzpqT2eqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+D+4gKz; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+D+4gKz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C298816A2
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rBVJgEifmad for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Dec 2024 08:39:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6D93E814C9
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D93E814C9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+D+4gKz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D93E814C9
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhonihEVaQJzVy2Bbs74DpiB+LrNVYNHZo3wHnFP0Ec=;
	b=V+D+4gKz9J9AmBUW+nza9qJnLtibnbxxNa7qe0G9fCg1c9eDqB1GJACksh/+JWA2LtuZQT
	AkcQJsiaIhuigA4WRbiEkTnZONC8y33cnZzKl6jmUAIqI8IxFsEQYvVjaMPQ6kIpXtu8e2
	k5IEDx9D4aMR54M2PBXGJfuBuKjp4xQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-j6W4QQD8MPGbieMHvWoCuQ-1; Wed, 18 Dec 2024 03:39:14 -0500
X-MC-Unique: j6W4QQD8MPGbieMHvWoCuQ-1
X-Mimecast-MFC-AGG-ID: j6W4QQD8MPGbieMHvWoCuQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6a1595fdaso500587066b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 00:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511153; x=1735115953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhonihEVaQJzVy2Bbs74DpiB+LrNVYNHZo3wHnFP0Ec=;
        b=fDDaxuPtFzFaXQneD/nM0hbBViFVaPiJupYxuBvCtN+y2GGXmwaq2qGr3dhluIaa9K
         zvaUC5Qn7QKxfr8cSLHGRny7djyvO7dBXeHjNMvIBYVBYTzG6GmyEo41e1VDAvYvC9B0
         S1ey8ADiPCQ7d+TWE7ytGrVz5Hdc+WZE0XwB6fhZF0sSjnoAWhrLzZF3hgM9R7uE8Ges
         cOg/du3++1mVpF9rlXRjs7eNWyR14NZDPlIsJ7gRojVmQFjQTfDkBW9tPCyT9DMeAzVL
         i2TCo8fKNvxfvaQ2r9yHl8rtBFDlapmkz+bejGc3WlerKOPqIDF5pTZET4q7y30FkNbg
         JghA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZYZzyxnEt47bu8CVN7sHW4m2aEcLJ4n8Ejy8aFa9XDA6RYb3pznT6KDfsPGO7B4dhah1jXWlREn6OobYAA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxR8znvXqkG5QONkt1gZjLKIYpoRw2LPnqeOAIVOfikdi1EFDJk
	5VY41ScL3yRYF2yNjp+jKIuFoxHYSahVKRzd3pcR7qSYF1lzHyH9Ee62HJldgdkRfbUv2fEL0I1
	csICGhhyB+EiFSslRJNAD2PKwACsutjEhi3nXBg5SHYbUjwOvtmidPQqG/UL+R6vtQw38rcjFex
	zAIxMsGcfwRaKxWwng8wOmOpCStgSVzvpDxulowi6CE9mOVKjl3vFmvQ==
X-Gm-Gg: ASbGncvBcCZvb1VcjDGtDsikuRZD3QyRvvopfh9vTkhCavfcAtsr5ntIpY3mHzSQNiG
	Kd8R7uNRIX9rrDtS/goOG9YVu6bxAbgeRqYrt5vM=
X-Received: by 2002:a17:907:78e:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-aabf477ddffmr189585166b.31.1734511153504;
        Wed, 18 Dec 2024 00:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPyHUFmwfjNjzfUhcrQYfLNkqlmB6wOjQYl2K8WIGXcwvWI6bQLQsDKPK91gwt2HYdHpGSb0X2wb+YUCuEdFA=
X-Received: by 2002:a17:907:78e:b0:aa6:96ad:f903 with SMTP id
 a640c23a62f3a-aabf477ddffmr189582266b.31.1734511153024; Wed, 18 Dec 2024
 00:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-3-lulu@redhat.com>
 <tah7oyn43szvjmuzdatcaysonqlzel5zok2ancuupk5eir2hh3@xfq7uacjn7rn>
In-Reply-To: <tah7oyn43szvjmuzdatcaysonqlzel5zok2ancuupk5eir2hh3@xfq7uacjn7rn>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 18 Dec 2024 16:38:35 +0800
Message-ID: <CACLfguWPmu=Wx76bqQesa+OEUAvietEDfGNvXDUCOt4LEFzgbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] vhost: Add the vhost_worker to support kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RXMBSz1zeddNZC8sebux909qsvNzyrSUT1EVX_WzcSU_1734511153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:41AM +0800, Cindy Lu wrote:
> >Add the previously removed function vhost_worker() back
> >to support the kthread and rename it to vhost_run_work_kthread_list.
> >
> >The old function vhost_worker was change to support task in
>
> s/change/changed
>
will fix this
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >change to xarray in
>
> "and to support multiple workers per device using xarray in"
>
will fix this
Thanks
Cindy
> >commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 38 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index eaddbd39c29b..1feba29abf95 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >       __vhost_vq_meta_reset(vq);
> > }
> >
> >+static int vhost_run_work_kthread_list(void *data)
> >+{
> >+      struct vhost_worker *worker =3D data;
> >+      struct vhost_work *work, *work_next;
> >+      struct vhost_dev *dev =3D worker->dev;
> >+      struct llist_node *node;
> >+
> >+      kthread_use_mm(dev->mm);
> >+
> >+      for (;;) {
> >+              /* mb paired w/ kthread_stop */
> >+              set_current_state(TASK_INTERRUPTIBLE);
> >+
> >+              if (kthread_should_stop()) {
> >+                      __set_current_state(TASK_RUNNING);
> >+                      break;
> >+              }
> >+              node =3D llist_del_all(&worker->work_list);
> >+              if (!node)
> >+                      schedule();
> >+
> >+              node =3D llist_reverse_order(node);
> >+              /* make sure flag is seen after deletion */
> >+              smp_wmb();
> >+              llist_for_each_entry_safe(work, work_next, node, node) {
> >+                      clear_bit(VHOST_WORK_QUEUED, &work->flags);
> >+                      __set_current_state(TASK_RUNNING);
> >+                      kcov_remote_start_common(worker->kcov_handle);
> >+                      work->fn(work);
> >+                      kcov_remote_stop();
> >+                      cond_resched();
> >+              }
> >+      }
> >+      kthread_unuse_mm(dev->mm);
> >+
> >+      return 0;
> >+}
> >+
> > static bool vhost_run_work_list(void *data)
> > {
> >       struct vhost_worker *worker =3D data;
> >--
> >2.45.0
> >
>

