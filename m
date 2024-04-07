Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66A5223
	for <virtualization@lists.linux.dev>; Sun,  7 Apr 2024 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460258; cv=none; b=OjsCbhBNtn5gGhjd/cLT3S4SLGdwrdv7uKGeIDHafqffQQEGUBGRwgl3Pez5YAB6CXlUnqignglkhuDlCQLwJR+U+gFN1+FpOLNUuRzuLCoJxw5/z24vvsV5JwMjVXOuusfBBTiKOSiX9CSZHfnvWaF1n/pGMHthUofFIADEvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460258; c=relaxed/simple;
	bh=avNLGOjDVhisrZeK5myUOE2ae08MglbbeQHmIGiFyzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkH5dP38mPHMSKRj2HJXm74LVohRXH61RUDuAeUNu3HGJkndPHVGaaJcTk7obSiUnfRLUvxEN84ilwPGyEuh9/ohmZ8dnHaoJAs6s6JDoU6OMWPU3OnlEKpdhp8fMIWr2Y5+PwwAeFRLOt/kQFLBzJe8FqH+JpylKAnk22N0Gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V23sc3EZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V23sc3EZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712460255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4llMbGOtb9G+H32W8HlzHWTqpdsqaxj/w9vQVxNuic=;
	b=V23sc3EZHcm8G7IXWR2i44BAuwc/cKjBuBtArXvTAEAiI7T/YtO7BgyWVXEWXYYHrfGxv5
	nR5ePSeUVJzCcuv+00jG9JZj78QAo1jx4ad6GhsMDD2vFDNLQGDl4dncrpRcbCM2+qe3wO
	MCybZMYDDP8wb8c6xQAHhpVfc46CMOw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-_f2TVBDyNEWWjKFO54ZykQ-1; Sat, 06 Apr 2024 23:24:13 -0400
X-MC-Unique: _f2TVBDyNEWWjKFO54ZykQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5d7d6b971so55091239f.0
        for <virtualization@lists.linux.dev>; Sat, 06 Apr 2024 20:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712460252; x=1713065052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4llMbGOtb9G+H32W8HlzHWTqpdsqaxj/w9vQVxNuic=;
        b=YsbPUwkJZiVCPwzXD1otqxtFJOy8Cw/qivYkhEQGTVaPF2Uq+mm9xlXx72oGvxzCpN
         fRYooR/Xx6kzadN+cIlWPabCXDzvQQk4P2A3Me5Lq/95KvikGcniRUtstQXS2srLkS4N
         SBpky9aAaHioN+PAB+psk2LLBx4BTkfDLgBLAWokxja9QtxvzMEzMtc010E3q2jom7Ez
         PeF5BNCbnzPE7/EGLZA7+PeQMDSi4e2PqHqFJ0WlO12F2VEfuIiLNRfd+JCvFfeeKnTV
         dq/GQzvBOJVq7Y13xvyxgt2O9ZqrDprabORsySSwKdCDZ+8NmEjhTi03WwcB0jmMqRpI
         cblg==
X-Forwarded-Encrypted: i=1; AJvYcCWLkRc4VCP/Nk7DyOEdouWBNsIFh8dE9kgWG8vzG1BtNUj9FoQBVKCXBAIyCbSfEgrMujmo+UrzFqcZMWc3p0Bb9Z0hFnFxQZ37Kvu+veU=
X-Gm-Message-State: AOJu0YzbFleGjZy875fnsPVcigclAXoC3e3uBZ73zU4v+FQ7WVSj0J3r
	t6AF6AD33euU6vESeJnMwf9mqeWf8WjrIGp+gVhBFdtnLxxH7Y28UhPFo2zgw9w1vv3WJ2h15aF
	LDB3GMDHs46zWYNpdF/Gn9GEWMLipSJAQFK7hBrl4yo2DqIAHQxGjysxooKQWuhiFAZujl+Nr87
	g10aQB8YOJAgZkuIDXf3OiWmn6NwJHdWyLiguQKdc=
X-Received: by 2002:a05:6e02:190b:b0:36a:1104:2d6e with SMTP id w11-20020a056e02190b00b0036a11042d6emr6626507ilu.1.1712460252245;
        Sat, 06 Apr 2024 20:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+3rRdgaxZRF8TpZU5PIXKR1yFdG7fJfb4neaG7xOdFbZTliP+Thd8FNrQj3g1PkMbZPEVqyeFMfwhDwn56Uk=
X-Received: by 2002:a05:6e02:190b:b0:36a:1104:2d6e with SMTP id
 w11-20020a056e02190b00b0036a11042d6emr6626487ilu.1.1712460251972; Sat, 06 Apr
 2024 20:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327112136.2897479-1-schalla@marvell.com> <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240331072925-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240331072925-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 11:24:00 +0800
Message-ID: <CACGkMEsGVxz=SSNS1y+duz0Bw1c9ot_fGG+Bz8vkKkiOwQWhig@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 29, 2024 at 12:34:34PM +0000, Srujana Challa wrote:
> > > > +static void octep_vdpa_set_config(struct vdpa_device *vdpa_dev, un=
signed
> > > int offset,
> > > > +                                 const void *buf, unsigned int len=
)
> > > > +{
> > > > +       /* Not supported */
> > >
> > > We probably need to filter out VIRTIO_NET_F_ANNOUNCE and other
> > > features that depend on the config writing.
> > As per modern virtio spec(v1.2), device config is read only for the dri=
ver.
> > Still do we need to filter out these features?
>
> Yes I didn't get this either. What is VIRTIO_NET_F_ANNOUNCE?
> VIRTIO_NET_F_GUEST_ANNOUNCE?

Yes.

> And how does it depend on config
> writing?

My bad, it should have nothing. So the part looks fine.

Thanks

>
> --
> MST
>

