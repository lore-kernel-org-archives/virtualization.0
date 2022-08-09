Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67529C25B06
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 09:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED77940579;
	Tue,  9 Aug 2022 09:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED77940579
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OFVoCMpO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IYNfAgdqeAgq; Tue,  9 Aug 2022 09:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8DC6040503;
	Tue,  9 Aug 2022 09:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DC6040503
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C248C0033;
	Tue,  9 Aug 2022 09:22:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12D56C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E460440503
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E460440503
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cvUzo1mM7IU6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:22:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F4CD40151
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F4CD40151
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660036940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f8CuRu0VaRqFFkHthq9Qm7LWJtiPIdDgB+lUrPINM48=;
 b=OFVoCMpOr8qhujYBSG/2VyGhauEd2vQo7ziv6l/uPNFVLGv+zKSu1Z+sGtlVRUSy14l+lh
 RM32v4CiW0DbljuY7NRfTeKBQhIgMM0Edp2zBqbBiga3du2uY8zwtuh0aFrgp9dzimjcNj
 JPUM0z4qJtpxUXDWN1iyDk9RG3t2beU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-ZU2JwFr8N0KN5LLxE-T2xQ-1; Tue, 09 Aug 2022 05:22:19 -0400
X-MC-Unique: ZU2JwFr8N0KN5LLxE-T2xQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 m22-20020a056402431600b0043d6a88130aso6890941edc.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 02:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=f8CuRu0VaRqFFkHthq9Qm7LWJtiPIdDgB+lUrPINM48=;
 b=0tfwfzENi1Yn0MzY6Ji5CtpE6+OEiZXWk1YYgr6URuwroTPXFe+1ZonACbobO7AxIs
 5QQ+5nNXW29EzzOiaeSSgJ1wb4I3ikFmBfiPT54fPCiPwTgD6+OA2ph3868xfCUkOtJZ
 8SnFlsALYBvDl9u+80SgtSvJS1AFgD7HKK6INGH1IP8a4VxijXmz36i3e2rZHfBYIn5q
 0itWJ1UyP4McyuynuUrZ1Ti60mZ7a+fRKU+VTydHWWiXs7H2aKX2KpX5qQpXjhZFhGb4
 /EYS9YUHZhM2gMHBa7CnHjRvJ80Zu0L8I4yB0RgDWyx3MTSKB2ZQov43sfjX6QDWKYq4
 8pIA==
X-Gm-Message-State: ACgBeo1S5W+qCWezwo7G3CetoTLm9vyWP39ggofckHiHW1A3Fu7mErJd
 PJf1rxMtb7c4iYMKwkccYDCazBZ5k+zwrxJhw1+Ck7k/tMqXkplCBWvNBKv6roxLuKC47sHZzMz
 VreC9WV0zUIF1gXjtK+L/S4ZnVi61diGZDiA4TCzQkg==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id
 p8-20020a056402500800b00440941a93c3mr9349650eda.47.1660036938121; 
 Tue, 09 Aug 2022 02:22:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7DZZ5SjiqXbps99Gb9SDnhMqX0r6RmLl+9aqtFop1SYkG8shBFFJetIyxpIPxZN30eOUwbtQ==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id
 p8-20020a056402500800b00440941a93c3mr9349630eda.47.1660036937876; 
 Tue, 09 Aug 2022 02:22:17 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 bx7-20020a0564020b4700b0043577da51f1sm5709186edb.81.2022.08.09.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 02:22:17 -0700 (PDT)
Date: Tue, 9 Aug 2022 05:22:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809051849-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> >               vi->big_packets = true;
> > +             vi->gso_is_supported = true;
> >
> > Please do the same for virtnet_clear_guest_offloads(), and
> > correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> > virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> > successful return, seems like a bug to me.
> 
> It is fine as long as
> 
> 1) we don't implement ethtool API for changing guest offloads
> 2) big mode XDP is not enabled
> 
> So that code works only for XDP but we forbid big packets in the case
> of XDP right now.
> 
> Thanks

To put it another way, changing big_packets after probe requires a bunch
of work as current code assumes this flag never changes.
Adding a TODO to handle dynamic offload config is fine but
I don't think it should block this.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
