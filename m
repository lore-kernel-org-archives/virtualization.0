Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC171C433FE
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 09:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A54184058;
	Tue, 31 May 2022 09:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4c3_lK9_TKb2; Tue, 31 May 2022 09:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E09CE84044;
	Tue, 31 May 2022 09:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C59C0032;
	Tue, 31 May 2022 09:23:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47314C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 09:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F8E284050
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 09:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5jtbqv1gsjhJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 09:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 541C484044
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 09:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653989006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1t1NBmkNMBO5DYdEINGWFlHVzMhXZpx3lk8YtT0vEg=;
 b=W6wc+5ouBAahyhZbpUPawAdMewMw2yGzFt6g41+AbVnREWipdHvpP7tGGLzDbhAxjXd4cU
 /wanc2jL5QP0MdOwgnUyM/78HjtcUWNlcvpKjqd61o2+iZ3vjoy7C4eJLFfua9nbne4/zA
 YQ4AasMqpHBVEBDnXb4MvgBh18vf4Xg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-xadnTmHdPGSTkN4m6ZKPyA-1; Tue, 31 May 2022 05:23:24 -0400
X-MC-Unique: xadnTmHdPGSTkN4m6ZKPyA-1
Received: by mail-wm1-f69.google.com with SMTP id
 m26-20020a05600c3b1a00b00397220d6329so985606wms.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 02:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=R1t1NBmkNMBO5DYdEINGWFlHVzMhXZpx3lk8YtT0vEg=;
 b=u1BH/SUETo4Scqo/viiWhtE2SGD/lQxsxKnuDm++3G+cS5YXViV1rs6rQXGD3weLOm
 +AMaLNtOv5I2c9MzTA1nAh+7s4t1RWGuCQT9MeBVg1yYg+GUV34ijOJYhRJDE2I9oPOB
 BI0E4FODysb/XEhS7Ir17vLTAYTLm6iK2QdRj14upie7W3wPSbWQFG1x/2XWz1GBOZ27
 JhQT+T0N4+p83IRuPJroFjusYlBmrvcj1MaF9Ng42Q39URwsatu0Ct+6jhAGKMWIY/xU
 LfzDE1Z6+bJCj9C0tc731a8R7GLWmu1a5G+loaTmWszXwJJCMtxFFaHyvZ3lMntwIVS0
 Oe1g==
X-Gm-Message-State: AOAM530nrsCv2/ANm23FDn/mxM8uC7/LiiUeQCMAL8TWWqtKeit1p9Me
 Duyz+mjWPcEncUxq17Lr4A8JHG/znOLSp4PSAm41qyhrBNXEeVb4JNRhUNrpX9fCW7hdUWzTTlZ
 PjmnX/73XrRtWNkd9c1COKuGiZZ8jkezb9sVwLI+DaA==
X-Received: by 2002:adf:fb0d:0:b0:20d:97e:17ce with SMTP id
 c13-20020adffb0d000000b0020d097e17cemr50794553wrr.585.1653989003673; 
 Tue, 31 May 2022 02:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzXciEmGxzFbd78RU5NlgInASiXlfG+r9fWr3h5yZzU+8WJoDJl/m3AngyKgTZnA+DlsQGmQ==
X-Received: by 2002:adf:fb0d:0:b0:20d:97e:17ce with SMTP id
 c13-20020adffb0d000000b0020d097e17cemr50794524wrr.585.1653989003358; 
 Tue, 31 May 2022 02:23:23 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 k66-20020a1ca145000000b0039c15861001sm1605939wme.21.2022.05.31.02.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 May 2022 02:23:22 -0700 (PDT)
Date: Tue, 31 May 2022 05:23:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Message-ID: <20220531052240-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <20220531014108-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRSD6xiS8DROkPvjJ4Y4dotOPWqUzaQeM3X=q_XgABdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfRSD6xiS8DROkPvjJ4Y4dotOPWqUzaQeM3X=q_XgABdw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm list <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, May 31, 2022 at 09:13:38AM +0200, Eugenio Perez Martin wrote:
> On Tue, May 31, 2022 at 7:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 26, 2022 at 02:43:34PM +0200, Eugenio P=E9rez wrote:
> > > Implement stop operation for vdpa_sim devices, so vhost-vdpa will off=
er
> > > that backend feature and userspace can effectively stop the device.
> > >
> > > This is a must before get virtqueue indexes (base) for live migration,
> > > since the device could modify them after userland gets them. There are
> > > individual ways to perform that action for some devices
> > > (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> > > way to perform it for any vhost device (and, in particular, vhost-vdp=
a).
> > >
> > > After the return of ioctl with stop !=3D 0, the device MUST finish any
> > > pending operations like in flight requests. It must also preserve all
> > > the necessary state (the virtqueue vring base plus the possible device
> > > specific states) that is required for restoring in the future. The
> > > device must not change its configuration after that point.
> > >
> > > After the return of ioctl with stop =3D=3D 0, the device can continue
> > > processing buffers as long as typical conditions are met (vq is enabl=
ed,
> > > DRIVER_OK status bit is enabled, etc).
> > >
> > > In the future, we will provide features similar to VHOST_USER_GET_INF=
LIGHT_FD
> > > so the device can save pending operations.
> > >
> > > Comments are welcome.
> >
> >
> > So given this is just for simulator and affects UAPI I think it's fine
> > to make it wait for the next merge window, until there's a consensus.
> > Right?
> >
> =

> While the change is only implemented in the simulator at this moment,
> it's just the very last missing piece in the kernel to implement
> complete live migration for net devices with cvq :). All vendor
> drivers can implement this call with current code, just a little bit
> of plumbing is needed. And it was accepted in previous meetings.
> =

> If it proves it works for every configuration (nested, etc), the
> implementation can forward the call to the admin vq for example. At
> the moment, it follows the proposed stop status bit sematic to stop
> the device, which POC has been tested in these circumstances.
> =

> Thanks!

Oh absolutely, but I am guessing this plumbing won't
be ready for this merge window.

> > > v4:
> > > * Replace VHOST_STOP to VHOST_VDPA_STOP in vhost ioctl switch case to=
o.
> > >
> > > v3:
> > > * s/VHOST_STOP/VHOST_VDPA_STOP/
> > > * Add documentation and requirements of the ioctl above its definitio=
n.
> > >
> > > v2:
> > > * Replace raw _F_STOP with BIT_ULL(_F_STOP).
> > > * Fix obtaining of stop ioctl arg (it was not obtained but written).
> > > * Add stop to vdpa_sim_blk.
> > >
> > > Eugenio P=E9rez (4):
> > >   vdpa: Add stop operation
> > >   vhost-vdpa: introduce STOP backend feature bit
> > >   vhost-vdpa: uAPI to stop the device
> > >   vdpa_sim: Implement stop vdpa op
> > >
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
> > >  drivers/vhost/vdpa.c                 | 34 ++++++++++++++++++++++++++=
+-
> > >  include/linux/vdpa.h                 |  6 +++++
> > >  include/uapi/linux/vhost.h           | 14 ++++++++++++
> > >  include/uapi/linux/vhost_types.h     |  2 ++
> > >  8 files changed, 83 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.31.1
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
