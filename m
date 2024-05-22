Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5259164
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349304; cv=none; b=YwdYnAlNPlxLcCfFp6NwTlRp8JS3A9sQSYhECf7k3ED0NG/3SZ2d8aYF2BkI0/niKVdXh6lLXM6B3w5km0y18i2b++lFXuaui9wZMrUoeGYcsMveGZvCi1iNZLOnLonLMR6hQ2FIUBtF8jkZtIkX6zeSM6bEmycfpWOJtmyhIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349304; c=relaxed/simple;
	bh=tDhOr5kYoJBPVbGFQ/5F4YX6f0w+bGwhd66V63gckoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO8yU5wm226ue8lq/varyl0ssyKpgsIZpqQOh0Us4OQ+nvRs16J21YZOhRachqqskkSHi1UFd1CZsNQ7qxhJcYPAsC9EGCsjDlwLrpfjM5JbFw0DLj2C6ObF4qFEFv4Bbbh0CoFZ+aWJaiYPWIwqE7P8LExophl0FTJD2cUfNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahoyer2M; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahoyer2M"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF0AF401D8
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwioZF1K35sn for <virtualization@lists.linux-foundation.org>;
 Wed, 22 May 2024 03:41:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9F63E401B7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F63E401B7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahoyer2M
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F63E401B7
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1UghrBASr9ke1BFJrNMmDxAz9OCEkeq9HPICdhp1JU=;
	b=ahoyer2MEzajdy86FDrQPbsAWgomzn+mMGxgel3/4ygYo80FK7nyJCV67bxEj+dTCPlh3D
	+SNqIfxunoP73R0wyKQAvgxT17lAzW8FD9PNb7HYN+1CYd+Lh7pEWCANVDTbpz3ZPoT4xq
	RSEMxfGf7s0rXjQKctx+dXKtEx1YjUI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-eMvpCwkRM2qi-r_whXHPoQ-1; Tue, 21 May 2024 23:41:39 -0400
X-MC-Unique: eMvpCwkRM2qi-r_whXHPoQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b432dfdcf6so11961253a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 20:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349298; x=1716954098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1UghrBASr9ke1BFJrNMmDxAz9OCEkeq9HPICdhp1JU=;
        b=J0ME329nyNUr4gETkn7qj3nemsQ9lQMUIZu5Baz7rMxURq2MyUjLu59bwdHdMuAPgY
         5n6D+Hk9zA7+b0S+jOLJU+DcKhWFGQ0nyOj85ydX5n12RdnYGjRsYYRV7dT2j9PBPEoD
         /8cI7KXc9C78s9fnFA5pf9eaQAJDgffNEhReVbGtqZAUGpUcBAC/3+XeCuK750bXq+aH
         aLBAR1+2JEU6MX5a+y4NQtOc00D3irXY6+p0o7dbxO2ESifXJ8e0aXUdyo2QfZS/eVkf
         qFjpRhuuS8zVWkYli1LFEIxGDcORWUexHxlPa2kxa3kehNCYNZlkwdyAbkO6BTeWo2VN
         Yi2g==
X-Gm-Message-State: AOJu0YwywL1XZVZ4s7xevPukkFFvvyTD0wAYV0o6AX2pVDQyFOQjC4lj
	Dp6pvIQfKyUM7+bos/QvEVyNokMzdkm6LHMCPLiZKwUzkDk5aAAfGt8Kcgeo02PM1VveZNl1YjV
	yXLe3Y8LRPQEjituX341KiKHFeZ3Hm5weSlo1HIeHOCRUfc60SFBjIdkbAcY9JGxjCvkzRxqDPt
	xb38hntoNRdkIewZoN5Cr06HIsUTbVmYDqID8DsOBUapbllxTUc5jxVw==
X-Received: by 2002:a17:90b:1994:b0:2b4:39dc:8639 with SMTP id 98e67ed59e1d1-2bd9f5cc2e8mr895495a91.46.1716349297422;
        Tue, 21 May 2024 20:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbchEQIMvyIRMvxk6QWEiH753Wga+j6LEMLJsBEdaFFXOVWzyqH+OGUN96Vz6pEs1SqT+9zyHuGj3lBxKMa8=
X-Received: by 2002:a17:90b:1994:b0:2b4:39dc:8639 with SMTP id
 98e67ed59e1d1-2bd9f5cc2e8mr895486a91.46.1716349297127; Tue, 21 May 2024
 20:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
 <CACGkMEvhs_-wD4p-i2VCmQnmdNPLsH9FkhkGePB5LxZQf4B30A@mail.gmail.com> <c4b73d50-2896-4bcc-ae61-6d72f9471978@oracle.com>
In-Reply-To: <c4b73d50-2896-4bcc-ae61-6d72f9471978@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 11:41:26 +0800
Message-ID: <CACGkMEsgs3YjeeW9Ji5AcVcL4_qs8PAD7+uQ-P3H7MGYRKpEcw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] vhost-vdpa: flush workers on suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:39=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 5/20/2024 10:28 PM, Jason Wang wrote:
> > On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> Flush to guarantee no workers are running when suspend returns.
> >>
> >> Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> ---
> >>   drivers/vhost/vdpa.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index ba52d128aeb7..189596caaec9 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -594,6 +594,7 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *=
v)
> >>          struct vdpa_device *vdpa =3D v->vdpa;
> >>          const struct vdpa_config_ops *ops =3D vdpa->config;
> >>          int ret;
> >> +       struct vhost_dev *vdev =3D &v->vdev;
> >>
> >>          if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>                  return 0;
> >> @@ -601,6 +602,8 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *=
v)
> >>          if (!ops->suspend)
> >>                  return -EOPNOTSUPP;
> >>
> >> +       vhost_dev_flush(vdev);
> >
> > vhost-vDPA doesn't use workers, see:
> >
> >          vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> >                         vhost_vdpa_process_iotlb_msg);
> >
> > So I wonder if this is a must.
>
> True, but I am adding this to be future proof.  I could instead log a war=
ning
> or an error message if vhost_vdpa_suspend is called and v->vdev.use_worke=
r=3Dtrue,
> but IMO we should just fix it, given that the fix is trivial.

I meant we need to know if it fixes any actual issue or not.

Thanks

>
> - Steve
>
>
>

