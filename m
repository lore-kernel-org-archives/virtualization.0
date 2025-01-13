Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A24437C
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735571; cv=none; b=WBKzJmFJFiGPHRbwsM4yaTF6h4t+To7heGRapClcl46W+JSxAnfsUEO52P1aW36QKJa7wKsLVWCgIo92HzjJFNJpvNfmLU4ZdD81d06sB8vEwFdCer6m+mtjOGoyPsEl6GYqt++f59kNc7jQBzEzPTnmJ1IymftrW9Pxp7XAGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735571; c=relaxed/simple;
	bh=iJBXhSEUXil9nzcleAa3rLf5fXsjKbI4577NtFmRmCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPxHb4V3som13cTn8LFp/AtD8yhhqFDqpFuEM+KLNI7uZXX4R391qnOFkdM40YygDvVeRmsYnFnFhl23C8ae+/kD5XV19rL0fCjQNYSRPCW+QX5WjeGmFf1YW9uYqzAWDViPuFUBFGy2TBh2v9gqItsrVjmBa8g7Pruza/jCa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hz4M6JW7; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz4M6JW7"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F85B402F7
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I4bSgiXG3NFN for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jan 2025 02:32:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 00B1040120
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00B1040120
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hz4M6JW7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00B1040120
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogh4yUdSverGfA2nr1La7HZqI96ihmOqtA9BI3+NwGU=;
	b=hz4M6JW7wa76o8tvgod+oT8vgtsnW13n5pgAabGXr90ARYwppmk+7ERsX7czVAQyMLvZtv
	FeyLcaebcc7W77CFVIRgWQNj09G6KeRwYzGShEgjjJlvDX9lBKYuj0YN8JwySziG1HnBvQ
	rmh9M3QUd3fxQfJgI8Db0DIN5QynUpg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-P3non6ZOPSmqkm_o2Xmnww-1; Sun, 12 Jan 2025 21:32:45 -0500
X-MC-Unique: P3non6ZOPSmqkm_o2Xmnww-1
X-Mimecast-MFC-AGG-ID: P3non6ZOPSmqkm_o2Xmnww
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa622312962so364435366b.2
        for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 18:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735564; x=1737340364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogh4yUdSverGfA2nr1La7HZqI96ihmOqtA9BI3+NwGU=;
        b=LS1U2EanpvRsukqqJP2EHBWK8XxgLkxs8IHWoNDwVIkEo2rQtMSRcGMmE1pLadgEfE
         Cwrp/fZnEyoAbbeIhkE4UXtWzOi7bEaw479vNC1nk6RSdos++gTNtjBfXckvg8qokD8Q
         jYgKJ0d8jqTO4jByr2qcFfPT3CoGiWsVBvCzQhG2uP+w5/j60OMPZrEHQYF0/TLRFwT3
         enTR+vH4JCpUU4G9tdjMQGaVYXdu3biiSqMR9C9zGhEhOmVIMVcs8MGNYFXSfqLVJYyU
         q+qlifgVWM9G2MO5qX/mrZqALXl6th2Ogc24XLcoHgWdbRvMvw1mApdsunnjZwiK28pi
         pJpA==
X-Forwarded-Encrypted: i=1; AJvYcCX0jeYUlOrPAnsz/8+V04gi7jqvTPfkO8Xd8pRCqfSHS55dGmnWPONY9iOfZE7hbW485HNnFaOBHwO+nv2E1w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzxrWoHp4/EdVaPDnpp+yscNC64MapNF1SFnncE9st5J0DhUo6R
	U9r/exoVgcGrhVMd4DjgzvpDz6x4qfv0p2fiQt+O2cFUAz/PfBhfxiuDjJmI7RAcZGxrcz/kqQu
	58LIvJ3/pWCg3jWHk3VNF5HQ8W2ECSViyz6Pn/jjoop98MfLKkc88xQeSack7vhLG6oewOWTo1X
	uhqYV7ar86BX6C6YiRMuD6bB7IjzLQo6xIwf1eT543bqffl35klIxX+Q==
X-Gm-Gg: ASbGncvMbc7PW3mFKmEg/ZBxxBtJ/wmLJ8NcbpkzHVcLWBnu1Vw+WPdC5G0HKselWBK
	ecAmCsnilp5RgGmGN9F4XDqJ/SiC9cOcf/e1GKNk=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id a640c23a62f3a-ab2ab5f6f1cmr1637286666b.32.1736735564394;
        Sun, 12 Jan 2025 18:32:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnuGt8CxE+gRSzYVi8MUlepoHGla7JG4/2R+e3nAiZqyvY650WJaTCzM5NsO1xJzfzWq/2khQ/lBupx9fZUEI=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab2ab5f6f1cmr1637285266b.32.1736735564092; Sun, 12 Jan 2025
 18:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20250108072229-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108072229-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 13 Jan 2025 10:32:07 +0800
X-Gm-Features: AbW1kvZSxc6vxEyyMbRsiKZHQLXzHErZjYxUy89i7uHx6o2XOjUFvAUYnAHvGsE
Message-ID: <CACLfguUjnJxvv2iuu2ASX7ZKiWbk48wWQTAVoOfZegLXJij=9w@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Iiai6Eyk0wEtEKRShfCuop8P40g7pGRhPJUnSXDhdIU_1736735564
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Dec 30, 2024 at 08:43:47PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
>
>
> I briefly applied this, but there seem to be a bit too
> many nits. So I will wait for v6 with everything addressed.
>
> Thanks!
>
sure, I will rebase this to the latest kernel, Thanks
Thanks
Cindy
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
> >
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
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (6):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Add the vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Add worker related functions to support kthread
> >   vhost: Add new UAPI to support change to task mode
> >   vhost_scsi: Add check for inherit_owner status
> >
> >  drivers/vhost/scsi.c       |   8 ++
> >  drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |   4 +
> >  include/uapi/linux/vhost.h |  19 ++++
> >  4 files changed, 192 insertions(+), 17 deletions(-)
> >
> > --
> > 2.45.0
>

