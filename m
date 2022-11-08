Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6E7C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 03:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED8B7401C0;
	Tue,  8 Nov 2022 03:09:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED8B7401C0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gt5BsXtq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKGAqMaemodl; Tue,  8 Nov 2022 03:09:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 595F640940;
	Tue,  8 Nov 2022 03:09:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 595F640940
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD73C0032;
	Tue,  8 Nov 2022 03:09:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB5EFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 03:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F20F40940
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 03:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F20F40940
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id snXBCATJ6Gab
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 03:09:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 502B140894
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 502B140894
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 03:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667876991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRtjwtaorg58e8Zp57TXoIs8WKp2QJ/obFRTRLN8svw=;
 b=gt5BsXtqytXDTrdPTblfnFAmvccL973DTQhHo9bsgg/AnfpWVibraFRMHepOYj1YbgM2Vb
 nTXCnB7r5q7/WxkIL+Mrsr2E5yRFP34ozuxsF0jr5Gi8O7tjlvwk0fAXzsY6ZP2UhDtTOo
 gGjkgGhWRiza6JQvzMrnP4Bi7F62qT4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-mu1wDjMNOmOUukR3p6xfJQ-1; Mon, 07 Nov 2022 22:09:49 -0500
X-MC-Unique: mu1wDjMNOmOUukR3p6xfJQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13bb98bb80fso6583949fac.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 19:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRtjwtaorg58e8Zp57TXoIs8WKp2QJ/obFRTRLN8svw=;
 b=sGayI63WuJ8Yf/aypp47r8pSsdBc3xvXEyZuXAZ2gQljJw1/0FLaserER8UlHvQVWz
 2rMPoZMVS+NH7H42wvKdSXtzDHT/t58vT1TlY9jDykJkoySdN0AE2woW4XqUizt8GFH7
 ePMDBBrbnb1npCJdjBmzS8bvTkCwuaburCEUCEyaRbbFQwIPfW3wzjFSPYhtS5FJEN/x
 EZ4l++BFv1cJP2kFvVX7W03cMfYnq8wa2cZPUiRQgH/2Pu/ARduobX/ggN4aEV7K2xLT
 e3xKAc4Mw4CcG3Td68AYMTIKMN2FAjhSs7FXkcCaTzk7EMaC5IBsVdGmjuA8m+U3iDFz
 Yj1w==
X-Gm-Message-State: ACrzQf3igpPqvAHYKz5b+0s8D0wq26qLRNkOvnMGjLo82EXWCRHB7cZj
 dmiYOobxcdirm/GNgW4RZHtOodLivpNMDge4MHW9/D8jOSP60KYz9tyPuN13rMpQ/pKCiCA0ciC
 l45WXg3Y3PYcVVgmE1otzW+EyU1+80GpMSgvzJE4E4cQatqMlWaZdTVSwpA==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr12052289oib.35.1667876988614; 
 Mon, 07 Nov 2022 19:09:48 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6BPJN6+RWLjuJmH1wJzS9NwxgnfXhSRGMuXsqjkcXwG8HMP9YZ06ug0yaAFlWBN/rcTRqzjG9mlnOGGsXVDR8=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr12052272oib.35.1667876988328; Mon, 07
 Nov 2022 19:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221107180022-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Nov 2022 11:09:36 +0800
Message-ID: <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
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

On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > Hi Michael,
> > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > >> When the vhost iotlb is used along with a guest virtual iommu
> > >> and the guest gets rebooted, some MISS messages may have been
> > >> recorded just before the reboot and spuriously executed by
> > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > >> re-initialized, the messages are not cleared. Fix that by calling
> > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > >>
> > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >> ---
> > >>  drivers/vhost/vhost.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > >> index 40097826cff0..422a1fdee0ca 100644
> > >> --- a/drivers/vhost/vhost.c
> > >> +++ b/drivers/vhost/vhost.c
> > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > >>    }
> > >>
> > >>    vhost_iotlb_free(oiotlb);
> > >> +  vhost_clear_msg(d);
> > >>
> > >>    return 0;
> > >>  }
> > > Hmm.  Can't messages meanwhile get processes and affect the
> > > new iotlb?
> > Isn't the msg processing stopped at the moment this function is called
> > (VHOST_SET_FEATURES)?
> >
> > Thanks
> >
> > Eric
>
> It's pretty late here I'm not sure.  You tell me what prevents it.

So the proposed code assumes that Qemu doesn't process device IOTLB
before VHOST_SET_FEAETURES. Consider there's no reset in the general
vhost uAPI,  I wonder if it's better to move the clear to device code
like VHOST_NET_SET_BACKEND. So we can clear it per vq?

>
> BTW vhost_init_device_iotlb gets enabled parameter but ignores
> it, we really should drop that.

Yes.

>
> Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> and then cleared, iotlb is not properly cleared - bug?

Not sure, old IOTLB may still work. But for safety, we need to disable
device IOTLB in this case.

Thanks

>
>
> > >
> > >
> > >> --
> > >> 2.37.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
