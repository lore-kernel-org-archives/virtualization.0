Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F565C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 08:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8612B414E4;
	Tue,  8 Nov 2022 08:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8612B414E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CuZR7opW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ej4L1MXq-p9v; Tue,  8 Nov 2022 08:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A42DF410B8;
	Tue,  8 Nov 2022 08:55:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A42DF410B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79F7BC0032;
	Tue,  8 Nov 2022 08:55:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3636CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 08:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1058381445
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 08:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1058381445
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CuZR7opW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6UMJWL_JkUC0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 08:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 478E38140D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 478E38140D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667897756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yipTWvAKK59+UDaW0mZvnxyflOnwLDwk1GJZlatPJg=;
 b=CuZR7opWThqtdRZIOQ7ABJ9I837OHqlJUjwEEnGY/U6703VbTypXmJCcVCvkkbNNqA6LQd
 wca/zo0HAtS+BNKMobAdYr6ywp/dT0dpmORPzBskKQ+l9Y7Qjz+iSnFUPEVqjkfEZCw9eX
 wlBTCEEjcI2shXeO0XfTkWAcx9DcXos=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-rJ8eH9LyPxuCsPuXr3_sVA-1; Tue, 08 Nov 2022 03:55:54 -0500
X-MC-Unique: rJ8eH9LyPxuCsPuXr3_sVA-1
Received: by mail-qv1-f70.google.com with SMTP id
 mi12-20020a056214558c00b004bb63393567so9380146qvb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 00:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yipTWvAKK59+UDaW0mZvnxyflOnwLDwk1GJZlatPJg=;
 b=UIHt5p3m4pg8f3sUEOxSd0VkZc2e1hZV6Wt8stLF3iHdPHbr7+skATtf6Gnj326lk+
 ZpdWHUJcdCnMYoBsnm6cuFBOiBY3MBgFw5XVjghDfWglAhjWOtgxAIjPnYA+6eV6UzmG
 Fw7U/eZLe/7W1hXF5uxIkioUk5st4/Z+ORkhDqxWOCfng/7vvmZ/z8tyCksbChYPAc8B
 wwDofFkCJiz5sWUfcjHiZLSRigOB29uPoCyBreIAYqhgSsygosNeQbayOdsn8RCHGS/k
 H+4j/pjFD9B6GWub83UChB4nK9HuQ+c2gzgSrmGtbRkusADovjidbdSpKmhSM8KGBz6z
 upKQ==
X-Gm-Message-State: ACrzQf0lutIOBoJWaOzNOCFhwSzWmiKd22rI152UCR3tTzKvdU0rPK7z
 B9P3qYUkErqdx5tdB3lh1vK+l67yIEmUmJQhEBV98yhKdMnabYytS37j5DRetb5e2bIrbty8kX8
 /am2X2qFPpKh/3Xi9wAWxd00/ojbbJazwIzWBI1BGwg==
X-Received: by 2002:a37:603:0:b0:6fa:6fa6:1019 with SMTP id
 3-20020a370603000000b006fa6fa61019mr20362207qkg.27.1667897754407; 
 Tue, 08 Nov 2022 00:55:54 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4sAQ/1DJwa8nDgW33KcEepaQdX8eNEfpVaNQCy6RzDEu4X9alIhMotTbpwFmqZnXU/fXpW6A==
X-Received: by 2002:a37:603:0:b0:6fa:6fa6:1019 with SMTP id
 3-20020a370603000000b006fa6fa61019mr20362199qkg.27.1667897754116; 
 Tue, 08 Nov 2022 00:55:54 -0800 (PST)
Received: from redhat.com ([138.199.52.3]) by smtp.gmail.com with ESMTPSA id
 r16-20020ac87ef0000000b003996aa171b9sm7624944qtc.97.2022.11.08.00.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 00:55:53 -0800 (PST)
Date: Tue, 8 Nov 2022 03:55:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221108035142-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > Hi Michael,
> > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > >> and the guest gets rebooted, some MISS messages may have been
> > > >> recorded just before the reboot and spuriously executed by
> > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > >>
> > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > >> ---
> > > >>  drivers/vhost/vhost.c | 1 +
> > > >>  1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > >> index 40097826cff0..422a1fdee0ca 100644
> > > >> --- a/drivers/vhost/vhost.c
> > > >> +++ b/drivers/vhost/vhost.c
> > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > >>    }
> > > >>
> > > >>    vhost_iotlb_free(oiotlb);
> > > >> +  vhost_clear_msg(d);
> > > >>
> > > >>    return 0;
> > > >>  }
> > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > new iotlb?
> > > Isn't the msg processing stopped at the moment this function is called
> > > (VHOST_SET_FEATURES)?
> > >
> > > Thanks
> > >
> > > Eric
> >
> > It's pretty late here I'm not sure.  You tell me what prevents it.
> 
> So the proposed code assumes that Qemu doesn't process device IOTLB
> before VHOST_SET_FEAETURES. Consider there's no reset in the general
> vhost uAPI,  I wonder if it's better to move the clear to device code
> like VHOST_NET_SET_BACKEND. So we can clear it per vq?

Hmm this makes no sense to me. iommu sits between backend
and frontend. Tying one to another is going to backfire.

I'm thinking more along the lines of doing everything
under iotlb_lock.



> >
> > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > it, we really should drop that.
> 
> Yes.
> 
> >
> > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > and then cleared, iotlb is not properly cleared - bug?
> 
> Not sure, old IOTLB may still work. But for safety, we need to disable
> device IOTLB in this case.
> 
> Thanks
> 
> >
> >
> > > >
> > > >
> > > >> --
> > > >> 2.37.3
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
