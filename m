Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF9C636D6
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 22:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5B394D752;
	Mon, 20 Feb 2023 22:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5B394D752
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pm0Krmns
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bosq7M6n4hfy; Mon, 20 Feb 2023 22:44:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E0AC4EB76;
	Mon, 20 Feb 2023 22:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E0AC4EB76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F02AC0032;
	Mon, 20 Feb 2023 22:44:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE33FC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 22:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAE494F27E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 22:44:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAE494F27E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DFwQs3b8_t_t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 22:44:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE3924EB76
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE3924EB76
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676933039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fg0gWyRV88lnqtyD81L0fHIJtzOwXTYSHstu5nhZ0Qk=;
 b=Pm0KrmnsrI8Va/sRlQYesOK3LeddSuKAYdYRMgYHxlKZJ5hEN7v5Ziy94x+zV1cjp66FAe
 CmUr1irkkQAV8ApYtYOa8t75vCmA6fJ/KRBjeBHOyd27ye6x/MfIpO4lmU2Ag7F55ojMsA
 TdQg4Sn6LrH/Iq2ai78uZPzcESdDtPU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280-egRSUhhiM0irEo1NNLPteA-1; Mon, 20 Feb 2023 17:43:58 -0500
X-MC-Unique: egRSUhhiM0irEo1NNLPteA-1
Received: by mail-wm1-f71.google.com with SMTP id
 o35-20020a05600c512300b003dc5cb10dcfso1120021wms.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 14:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fg0gWyRV88lnqtyD81L0fHIJtzOwXTYSHstu5nhZ0Qk=;
 b=NTHMTWLZv82OKT+ONLFPB5Dm/heqiNaSYqn4P3EMA4wA+dKZzZpcQR4uWcFxLCvfz7
 GNjfqyH9enY7cJ6Oybs2JCrYtiTll4whNAzCcmG2reiZBUZ2LRRvxDDSqFm5zTXVJsSH
 rIFZL1+24vDBRCQHv5jshldSj8b/iA6NMXpWFvqlmXM8mQAlMehCmMGc2g+oCi8+8/d/
 ghgGQInWb1H1DG7Jwd7RvxsmbwkE67LWGa0gBeGsafaG5gE4JVFtlQWtAbUuaZkm1zPo
 DPQFAvkpOtOK4lf/kpF8q1iExBD+nuKVjkQbtHqsskwmo/GwyglpB1vG2qudWx2V82Ce
 7Xog==
X-Gm-Message-State: AO0yUKW8OTNbsB0M10MgnNPwLK5T33ci9RfY/QVNgw4CjfDykpPpc98+
 jKKpvRTlXAh15afIyuahXx486RSdAkEkZz4YvU/lTsmz9o1Ge+JnfdGzdSDt1k8b4fFWSAs3/Xh
 RI45XvnEk2Raa823/+WlfgED8NIGy+b2jC0UgXP5bww==
X-Received: by 2002:a5d:4303:0:b0:2c3:eeeb:b2f7 with SMTP id
 h3-20020a5d4303000000b002c3eeebb2f7mr2770362wrq.62.1676933037307; 
 Mon, 20 Feb 2023 14:43:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8fjWUdkFasyiCpJ921TNihGrr7KuKk/ouFzO8fe/cEqa5MmSW78OMLyXUnMVyGdRIjvzp7vA==
X-Received: by 2002:a5d:4303:0:b0:2c3:eeeb:b2f7 with SMTP id
 h3-20020a5d4303000000b002c3eeebb2f7mr2770347wrq.62.1676933036990; 
 Mon, 20 Feb 2023 14:43:56 -0800 (PST)
Received: from redhat.com ([2.52.36.56]) by smtp.gmail.com with ESMTPSA id
 y6-20020a056000108600b002c53f6c7599sm1179885wrw.29.2023.02.20.14.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Feb 2023 14:43:56 -0800 (PST)
Date: Mon, 20 Feb 2023 17:43:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <20230220174110-mutt-send-email-mst@kernel.org>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho>
 <20230220074947-mutt-send-email-mst@kernel.org>
 <Y/N7+IJ+gzvP0IEf@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <Y/N7+IJ+gzvP0IEf@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vitaly Mireyno <vmireyno@marvell.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Mon, Feb 20, 2023 at 02:56:08PM +0100, Jiri Pirko wrote:
> Mon, Feb 20, 2023 at 01:55:33PM CET, mst@redhat.com wrote:
> >On Mon, Feb 20, 2023 at 09:35:00AM +0100, Jiri Pirko wrote:
> >> Fri, Feb 17, 2023 at 02:47:36PM CET, mst@redhat.com wrote:
> >> >On Fri, Feb 17, 2023 at 01:53:55PM +0100, Jiri Pirko wrote:
> >> >> Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
> >> >> >On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> >> 
> >> >> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> >> >> >> 
> >> >> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> >> >> >> set implicates that the driver provides the exact size of the header.
> >> >> >> 
> >> >> >> The driver already complies to fill the correct value. Introduce the
> >> >> >> feature and advertise it.
> >> >> >> 
> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> >
> >> >> >Could you add a bit of motivation just for the record?
> >> >> >Does this improve performance for some card? By how much?
> >> >> >Expected to help some future card?
> >> >> 
> >> >> I can get that info, but isn't that rather something to be appended to
> >> >> the virtio-spec patch? I mean, the feature is there, this is just
> >> >> implementing it in one driver.
> >> >
> >> >It is more like using it in the driver.  It's not like we have to use
> >> >everything - it could be useful for e.g. dpdk but not linux.
> >> >Implementing it in the Linux driver has support costs - for example what
> >> >if there's a bug and sometimes the length is incorrect?
> >> >We'll be breaking things.
> >> 
> >> I understand. To my understanding this feature just fixes the original
> >> ambiguity in the virtio spec.
> >> 
> >> Quoting the original virtio spec:
> >> "hdr_len is a hint to the device as to how much of the header needs to
> >>  be kept to copy into each packet"
> >> 
> >> "a hint" might not be clear for the reader what does it mean, if it is
> >> "maybe like that" of "exactly like that". This feature just makes it
> >> crystal clear.
> >> 
> >> If you look at the tap implementation, it uses hdr_len to alloc
> >> skb linear part. No hint, it counts with the provided value.
> >> So if the driver is currently not precise, it breaks tap.
> >
> >Well that's only for gso though right?
> 
> Yep.
> 
> 
> >And making it bigger than necessary works fine ...
> 
> Well yeah. But tap does not do that, does it? it uses hdr_len directly.
> 

I mean if hdr_len is bigger than necessary tap does work.


> >
> >> I will add this to the patch description and send v2.
> >> 
> >
> >I feel this does not answer the question yet, or maybe I am being dense.
> >My point was not about making hdr_len precise.  My point was that we are
> >making a change here for no apparent reason. I am guessing you are not
> >doing it for fun - so why? Is there a device with this feature bit
> >you are aware of?
> 
> Afaik real hw which does emulation of virtio_net would benefit from
> that, our hw including.

OK so do you have hardware which exposes this feature?
That is the bit I am missing. Maybe mention the make
in the commit log so
we know where to turn if we need to make changes here?
Or "under development" if it is not on the market yet.

> 
> >
> >
> >
> >> 
> >> >
> >> >The patch was submitted by Marvell but they never bothered with
> >> >using it in Linux. I guess they are using it for something else?
> >> >CC Vitaly who put this in.
> >> >
> >> >> 
> >> >> >
> >> >> >thanks!
> >> >> >
> >> >> >
> >> >> >> ---
> >> >> >>  drivers/net/virtio_net.c        | 6 ++++--
> >> >> >>  include/uapi/linux/virtio_net.h | 1 +
> >> >> >>  2 files changed, 5 insertions(+), 2 deletions(-)
> >> >> >> 
> >> >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> >> >> index fb5e68ed3ec2..e85b03988733 100644
> >> >> >> --- a/drivers/net/virtio_net.c
> >> >> >> +++ b/drivers/net/virtio_net.c
> >> >> >> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
> >> >> >>  	VIRTIO_NET_F_GUEST_UFO,
> >> >> >>  	VIRTIO_NET_F_GUEST_CSUM,
> >> >> >>  	VIRTIO_NET_F_GUEST_USO4,
> >> >> >> -	VIRTIO_NET_F_GUEST_USO6
> >> >> >> +	VIRTIO_NET_F_GUEST_USO6,
> >> >> >> +	VIRTIO_NET_F_GUEST_HDRLEN
> >> >> >>  };
> >> >> >>  
> >> >> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> >> >> >> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
> >> >> >>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
> >> >> >>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> >> >> >>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >> >> >> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
> >> >> >> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> >> >> >> +	VIRTIO_NET_F_GUEST_HDRLEN
> >> >> >>  
> >> >> >>  static unsigned int features[] = {
> >> >> >>  	VIRTNET_FEATURES,
> >> >> >> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> >> >> >> index b4062bed186a..12c1c9699935 100644
> >> >> >> --- a/include/uapi/linux/virtio_net.h
> >> >> >> +++ b/include/uapi/linux/virtio_net.h
> >> >> >> @@ -61,6 +61,7 @@
> >> >> >>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> >> >> >>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
> >> >> >>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
> >> >> >> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
> >> >> >>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
> >> >> >>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
> >> >> >>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> >> >> >> -- 
> >> >> >> 2.39.0
> >> >> >
> >> >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
