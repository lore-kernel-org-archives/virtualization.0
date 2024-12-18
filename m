Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57870192D69
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511590; cv=none; b=nurrvH3rrd0UUKTJcwLnvgT65mfJDSapY49T/kwx3s2LQnN/byXwZ3vs3/VbKCPpcZLat/VQ9EMNecbwKJpQMhMyT86ITEERyq2mVfBgurEwpeEA3gCWbFUqyLznvc6ebp5q6RlnBF/OQ3Ivv1aBRrevXNjxtT2R6cakGlIMVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511590; c=relaxed/simple;
	bh=O3ovGN6Hg1bqUxumZterPrFzVTulwMpdVPSvm/DtAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCMsYxHIgA82W04JQiAO5rkOgLrr1btMcgYvMnx9hkUZGRRjdSRwCCtzll9kvZmgGyUpQ0N0Hy92YSpUcVZ2zLeX6iclvdGKVfRQ9iP3bRVxpyApb4WYXrzRnM3v/Q+Thkz3PIIqrKjW8KQTv41DMAGdsCov4JWEyMauJQmD7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3L3PqID; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3L3PqID"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E371C4172F
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UE07K8HnwqnS for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Dec 2024 08:46:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CCA1941605
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCA1941605
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3L3PqID
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CCA1941605
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqGOCEuKyFp5Mq0Dor8PkiIuS+YUjt1N5OpQaCIrUnI=;
	b=h3L3PqIDGaPdQ6J/W/H9ll+c6sEHDdKnaK/6+NPz0KcBUCIR0dvZWZ5sO74w1mF7jipzFI
	Ipkp34boddRWmUbxzOTZGetaxGPeTrxLuunXwtVResJJXUJZ6y43gaOE7jFnohZiZIhmex
	3bGAf9YDtgYqzbRMgJxRyU562UyZ6sI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Vxd7rj6hMu6mPGG_KTlR9g-1; Wed, 18 Dec 2024 03:46:24 -0500
X-MC-Unique: Vxd7rj6hMu6mPGG_KTlR9g-1
X-Mimecast-MFC-AGG-ID: Vxd7rj6hMu6mPGG_KTlR9g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aab954d1116so441520066b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 00:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511583; x=1735116383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqGOCEuKyFp5Mq0Dor8PkiIuS+YUjt1N5OpQaCIrUnI=;
        b=pZPJB1G5KrgJfOvqQ79qZwbnPV7WTRzy2QGCdoBGT2uX6KVvAD0IkVgJloRWl1x+w6
         NEWcArrG6TxOd/CzHbtRDtn4ISL5wz2AFOb8L174QtlTy+jodqAuC3QWcFMuZEyk0C61
         DNAptGOlxkc7fh4/ioOj+EWzk639D1Pm+NCYTWWtO5wTHetANoS1hHgBlkGQfY8GHoEt
         xDOgWyPMGAW+WOx6mjtaDFs9mayMZuPQX4tiJzq1ulgnRxFvEIzHUDOU+6UR1t1Qh6ls
         Qmw4E/pVTe6OGJsgoe7UNy9IT1ps5heDJHARo1ETxpIntBp6sxTIBvZMPucC0h/AbznM
         +aNw==
X-Forwarded-Encrypted: i=1; AJvYcCWR+eWERbQPePp6r6ZhWsJmdJ7Ywo1t4RXOnS5LDJn7a/iE3Fc22/rT5XuIRp2LI4F7raLp+Uybop87bRJc7g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwL8xWGIlo5iQ8d7dOaplVu+gVo8QibgcFuxClzeD+72XZNLhwO
	65veWcYEPMKJT/BS7ttYzv8NizROFIkq2R83msref3bvxIWoJLbyYyzClxWqUbdBwZJDKl7D3fI
	nAI69PEsFf/BKQTzLMcdLo561KlXDo446E28PIM4jvZDbxRIwc7rDa27spNx7vuYAJqa0ypUrT+
	aLmG/t1lyrEcZE+af1BwmTqW/8Tf2Jvx5FEMdwlPJMHyYa5atbjn6/YA==
X-Gm-Gg: ASbGncvx0QME0agZtdYVCmSViNX0Bcfbrb/0EiMmR4sRrhEdRJNkvbZQ4/nz2aaXiIZ
	Zx+SbLjVNkwZ4I2dQIUDcIA7tgW0E7xEMRVyexMU=
X-Received: by 2002:a17:907:86a1:b0:aa6:8430:cb02 with SMTP id a640c23a62f3a-aabf4966c7dmr144137866b.61.1734511583428;
        Wed, 18 Dec 2024 00:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHFm3Z3+PffAYmhBV7W18HwZ6rWjm1WHllt6r3VVlY7cNgegLPC1hcc2vCR+lKDficcfktiXwIyQn7ScZf8Y=
X-Received: by 2002:a17:907:86a1:b0:aa6:8430:cb02 with SMTP id
 a640c23a62f3a-aabf4966c7dmr144136066b.61.1734511583030; Wed, 18 Dec 2024
 00:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-4-lulu@redhat.com>
 <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
In-Reply-To: <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 18 Dec 2024 16:45:46 +0800
Message-ID: <CACLfguWtkt6xXs5dJygyEGQwztFdC8BrT3KOr1wpGjSraFL8HA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] vhost: Add the cgroup related function
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2iCAuozuYuApB5xNLC37p165G4BVN877rC-Nn8Ekndw_1734511583
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:53=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:42AM +0800, Cindy Lu wrote:
> >Add back the previously removed cgroup function to support the kthread
>
> nit: missing . at the end
>
will fix this
> >The biggest change for this part is in vhost_attach_cgroups() and
> >vhost_attach_task_to_cgroups().
>
> It's not clear what the big change is, is there a piece missing?
>
sure, I will rewrite this part to make it more clear
Thanks
cindy
> >
> >The old function was remove in
>
> s/remove/removed
>
> BTW which is the old function?
>
I will add this information
Thanks
cindy
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> > 1 file changed, 33 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 1feba29abf95..812dfd218bc2 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -22,6 +22,7 @@
> > #include <linux/slab.h>
> > #include <linux/vmalloc.h>
> > #include <linux/kthread.h>
> >+#include <linux/cgroup.h>
> > #include <linux/module.h>
> > #include <linux/sort.h>
> > #include <linux/sched/mm.h>
> >@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> > }
> > EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> >
> >+struct vhost_attach_cgroups_struct {
> >+      struct vhost_work work;
> >+      struct task_struct *owner;
> >+      int ret;
> >+};
> >+
> >+static void vhost_attach_cgroups_work(struct vhost_work *work)
> >+{
> >+      struct vhost_attach_cgroups_struct *s;
> >+
> >+      s =3D container_of(work, struct vhost_attach_cgroups_struct, work=
);
> >+      s->ret =3D cgroup_attach_task_all(s->owner, current);
> >+}
> >+
> >+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
>
> This function looks renamed, should we mention in the commit
> description?
>
> >+{
> >+      struct vhost_flush_struct flush;
> >+      struct vhost_attach_cgroups_struct attach;
> >+
> >+      attach.owner =3D current;
> >+
> >+      vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> >+      vhost_worker_queue(worker, &attach.work);
> >+
> >+      init_completion(&flush.wait_event);
> >+      vhost_work_init(&flush.work, vhost_flush_work);
> >+      vhost_worker_queue(worker, &flush.work);
> >+      wait_for_completion(&flush.wait_event);
>
> IIUC this block is the old "vhost_dev_flush", right?
>
> Maybe we should mention also that in the commit description.
>
sure, will add these informations
Thanks
cindy
> >+
> >+      return attach.ret;
> >+}
> >+
> > /* Caller should have device mutex */
> > bool vhost_dev_has_owner(struct vhost_dev *dev)
> > {
> >--
> >2.45.0
> >
>

