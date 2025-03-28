Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775820DD79
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140679; cv=none; b=feQL20vNl/wxT6ypWn19cVVXbnXoSkaUzZhaBWuKTUQLYxX1/MTIYdMcG66cnmzudlgZCqWQf2PC+DvX7gHOpMLebvrx0FGRZDl1g0pk9czZ2HwGy86xGWCvq1ntNXZ+7tYGqLrxBlr+WAg77PJRB0qf2krxt0T2Zr6lOSIFNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140679; c=relaxed/simple;
	bh=XQtprkEDEsNATdaVZNN4W5lGHi2fIAWaW+Dfp7jzqhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBmHOcf2zk+kB1h6uIAIuhbgsoT+GUG5Q/3Yjveger8jL0Au3jzjIlvIr1T5q4S6Lg/AnRCZMccVkidx2nPLbaWntHlIJo7pD2XfNY8/ia4sgCrkMOAPc1z/3rY3gOiAyK6rlCF79dO+keu+gXy6tKKH0BbdWaQuzxC44scOp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODvD75/u; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODvD75/u"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 125E0400F6
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fka80vRVROIU for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 05:44:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 449DC400AF
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 449DC400AF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ODvD75/u
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 449DC400AF
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743140676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QutikAf8CzdrkFZy4fbFiEuK2llYIXRXcPk92xeA3Cs=;
	b=ODvD75/ufZ7uL8RtjQscqX7/XvaVF5WnftV8ve4b5VZHgCINyTRMFInccTZCt/hbygN5z5
	0XwRWCYdzSwyeVKCNpRuGE5oq3Hvzmbgxb8NODJoT9SP6F8Fx+SRDf8tKyG8i5b12NlLvG
	f8ZWUpxV4YVwZ0ZDs1jDtV3FCy76lYI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-4YLEcYh3PlCPwHF4UxRcyg-1; Fri, 28 Mar 2025 01:44:34 -0400
X-MC-Unique: 4YLEcYh3PlCPwHF4UxRcyg-1
X-Mimecast-MFC-AGG-ID: 4YLEcYh3PlCPwHF4UxRcyg_1743140673
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e6b2b8339fso1875855a12.3
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Mar 2025 22:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140673; x=1743745473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QutikAf8CzdrkFZy4fbFiEuK2llYIXRXcPk92xeA3Cs=;
        b=u3SNNJSVm6zMIVJ1Z2Cy/MzIPssMIjgDj9uXyEYSdKq9t9mMmDi8Y6ezL16n6eFWFM
         oSbETLmZw6Vo1rnu17H8uQxX2faP66xX3jS1l47J6Fglsr9qOkek90Pll9Z5eaurRdtn
         tRjaqN5ZQIV5g8FUApWav+M/jnAqHYDP3veiucOB568ey85JkPxFt7MiR1nHR6muDoRF
         f093u8NvsEaXUpM2pfuIXvNFDcT14LPzuMOuMnoRZ7faE+nZ8SKC1JOhbko3b5HOhhCM
         ezNmHiCA0eIDYwRPS6eo3BiNaO2PAbTjVvTcZmFmcSTl+JwhmYHPkqSSK0oBi5nkFMGO
         dBFg==
X-Forwarded-Encrypted: i=1; AJvYcCXWrwut5Hwd51GSyjKjKZW54DY8cZebBEHQWX011dh6PPw2mas1ymLPZdOGfCRY+zPMEgXYy8u/jPr6GbgzWQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxpFNdqwMPRpUUeBcKRYhGmCJhEN08bbP8lirIpiw4dX7Vu5aSH
	7rq6oRpXQ30EjyNArYlK3qAMm6OpVGhUE3Hagqv24Td4AtHXAZ0gaOsDVzwOwanJC3wywkr1WKa
	cb4VGmNGQSwwI0g0keiit7/cphATrbwWNGn/qEk2SOo58u7Q1eDDnVSxtqAB+6HMvybDWn8cHvi
	Qhd1McO3lMAwGcHw7T2Qkrf8u+AdxmUgNtphf459ltRkDD66HAAZjFcg==
X-Gm-Gg: ASbGncsjnkx6D27TnnR6W7cnSxq+XA8eRq9URFv0RyfTiaJ6LJ38AfQHS3gW3hhIRIe
	7ZzXbXF/JQ9iWTOg1kpJopJZM3yp/74e7ajDdrcZxryPr2RNz1M2UoqdsIiSOehAqrwG2ZNpGdg
	==
X-Received: by 2002:a17:907:97d3:b0:ac2:842c:8d04 with SMTP id a640c23a62f3a-ac6faefc2demr579369566b.17.1743140673123;
        Thu, 27 Mar 2025 22:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJb11SZdo5gIc5Cpkf/Foi1hoNnZtutCCOu5oz1dTbJqGdShPR2w9s/elEfvXF2PGDrqfGoK9Uujk0qNWiQVc=
X-Received: by 2002:a17:907:97d3:b0:ac2:842c:8d04 with SMTP id
 a640c23a62f3a-ac6faefc2demr579367866b.17.1743140672665; Thu, 27 Mar 2025
 22:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-7-lulu@redhat.com>
 <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
In-Reply-To: <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 13:43:56 +0800
X-Gm-Features: AQ5f1JoqnO2FywuK703ia-cevncP3vP4nSex8V3LYpufvkKolFtpzyEbcR13XLU
Message-ID: <CACLfguXUUwpsyRV2L+wM4cFZ3qSbBNEht8J-JG4ppaLY-_9Sow@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] vhost: uapi to control task mode (owner vs kthread)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7NsyUG9JmWfr9-epOwOELNYfG1B6E9XTyRHeJoRo7DU_1743140673
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:58=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Sun, Mar 02, 2025 at 10:32:08PM +0800, Cindy Lu wrote:
> >Add a new UAPI to configure the vhost device to use the kthread mode
> >The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
> >to choose between owner and kthread mode if necessary
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> > include/uapi/linux/vhost.h | 15 +++++++++++++++
> > 2 files changed, 35 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index be97028a8baf..ff930c2e5b78 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, =
struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> >-
> >+      dev->inherit_owner =3D true;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> >@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >-
> >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >+              u8 inherit_owner;
> >+              /*inherit_owner can only be modified before owner is set*=
/
> >+              if (vhost_dev_has_owner(d)) {
> >+                      r =3D -EBUSY;
> >+                      goto done;
> >+              }
> >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> >+                      r =3D -EFAULT;
> >+                      goto done;
> >+              }
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >+              r =3D 0;
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..547b4fa4c3bd 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,19 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost dev=
ice
>
> Should we mention that this IOCTL must be called before VHOST_SET_OWNER?
>
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1(default value):
> >+ *   - Vhost will create tasks similar to processes forked from the own=
er,
> >+ *     inheriting all of the owner's attributes..
>                                                    ^
> nit: there 2 points here
>
Thanks Stefano, I will change this
Thanks
cindy
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - Vhost will create tasks as kernel thread
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> >+
> > #endif
> >--
> >2.45.0
> >
>

