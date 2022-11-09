Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1412C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 03:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 496194173B;
	Wed,  9 Nov 2022 03:39:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 496194173B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6snXiY7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CfRDlsqSMx9s; Wed,  9 Nov 2022 03:39:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53DE941736;
	Wed,  9 Nov 2022 03:39:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53DE941736
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 214E7C0033;
	Wed,  9 Nov 2022 03:39:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23882C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AD7A60E6D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:39:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AD7A60E6D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6snXiY7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ITZLuqn6Zgq6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C43A60E6B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C43A60E6B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667965174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcRfMGDR57T6McLNYaj9+wh/c5mo5rhH0w8+9LE63fE=;
 b=X6snXiY7a2hzT8i7UxyYUri7vy9hFMzzxAKm0RRyYW4K5rl8L4yLkBinCLSrTXOmVLjsvn
 Jj2HCMo9uPASATCNIicyVyhe75bP9WppIKk+mvJstWP58fMbAN7VLMBguOes9L490mr5cK
 i2nlb0ezHvd5pb/U8TiujBd9Upg++0M=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-NZwdybzxM5C4ZMIXVF9IWQ-1; Tue, 08 Nov 2022 22:39:32 -0500
X-MC-Unique: NZwdybzxM5C4ZMIXVF9IWQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 r17-20020a056830135100b0066c3ca9c6d8so7814257otq.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 19:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OcRfMGDR57T6McLNYaj9+wh/c5mo5rhH0w8+9LE63fE=;
 b=vrz3UUGGlyCf04bhQXD/Y1xM8Qjbq2i6QuLp8bOSn/imcO+OnSSmuB3MxR2+J4P+I5
 NCBkntVQx5RDTPN0nUFZgyQzFWUbLDYM4gcpjBmh/4hz2a59P5dXrm55kSLA3on0B6Gp
 R6+PwQniXFD5SZ5NT+UVRaaaCGowElmPzOdobuqkcVuiE8EzoE7O5Enm+L7D9U+xeG6m
 Qb4jyGv/0TFtI5F8b+fhQkFgnVGyDrXM1YGOTbASMrpul2DUGzZaSSP2xeV4gI1k6SBG
 TmCJMUyy6LH6iIG0QVz9L1UowowU1IlGLAHJ70kw1SHeCthb64K0BdSBpfscZm3sCsss
 UUyg==
X-Gm-Message-State: ACrzQf274srC7noXPRXzH+Y6shBLnWth8AAY+0sfgZZgmVRDa8Z6Zp05
 tz6hEP/JQoDLeKRXEOl/ood6BVbU65IaAgCW/0AG8HUdfKLls2WoLWRnEjLI7JeO9FqlHk/ditV
 aezk/7jh+uaCDlyB7AUISMwpHH3ooEnAI3tcILBKAFS0f0JnwNwucrrRQVw==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr43418510oal.35.1667965172170; 
 Tue, 08 Nov 2022 19:39:32 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6IbP7wCQjQ/73WjHzwN93Q6Kmxzrb0cn8zveXWG8zANJYKg6GpnJHmpdmPfff7Nlsh5HW8PAE7iWVD1TlJexY=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr43418498oal.35.1667965171959; Tue, 08
 Nov 2022 19:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
 <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
 <20221108041820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221108041820-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 11:39:20 +0800
Message-ID: <CACGkMEvO-Kz_m25J58KNbC7Gqa16wn7xPdh1Ts0TJLa2RbbNVA@mail.gmail.com>
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

On Tue, Nov 8, 2022 at 5:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
> > On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> > > > On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > > > > Hi Michael,
> > > > > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > > > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > > > > >> and the guest gets rebooted, some MISS messages may have been
> > > > > > >> recorded just before the reboot and spuriously executed by
> > > > > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > > > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > > > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > > > > >>
> > > > > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > > > >> ---
> > > > > > >>  drivers/vhost/vhost.c | 1 +
> > > > > > >>  1 file changed, 1 insertion(+)
> > > > > > >>
> > > > > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > >> index 40097826cff0..422a1fdee0ca 100644
> > > > > > >> --- a/drivers/vhost/vhost.c
> > > > > > >> +++ b/drivers/vhost/vhost.c
> > > > > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > > > > >>    }
> > > > > > >>
> > > > > > >>    vhost_iotlb_free(oiotlb);
> > > > > > >> +  vhost_clear_msg(d);
> > > > > > >>
> > > > > > >>    return 0;
> > > > > > >>  }
> > > > > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > > > > new iotlb?
> > > > > > Isn't the msg processing stopped at the moment this function is called
> > > > > > (VHOST_SET_FEATURES)?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Eric
> > > > >
> > > > > It's pretty late here I'm not sure.  You tell me what prevents it.
> > > >
> > > > So the proposed code assumes that Qemu doesn't process device IOTLB
> > > > before VHOST_SET_FEAETURES. Consider there's no reset in the general
> > > > vhost uAPI,  I wonder if it's better to move the clear to device code
> > > > like VHOST_NET_SET_BACKEND. So we can clear it per vq?
> > >
> > > Hmm this makes no sense to me. iommu sits between backend
> > > and frontend. Tying one to another is going to backfire.
> >
> > I think we need to emulate what real devices are doing. Device should
> > clear the page fault message during reset, so the driver won't read
> > anything after reset. But we don't have a per device stop or reset
> > message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
> > my mind.
>
> That's not a reset message. Userspace can switch backends at will.
> I guess we could check when backend is set to -1.
> It's a hack but might work.

Yes, that's what I meant actually.

>
> > >
> > > I'm thinking more along the lines of doing everything
> > > under iotlb_lock.
> >
> > I think the problem is we need to find a proper place to clear the
> > message. So I don't get how iotlb_lock can help: the message could be
> > still read from user space after the backend is set to NULL.
> >
> > Thanks
>
> Well I think the real problem is this.
>
> vhost_net_set_features does:
>
>         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>                 if (vhost_init_device_iotlb(&n->dev, true))
>                         goto out_unlock;
>         }
>
>
> so we get a new iotlb each time features are set.

Right, but this looks like another independent issue that needs to be fixed.

>
> But features can be changes while device is running.
> E.g.
>         VHOST_F_LOG_ALL
>
>
> Let's just say this hack of reusing feature bits for backend
> was not my brightest idea :(
>

Probably :)

Thanks

>
>
>
>
> > >
> > >
> > >
> > > > >
> > > > > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > > > > it, we really should drop that.
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > > > > and then cleared, iotlb is not properly cleared - bug?
> > > >
> > > > Not sure, old IOTLB may still work. But for safety, we need to disable
> > > > device IOTLB in this case.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >> --
> > > > > > >> 2.37.3
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
