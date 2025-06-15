Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692E265603
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749996498; cv=none; b=cDC7CXr3uYoPwMG65KXVQSxlJgEBqaeV6z0dVE3a4tgD2YO3qlAgAWvCkoPASLE1V4n8TCl8pQ5pZGquD4BClPnXEk9rivOZq0S8/vQBKziHMCKDHd6sLZIwu8n3CK/4LRbDiSS++w2SMx6G5fRyYM3h4Zs1X4WrIJzf7jSw+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749996498; c=relaxed/simple;
	bh=ZMkuY8utSlgX4E1TJgbabBifoab9L056uppzdIxIscI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcED/lUpCkku7hpzeBLbImEc2N0YJUKlCKICKbrr7rppbYVCT1FKpbcB4x5jWIuHhPKWmo3rKmAtnIcbabYLc8cod6wGWFzJDL3Ln+ywIbwRz1hbeB8FWmOb67o5mAMJWfqHgqkHr/PSz0EAB3mpFgUe+1qemoU3g0YJ3LjNWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V48fO4Qf; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V48fO4Qf"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA1B740109
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 14:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rYd6DXTOyzr for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jun 2025 14:08:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EBDDD400AE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBDDD400AE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V48fO4Qf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EBDDD400AE
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749996493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5F9RD1nifDmIVXEq5JzNevYty30dQQi6BLivh0kLXI=;
	b=V48fO4QfWtcUvSEhdmitTSvVSNskna/VkYzmUAWjEe7y8XvHRpDplaMkhBNA9AzIKUEHK4
	XORtwIBlWRwr1aKu4ooRiw4T59yWWPFPIq3AYqsk9HfARNbAKQmVnucM5tCyUzWSP6Q032
	srbhV3YS2SbrhSZDcstIz9Rq5iXDgys=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-CCwlqNUVMku2h6Shj4W4tA-1; Sun, 15 Jun 2025 10:08:12 -0400
X-MC-Unique: CCwlqNUVMku2h6Shj4W4tA-1
X-Mimecast-MFC-AGG-ID: CCwlqNUVMku2h6Shj4W4tA_1749996492
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c7c30d8986so1292800185a.2
        for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749996492; x=1750601292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5F9RD1nifDmIVXEq5JzNevYty30dQQi6BLivh0kLXI=;
        b=J7ZW6loXd92VKFSpEzd0PXMouupqKZE/PLfkfk4hMMtz0rPViUarLWTNNmdmUZwJIr
         nMFBFzyxkv54LGUdkSFMN+AOqtuwS/zAlwyXbINYc5+UovOzuIW9mFeQ498NE3INq7sg
         gRkrvVvl8SVz5fD6COiBiCkevdpPgMJUKKl0AWFNE++02r8xwrdbwZt2qQSTJm4YimdI
         dkuxD9fwI6NOukfgTG/Ohzr6947m881j2K4EZ/rUZX+R+uZEzlZJgPUzGL030LcPDKNG
         ySnGqZnThHWnL9uRzpfAihN4oBe9oxPi+iS55TI5F9TUjYrUAFmPNCyNbg3+k2/YAuEL
         R9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWejNq8OTz1r5DzLurVloPC0+fgwUK9fHLyGlC5b0z/OrokTaAvUsnqKHsCw95f2TMxXYoCw+1MiH/4pXaKoQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxhSAwyk+apQJYfypmc0mqQ8rjxNT/dFBtItW1Uy/h8ufcFia9C
	a/mB4WCDxfaujEB5LBTUJNPl8npRT/xpWn8CWHDqD/+FrjqIqpiPBHMqxofvdwiFQR4PihvplcA
	oT9F3dhvE/awvbIAsydo8q56oTAwJFShuLj0dCYQxY1AsZU3T/fr+oCaW5stCfq+cIX8mUegeGS
	YIPWUePZXm2VbTyCMU/x5qQPWmK9jWjG0slF0M7pg8jgjMisio6QOuZtFV4A==
X-Gm-Gg: ASbGncv1E0MDopLZFz+0KNd1JA76A+jLEQeSdc8IC+JV4wRm5YHechni7SF12bm0Pe6
	Ytbi+Gr1yNGgaP7uGepIKsPDLEiNydIWRq8bzIIXW3Yu05E21mKz1gw2qlISQpj7CzxeXDe54z+
	sqFoo0
X-Received: by 2002:a05:620a:424b:b0:7c5:562d:ccf4 with SMTP id af79cd13be357-7d3c6c04a42mr976767585a.4.1749996491841;
        Sun, 15 Jun 2025 07:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx0K+fxFSP4BqeDRz0y+o/8CQcKF4SvXSEuhhUCRwUNvz+In8dyZXZqILXiqwaViRTlSKW5mWNGj/EecyaUpU=
X-Received: by 2002:a05:620a:424b:b0:7c5:562d:ccf4 with SMTP id
 af79cd13be357-7d3c6c04a42mr976764285a.4.1749996491522; Sun, 15 Jun 2025
 07:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250612022012-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250612022012-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 15 Jun 2025 22:07:34 +0800
X-Gm-Features: AX0GCFswiCco_DauL--0e2ckwRlj1O7zbAgJChjHQQatloXrMYTxWULtZX6JYno
Message-ID: <CACLfguVOmz5dzvX+08X_0bBQP1iEoxjX=eh=id3mWGtjSodSrQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/3] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eUbz8dg475h8BLJc2WmlGIVBOpvyzZodg3_fV7ATd94_1749996492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:20=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 09, 2025 at 03:33:06PM +0800, Cindy Lu wrote:
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
>
>
> > Changelog v2:
> >  1. Change the module_param's name to enforce_inherit_owner, and the de=
fault value is true.
> >  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> >
> > Changelog v3:
> >  1. Change the module_param's name to inherit_owner_default, and the de=
fault value is true.
> >  2. Add a structure for task function; the worker will select a differe=
nt mode based on the value inherit_owner.
> >  3. device will have their own inherit_owner in struct vhost_dev
> >  4. Address other comments
> >
> > Changelog v4:
> >  1. remove the module_param, only keep the UAPI
> >  2. remove the structure for task function; change to use the function =
pointer in vhost_worker
> >  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> >  4. Address other comments
> >
> > Changelog v5:
> >  1. Change wakeup and stop function pointers in struct vhost_worker to =
void.
> >  2. merging patches 4, 5, 6 in a single patch
> >  3. Fix spelling issues and address other comments.
> >
> > Changelog v6:
> >  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
> >  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FR=
OM_OWNER
> >  3. reuse the function __vhost_worker_flush
> >  4. use a ops sturct to support worker relates function
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner.
> >
> > Changelog v7:
> >  1. add a KConfig knob to disable legacy app support
> >  2. Split the changes into two patches to separately introduce the ops =
and add kthread support.
> >  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
> >  4. Rebased on the latest kernel
> >  5. Address other comments
> >
> > Changelog v8:
> >  1. Rebased on the latest kernel
> >  2. Address some other comments
> >
> > Changelog v9:
> >  1. Rebased on the latest kernel.
> >  2. Squashed patches 6=E2=80=917.
> >  3. Squashed patches 2=E2=80=914.
> >  4. Minor fixes in commit log
> >
> > Changelog v10:
> >  1.Add support for the module_param.
> >  2.Squash patches 3 and 4.
> >  3.Make minor fixes in the commit log.
> >  4.Fix the mismatched tabs in Kconfig.
> >  5.Rebase on the latest kernel.
> >
> > Changelog v11:
> >  1.make the module_param under Kconfig
> >  2.Make minor fixes in the commit log.
> >  3.change the name inherit_owner to fork_owner
> >  4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
> >  5.Rebase on the latest kernel
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (3):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce kthread mode support in vhost
> >   vhost: Add configuration controls for vhost worker's mode
>
>
> All of this should be squashed in a single patch.
>
Sure will do
Thanks
cindy
> >
> >  drivers/vhost/Kconfig      |  17 +++
> >  drivers/vhost/vhost.c      | 234 ++++++++++++++++++++++++++++++++++---
> >  drivers/vhost/vhost.h      |  22 ++++
> >  include/uapi/linux/vhost.h |  25 ++++
> >  4 files changed, 280 insertions(+), 18 deletions(-)
> >
> > --
> > 2.45.0
>

