Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA321459F6
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068749; cv=none; b=SN+cEwyNUySplZELsFXjWNqazAWsqXp26O2WKmjhDVhP/ssAMNDOLKG88fjy9N0QntK5fkgpmCrWTm2nWfUuUqGcO8Iqyg87pJIIAp4lgoJ1/vAQ8EUUeA5Dj6VkUyYMv8h+0FKDquxQiQcU3tAqtM8+neq14nQbpFrJiTqt2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068749; c=relaxed/simple;
	bh=OOowEg/kEpwQ0lfAfbo1RCLo+763fhF3zIXfDo/uL2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb+ehCicYLYYHtHCQi4MqUgtMTaB/W6LDkfxOIo92SUv6tjRRWeXRX71OIWhEJNf2iRxOFXP76/2k5GQbYyF6cBRXrKUnWWHLgIKuq4PvOOIpuVhxu4qG7SJ2M129/svshlkro9479DeI1Se6DIlp3GeJhUCfSBf/4hULvaTCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2gMUaDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2gMUaDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760068746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTGZcY56/dokYZNCRBhJDePRYFdQBXGbtHcTvy8LlVQ=;
	b=b2gMUaDeZF9TP2rDmWmdqVF4uGYjeD4kIUXI7SaW19yG5RjQTiZ9sN9bNB4pzxhc/U3CiG
	tPFDWWrigg6ZjiLgzpPyxxmqQQpU4mT3ae5KKjWOp+GCk2QsFvbAnp+wRnHbgbwdQlq5SL
	92Wi3cYZwpCZCp/leg0t/yE90Sp/d+w=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-18L7H65tPrm5Vvz9F_3m5g-1; Thu, 09 Oct 2025 23:59:04 -0400
X-MC-Unique: 18L7H65tPrm5Vvz9F_3m5g-1
X-Mimecast-MFC-AGG-ID: 18L7H65tPrm5Vvz9F_3m5g_1760068744
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso4423586a12.2
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 20:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760068744; x=1760673544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTGZcY56/dokYZNCRBhJDePRYFdQBXGbtHcTvy8LlVQ=;
        b=S5vt3pSuJ8VtmoIi6k0O8rgTkv7nRfBjwxj8P4VmXT6WOfkwfNVpFSKzbwsslQ9sy/
         BLhY6FHlRjFkFcyE2C0GjWIS5xxEGnYKLB7Im0fWgP61TAf/qTNCFDKr0UECZtnuALQz
         69vjmRfn6EsUG94EuXvCLxMa2heWm/H0tXNhXrpfgiGQ95LLK6BY2EbI7v1bQGSU66Zf
         B8kUOsThIE1KaPEwoISJ82/Es1b3/4egHyXAxpL619TNxqTdi9wFTvjCoohjjI5xa/dJ
         +3C4rUISwUaG9BveFybQtM3dTNr2TtHvWcc1vpV2TDGj+xZ++/IBaARBi7AYOpwS1zrX
         +PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8VQ3eeD15XeXJ7m3wDXexpAr2k/PO6Fy1Zf3qfobRdv6w/TC0jw/8/XhdSVtcQe6hOu+pNSNcZOX+Z+GrWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj/dSO3kEyWgSBGEp2gTpa8hjEirkGChw8VroDEu+Xp0oplWQc
	YWtZoRnuAKwPDowICNqQryOyYd47ruuVhm4BuCE+KWXaAVd2qKMIpbXZBlnfsgILA0EeISWgNfs
	zxmQ9r4ui7km1W/GujOVieym7/n0s6ppa6V8+PWSg3Sgah58S1JhW7koeFxw8wlXTyn7CginaCi
	QlPwyf0SRnhIyiz5QhoWZmswhyvGLSD1KhZYEXXiYQW5A=
X-Gm-Gg: ASbGncuq5OuVLQOPa4zeD5I6lVO73nyDSPl1NeXrGnPMHXrNGWzwnVQF0pPNHuMbnIM
	KR1qlmAf7v1xeuidzHtg+up4ZHwQ4WPRrcqr6LkDzoKhhBXTyg04AuO9ypwa8VEo44HYQDRP5EH
	gInaiKzDXfbBhYLHyKtCB0Fg==
X-Received: by 2002:a17:90b:1e05:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-33b51162572mr14729297a91.12.1760068743877;
        Thu, 09 Oct 2025 20:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3LgHkeItfKnzksx2+VbTfs5eW8tDQx+zY+LgfqMUL2flkA6GpUP6M0cgBlsLMGMJv8UZaOLmaiFPSWsXCyYM=
X-Received: by 2002:a17:90b:1e05:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-33b51162572mr14729270a91.12.1760068743399; Thu, 09 Oct 2025
 20:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251002103537.308717-1-eperezma@redhat.com> <20251002103537.308717-3-eperezma@redhat.com>
 <CACGkMEucnJMs0QcH4ggourizEGsvkzF-d_OYXy0XBeU_opdNAQ@mail.gmail.com>
In-Reply-To: <CACGkMEucnJMs0QcH4ggourizEGsvkzF-d_OYXy0XBeU_opdNAQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Oct 2025 11:58:52 +0800
X-Gm-Features: AS18NWBtRCPzDFJG5Q7UQQXe3VTwnoyqKwTQOUsdAeF4GtUTRJFpiT8J0K9euhI
Message-ID: <CACGkMEtG_zbbXPx8ZYfCm09GG4hRVeEQp6FBFzXZLP_-PrvCJw@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: allow to specify device-specific features if
 it's multiclass
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, 
	=?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NqUNmKz1Ewh-5FWDzaEd83_7texj99zCyjWc5RSeEZ8_1760068744
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Oct 2, 2025 at 6:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Even if the device supports more than one class, there are ways to solv=
e
> > the ambiguity of which device are we creating.  In the VDUSE case it is
> > the name, for example.
>
> This may only work for VDUSE but not other parents.
>
> >
> > RFC: I fon't understand 100% the motivation of this limitation, as the
> > backend should be the one filtering out the invalid features if any.
>
> I think we can avoid these tricks. Currently, there's a one single
> mgmt device, this seems to be in-convenient. Could we have a per
> device mgmt device? For example, if user space creates vduse0, vdpa
> mgmtdev show may see vduse0 so we won't have this issue.

Or if we specify the class, there won't be ambiguity.

Thanks

>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 34874beb0152..0fc32f3bd66f 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -688,15 +688,6 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_=
buff *skb, struct genl_info *i
> >                 err =3D -EINVAL;
> >                 goto err;
> >         }
> > -       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> > -           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> > -           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> > -           config.device_features & VIRTIO_DEVICE_F_MASK) {
> > -               NL_SET_ERR_MSG_MOD(info->extack,
> > -                                  "Management device supports multi-cl=
ass while device features specified are ambiguous");
> > -               err =3D -EINVAL;
> > -               goto err;
> > -       }
> >
> >         err =3D mdev->ops->dev_add(mdev, name, &config);
> >  err:
> > --
> > 2.51.0
> >
>
> Thanks

