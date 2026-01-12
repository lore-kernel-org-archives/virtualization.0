Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5CE334361
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204281; cv=none; b=qjaZVciWc8DTajgBmYS7TVDph2jHV5dheqzn7YCpL46KYJMOqeKe6ckx8XmWaJhJUipZLK0FSrhVA8+u1qTi0EShN5xh7mamMj9tIhypXgmGQ+lKRRPq/+WxhXiAfyCh0+BaK2FZPTvje7FIYKUJBFuAr4sFODBKd//YaJ4NIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204281; c=relaxed/simple;
	bh=RZ2tvxsmCX24uDJ15IaQlTZnLPgbaybYzUjgCZwB0Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIewGWpfghmSdWdvwOHy6sGK0YXFGz3QQHHFavovqpqGiWxLvlqYrPMezV5yLQBXu4f5pfiVwnQT0Z532Xuxo1D8Um6EUWIm7trIr4411jU05ZVKfXLvn+tgWptRC1w2NmxtJatTq6/kkVKaL4gIS0jFRg+8PfxBA08K3H6fnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwrRH8br; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwrRH8br"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768204279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9bJY82Em3XUvTofO2LCM2TVTZj/AMPkAh8qf5d6z064=;
	b=cwrRH8brG/v1idyBZgeOFKP7WOoEuOkgu4XTrV3yBor/TkGvWi1ygoa8XrZ2eBNRaTkeIw
	7idlui0LvkF8UjllKBiqZqUd5jhYZ/DH+JHUANTxZWNq864+jQw7t4wjzMzvJUnXwtIEnH
	mmR07DmUVrRrudT4URY7VcQXb8X3rBI=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-zYWRNML7PWyoH1V3ErH5Ag-1; Mon, 12 Jan 2026 02:51:17 -0500
X-MC-Unique: zYWRNML7PWyoH1V3ErH5Ag-1
X-Mimecast-MFC-AGG-ID: zYWRNML7PWyoH1V3ErH5Ag_1768204277
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6446ee26635so8627626d50.1
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 23:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204277; x=1768809077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9bJY82Em3XUvTofO2LCM2TVTZj/AMPkAh8qf5d6z064=;
        b=oz4McB4aNvKAzgsj/K8fmCg+icuidmvXVa8752LewKuIHPi/yM3qSTTzVqicUR8oi4
         U6p0cJ5FQySjzg3jBOh3TlEQViyLdW3xJYdMuCTf3v2C8QkUkoRgAp9t4tX58H1DGqoQ
         0LTaaBxmtpMWAXtP4KEk73r8QNr/6aXijEl3UDhIWqP/ba0kT2oXSVII4QFtgyTueCO/
         NI2y111AXHxbUnt0DLkDL35O18B+xNQS8zpuofVQHxMihUxF2zhfXAOGjGtfSyPJ+T0F
         jAdBZfBHUQeArY3fxkgPuvzA5vWkBXF7PDMUhxqc0Loa55vZA6Eb0dgsFuCtk7o45Xlc
         vVNw==
X-Forwarded-Encrypted: i=1; AJvYcCXqG76SpbqD/hHDwBznLh6B4n2lDIss7sWntLPLwCgkLrvXWL9K97qpcoPDaA0nE0T+cv0Kk7jhd8hHvlGFcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgxH7kqcGbotOML8eGn7VRwgCE9gdWBRAJDHUurtJIS3Oi+9MX
	2Q0IoQKiZAVXF7cXaTng9fMmqTiJi4cel8IKXPeo+KyJojwD1acjVkBLVRH3rdp/SfHd6Pt+MuA
	Y5wMwmcBO/7K3wkSvwH5tG71+p9OLR7f7gAjr0uW58tK3LlrEAXdblk3EBVr3g8/PLIEzMGEhwY
	c7ZqlyxJRrC2iEh86+0E+hsuqKa1j2h1CH5qQOXQXilmQ=
X-Gm-Gg: AY/fxX7A+vLj7B7wy6UEKEM0KQ7PX7cpb8WBrIvq1rLkcSWgZSHlp8ryRhTKlvY8t8M
	ps1dC5+2ZPvb5oY9NTS7gncFVLvt/Xv9EpeVtjzx34u/d+LwJn5SFEidpFSRPHXajtuSj9jBN6y
	2x8qq8Y7gDagEDUmROedF8ta/XqUb4vCP6jKmY9k4+1JOdsutTA7PCJkQKtEsoLl8nNw==
X-Received: by 2002:a05:690e:1347:b0:645:5811:fb18 with SMTP id 956f58d0204a3-64716c4fbb8mr13450314d50.69.1768204277095;
        Sun, 11 Jan 2026 23:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSoAVPZ76gBUWclQgB+n+WMM7Auuq0lIBfLAZMNJcTIGsTykA48PA2nx+rshasSSj2Ohr3Zq2LVDn6P6nYOJY=
X-Received: by 2002:a05:690e:1347:b0:645:5811:fb18 with SMTP id
 956f58d0204a3-64716c4fbb8mr13450302d50.69.1768204276835; Sun, 11 Jan 2026
 23:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-7-eperezma@redhat.com>
 <20260110184849-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110184849-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 08:50:40 +0100
X-Gm-Features: AZwV_QipQZhHoM64tG7IdERJrSkNPvhfpkB_JBclyoUcRkvsoI_MNkrMNQ5bUbw
Message-ID: <CAJaqyWeDu6+KBFAg0jNSS=zZWSc2Q0qnd=9bB+NdxvMDLunCZw@mail.gmail.com>
Subject: Re: [PATCH v11 06/12] vhost: forbid change vq groups ASID if
 DRIVER_OK is set
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ONEQIXtwSCmbbN1cFxtxUYaoIOylbsxkFY3Z2hNs9pI_1768204277
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:49=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:24PM +0100, Eugenio P=C3=A9rez wrote:
> > Only vdpa_sim support it.  Forbid this behavious as there is no use for
>
> behaviour
>

Fixing in the next version, thanks!

> > it right now, we can always enable it in the future with a feature flag=
.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 9d25b735b43d..3f0184d42075 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -682,6 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdp=
a *v, unsigned int cmd,
> >                       return -EFAULT;
> >               if (idx >=3D vdpa->ngroups || s.num >=3D vdpa->nas)
> >                       return -EINVAL;
> > +             if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
> > +                     return -EBUSY;
> >               if (!ops->set_group_asid)
> >                       return -EOPNOTSUPP;
> >               return ops->set_group_asid(vdpa, idx, s.num);
> > --
> > 2.52.0
>

