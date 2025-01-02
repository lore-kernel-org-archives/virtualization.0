Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1310957
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788564; cv=none; b=IWRpNXyX3vUBT7i6csb7JMpcRudw+NMugYg7H4cOdDWfnL99nD3Fn8CamQDENZeCGA4lzrKfgBC23lB3f0YkavRneG8UH6N7B3Gkbdxk7VbUMuKbJf3iskwWXWLmNUGQ8jMVrgIqHdnlMCuEdDySkmBXKoQmBrqkxAUzGi3xx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788564; c=relaxed/simple;
	bh=yBccCS82jh7ovGObzBDk9jbyc37dC8PGynna4j5nJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB8pBIi0gt6GXAEtzC7UO1HP8OvGKxe9Wuog1Vj5qE4xocid3BnZrTFXEgTlVidskR9/dIxthU8H1dhGuPGvduX2Cp+z3Jl5DSvHVCB0AsGVn7+z4fADtfj1k/5MDXpA+XF2CeMy5FkoMckIlaD3R+T+VztTw8/CGqomJ5wUQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjbXmXHR; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjbXmXHR"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAA3D606AE
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzDgjWXxr9N0 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jan 2025 03:29:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F4185600CD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F4185600CD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bjbXmXHR
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F4185600CD
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735788560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NN6AyzPMDSUlUsPWjiPfTwpmHUglS8cLZ/Ty6brF+N0=;
	b=bjbXmXHRKrJ7r8KtYXoPCPHdhNSrKk42ClrYsYO3e2eF4FZb/02EofosERd0hJoMVsYlRm
	fc0yBix92EymQHj8phQlDrr+KOH+vt5JA4E5b8miVILZKsmNit8i/pn+9HPPekyJ3qxeKb
	LDI3brVbvBTMZhzzOwv2/3f0vyxYkwE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-CTsSwr5KOui77bTuABvazA-1; Wed, 01 Jan 2025 22:29:19 -0500
X-MC-Unique: CTsSwr5KOui77bTuABvazA-1
X-Mimecast-MFC-AGG-ID: CTsSwr5KOui77bTuABvazA
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21638389f63so127244385ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 01 Jan 2025 19:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735788558; x=1736393358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN6AyzPMDSUlUsPWjiPfTwpmHUglS8cLZ/Ty6brF+N0=;
        b=XwQ3m2/KyBvT2hIk3mO5xjKNNuiddzqoMcGMKIorMVX5wIf4UOgUY2pYOw2S7KAZRN
         Dnz7iiL1DREthxdvT6Q/JL+GVeIQlPOLJxgljy+E6jwqm0YjZ0Ie59sS9hbeVwNerLFV
         j9EYZRzDgNnupBLOKJnA+/VDRStynFFlMB+9Cuf34JFxrIynRZgFaqWCSHreoT40YPIp
         JDbrtNRX++jyNX0viCZx5s/vrmV6zDsitPGwRE2KyVk+fO5H/P8g95LTP9QhkCuDVvXP
         a8buU67cmhwaLgMNYyPzj546eC0KbXYPlR52bgg3wYDHTl8h31D2j6i3JkQ8s36z/0Qb
         cJtg==
X-Forwarded-Encrypted: i=1; AJvYcCX6BuKb4w7L6KvC+R9MypG+u8DZ1jUu7Gsd7NomWLkq5SWBWE2hukNsxyuXo/Y4DdWh4/lxYBqqHjdam2vX7g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxroafLBlUEPbbtPCCDLCacXwecY/gaBa/SuFpIfxIJl50GUsNJ
	GbQdpPrwunfKam+zQpY714ejuUVlRIPgxqk6t0J+Runx/4oMJOBkkaRyd7FoWI7Ao4dcxHQNwfq
	FhFow/AvJTSoCyq7OzazkfJgG7wV0b/PENt4U1k/bTmJHxT0Y77Belvszl5RJWxHou2m0QlD8A1
	bJCjrFVbFZzB2CiC322ODv16eFax0CuofX0QmXE4rZyz0Iu5QoGkh4vg==
X-Gm-Gg: ASbGncu85We6L6xuGTv6bRnN+CKetbZK3br+U2VeC/3oxdo0WZVIDnbipwplf74kGAg
	RuGBPoyKndNkjCqyV/k4O3ZGprNP9fV91s3HrfNc=
X-Received: by 2002:a05:6a21:328d:b0:1e0:f495:50bb with SMTP id adf61e73a8af0-1e5e084326emr65097244637.44.1735788558363;
        Wed, 01 Jan 2025 19:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtn+VAOFvm/mDkS1q8GJ11i0qd0gI5imLGdJDyg/nRuIP8JtT8/NjGx/stu9lZmUQa1g1BqtbPotRqX98ZHnQ=
X-Received: by 2002:a05:6a21:328d:b0:1e0:f495:50bb with SMTP id
 adf61e73a8af0-1e5e084326emr65097218637.44.1735788557935; Wed, 01 Jan 2025
 19:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-4-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:29:06 +0800
Message-ID: <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bz28VQSKYbgj6buSJRozX94JgTKvKj5PNWWNJH2vtZk_1735788558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Reintroduce the previously removed functions vhost_attach_cgroups_work()
> and vhost_attach_cgroups() to support kthread mode. Rename
> vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
> the implementation of the old function vhost_dev_flush() in this
> new function.
>
> These function was removed in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1feba29abf95..812dfd218bc2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> +#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
> +struct vhost_attach_cgroups_struct {
> +       struct vhost_work work;
> +       struct task_struct *owner;
> +       int ret;
> +};
> +
> +static void vhost_attach_cgroups_work(struct vhost_work *work)
> +{
> +       struct vhost_attach_cgroups_struct *s;
> +
> +       s =3D container_of(work, struct vhost_attach_cgroups_struct, work=
);
> +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> +}
> +
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
> +       struct vhost_flush_struct flush;
> +       struct vhost_attach_cgroups_struct attach;
> +
> +       attach.owner =3D current;
> +
> +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> +       vhost_worker_queue(worker, &attach.work);
> +
> +       init_completion(&flush.wait_event);
> +       vhost_work_init(&flush.work, vhost_flush_work);
> +       vhost_worker_queue(worker, &flush.work);
> +       wait_for_completion(&flush.wait_event);
> +
> +       return attach.ret;
> +}

This seems to be inconsistent with what you said above which is

"""
> These function was removed in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
"""

As 6e890c5d5021 had:

static int vhost_attach_cgroups(struct vhost_dev *dev)
{
        struct vhost_attach_cgroups_struct attach;

        attach.owner =3D current;
        vhost_work_init(&attach.work, vhost_attach_cgroups_work);
        vhost_work_queue(dev, &attach.work);
        vhost_dev_flush(dev);
        return attach.ret;
}

It seems current vhost_dev_flush() will still work or the open coding
of the flush logic needs to be explained.

Thanks

> +
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> --
> 2.45.0
>

