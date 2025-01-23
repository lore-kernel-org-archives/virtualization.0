Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD13136E28
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596867; cv=none; b=qULjjhx5myZIW3bHh1tWsuLbolPJuI8SHvzIIfRyRS/Y0g48UP9VWFuzZom0lGZF9WcoOKMeOFIeExDBybiFyvUcW2HkC7hMXBZFxkZONLpT5IqGxQCDI1m7qie0JnCzyQ0Buq5vjZhMic04V0fQs+EoiHjtdaf4+5gAW1LjAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596867; c=relaxed/simple;
	bh=Z5RUeXjewdZrKMZoMK7Pqpm+bBakm0Sa9RBcpd7Nc0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSXFa5zt5Uh9IkPQBLM6Q0y1k6SK70FcoATjg9pdj65c6YMpaE4Ib6XnYjE1y17j9ud314qsYNaBKFPKATkUvZ0qlKK8or3+ZVwUUzYA3XmpFNveWM4t4MjIAClG3BqVbZ55zZ7AMsaF++lRH1+wLgLipYWrrLplTF9j4L3clM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8j/eZMG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8j/eZMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737596864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2w3Y/ryYxPYy1DTvoWZ1USlMPCnV5SBRkSrpIuoftOE=;
	b=X8j/eZMGVEKRE0L4C8gPZMVy5HKXagF0Ob148fcxwpMiwwzzn7BDViNvf1PAZ4fCEUFAqw
	+pPIbrf+oL6aJ1ECoc/FbjH5eI5qrE+OwEdbP0Slw3kJp8ASN2T18QuP22VvTXirWnhAhu
	T5Ka2LRVKkHm4OXEGdn3e5lxhViMFEw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-9XbNZz89PeeRMSLoUnAJVg-1; Wed, 22 Jan 2025 20:47:42 -0500
X-MC-Unique: 9XbNZz89PeeRMSLoUnAJVg-1
X-Mimecast-MFC-AGG-ID: 9XbNZz89PeeRMSLoUnAJVg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so1308433a91.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737596861; x=1738201661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w3Y/ryYxPYy1DTvoWZ1USlMPCnV5SBRkSrpIuoftOE=;
        b=SEoiOamagpBis1kTTSScAdgR8+l56WwSgRe/cObE4R4qlMc0k5H7z9kdIOrIas8pOh
         ZtjRcOWjzEFYpwtW9OpPJAJfs6k0U9mU0L1T6zYpLDS09oF4WIW88RaY514edkNL9Ej4
         9obrqAoNAsGd2k6YeBaiGUKNw0gLMwKD0+YeFS9dlpqEYgBLTNFZUjedPNN32hwYU9Ia
         o/QRnbdGQ28PCem3qecLBDrMwh6APw5ZWQQUyLWSeACStpOmmpC00l8Onoe+LTcwzk4W
         AHApng1v9cLGrlRVIPtEj5hrSgXSIOJEjD/30hH47+TrGhng3ARrJsVYCo1IAniMZGMA
         ivhg==
X-Forwarded-Encrypted: i=1; AJvYcCUGdeTNVbJ89Onr8N3EOKPC0FPOpEKJaQtIZ0r27/9x2FqLK2RyafLIL1k+zYZq0Zkr1HrLYzJkrGsQokagQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzktPw8cBr2XUIB1bAdzfLnYCU4PT6jmwAwAvcnnn4d1tGYokqG
	8cMlk40bNMzKiM7NwxwrTd+hZVJV3/GeowZUBlAuh+2f5APeSKuFhsadrZVvkZEgIRiV86H3Ocf
	Y9LA9Ww1AamDpu6zdOE3d39RgjJsD+/hoISaQEPoRpFdlPSaYf6ibWhiUzDoEyuWT21zMrenRIs
	wJzMAx33Td7miyxf5F75pPbQX8dDa5d2hzx5wlfMM=
X-Gm-Gg: ASbGncupz4tk+vIhC+EAOkVvDvqlwMjmyr8x2AnHUKyl2Ca+QFfba+5yg8V7rVwZ/9T
	x1kMGKRN8tbIVGlv7qYIzhoPCVk30icr207quor0We4Qpnx157w==
X-Received: by 2002:a05:6a20:7b07:b0:1e1:ae83:ad04 with SMTP id adf61e73a8af0-1eb215902cbmr28856211637.27.1737596861504;
        Wed, 22 Jan 2025 17:47:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdZdwwjJ5kCcRmJHzJl5lWj7E98LLPwdagwjLW/JUd5U0/kw+ztqsftXrAA274zp1e3eDzywK2qI832IR8A2w=
X-Received: by 2002:a05:6a20:7b07:b0:1e1:ae83:ad04 with SMTP id
 adf61e73a8af0-1eb215902cbmr28856182637.27.1737596861043; Wed, 22 Jan 2025
 17:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250107182516.48723-1-andrew.boyer@amd.com> <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org> <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com> <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com> <20250122172108-mutt-send-email-mst@kernel.org>
 <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>
In-Reply-To: <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:47:24 +0800
X-Gm-Features: AbW1kvYiXd_SnAMHtuoWs6gLhZS8a_9rFjsxfkS5q97ZP7kXQdo-f6txEA7Xkg0
Message-ID: <CACGkMEuf2PgrOYvVdLjgQT53AH7pJFtk9L3bC55JZbkM78V_yA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
To: "Boyer, Andrew" <Andrew.Boyer@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Nelson, Shannon" <Shannon.Nelson@amd.com>, 
	"Creeley, Brett" <Brett.Creeley@amd.com>, "Hubbe, Allen" <Allen.Hubbe@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6F5UaE839udoUU0b0Tc6xMmiopMB3Uz6eW_EoQioGec_1737596861
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 6:34=E2=80=AFAM Boyer, Andrew <Andrew.Boyer@amd.com=
> wrote:
>
>
> > On Jan 22, 2025, at 5:25=E2=80=AFPM, Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Jan 22, 2025 at 10:14:52PM +0000, Boyer, Andrew wrote:
> >>
> >>> On Jan 22, 2025, at 5:07=E2=80=AFPM, Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >>>
> >>> Caution: This message originated from an External Source. Use proper =
caution when opening attachments, clicking links, or responding.
> >>>
> >>>
> >>> On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote=
:
> >>>> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> >>>> [...]
> >>>>
> >>>>>>>> --- a/drivers/block/virtio_blk.c
> >>>>>>>> +++ b/drivers/block/virtio_blk.c
> >>>>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_m=
q_hw_ctx *hctx)
> >>>>>>>> {
> >>>>>>>>  struct virtio_blk *vblk =3D hctx->queue->queuedata;
> >>>>>>>>  struct virtio_blk_vq *vq =3D &vblk->vqs[hctx->queue_num];
> >>>>>>>> -   bool kick;
> >>>>>>>>  spin_lock_irq(&vq->lock);
> >>>>>>>> -   kick =3D virtqueue_kick_prepare(vq->vq);
> >>>>>>>> +   virtqueue_kick(vq->vq);
> >>>>>>>>  spin_unlock_irq(&vq->lock);
> >>>>>>>> -
> >>>>>>>> -   if (kick)
> >>>>>>>> -           virtqueue_notify(vq->vq);
> >>>>>>>> }
> >>>>>>>
> >>>>>>> I would assume this will be a performance nightmare for normal IO=
.
> >>>>>>
> >>>>>
> >>>>> Hello Michael and Christian and Jason,
> >>>>> Thank you for taking a look.
> >>>>>
> >>>>> Is the performance concern that the vmexit might lead to the underl=
ying virtual storage stack doing the work immediately? Any other job postin=
g to the same queue would presumably be blocked on a vmexit when it goes to=
 attempt its own notification. That would be almost the same as having the =
other job block on a lock during the operation, although I guess if you are=
 skipping notifications somehow it would look different.
> >>>>
> >>>> The performance concern is that you hold a lock and then exit. Exits=
 are expensive and can schedule so you will increase the lock holding time =
significantly. This is begging for lock holder preemption.
> >>>> Really, dont do it.
> >>>
> >>>
> >>> The issue is with hardware that wants a copy of an index sent to
> >>> it in a notification. Now, you have a race:
> >>>
> >>> thread 1:
> >>>
> >>>       index =3D 1
> >>>               ->                      -> send 1 to hardware
> >>>
> >>>
> >>> thread 2:
> >>>
> >>>       index =3D 2
> >>>               -> send 2 to hardware
> >>>
> >>> the spec unfortunately does not say whether that is legal.
> >>>
> >>> As far as I could tell, the device can easily use the
> >>> wrap counter inside the notification to detect this
> >>> and simply discard the "1" notification.
> >>>
> >>>
> >>> If not, I'd like to understand why.
> >>
> >> "Easily"?
> >>
> >> This is a hardware doorbell block used for many different interfaces a=
nd devices. When the notification write comes through, the doorbell block u=
pdates the queue state and schedules the queue for work. If a second notifi=
cation comes in and overwrites that update before the queue is able to run =
(going backwards but not wrapping), we'll have no way of detecting it.
> >>
> >> -Andrew
> >>
> >
> > Does not this work?
> >
> > notification includes two values:
> >
> > 1. offset
> > 2. wrap_counter
> >
> > if ((offset2 < offset1 && wrap_counter2 =3D=3D wrap_counter1) ||
> >     offset1 > offset1 && wrap_counter2 !=3D wrap_counter1)) {
> >        printf("going backwards, discard offset2");
> > }
> >
>
> No, Michael, this does not work in our programmable hardware device, beca=
use it is not software.
>
> -Andrew
>

Should we send a patch to disable this feature and cc stable first
then consider how to fix this?

Thanks

