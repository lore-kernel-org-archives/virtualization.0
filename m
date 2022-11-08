Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7FBC4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 09:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF4404032F;
	Tue,  8 Nov 2022 09:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF4404032F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ah4ajqaE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iV1GTNryeY5g; Tue,  8 Nov 2022 09:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2E3E4032D;
	Tue,  8 Nov 2022 09:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2E3E4032D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C44D8C0033;
	Tue,  8 Nov 2022 09:31:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C65B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A710B8145D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A710B8145D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ah4ajqaE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7a2-useRK8ZX
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:31:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3DAF8136D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3DAF8136D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667899901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wORuoNKSEGIHseLSvWb8U/wTDNM4BG+j707oJXZ4j9I=;
 b=Ah4ajqaE42Q56y2ekKGk1XqdjRNOyuDIcklz/dS8/K4nS8CVRaOXoASS773yOyUwJjj/N8
 M2W7+aCHd5+FvVjlcIkxsKJLYlT9jIwr/QqFMo6IFMHe48q8QrcsLkndZ0wcX3jfrYPWoj
 ZIBKtzk+FVjl6mYtxU1GITdWkHl5Jk0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-P6xMzxu6M2iZKunM9ntKpw-1; Tue, 08 Nov 2022 04:31:39 -0500
X-MC-Unique: P6xMzxu6M2iZKunM9ntKpw-1
Received: by mail-qv1-f72.google.com with SMTP id
 b2-20020a0cfe62000000b004bbfb15297dso9337684qvv.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 01:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wORuoNKSEGIHseLSvWb8U/wTDNM4BG+j707oJXZ4j9I=;
 b=v/uacFsMmfl18pxdcs515p/5HdQNAVQl5iY0JfpsGECV9NaLV2jqJgJgsDXBxvOcp/
 iTqhhIp/cmgajgijP9AKGZimpTzFQN1RYvaLSEmCh3Y3/X1RA2TQ2qzcOXWapBOW4SFx
 jG9yextX5rY/NE8WP1oOGtWgaa69ZlvSjYyAGhrnSVsRDDL/MrHrljFPJBfvb3gaHLmF
 WB8iB3WgnXflqMdR6eATF+2u26/1634U9WE8r85h/X+TtMm3hGD7kHFfGQZL1JuKNXhE
 cQVH1SmAHGKLODEgSfzHJuwQUK159eMbxVz9mRIRnZ2qMmV/fNUUzJJxSCCcirqTUiim
 Gjuw==
X-Gm-Message-State: ACrzQf0kAmpeld5TrnUlPQNrZM7OY83aiEvXUiAtb8fWnSC0U9Q4sdWw
 KZPVL5ldIL8N+dM5+zCEbLOpv/tNLZbzzBDJp8saVSMLsuOF8yW8KWWhYIB60uqo4Ziue70Ezv2
 HdvE/Ihu5OlvuheRo1ZWlViQJRgaHxQo6/l2BRGO9QA==
X-Received: by 2002:ac8:4788:0:b0:3a5:6a2f:e77d with SMTP id
 k8-20020ac84788000000b003a56a2fe77dmr15500747qtq.562.1667899899156; 
 Tue, 08 Nov 2022 01:31:39 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5r6u9VAFIEkP5ZvGS1wz6LtG1vG3jMrqncPoAa0QeUVMjh8Yu9Jeel/zWCsisC28rCmndQSA==
X-Received: by 2002:ac8:4788:0:b0:3a5:6a2f:e77d with SMTP id
 k8-20020ac84788000000b003a56a2fe77dmr15500734qtq.562.1667899898878; 
 Tue, 08 Nov 2022 01:31:38 -0800 (PST)
Received: from redhat.com ([138.199.52.3]) by smtp.gmail.com with ESMTPSA id
 o14-20020a05620a0d4e00b006eef13ef4c8sm8702771qkl.94.2022.11.08.01.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 01:31:38 -0800 (PST)
Date: Tue, 8 Nov 2022 04:31:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221108041820-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
 <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
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

On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
> On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> > > On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > > > Hi Michael,
> > > > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > > > >> and the guest gets rebooted, some MISS messages may have been
> > > > > >> recorded just before the reboot and spuriously executed by
> > > > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > > > >>
> > > > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > > >> ---
> > > > > >>  drivers/vhost/vhost.c | 1 +
> > > > > >>  1 file changed, 1 insertion(+)
> > > > > >>
> > > > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > >> index 40097826cff0..422a1fdee0ca 100644
> > > > > >> --- a/drivers/vhost/vhost.c
> > > > > >> +++ b/drivers/vhost/vhost.c
> > > > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > > > >>    }
> > > > > >>
> > > > > >>    vhost_iotlb_free(oiotlb);
> > > > > >> +  vhost_clear_msg(d);
> > > > > >>
> > > > > >>    return 0;
> > > > > >>  }
> > > > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > > > new iotlb?
> > > > > Isn't the msg processing stopped at the moment this function is called
> > > > > (VHOST_SET_FEATURES)?
> > > > >
> > > > > Thanks
> > > > >
> > > > > Eric
> > > >
> > > > It's pretty late here I'm not sure.  You tell me what prevents it.
> > >
> > > So the proposed code assumes that Qemu doesn't process device IOTLB
> > > before VHOST_SET_FEAETURES. Consider there's no reset in the general
> > > vhost uAPI,  I wonder if it's better to move the clear to device code
> > > like VHOST_NET_SET_BACKEND. So we can clear it per vq?
> >
> > Hmm this makes no sense to me. iommu sits between backend
> > and frontend. Tying one to another is going to backfire.
> 
> I think we need to emulate what real devices are doing. Device should
> clear the page fault message during reset, so the driver won't read
> anything after reset. But we don't have a per device stop or reset
> message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
> my mind.

That's not a reset message. Userspace can switch backends at will.
I guess we could check when backend is set to -1.
It's a hack but might work.

> >
> > I'm thinking more along the lines of doing everything
> > under iotlb_lock.
> 
> I think the problem is we need to find a proper place to clear the
> message. So I don't get how iotlb_lock can help: the message could be
> still read from user space after the backend is set to NULL.
> 
> Thanks

Well I think the real problem is this.

vhost_net_set_features does:

        if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
                if (vhost_init_device_iotlb(&n->dev, true))
                        goto out_unlock;
        }


so we get a new iotlb each time features are set.

But features can be changes while device is running.
E.g.
	VHOST_F_LOG_ALL


Let's just say this hack of reusing feature bits for backend
was not my brightest idea :(





> >
> >
> >
> > > >
> > > > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > > > it, we really should drop that.
> > >
> > > Yes.
> > >
> > > >
> > > > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > > > and then cleared, iotlb is not properly cleared - bug?
> > >
> > > Not sure, old IOTLB may still work. But for safety, we need to disable
> > > device IOTLB in this case.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > >> --
> > > > > >> 2.37.3
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
