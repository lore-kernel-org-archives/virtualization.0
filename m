Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037318FA34
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604808; cv=none; b=TnshP4gl2KL+6hSTnV3NbzDfnFA5RBMUoXToVjorihrUc+ZTJB2UpU8XZF82H+3MrL8TOTJVoKSQr5W0bstttTcHKapwt0sW8noHApOGYatLVjEkVsLgV47mBcQX3RQyua7pLge0dX0cRmXzzSwdbCqU9r9ZC9k9HJlP7/kqSEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604808; c=relaxed/simple;
	bh=LZFnsJhlMMXmLcnLjHwif3Tko8RTPA1FKx72W7VDpJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2xdflbeUe8p30FnwmdNxXOwJhrImrGbbBqKAS3t5rmWPQnhVSD+CSGT2dyPJNpywQUFifMkHjDYtvCndSNaxZyWbqRjVWVHnpJZ5DS4S3JrZdNeVo/IjgJKG/wZHvNTjMcfd9x3xkdUNKltwPOcbOaAyscB4Gh/r9aNJnqJse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YatCsrQp; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YatCsrQp"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32AF140533
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 09:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cDZ2InbjZxc8 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 09:46:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF9AE40292
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF9AE40292
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YatCsrQp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF9AE40292
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720604803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr3Fzy04+IjAcueeHCouhzEQFA2vb2X2x/Lajkzkytk=;
	b=YatCsrQpJ/OO0CxDVg2fqzIj8akACHno4x0xxpaagEwisLr/+FQ+51BbnL5/6uNPkVtVI4
	PH1xwL70j94+hs503mPBKFJSKk5Yhg+1piLEA28LlIH5kZ/oE1RKUKGr3rEXJiOklf1CDe
	BJumird57RJt5nbMQl9xklVeOVTuZRQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-O11A05VMPU6Pl3qxmCUHIA-1; Wed, 10 Jul 2024 05:46:42 -0400
X-MC-Unique: O11A05VMPU6Pl3qxmCUHIA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee49ce152eso58622601fa.3
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604800; x=1721209600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr3Fzy04+IjAcueeHCouhzEQFA2vb2X2x/Lajkzkytk=;
        b=kX32aI7S0uryox9H0aDf8TQatw4QlrTytEpSdd8bYst4HU8DAwzHs+llS9ZbPAnfqK
         RLGGZWKgvg//knNOvwTCRlLlZlrM7L9MtGnusmRP5+zXH9ktcM82c+pXAGOLTsTBj77f
         bBnt7GAbBbZU65nY3O04Ur+ETRpDumh1Q/ccmXpprwmAnOCzLxGPAcM4SX8O4za4+8T+
         A04K5lNmN7fosRQ1UduoKvkvelBaXd8bSkBerp/hXphldxZ4THN10gBXKRZX2LYp8YwD
         5pP64lNrXPyTq0uWhXvyCz0wLfhw16iz38ESP3eHR+aHgdgX5yNwkX/JAPUFM0AOwvwV
         ioMw==
X-Forwarded-Encrypted: i=1; AJvYcCXzmT6nexrLRGOSu9JlbGc5T+J8cabuuORxI4oynHcw6sqa1mOK4qwNvn2JUH0q1UETN55253P7GxWaJHSTYaGuYzXVgequQUJ2qha0znhDsgTCQ/oKHCEKGQ==
X-Gm-Message-State: AOJu0YzHJ+TFtX7Y+rzO8hVGclXyBPj0NNkZI49kVlvK0x5/J3I08aFC
	odW3i1uypNoOXoypC4aKcwA1clFu1XZIBGKN7uCJMFheSGNFS3uC0/lctUmQmgU0IwMKjwbc/Nx
	5njg0cc2VylqM2xTgMBSaMm/g4qj+qvNERG45zwkbnBfvzDuoYIyhYVWPDlv9vfy5q07iDZ8LG0
	KKev80efVpIzB8TZif9rGcDpfLueUI9+mRwzrCcqop7iIx8ISLkPV+ig==
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id 38308e7fff4ca-2eeb30ba01bmr30673251fa.2.1720604800509;
        Wed, 10 Jul 2024 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ffFCw3VbNM6Vw/r2MqpTFMKw6bcckSDGxnXr5Oj3vP+HBV03PNXiHpFH5GB2HlKHopl3lyeXuVt4nS1YdPI=
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id
 38308e7fff4ca-2eeb30ba01bmr30673101fa.2.1720604800176; Wed, 10 Jul 2024
 02:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
 <20240709084109-mutt-send-email-mst@kernel.org> <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
 <20240710020852-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710020852-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Jul 2024 17:46:02 +0800
Message-ID: <CACLfguW0HxPy7ZF7gg7hNzMqFcf5x87asQKBUqZMOJC_S8kSbw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Leonardo Milleri <lmilleri@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 at 14:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:05:48AM +0800, Jason Wang wrote:
> > On Tue, Jul 9, 2024 at 8:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> > > > On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> > > > >
> > > > > Hi Cindy,
> > > > >
> > > > > > From: Cindy Lu <lulu@redhat.com>
> > > > > > Sent: Monday, July 8, 2024 12:17 PM
> > > > > >
> > > > > > Add support for setting the MAC address using the VDPA tool.
> > > > > > This feature will allow setting the MAC address using the VDPA =
tool.
> > > > > > For example, in vdpa_sim_net, the implementation sets the MAC a=
ddress to
> > > > > > the config space. However, for other drivers, they can implemen=
t their own
> > > > > > function, not limited to the config space.
> > > > > >
> > > > > > Changelog v2
> > > > > >  - Changed the function name to prevent misunderstanding
> > > > > >  - Added check for blk device
> > > > > >  - Addressed the comments
> > > > > > Changelog v3
> > > > > >  - Split the function of the net device from vdpa_nl_cmd_dev_at=
tr_set_doit
> > > > > >  - Add a lock for the network device's dev_set_attr operation
> > > > > >  - Address the comments
> > > > > >
> > > > > > Cindy Lu (2):
> > > > > >   vdpa: support set mac address from vdpa tool
> > > > > >   vdpa_sim_net: Add the support of set mac address
> > > > > >
> > > > > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++=
++++++++
> > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > > > > >  include/linux/vdpa.h                 |  9 ++++
> > > > > >  include/uapi/linux/vdpa.h            |  1 +
> > > > > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > --
> > > > > > 2.45.0
> > > > >
> > > > > Mlx5 device already allows setting the mac and mtu during the vdp=
a device creation time.
> > > > > Once the vdpa device is created, it binds to vdpa bus and other d=
river vhost_vdpa etc bind to it.
> > > > > So there was no good reason in the past to support explicit confi=
g after device add complicate the flow for synchronizing this.
> > > > >
> > > > > The user who wants a device with new attributes, as well destroy =
and recreate the vdpa device with new desired attributes.
> > > > >
> > > > > vdpa_sim_net can also be extended for similar way when adding the=
 vdpa device.
> > > > >
> > > > > Have you considered using the existing tool and kernel in place s=
ince 2021?
> > > > > Such as commit d8ca2fa5be1.
> > > > >
> > > > > An example of it is,
> > > > > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55=
 mtu 9000
> > > > >
> > > > Hi Parav
> > > > Really thanks for your comments. The reason for adding this functio=
n
> > > > is to support Kubevirt.
> > > > the problem we meet is that kubevirt chooses one random vdpa device
> > > > from the pool and we don't know which one it going to pick. That me=
ans
> > > > we can't get to know the Mac address before it is created. So we pl=
an
> > > > to have this function to change the mac address after it is created
> > > > Thanks
> > > > cindy
> > >
> > > Well you will need to change kubevirt to teach it to set
> > > mac address, right?
> >
> > That's the plan. Adding Leonardo.
> >
> > Thanks
>
> So given you are going to change kubevirt, can we
> change it to create devices as needed with the
> existing API?
>
Hi Micheal and Parav,
I'm really not familiar with kubevirt, hope Leonardo can help answer
these questions
Hi @Leonardo Milleri
would you help answer these questions?

Thanks
Cindy
> > >
> > > --
> > > MST
> > >
>

