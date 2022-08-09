Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C020AC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 09:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B492F40503;
	Tue,  9 Aug 2022 09:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B492F40503
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mq6xQK8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIg0_dszIDVm; Tue,  9 Aug 2022 09:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3855940151;
	Tue,  9 Aug 2022 09:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3855940151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2C83C0033;
	Tue,  9 Aug 2022 09:29:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 528EFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 392DD410A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 392DD410A9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mq6xQK8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ycNjEwynbQC6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CA0D40999
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CA0D40999
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660037347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i3CATCtOr4DaqpfIq4Pd2xIwJooc1cqdrsWCwYa0J84=;
 b=Mq6xQK8n/gNHRwcC9B228jNVTjrwILCN59/mJRL3GgtB6O+0nu+71Rz3D6N1af6HOrVBHt
 eThLRSxGmpp+qqICVwlWhLzVsHuwo6w5apP7SY7mgt2vsCQ92IFGMMEaAjnUbVuMAkaDC7
 Ed12kaySKFQlsGdx3sgI11GqFMaYj2A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-PzHBpPaIMMW5nlwG3f_NAQ-1; Tue, 09 Aug 2022 05:29:05 -0400
X-MC-Unique: PzHBpPaIMMW5nlwG3f_NAQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 q10-20020a19f20a000000b0048d029a71d3so714612lfh.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 02:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i3CATCtOr4DaqpfIq4Pd2xIwJooc1cqdrsWCwYa0J84=;
 b=wEi6+JAOsNafkSu5jg8/3PYEd50Ge47WZmtFcMIWLvoTvtXqNBEe70H4CRbB+bDERC
 4gSb/crtZNzB0D9PKOp4WJsMu81xsSh1USUh5H78+SnZp41Wr32RpjvWHTCOJvhCUzZ1
 Ro2llHcVKJh5c2CWWY5InJ9RLfDX4Iif9rloysPFwA//KFRSPzwv2tpZQ49XFYmHqBhw
 w/Ss5AcyVdt2ek9wTQmmYq+cCNVMrmtHfBWTkqWVJwqhEJ+vI/uvQ0c/Qm2vL9LYMWp8
 77DHzeNz/nfRzh0ptd+AVXsnOgZ/B2+XtcDL63uLBMOLdKApZAbNa6TXyGxan07BL8Zu
 PRig==
X-Gm-Message-State: ACgBeo2FkCCviuaL591vyyASu4DIZjB2j4bh8fR6Df37/PDPPqlgkbaU
 QfToJ0yDwIwnBYWThGNapPR28H7pCrD05OUtMbpFtX31B/a93EhZW6OjSsQDqQfULM0vj8tzyUj
 XaRkZkcCdJ24z565FZGFqIBQRfv5hpb4NI1f8Dd2M1DJckR52kfvT48XQRw==
X-Received: by 2002:a19:8c13:0:b0:48d:d87:b6e1 with SMTP id
 o19-20020a198c13000000b0048d0d87b6e1mr1068617lfd.238.1660037344331; 
 Tue, 09 Aug 2022 02:29:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7OGgTzmhpxSYOD1DZMwW9eRM65+6hFSTanU+PfiyXlGoeBJaUErXZCp509bJ1hrpsFXhg8UeLb9D1pnGF1JfI=
X-Received: by 2002:a19:8c13:0:b0:48d:d87:b6e1 with SMTP id
 o19-20020a198c13000000b0048d0d87b6e1mr1068608lfd.238.1660037344154; Tue, 09
 Aug 2022 02:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <20220809051849-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809051849-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Aug 2022 17:28:53 +0800
Message-ID: <CACGkMEvMqnjcY2R-BWUT_DreK4YN5CWmE_KfSqosH89Yn4g62g@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 kubakici@wp.pl, sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
 gavi@nvidia.com, virtualization <virtualization@lists.linux-foundation.org>,
 "Hemminger, Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Tue, Aug 9, 2022 at 5:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
> > > *vdev)
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > > +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> > >               vi->big_packets = true;
> > > +             vi->gso_is_supported = true;
> > >
> > > Please do the same for virtnet_clear_guest_offloads(), and
> > > correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> > > virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> > > successful return, seems like a bug to me.
> >
> > It is fine as long as
> >
> > 1) we don't implement ethtool API for changing guest offloads
> > 2) big mode XDP is not enabled
> >
> > So that code works only for XDP but we forbid big packets in the case
> > of XDP right now.
> >
> > Thanks
>
> To put it another way, changing big_packets after probe requires a bunch
> of work as current code assumes this flag never changes.
> Adding a TODO to handle dynamic offload config is fine but
> I don't think it should block this.

Yes, this is what I mean.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
