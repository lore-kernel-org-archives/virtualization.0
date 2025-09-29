Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765D1F5EA
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126064; cv=none; b=Qtwwk+uD7UpXrTs5olT5Q9vJwGCmHavVVwYTNYTPdlZ8GT/qqkwHTqpanPadZb+7wTCZxfEcFBbN02xKie9PkkmwPGRdVs41C3IiKO46aH4MIJYCSdiie2/adh1cIlueONTqIsFgfziSnUDNOVUgJN2+07PNxicnpgXfd/qq47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126064; c=relaxed/simple;
	bh=IbEySVpKbLCFuZ9rrIjdK5cqttbR+AKe+UCoV2F1p5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxfHon2CDDx/sendYe4AYBDia7vkVB1KvveWmYMZfCXM6ogmcUip72PHXNLnx451HzJzU0tT++XvJKm5fsgdNcRCwWw0bX1hCKgrC2rQafsfuSoroH88zYa3G3NiC4XgOYoz96IIpFqtgOqgRebl1XQrX+g5QjOFA9KpMSIFueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPRmIJZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPRmIJZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759126062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBfJ6EZcrzpxQaUNzV7H/FmOU4A4hPZpwBb7rVCM3A0=;
	b=iPRmIJZ/O41BWHt9Bib6WEbZCsG9dw66mAo/o6tJ9/p3NWUauMi1kgExwXGQ9TDcE6KetC
	N7DrWNnva2d4Gj0rqIrrqaXpz5rMovTRlyn0Q8IzkOqWlkl/wsR1EuJfZvK8aqq+g7YCqD
	1DchwJx2//qOoKhddzKFQkDAQvKajZk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-9xFJT4nQN7OHXN85wMvVZg-1; Mon, 29 Sep 2025 02:07:40 -0400
X-MC-Unique: 9xFJT4nQN7OHXN85wMvVZg-1
X-Mimecast-MFC-AGG-ID: 9xFJT4nQN7OHXN85wMvVZg_1759126060
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7436271d14cso61741647b3.1
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 23:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759126060; x=1759730860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBfJ6EZcrzpxQaUNzV7H/FmOU4A4hPZpwBb7rVCM3A0=;
        b=iIXwx2PHgZ24xNeVXjNdP3YASxvxB1b0RAmapFPmOWEI//JMtqIKl/Vnp/PiKSHPYm
         fVkz/+CqJ1yq0jYwP6Tf08W6Xm/miysnB3NjDFyi4Q2k9/cEdZEr08YrWB/J1HEJoILG
         VBvGYxsPj69vCQ13p6myeIZtgvi5ye3H/HtNwsCzeNvrKkf7wm9GuIW+RAE628+HVTb0
         xoe7REDCoSBL8s9PAFeW3z9CTkD+hQDQiRGxhNXQvlOeKaW1u6lHYksoPD17gDrK+qK9
         lmX/wyizUjpHnupc1Y+rW6JiDXa1KB+T1qYBMsAG6mRYtfukrkoUyjvLv3suVBEqLqr4
         0+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXp1Ywbsl6W3RiZrl/lOf4phgp7JQri9TN++VRZLtYLuYooSdCHbDdVAdH365U7w+LZgJy64X8pwm97bxKZMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCF2nuMrXWOE47WH1KTV+FnIStD1WtToQtndfcOvH8G+YgPwtT
	H1z9Z1FibRR4dKWaHUA++2t3iB9edR6GIWH+zlpR7090NLWeFDnF1FEf5EmlbYOsb/lAWFhHzdm
	Qsc/Jh+iCDLsd5rynQK9oJWYc9uMD2zAyqVo7SXdaIbfpRkdXnWfXjrhaJ8H08n3nWybFjoAAEJ
	bgp5dJhse3aYIicVVRIgBizI+rhUYcVXPMvYzfoa2fIOY=
X-Gm-Gg: ASbGnctzOvQ6fBjxd0V4ewkFQTELK79rGKMqVSEVsF2QoWOBUu/Y6z1sTvNcFjAYeOi
	xap6wC3mee7a9o/X5TT9tauYfTA3WLADYTBlc2GdkljamUAc8IHEOMY4jpNT1GIflwDctgt7r0a
	1IRyn6SeSIfuYdBT1dkSeE0nvxtgFnBxSsgsrquhg9pUHqFLssji83myuvTznRd50Qc+0LnfdHm
	EL6t657
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id 956f58d0204a3-636dddd2be7mr7496556d50.20.1759126059832;
        Sun, 28 Sep 2025 23:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHruQhakXa8wGOKerNcye69UaAM4mVrSZQ9uhbK5P04HWTKnvPzXlUqVP3RMbc5y1i8ThnHdTlq1SvY2ch1664=
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id
 956f58d0204a3-636dddd2be7mr7496534d50.20.1759126059494; Sun, 28 Sep 2025
 23:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
In-Reply-To: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:07:03 +0200
X-Gm-Features: AS18NWC7XMXAuGMO8Eptz-Q_otll5LtJWRETocFL-g0lU0gc6j4WgNxpmozonlI
Message-ID: <CAJaqyWc58wnym96C79E-tG6yBvem5skE3M3vdzBxMYX0aNJVLQ@mail.gmail.com>
Subject: Re: vduse: add vq group support
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KBf1vKXzStjFaVQOhfwyjxEuNz4VOFP6EbG56ioYHLg_1759126060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 4:22=E2=80=AFPM Colin King (gmail)
<colin.i.king@gmail.com> wrote:
>
> Hi,
>
> Static analysis on linux-next has found an issue with the following commi=
t:
>
> commit ffc3634b66967445f3368c3b53a42bccc52b2c7f
> Author: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Date:   Thu Sep 25 11:13:32 2025 +0200
>
>      vduse: add vq group support
>
>
> This issue is as follows in function vhost_vdpa_vring_ioct:
>
>          case VHOST_VDPA_GET_VRING_GROUP: {
>                  u64 group;
>
>                  if (!ops->get_vq_group)
>                          return -EOPNOTSUPP;
>                  s.index =3D idx;
>                  group =3D ops->get_vq_group(vdpa, idx);
>                  if (group >=3D vdpa->ngroups || group > U32_MAX || group=
 < 0)
>                          return -EIO;
>                  else if (copy_to_user(argp, &s, sizeof(s)))
>                          return -EFAULT;
>                  s.num =3D group;
>                  return 0;
>          }
>
>
> The copy_to_user of struct s is copying a partially initialized struct
> s, field s.num contains garbage data from the stack and this is being
> copied back to user space. Field s.num should be assigned some value
> before the copy_to_user call to avoid uninitialized data from the stack
> being leaked to user space.
>

That's right! v5 of the patch fixes the issue.

Thanks!

