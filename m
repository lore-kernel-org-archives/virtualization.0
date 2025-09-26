Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E92749D5
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875879; cv=none; b=BcRZtllCJi9Pkp6miuzkkacq2s7stgl0Q6VNYDzRCkx+vkRMteWFPes8B6mQewHd730dnCpbfGWXrBhk6Pp7WY59xLyUJqEvZAVNWmMM1MxE0F2fhowykV2zZkoxjixUfwfHs1Eve1L5vNX3+6NPGpUDrzeIICeXnukQaM2mAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875879; c=relaxed/simple;
	bh=l7ccryhsdYTnF0StFj5adAoUTTZjM7CJm2tdkS/IsoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/WRLy82+vaUskTQjnyCShQWk0OL+cGo8fRZGb0iTJaHbLraYs1M6i5pnrya3ACpZjdTYP4rDgGPzP80J5NOSSFDEGWp6G2IsB9C6RVLGCiips+dUDcx9BfvUd3F0j7Oj3BRskXwvSc4b2S4wXTZA5/bR81ApsMx5kntt/7m0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXb70RI3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXb70RI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758875876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWIS+M2+D+NxPOxD8BZpU+DFrxLryhzIK4I38vFOSLM=;
	b=VXb70RI36PXOLeg1jtM1fOYkOrPVttBOweR+HxRAxQb/DTNmXka2XObvYzuVBmhy6C6T2d
	ZdWizKVx2GmkTQP7VnDYb71B51m25CjoyK26TeOzNgnesdx6rVNSIFJT5ri7pDjUre4IWr
	I/bwg2fFsG1WLqJXIk1tDyIRGWYVHkE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Edq1UVCLPVmsnlFBFR6y2g-1; Fri, 26 Sep 2025 04:37:54 -0400
X-MC-Unique: Edq1UVCLPVmsnlFBFR6y2g-1
X-Mimecast-MFC-AGG-ID: Edq1UVCLPVmsnlFBFR6y2g_1758875874
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso3102237a91.1
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 01:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875874; x=1759480674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWIS+M2+D+NxPOxD8BZpU+DFrxLryhzIK4I38vFOSLM=;
        b=tcf2LzN7i/dBLMyYSfdWF7sRtUy6i1r47LS8sD8xLX98kbX6rrMXgmc0x4Yu5a0w2T
         Zy5FFS4Hs5pG0sj3oeJXR99nFozsevBguELUeBT+8xOVg8oVJn/Um1yDbN/NLDXMN/u8
         lPhZ4kWvfVqd3nl0Fr1KutUE3bXryYjTKyWAA8jO/nAto0TiaDy+5XdcUfWQAdCGnPc1
         JFXbIBtk3GwBxUKDktm6snxqecspBgZu52S3krGrK9vMvW5Tx3JeYfdflzMQBZ4y5FzT
         jeJghmjCLEo9lX5VmgVbbgEMsY6Kd00z1BQoyVGVz2lsFWL1asbqp//4BZ6+QfEkkGL4
         cNbg==
X-Forwarded-Encrypted: i=1; AJvYcCUICp0GmFA+ZmwF9ab/DVy0bQTwm2TqkV8y49sWNuxCmXm/2fn2l5ifh6pU0Wt6C0xRQ2RYP/QQKni8k7SmCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH1YOfGkCFexc0bjhmH4K4F9kc1W2GkWPEiD2/QBb1mF8rEi7P
	htQ4t2FaHvjMbEPvZwvixmzLWZbA9FLIgouOw7cF8wG0X4G+L/T9QghrH1ir1wCsNYC3w1ArUvK
	GO75g/3UKyPOKSJSKO1FA8pFZcElB2+HT0hGwLc3g/b0JdAVyHgkL50Pi1BRdMJsSdtvTsVdV8e
	VXyRp3QKDJ178JDulCLinX9Q6T7w1RID8YNWpmSazFjy0=
X-Gm-Gg: ASbGncsYVqF4L8gAoWGPD0zixj8x8qW++CQYupJWPUUCOp2htJaqRldGi1eK25VUrzJ
	S2RqHrn/+av9k8fOIZIngPF6hWxCgrUCYr/W7y8BsCik69H5FeFxs9Bi4RyJ4/J25/Mxkxkpo5F
	EtYiyJgtud8+RF2VKS6g==
X-Received: by 2002:a17:90b:1d12:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-33455ee3d23mr5868326a91.10.1758875873465;
        Fri, 26 Sep 2025 01:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNdP3jcqkB/SoDVWTNElXZF3uJPrDyZBO4hpIYz3HUA2RYGm5n9SzDuM3YCq9dzEN8BUadAUt14kF1KaNWMbQ=
X-Received: by 2002:a17:90b:1d12:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-33455ee3d23mr5868294a91.10.1758875873078; Fri, 26 Sep 2025
 01:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-6-eperezma@redhat.com>
 <CACGkMEvYw4=TPqQ=R51vYdgE786MWyPP0UcApiDhiCKWMQXR7Q@mail.gmail.com> <CAJaqyWcZGE0SD6Eed2WhiskYaSR0pSm3dMYf2j4TyfbZe3Qmrg@mail.gmail.com>
In-Reply-To: <CAJaqyWcZGE0SD6Eed2WhiskYaSR0pSm3dMYf2j4TyfbZe3Qmrg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 16:37:40 +0800
X-Gm-Features: AS18NWDaBIUtxrPONpil5WxsdzbxQccrHy2wvcmJyDtgutPrSWuat8Z7z0Ymi_4
Message-ID: <CACGkMEu6BcPfzuPFJ8REO6WGKmH+8n6S7c0Gjjzi+CP-q5kHQQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W6XyIZilvNQefPe3tP9Bvb7Aic8IcKQDlTQBe2X9UIA_1758875874
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:17=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Sep 26, 2025 at 9:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Sep 25, 2025 at 5:14=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v4:

[...]

> > >   * Structure used by read(2) on /dev/vduse/$NAME.
> > > @@ -334,6 +376,9 @@ struct vduse_dev_request {
> > >                 struct vduse_vq_state vq_state;
> > >                 struct vduse_dev_status s;
> > >                 struct vduse_iova_range iova;
> > > +               /* Following members only if vduse api version >=3D 1=
 */;
> >
> > This comment is confusing since padding exists before.
> >
>
> Ok that's totally right. Should it say "following members but padding"?

That's fine.

Thanks

