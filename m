Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78272156971
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688919; cv=none; b=asVzp9HK5DrJQnfVem+d0iKXkAcgQFJ1Gia3djjmdXVMxJt3ZhIUVvEzA2VXDrlMEVnNEAPH3owz72frXEXf3asDEeNx6p8Io678t68xk6XW3Un4xYLpLE2fTMLbT0LVYso2xI2M6LFhRCwoRwZlqECm++Oyw56QOklUxjD4DHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688919; c=relaxed/simple;
	bh=ljxzkssEHs7PsymbyswJfU5Htuhh01H9EMxCQUsejwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo+UNeRAWb5/15T/eayQGKfrsPsLBlNzwliRs12ObsvmAwvSDBJ9gXQUN90Vq5sfyUmqLFiwAveFmGJ9Dc94uEepnWrmjMKyA4uZL5ySWlw/JBxf4aPEs61xG3UsfaXQEMPhNFbirV+Yaux7HZ/EcrqY5J9D+CQOQzj/O5RIZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmIM+wmd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmIM+wmd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CF984100D
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 09:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PkWp1pc2HGdF for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Jul 2024 09:08:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lmilleri@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C983B4102C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C983B4102C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VmIM+wmd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C983B4102C
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720688915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/tGGgMXZufug5VbuEhcEzd7l9HFMjvswmFUFEeaDBA=;
	b=VmIM+wmdIcqkzDd55a00EeSUYAS3kMc/WZJt/B3FAbLyQSj08AxzVrfadM7jXee685vtn9
	P81hA0Rpvod00gWt6Jb8PnEEay4mZaGGCasxvsalLdM5MaT2kn2jYeR8HQNy0CYAtUjFUt
	LITXgpyFSWAykOhyTo+8FkMzdXclM94=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-14ZLuLDLMy-KM7U3USUT8g-1; Thu, 11 Jul 2024 05:08:31 -0400
X-MC-Unique: 14ZLuLDLMy-KM7U3USUT8g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee9308bc8cso5295271fa.0
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 02:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688910; x=1721293710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/tGGgMXZufug5VbuEhcEzd7l9HFMjvswmFUFEeaDBA=;
        b=fmxT9xfISfIBALn/5Mlkh4a8gcZ8tQ+GBNZ2dpJjeHQ0RVMi4gprKs38iBHjN2Ndfp
         xNSQyBalZZM/xOb0Egta7cCvRd/PPXiVtvNb8QVA+mWzqIYdjYvkLOY9QivGN9so5Qbx
         UYr+KO0PpGbrtPvzYCQQ/4Iys/Q5LspTJplAhK8ilfhCuKnaSzdHF3NdL9oTGpez/qaG
         lSLOC4bZZqySfHrwNqS0vB5mncflGMfwJkkmGFmOcmz92xPZ5N/ANMxMZIv5anDrwoCy
         lNUu4/3YMPXYq5MiXHdkQEWUnXdxpRgQ6VPSmjRwW8Mlh+wrthy7ldw5fUVSPZOOcegu
         K28w==
X-Forwarded-Encrypted: i=1; AJvYcCWf4+0vjQqL6fpWGno/NbjfwdMVBF67mkxW6+7d6u11o3dyFX94IgizOoCohY1EUrhOaG+ghg5y2b8w3Ch8jjTC+wgKyQu8NzvdlQNNZakTiQAYkMlHsidDSg==
X-Gm-Message-State: AOJu0YybTmpCGixf9eH9b69eN26x3i0FSy3dPWF7+ElyJIb4FSUPNdUq
	SEyE0WpQUVcGENIdRlMRtile3v10tBupHRxnA7ixD03sBxbZLpnG2fyq6DtVSXSomn815t4eslb
	gv5+7ag5tI1YYBREuQAYkRr/b0pX94Q+y+zQMEu/kJzGGt0tcW7GDpL4A5LOQRCjeibQMmlRTM7
	c0GT2f6dJvK+TF+lYxr6puUkDcFwoFkgvOwqrU1dnM0Wsws34epzCe/w==
X-Received: by 2002:a2e:a7c7:0:b0:2ee:5b64:b471 with SMTP id 38308e7fff4ca-2eeb30fefcdmr62447831fa.30.1720688910124;
        Thu, 11 Jul 2024 02:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6W3hcev+Z5OBlMg/D7fGaW0A5j3JIOurKm0/vCYKBrpnwOMpohSuAs0Uf+VCxUXTyOZqrGR6A60J2YxKWLD0=
X-Received: by 2002:a2e:a7c7:0:b0:2ee:5b64:b471 with SMTP id
 38308e7fff4ca-2eeb30fefcdmr62447591fa.30.1720688909618; Thu, 11 Jul 2024
 02:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
 <20240709084109-mutt-send-email-mst@kernel.org> <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
 <20240710020852-mutt-send-email-mst@kernel.org> <CACLfguW0HxPy7ZF7gg7hNzMqFcf5x87asQKBUqZMOJC_S8kSbw@mail.gmail.com>
In-Reply-To: <CACLfguW0HxPy7ZF7gg7hNzMqFcf5x87asQKBUqZMOJC_S8kSbw@mail.gmail.com>
From: Leonardo Milleri <lmilleri@redhat.com>
Date: Thu, 11 Jul 2024 10:08:18 +0100
Message-ID: <CAD2tU16x1aeZLcQrESroqz-5n=S0nkgh8QTQO31-yYF_7hqB=Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the noise, resending the email in text format

Hi All,

My answers inline below

>> Any specific reason to pre-create those large number of vdpa devices of =
the pool?
>> I was hoping to create vdpa device with needed attributes, when spawning=
 a kubevirt instance.
>> K8s DRA infrastructure [1] can be used to create the needed vdpa device.=
 Have you considered using the DRA of [1]?

The vhost-vdpa devices are created in the host before spawning the
kubevirt VM. This is achieved by using:
- sriov-network-operator: load kernel drivers, create vdpa devices
(with MAC address), etc
- sriov-device-plugin: create pool of resources (vdpa devices in this
case), advertise devices to k8s, allocate devices during pod creation
(by the way, isn't this mechanism very similar to DRA?)

Then we create the kubevirt VM by defining an interface with the
following attributes:
- type:vdpa
- mac
- source: vhost-vdpa path

So the issue is, how to make sure the mac in the VM is the same mac of vdpa=
?
Two options:
- ensure kubevirt interface mac is equal to vdpa mac: this is not
possible because of the device plugin resource pool. You can have a
few devices in the pool and the device plugin picks one randomly.
- change vdpa mac address at a later stage, to make sure it is aligned
with kubevirt interface mac. I don't know if there is already specific
code in kubevirt to do that or need to be implemented.

Hope this helps to clarify

Thanks
Leonardo


On Wed, Jul 10, 2024 at 10:46=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, 10 Jul 2024 at 14:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:05:48AM +0800, Jason Wang wrote:
> > > On Tue, Jul 9, 2024 at 8:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> > > > > On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrot=
e:
> > > > > >
> > > > > > Hi Cindy,
> > > > > >
> > > > > > > From: Cindy Lu <lulu@redhat.com>
> > > > > > > Sent: Monday, July 8, 2024 12:17 PM
> > > > > > >
> > > > > > > Add support for setting the MAC address using the VDPA tool.
> > > > > > > This feature will allow setting the MAC address using the VDP=
A tool.
> > > > > > > For example, in vdpa_sim_net, the implementation sets the MAC=
 address to
> > > > > > > the config space. However, for other drivers, they can implem=
ent their own
> > > > > > > function, not limited to the config space.
> > > > > > >
> > > > > > > Changelog v2
> > > > > > >  - Changed the function name to prevent misunderstanding
> > > > > > >  - Added check for blk device
> > > > > > >  - Addressed the comments
> > > > > > > Changelog v3
> > > > > > >  - Split the function of the net device from vdpa_nl_cmd_dev_=
attr_set_doit
> > > > > > >  - Add a lock for the network device's dev_set_attr operation
> > > > > > >  - Address the comments
> > > > > > >
> > > > > > > Cindy Lu (2):
> > > > > > >   vdpa: support set mac address from vdpa tool
> > > > > > >   vdpa_sim_net: Add the support of set mac address
> > > > > > >
> > > > > > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++=
++++++++++
> > > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > > > > > >  include/linux/vdpa.h                 |  9 ++++
> > > > > > >  include/uapi/linux/vdpa.h            |  1 +
> > > > > > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.45.0
> > > > > >
> > > > > > Mlx5 device already allows setting the mac and mtu during the v=
dpa device creation time.
> > > > > > Once the vdpa device is created, it binds to vdpa bus and other=
 driver vhost_vdpa etc bind to it.
> > > > > > So there was no good reason in the past to support explicit con=
fig after device add complicate the flow for synchronizing this.
> > > > > >
> > > > > > The user who wants a device with new attributes, as well destro=
y and recreate the vdpa device with new desired attributes.
> > > > > >
> > > > > > vdpa_sim_net can also be extended for similar way when adding t=
he vdpa device.
> > > > > >
> > > > > > Have you considered using the existing tool and kernel in place=
 since 2021?
> > > > > > Such as commit d8ca2fa5be1.
> > > > > >
> > > > > > An example of it is,
> > > > > > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:=
55 mtu 9000
> > > > > >
> > > > > Hi Parav
> > > > > Really thanks for your comments. The reason for adding this funct=
ion
> > > > > is to support Kubevirt.
> > > > > the problem we meet is that kubevirt chooses one random vdpa devi=
ce
> > > > > from the pool and we don't know which one it going to pick. That =
means
> > > > > we can't get to know the Mac address before it is created. So we =
plan
> > > > > to have this function to change the mac address after it is creat=
ed
> > > > > Thanks
> > > > > cindy
> > > >
> > > > Well you will need to change kubevirt to teach it to set
> > > > mac address, right?
> > >
> > > That's the plan. Adding Leonardo.
> > >
> > > Thanks
> >
> > So given you are going to change kubevirt, can we
> > change it to create devices as needed with the
> > existing API?
> >
> Hi Micheal and Parav,
> I'm really not familiar with kubevirt, hope Leonardo can help answer
> these questions
> Hi @Leonardo Milleri
> would you help answer these questions?
>
> Thanks
> Cindy
> > > >
> > > > --
> > > > MST
> > > >
> >
>

