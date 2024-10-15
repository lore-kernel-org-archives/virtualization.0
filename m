Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7017D340
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971731; cv=none; b=BsO3QDosf/kmRgLgXBsSGUts7lD7epP0BzsQBLtjuIu8v0L4CPfcCbx81BLMB8DEYWLyoksyuapUHm/ubBkzPRnSYixSKx6QIVFjXVjy1hn58/e4h4fq8VRs1yTJa9Q7W9WVQwAqk5BpBVT7I3hpbpj5m7r4ARdtU3TU3fBW+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971731; c=relaxed/simple;
	bh=x69P0Z65oXCH9k7dXC/rZ9aJQ5P/0luVc80ETZqatuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7AniwLnf8UzC2iCVzaxqYLdF2jiLTxFnTFAIStj4Qor/iT3QPl69BQ4gQE3guob14CdYk/7DgzY8DviXchRy4uk8/9mgtaGYNZS4M6ym724EPKIV4ES3tZSsdGzdiMzLjAfewwglKFNK0yYvPr75Dl8PqgwrO+TCLeb+MIPepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShTtRiSy; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShTtRiSy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E09C160865
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 05:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0abz172Ay2S for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 05:55:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0563260863
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0563260863
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ShTtRiSy
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0563260863
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 05:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728971726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLop8z2nADHha6QKe8wKTicygsTgRvsS7+q08jtnUQY=;
	b=ShTtRiSye7UTur6DVc9h12ChHKpgrwRLBK9rBcSzUP45g/GjgaliznGJcJA6TSUs5UXi3B
	EAjnPG8J3ThQvG0ewgOx4Swcf1bmYqOhQ5ny4MBVOgoNDFntHvoqPrvopS5/e4dnA1WO5n
	Llqe9UXhO6dH9CfixkpelABpmB5yM+k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-FpyLOpnbMuWh6iCrZXJzHw-1; Tue, 15 Oct 2024 01:55:24 -0400
X-MC-Unique: FpyLOpnbMuWh6iCrZXJzHw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso65994366b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 22:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728971722; x=1729576522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLop8z2nADHha6QKe8wKTicygsTgRvsS7+q08jtnUQY=;
        b=X1aPlTzWcJ3YP7j8UNIoJXSu7z+hegqLhPMu9a18p3/1y+gsH9d5cCjIbEyA7E4Zrd
         Awjx0WOTDtYfaE4/BSkUagv57INdy1JZmd3Yep3WMp4/jhFd2nVPditbMB+CNRdv22oR
         gQFjPkHUIRTKfWyQzr3MMFH+QgwBD2f828Ppqw/7B7P0eelSuKWNWR2/d4/pDW5iO1nE
         n73T10d4Se3/91QKu7taY35peOGEiEZZx8As2GuZHeIIj910hsL+GvBicsoAIeOUOvv8
         ljoiz3zUetHWS5rKtxfNhnC81cFbdK6r6yo5vMZWMn/m7HFXJPBX1wExtwmoVAP1hrkr
         zOpA==
X-Forwarded-Encrypted: i=1; AJvYcCVHDFBb8QdaqUyPoYci7gx371Mfv6GD7b9vmDhw84vbWF5ifD4gA1e6EHjZSvxjZ0aPEThNIC/6smXOmbJd8w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzOKufcuLHugXE5qGMHlTLDkuQyUtiBGxB/r/OVcrk8LaANDyR6
	OlqqJe90VD5/rK/+oplP6xfH9tu6eynYs/vBUXsHm8W1iSf/pEcDndWJFNMkRvm5YOQziK6HKS9
	bouC3Qpjm/fJroHF5A6OWSxmYAZDXMSDrawXgVuVY9xgG9RJeguSumBN5fA+25hKOdLCMYjWwWp
	IhS8EKMpku+xWZepXd55osqHaScWpE2aG+6zhllruIeP9j3ht/G+H2yw==
X-Received: by 2002:a17:907:846:b0:a99:4eac:bb98 with SMTP id a640c23a62f3a-a99e3e3e61bmr1001504866b.51.1728971721969;
        Mon, 14 Oct 2024 22:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjt5CGZTGpCyBOXaYD1O5WADuUpaIz5hSp3KPQ1fxEr1hHSQgXOGp8y5FVkyhKceluqiCgv5Ijc+HLMtC+mvE=
X-Received: by 2002:a17:907:846:b0:a99:4eac:bb98 with SMTP id
 a640c23a62f3a-a99e3e3e61bmr1001503966b.51.1728971721556; Mon, 14 Oct 2024
 22:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-4-lulu@redhat.com>
 <4z4lgkittsui6xv26h4gwo4o4xuut4sbcih6p7jxajwignftyq@catixvwskk5m>
In-Reply-To: <4z4lgkittsui6xv26h4gwo4o4xuut4sbcih6p7jxajwignftyq@catixvwskk5m>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 13:54:44 +0800
Message-ID: <CACLfguVyO-L4z9qjVYnCLZvoGkYwLxViY7VWjrWsoHXzM7mW5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 21:33, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Oct 04, 2024 at 09:58:17AM GMT, Cindy Lu wrote:
> >Added back the previously removed function vhost_workers_free() and
> >renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
> >will select the different mode based on the value of the parameter.
> >
> >The old function vhost_workers_free was change to support task in
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >also changed in
> >commit a284f09effea ("vhost: Fix crash during early vhost_transport_send_pkt calls")
> >change to xarray in
> >commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
> > 1 file changed, 47 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index ad359d4b725f..fed6671c1ffb 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -648,8 +648,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> >       dev->mm = NULL;
> > }
> >
> >-static void vhost_worker_destroy(struct vhost_dev *dev,
> >-                               struct vhost_worker *worker)
> >+static void vhost_worker_destroy_kthread(struct vhost_dev *dev,
> >+                                       struct vhost_worker *worker)
> >+{
> >+      if (!worker)
> >+              return;
> >+
> >+      WARN_ON(!llist_empty(&worker->work_list));
> >+
> >+      xa_erase(&dev->worker_xa, worker->id);
> >+      kthread_stop(worker->task);
> >+      kfree(worker);
> >+}
> >+
> >+static void vhost_worker_destroy_task(struct vhost_dev *dev,
> >+                                    struct vhost_worker *worker)
> > {
> >       if (!worker)
> >               return;
> >@@ -660,7 +673,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> >       kfree(worker);
> > }
> >
> >-static void vhost_workers_free(struct vhost_dev *dev)
> >+static void vhost_workers_free_task(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >       unsigned long i;
> >@@ -675,10 +688,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
> >        * created but couldn't clean up (it forgot or crashed).
> >        */
> >       xa_for_each(&dev->worker_xa, i, worker)
> >-              vhost_worker_destroy(dev, worker);
> >+              vhost_worker_destroy_task(dev, worker);
> >       xa_destroy(&dev->worker_xa);
> > }
> >
> >+static void vhost_workers_free_kthread(struct vhost_dev *dev)
> >+{
> >+      struct vhost_worker *worker;
> >+      unsigned long i;
> >+
> >+      if (!dev->use_worker)
> >+              return;
> >+
> >+      for (i = 0; i < dev->nvqs; i++)
> >+              rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >+      /*
> >+       * Free the default worker we created and cleanup workers userspace
> >+       * created but couldn't clean up (it forgot or crashed).
> >+       */
> >+      xa_for_each(&dev->worker_xa, i, worker)
> >+              vhost_worker_destroy_kthread(dev, worker);
> >+      xa_destroy(&dev->worker_xa);
> >+}
> >+
> >+static void vhost_workers_free(struct vhost_dev *dev)
> >+{
> >+      if (enforce_inherit_owner)
> >+              vhost_workers_free_task(dev);
> >+      else
> >+              vhost_workers_free_kthread(dev);
> >+}
>
> nit: new line here
>
sure, will fix this
> > static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >@@ -846,7 +885,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
> >       __vhost_worker_flush(worker);
> >       mutex_unlock(&worker->mutex);
> >
> >-      vhost_worker_destroy(dev, worker);
> >+      if (enforce_inherit_owner)
> >+              vhost_worker_destroy_task(dev, worker);
> >+      else
> >+              vhost_worker_destroy_kthread(dev, worker);
> >       return 0;
> > }
> >
> >--
> >2.45.0
> >
> >
>

