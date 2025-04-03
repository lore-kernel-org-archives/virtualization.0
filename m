Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473C33993
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659592; cv=none; b=C+ULxcqxumtjw/DNlKlx0GQMTCzHdATs4LUb3BXw8LBRfy08caH2v5othK9+2yqEdQIuLOenG48nTEe30WFgfenff12Rwjmn0Dz8pcbZkiXHSIfXm5dft9To/elsHHOec6fr7gNBmfJ//XoV7gqWi6QrLmFAD4J60ggKSzG8CEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659592; c=relaxed/simple;
	bh=4bS5onAMqnZXsH3MQL3fZNQzN/QQVysLsc6zj/UJdIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH4qbLCbzjNwTW60na6Vjtqu6SJB80Rmu3942hYZSTBMxDSOnw4R6JH966GPcOA+rAn0iniGxS5mKsopB194R475U+gd2HqfgjJ2bbFnZz0ewUMHWtEs6t3PJTZHf0tTNK72lIKyvEgHm7KLBcoZf+RIEaoRPfEp8PRrhM2kASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5p7U2Xz; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5p7U2Xz"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93B2C41113
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 05:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHkxz1oHAN6D for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 05:53:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D9BC9411C6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9BC9411C6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U5p7U2Xz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9BC9411C6
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 05:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743659588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3jbd2doY1NSOX00VkbRurvkdLq9F5tN6tB0xPnD0Og=;
	b=U5p7U2XzKE/QDl8ZXuLr5dvZXS3Xh131BVbeK7JeAefhEMPfn0+AgXbsfJOMAI4/vcjn9p
	hAThUNzOEMsfF/PH3hB2Y3GFy+VfFHv4zdqnSJjqN65pGXtSQsLnW++Zk5UHkbs7FEUcd+
	qaQK1e8lrUTbzK6ytH8tAmSLuDeyixU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-89QRvrkTOL-CoGhpPnk04A-1; Thu, 03 Apr 2025 01:53:07 -0400
X-MC-Unique: 89QRvrkTOL-CoGhpPnk04A-1
X-Mimecast-MFC-AGG-ID: 89QRvrkTOL-CoGhpPnk04A_1743659586
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3d89cc4f3so31734766b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 02 Apr 2025 22:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743659586; x=1744264386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3jbd2doY1NSOX00VkbRurvkdLq9F5tN6tB0xPnD0Og=;
        b=QZNr+BmLQR2RfUkyUrVWLIRpnyCwTSXvDX3MQq87HF4ci8ItUbzKuqP790Hs6coI/Y
         zTpS9Yu+r7xb6BVl21aDMp0b9xvDy1jRxD5y9b8Ffb76+aeY0i3FF5L4WoKaXhnWn1sL
         h51YI6qbLACak6JWOh9E2lvS6xqgPmsrNo8VsugX90bHT13Eocn5tY5j8U8VAl90AHOi
         wncc8ukwYxDGm9qfpb27AP+t4zzeEKmWMdIcmrQQpDQ1985kYRJGowe0EEjsimolN80Q
         Ik1RuLmZ8m90+x5bMYJvs11EPYNi8haBLTQCSwcsatez4Yhcj83sTzMjw5RrKIK+yzp0
         xc+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIyGEIIi+GeQMn56xAFmUXTkhArXE03HHkohfYldDyQrfunUyfeHt9cksfqCte1oFjSGUMy2kMea7i8wYNfQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw8CuUOmjlkIjyj+QblXLurtPPQYBNbrt3u61CJrbdnnPRVV/Y0
	K84LVJNg2RIspEVsxRNogsp4HFlXU97MtHXmYGcZStW98G3KWRR5Jkc+cpYNuRMRW4mD12wlYuT
	nqMTfgfWftphd+RWd6K85/4hj17mp85Dh8KzgszyoBvAKwYooBWzJiewbYHkrdUgsII5giTx6aa
	W6uMKHsettDIarKg6a0heJ/qhQrWj6OOxSnCOC2zcNAKWSem9UmbQMog==
X-Gm-Gg: ASbGncvdMAgPkFEOAiVWdS1G33bryTqz1a64NJ2363bCimZc3GGPByXTLZy0Zn/bHPs
	2vWqngUbzLrNUfuZk2kAcSZ46qej5cq0SLpu0Kj8f02kjf9RZARxBy2g74W1KIg3tSOIHl2+wLA
	==
X-Received: by 2002:a17:907:7daa:b0:ac7:322c:fd0c with SMTP id a640c23a62f3a-ac738be4bc5mr1287977666b.40.1743659586302;
        Wed, 02 Apr 2025 22:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Z7xb5HzuAp3VvTBF4XJMRYjpTwnMri/J3XyJV/X24GWV812YboBMK2hckDCVRlWhGZcOzWwt5e0C8UfpFi8=
X-Received: by 2002:a17:907:7daa:b0:ac7:322c:fd0c with SMTP id
 a640c23a62f3a-ac738be4bc5mr1287975866b.40.1743659585908; Wed, 02 Apr 2025
 22:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-2-lulu@redhat.com>
 <74u5ppfmuf4gwjup3eotpnd6bulocerdk4l54qvykfcnesf6hm@udabnuiw2v6y>
In-Reply-To: <74u5ppfmuf4gwjup3eotpnd6bulocerdk4l54qvykfcnesf6hm@udabnuiw2v6y>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 3 Apr 2025 13:52:29 +0800
X-Gm-Features: AQ5f1Jo1foH-PvZGrIRlU2VXTP0saZl6MC9BSYsmGgkgWtc7Py14P3qzqSSJo7E
Message-ID: <CACLfguW+k0BJQMMU7fRKqJtidA=+p=Ky555bhcZ0kdU8fJOhhQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m_wklKg5wwlo9NjWF1wLXaphoujUetHO9eY7FSrEj_c_1743659586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:30=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:45PM +0800, Cindy Lu wrote:
> >The vhost now uses vhost_task and workers as a child of the owner thread=
.
> >While this aligns with containerization principles,it confuses some lega=
cy
>
> nit: missing space "principles,it"
>
> >userspace app, Therefore, we are reintroducing kthread API support.
>
> nit: "userspace app, Therefore" -> "userspace app. Therefore"
>
> >
> >Introduce a new parameter to enable users to choose between
> >kthread and task mode.
>
> I would explain that by default this is true, and so we are not changing
> the behavior with this patch.
>
Sure,I will change these
Thanks
Cindy
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 1 +
> > drivers/vhost/vhost.h | 9 +++++++++
> > 2 files changed, 10 insertions(+)
>
> Anyway, the patch LGTM with or without the commit tweaks:
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 63612faeab72..250dc43f1786 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> >       dev->byte_weight =3D byte_weight;
> >       dev->use_worker =3D use_worker;
> >       dev->msg_handler =3D msg_handler;
> >+      dev->inherit_owner =3D true;
> >       init_waitqueue_head(&dev->wait);
> >       INIT_LIST_HEAD(&dev->read_list);
> >       INIT_LIST_HEAD(&dev->pending_list);
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index bb75a292d50c..19bb94922a0e 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -176,6 +176,15 @@ struct vhost_dev {
> >       int byte_weight;
> >       struct xarray worker_xa;
> >       bool use_worker;
> >+      /*
> >+       * If inherit_owner is true we use vhost_tasks to create
> >+       * the worker so all settings/limits like cgroups, NPROC,
> >+       * scheduler, etc are inherited from the owner. If false,
> >+       * we use kthreads and only attach to the same cgroups
> >+       * as the owner for compat with older kernels.
> >+       * here we use true as default value
> >+       */
> >+      bool inherit_owner;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> > };
> >--
> >2.45.0
> >
>

