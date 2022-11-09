Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58309C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 03:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3D2A60E71;
	Wed,  9 Nov 2022 03:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3D2A60E71
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hM2Z4703
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i_hd9Rt6aH_o; Wed,  9 Nov 2022 03:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A9D860E57;
	Wed,  9 Nov 2022 03:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A9D860E57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02509C0033;
	Wed,  9 Nov 2022 03:44:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05F5AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4DA081EC7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:44:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4DA081EC7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hM2Z4703
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5WhcFWLN9td
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:44:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04F0881EC6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04F0881EC6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667965464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SzpVeGFSvJuoKb2g3I84q9t3Q2PU0091JEzT9e1Qh0=;
 b=hM2Z47033lmUZzqnwtby/YWqskO9XZc5s6k/IH/9V8idGTon0/XWoOSUciZVEeojsAwD7N
 oc+xOPHku9j6dsqF9k4YYflyFjARsiAydfNzylrORac8+x6ZjftcbmxDXRIp+v9YJlflkB
 hRv5JOX5504WOyp/+N8mWtrKu7txYBU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-ykfwlljmOXWj97XAh2zSdQ-1; Tue, 08 Nov 2022 22:44:16 -0500
X-MC-Unique: ykfwlljmOXWj97XAh2zSdQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13bc77c87f6so8023543fac.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 19:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SzpVeGFSvJuoKb2g3I84q9t3Q2PU0091JEzT9e1Qh0=;
 b=ZwquRLuQDoTRrTpqEVOPAVXwk9UGc2fifULIfBGZxcz+IGeH5UuC1KuCpkEKjhqRxi
 5QuewwXfBSXNo5IqXE0fTXc7l5tD+Og2HXJHyr0arXdYMZZdZIl5Q7Vz3gBqk40UtiL/
 cIgrz8gxIrxGw9D3+k2J8IA0lrwZbLzM1RKAsYqwlnVboKfd6g4toJHz2xYDPrhHtlUb
 ZhJESJhBLRWpYGDBg0oBFD4n1YCa/HuSWjI6VNIeCsqpNBO9FkJMPBb4UUHibmhh9xy5
 yJ4p3D/b6zCoXoAcsvT3SqtZoolG37IGs2VfJ4H1DMl0HBdBefk+jL/USiDhu0kp4Rb6
 obPA==
X-Gm-Message-State: ACrzQf1YEw/8tBB561nbBIEAgmmpuFbSJDmcPSSqoFBeXnPw8EJvSiJ3
 jZ6TEEo7oxANX+li3EbNSiQq/wZaoKtP5Fyq07dvTeenDkhQ3ZmcTGf/i0QazYlUQjErDL45g6w
 tbhscdKve5k4J5Im0bX+PW3+nKwdgpEFEbIgTsNOT4ZafhzS8b0UrzNPKWg==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr14803964oib.35.1667965455532; 
 Tue, 08 Nov 2022 19:44:15 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6706UrLNwyKe2vttKVh1ZtOJWzRUIuzEBoQnK1DCHM6gi/phgLdZny/rAkO0ET6NpmVgPN9DannOh8BBXGems=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr14803953oib.35.1667965455277; Tue, 08
 Nov 2022 19:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
 <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
 <20221108041820-mutt-send-email-mst@kernel.org>
 <7105abc8-85d1-63a4-7f77-a2b3e0177b6f@redhat.com>
In-Reply-To: <7105abc8-85d1-63a4-7f77-a2b3e0177b6f@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 11:44:03 +0800
Message-ID: <CACGkMEuX-_+fce_rmc-DsBEfa84d1Kxxe2tE_REae2_JrqBWjw@mail.gmail.com>
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
To: eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger.pro@gmail.com
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

On Tue, Nov 8, 2022 at 6:17 PM Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Michael, Jason,
>
> On 11/8/22 10:31, Michael S. Tsirkin wrote:
> > On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
> >> On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> >>>> On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>>> On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> >>>>>> Hi Michael,
> >>>>>> On 11/7/22 21:42, Michael S. Tsirkin wrote:
> >>>>>>> On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> >>>>>>>> When the vhost iotlb is used along with a guest virtual iommu
> >>>>>>>> and the guest gets rebooted, some MISS messages may have been
> >>>>>>>> recorded just before the reboot and spuriously executed by
> >>>>>>>> the virtual iommu after the reboot. Despite the device iotlb gets
> >>>>>>>> re-initialized, the messages are not cleared. Fix that by calling
> >>>>>>>> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> >>>>>>>>
> >>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/vhost/vhost.c | 1 +
> >>>>>>>>  1 file changed, 1 insertion(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >>>>>>>> index 40097826cff0..422a1fdee0ca 100644
> >>>>>>>> --- a/drivers/vhost/vhost.c
> >>>>>>>> +++ b/drivers/vhost/vhost.c
> >>>>>>>> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> >>>>>>>>    }
> >>>>>>>>
> >>>>>>>>    vhost_iotlb_free(oiotlb);
> >>>>>>>> +  vhost_clear_msg(d);
> >>>>>>>>
> >>>>>>>>    return 0;
> >>>>>>>>  }
> >>>>>>> Hmm.  Can't messages meanwhile get processes and affect the
> >>>>>>> new iotlb?
> >>>>>> Isn't the msg processing stopped at the moment this function is called
> >>>>>> (VHOST_SET_FEATURES)?
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>> Eric
> >>>>> It's pretty late here I'm not sure.  You tell me what prevents it.
> >>>> So the proposed code assumes that Qemu doesn't process device IOTLB
> >>>> before VHOST_SET_FEAETURES. Consider there's no reset in the general
> >>>> vhost uAPI,  I wonder if it's better to move the clear to device code
> >>>> like VHOST_NET_SET_BACKEND. So we can clear it per vq?
> >>> Hmm this makes no sense to me. iommu sits between backend
> >>> and frontend. Tying one to another is going to backfire.
> >> I think we need to emulate what real devices are doing. Device should
> >> clear the page fault message during reset, so the driver won't read
> >> anything after reset. But we don't have a per device stop or reset
> >> message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
> >> my mind.
> > That's not a reset message. Userspace can switch backends at will.
> > I guess we could check when backend is set to -1.
> > It's a hack but might work.
> >
> >>> I'm thinking more along the lines of doing everything
> >>> under iotlb_lock.
> >> I think the problem is we need to find a proper place to clear the
> >> message. So I don't get how iotlb_lock can help: the message could be
> >> still read from user space after the backend is set to NULL.
> >>
> >> Thanks
> > Well I think the real problem is this.
> >
> > vhost_net_set_features does:
> >
> >         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> >                 if (vhost_init_device_iotlb(&n->dev, true))
> >                         goto out_unlock;
> >         }
> >
> >
> > so we get a new iotlb each time features are set.
> >
> > But features can be changes while device is running.
> > E.g.
> >       VHOST_F_LOG_ALL
> >
> >
> > Let's just say this hack of reusing feature bits for backend
> > was not my brightest idea :(
> >
>
> Isn't vhost_init_device_iotlb() racy then, as d->iotlb is first updated with niotlb and later d->vqs[i]->iotlb is updated with niotlb. What does garantee this is done atomically?
>
> Shouldn't we hold the dev->mutex to make all the sequence atomic and
> include vhost_clear_msg()?  Can't the vhost_clear_msg() take the dev lock?

It depends on where we want to place the vhost_clear_msg(), e.g in
most of the device ioctl, the dev->mutex has been held.

Thanks

>
> Thanks
>
> Eric
>
> >
> >
> >
> >>>
> >>>
> >>>>> BTW vhost_init_device_iotlb gets enabled parameter but ignores
> >>>>> it, we really should drop that.
> >>>> Yes.
> >>>>
> >>>>> Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> >>>>> and then cleared, iotlb is not properly cleared - bug?
> >>>> Not sure, old IOTLB may still work. But for safety, we need to disable
> >>>> device IOTLB in this case.
> >>>>
> >>>> Thanks
> >>>>
> >>>>>
> >>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.37.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
