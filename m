Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F5BC4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 09:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE0388199D;
	Tue,  8 Nov 2022 09:14:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE0388199D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CSPMtxeD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgq5YJpRrfoz; Tue,  8 Nov 2022 09:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 792F0817D3;
	Tue,  8 Nov 2022 09:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 792F0817D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33C8FC0033;
	Tue,  8 Nov 2022 09:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1055EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAF5360C27
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAF5360C27
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CSPMtxeD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RbDF9ZJE543
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03472606F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03472606F2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667898846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V76xZRdJF90cto+eNTfmdr62lIvdE2c1NcFAYSKdle4=;
 b=CSPMtxeDvPjU2mX/CrY6KeG/lVysw0XqRuNZHD16yBk+hJFMySv0pQR7vjQkDiUZeUS9IN
 Vn/5Br0C9mrrzpRzlQMrVcysCWqwZb95GPvz9I7VPB1+cDtHmgGICgpAWiFFrsIsHpW+cU
 88KokRXSiYtI5Mw63PAeArpHJ9ypT0I=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-BeTMPK6sPu6McsdA8_-Y7g-1; Tue, 08 Nov 2022 04:14:02 -0500
X-MC-Unique: BeTMPK6sPu6McsdA8_-Y7g-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13d553369a0so6979052fac.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 01:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V76xZRdJF90cto+eNTfmdr62lIvdE2c1NcFAYSKdle4=;
 b=CYjl65Wbnl0zirLZjic8o1EjMx/0Z2aKlf++hU1Sw9ESJ3DJoNvz0aAPx/hWelsMee
 VjGRL30tYaWiiSSQpQmnJCCwY7nji8S97+FG62ror7NnkdhiQF1IELMNZsc1IoqNKKn4
 0hVpf2NRbA9h8caCwM8J5V44U3XQnGGq8cs+NnHyP97yyX+nuwEnGbWAoi9Vn4fq6dzG
 yC3Kz8q+KEmj8zuGjF7kXEXDx6EZaEKYmdGbbR74RlX90IiOwfFjMGihCNn/OOBkogCW
 f3KdZwUVT8OzJeViS8SlE/ZKcK9cHjzQoeur4Y0xg2tXSNwz/qaUU8YJGo/crBD7AmDS
 kxBg==
X-Gm-Message-State: ACrzQf3tspgtX301Ckcv0B17bYCL0282rZylPhGsLgAbE+Xr1opvxBkA
 xgAKx6tiK/yoGxx+MWpMd5I9OPOGHgQX4LGkMOTtx/6Cl4g0NRv8l7jhp8qp9SvqAeyWhO/CBux
 gGn5vcxtNLV4BFL5Z1BDd6BKi/FFIfc40d/O74ZL0EuE48DKfD2VIG2tvEA==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr12605626oib.35.1667898842132; 
 Tue, 08 Nov 2022 01:14:02 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4BhHQXBK0rCa4T6dbx0EVI/Ylq8zyZOMDMURFlkMUxZJxMkfdr0MI6/RWsCNdB4MxuJjGKjU+X+8yWsgsh5K0=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr12605616oib.35.1667898841877; Tue, 08
 Nov 2022 01:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221108035142-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Nov 2022 17:13:50 +0800
Message-ID: <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Auger <eric.auger@redhat.com>,
 eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> > On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > > Hi Michael,
> > > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > > >> and the guest gets rebooted, some MISS messages may have been
> > > > >> recorded just before the reboot and spuriously executed by
> > > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > > >>
> > > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > >> ---
> > > > >>  drivers/vhost/vhost.c | 1 +
> > > > >>  1 file changed, 1 insertion(+)
> > > > >>
> > > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > >> index 40097826cff0..422a1fdee0ca 100644
> > > > >> --- a/drivers/vhost/vhost.c
> > > > >> +++ b/drivers/vhost/vhost.c
> > > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > > >>    }
> > > > >>
> > > > >>    vhost_iotlb_free(oiotlb);
> > > > >> +  vhost_clear_msg(d);
> > > > >>
> > > > >>    return 0;
> > > > >>  }
> > > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > > new iotlb?
> > > > Isn't the msg processing stopped at the moment this function is called
> > > > (VHOST_SET_FEATURES)?
> > > >
> > > > Thanks
> > > >
> > > > Eric
> > >
> > > It's pretty late here I'm not sure.  You tell me what prevents it.
> >
> > So the proposed code assumes that Qemu doesn't process device IOTLB
> > before VHOST_SET_FEAETURES. Consider there's no reset in the general
> > vhost uAPI,  I wonder if it's better to move the clear to device code
> > like VHOST_NET_SET_BACKEND. So we can clear it per vq?
>
> Hmm this makes no sense to me. iommu sits between backend
> and frontend. Tying one to another is going to backfire.

I think we need to emulate what real devices are doing. Device should
clear the page fault message during reset, so the driver won't read
anything after reset. But we don't have a per device stop or reset
message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
my mind.

>
> I'm thinking more along the lines of doing everything
> under iotlb_lock.

I think the problem is we need to find a proper place to clear the
message. So I don't get how iotlb_lock can help: the message could be
still read from user space after the backend is set to NULL.

Thanks

>
>
>
> > >
> > > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > > it, we really should drop that.
> >
> > Yes.
> >
> > >
> > > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > > and then cleared, iotlb is not properly cleared - bug?
> >
> > Not sure, old IOTLB may still work. But for safety, we need to disable
> > device IOTLB in this case.
> >
> > Thanks
> >
> > >
> > >
> > > > >
> > > > >
> > > > >> --
> > > > >> 2.37.3
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
