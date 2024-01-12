Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D91399
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jan 2024 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDWPUS54"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FDAA40486
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jan 2024 02:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FDAA40486
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KDWPUS54
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JLHQ_hbArpg
	for <virtualization@lists.linux-foundation.org>;
	Fri, 12 Jan 2024 02:28:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0BF3B402E5
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jan 2024 02:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BF3B402E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705026513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeTVuqKhv2fZpIVKNAyi6YXBAGL4wvIDq7FTTj/zUOY=;
	b=KDWPUS54N/ajjRS5+kJ5msgxkjX/hqRhIYeB5uJz6CkRzkMhKup85fbuw1rRFqO0Ie9IVl
	MCDoeQweYehnNUaWzYt5kaRUNmoFU68rePjdfmhysjid39+yqxY1bI9t1OnxNEisEPyYrf
	s6j1LppVLBxfoLyeb53vZJToH6SKmHI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-OBnKOPj0OemR7gM5FfhtNw-1; Thu, 11 Jan 2024 21:28:31 -0500
X-MC-Unique: OBnKOPj0OemR7gM5FfhtNw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5986f8b675aso5150450eaf.1
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 18:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705026511; x=1705631311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeTVuqKhv2fZpIVKNAyi6YXBAGL4wvIDq7FTTj/zUOY=;
        b=OJ5VHn9sdtwg14fS1Ka6LvjnT0A73zZh/BcY0q6SV32yhBgUWpUnZlrXksoKJzlHPm
         d6quB3JIP0jvgRopzcLBKDKvKqGEj9yvBkPM0WZnqEZwkcTzByZsEwdq6f7ESPP8hSoE
         +Eae4xH9EAWPPMXKAsOZycn5Ijbv6Gv/kQrxRSDEiuMd4kOQTUbf7lzNlMTeUZU0Ix0x
         J4Pj4rAmzItqUMy1KrbmRq2/woxE1zzo3pzDYZREfzOqkqxf1lxB6vPsJMfB2m2cWvAE
         JnQMb5ZXhjxeNXxIkEtgvz/1YyWdIyvKmpaQkF1tJgmeJM57HMlfEWxK/1HkDQqfjzOu
         nxZw==
X-Gm-Message-State: AOJu0YyHR3MoKmVqEerQ6FLmLDFP+OROoG+1zo6RTnhMTQ4BG/GIFmsB
	FCOLZgwiQ48Um6fUXIgLFiR/oYjtlZzyB+BFc4n2heeGUQz2VuezoUfTgm1YaPQIBTVBQqugDbA
	M7UmXHngUTYKfhF9Fh+OvdPaZQZEVQ/nkqYDzmaAK1ih9zWb6mp4F7OgZD4NnYJzZ4A==
X-Received: by 2002:a05:6359:6405:b0:175:73dd:ee6 with SMTP id sh5-20020a056359640500b0017573dd0ee6mr834033rwb.16.1705026511026;
        Thu, 11 Jan 2024 18:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW2Xnn8PKemp66RnUzbjDWcA8NmUcSTIp22CxywvzfTM4hSUKnYchGYy+sQaujDdCaWL+asHJAAQd+ixoedHw=
X-Received: by 2002:a05:6359:6405:b0:175:73dd:ee6 with SMTP id
 sh5-20020a056359640500b0017573dd0ee6mr834029rwb.16.1705026510741; Thu, 11 Jan
 2024 18:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
 <CACGkMEv8TXXTrCW=hf1sJ+V2a0eD3w1b1Yub4FnGZ0=Du-RbtQ@mail.gmail.com> <11ebc73f-6469-4c97-9da0-0728edfb283a@oracle.com>
In-Reply-To: <11ebc73f-6469-4c97-9da0-0728edfb283a@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Jan 2024 10:28:19 +0800
Message-ID: <CACGkMEs1sf6NWT76fM+D715kqrwJ56SAXrcExKvWH_AYsjcGJg@mail.gmail.com>
Subject: Re: [RFC V1 07/13] vhost-vdpa: flush workers on suspend
To: Mike Christie <michael.christie@oracle.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Eli Cohen <elic@nvidia.com>, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:18=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 1/10/24 9:09 PM, Jason Wang wrote:
> > On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> To pass ownership of a live vdpa device to a new process, the user
> >> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> >> VHOST_IOTLB_REMAP to change the user virtual addresses to match the ne=
w
> >> mm.  Flush workers in suspend to guarantee that no worker sees the new
> >> mm and old VA in between.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  drivers/vhost/vdpa.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index 8fe1562d24af..9673e8e20d11 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -591,10 +591,14 @@ static long vhost_vdpa_suspend(struct vhost_vdpa=
 *v)
> >>  {
> >>         struct vdpa_device *vdpa =3D v->vdpa;
> >>         const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +       struct vhost_dev *vdev =3D &v->vdev;
> >>
> >>         if (!ops->suspend)
> >>                 return -EOPNOTSUPP;
> >>
> >> +       if (vdev->use_worker)
> >> +               vhost_dev_flush(vdev);
> >
> > It looks to me like it's better to check use_woker in vhost_dev_flush.
> >
>
> You can now just call vhost_dev_flush and it will do the right thing.
> The xa_for_each loop will only flush workers if they have been setup,
> so for vdpa it will not find/flush anything.

Right.

Thanks

>
>
>

