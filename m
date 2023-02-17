Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD84C05027
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 13:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95596404B5;
	Fri, 17 Feb 2023 13:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95596404B5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PSOop/BP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tx3jlAARBk9Y; Fri, 17 Feb 2023 13:47:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF4D240108;
	Fri, 17 Feb 2023 13:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF4D240108
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF5C6C0032;
	Fri, 17 Feb 2023 13:47:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A3AC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 13:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F29F381268
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 13:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F29F381268
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PSOop/BP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wyX5y3biaZn0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 13:47:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34AA681214
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34AA681214
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676641663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j566sxiFR30aTmiG4rGSD34hpOB39mjJ2E7i4/yghZo=;
 b=PSOop/BPHY9R/bsa4nTDFByM9Wqb6Vp1NSw92L1IRsFaUDltOnOQgXoOxTgnS+Hr9QkQXg
 w9yvgGHbovV3gVRYuWrGY0Yj0I9I15Bo6nHnQo8CiJVW6B6fV5R1JvMqdEC8GAqcsu1kUZ
 gMCpe6xWo/MXVfMmwZcmzp2LZKn/R54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-JjUEY9c-N4eS4vxTU2BgWg-1; Fri, 17 Feb 2023 08:47:41 -0500
X-MC-Unique: JjUEY9c-N4eS4vxTU2BgWg-1
Received: by mail-wm1-f72.google.com with SMTP id
 v6-20020a05600c444600b003e206cbce8dso755403wmn.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j566sxiFR30aTmiG4rGSD34hpOB39mjJ2E7i4/yghZo=;
 b=6ATKUOZ6dQYHwOm46eBPM78OZyJGE0q50W8oG22mP8kTD78cOZOOKFD88nd/QFadJ3
 LT6G/XaK8NyJFaA5LHQHZzYKXaGecj1+M7kzdA8xaHSobDDfM0lBuiUR1KMz45U8cCfm
 ayZhvyENNLnlEZXRqZ9Xtcau0ONldyPGR1iGpGa8HvjQwpQsWi/t1THGvvA4ENVRgzNm
 +7hWBnK0ckhsyxSu7JCZV2iexB5Vu4/YM9Ep9XO1KjOt/6RG85Xt7plqEpktbanHhgU2
 IBzMMh74x3kc+Gnv9UP58keEtrf/LFfyc0CUM3S9SpDaK8rzKdXlgG+BUcRwN3SSep3Y
 hBOA==
X-Gm-Message-State: AO0yUKUUPSHceRFvVc0nCvhIr8V0wu5K1wZlUoF3wUFaLBKYeJwZ9iCF
 VcTFVhbGMzWTtSXauxhFUo+OWEmEhglUb0lPqd9PkoniivM7EaCNavMwbqUahPE1lX2Xq539WpK
 zLdcRRujAEciTEeCooKTt/dQMOw/Bm9eFfUQRjRa9bw==
X-Received: by 2002:a05:600c:4591:b0:3df:9858:c038 with SMTP id
 r17-20020a05600c459100b003df9858c038mr5078950wmo.13.1676641660747; 
 Fri, 17 Feb 2023 05:47:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+oXntli+obuZQPsa34EK1fBtgGYx9q6alm4B/8LEVVaw4ZU1QEArkNeZvSg69zjWc09iakSg==
X-Received: by 2002:a05:600c:4591:b0:3df:9858:c038 with SMTP id
 r17-20020a05600c459100b003df9858c038mr5078939wmo.13.1676641660475; 
 Fri, 17 Feb 2023 05:47:40 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 y11-20020a05600c364b00b003dc0cb5e3f1sm4622433wmq.46.2023.02.17.05.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Feb 2023 05:47:39 -0800 (PST)
Date: Fri, 17 Feb 2023 08:47:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <20230217083915-mutt-send-email-mst@kernel.org>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <Y+94418p73aUQyIn@nanopsycho>
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

On Fri, Feb 17, 2023 at 01:53:55PM +0100, Jiri Pirko wrote:
> Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
> >On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> >> 
> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> >> set implicates that the driver provides the exact size of the header.
> >> 
> >> The driver already complies to fill the correct value. Introduce the
> >> feature and advertise it.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >
> >Could you add a bit of motivation just for the record?
> >Does this improve performance for some card? By how much?
> >Expected to help some future card?
> 
> I can get that info, but isn't that rather something to be appended to
> the virtio-spec patch? I mean, the feature is there, this is just
> implementing it in one driver.

It is more like using it in the driver.  It's not like we have to use
everything - it could be useful for e.g. dpdk but not linux.
Implementing it in the Linux driver has support costs - for example what
if there's a bug and sometimes the length is incorrect?
We'll be breaking things.

The patch was submitted by Marvell but they never bothered with
using it in Linux. I guess they are using it for something else?
CC Vitaly who put this in.

> 
> >
> >thanks!
> >
> >
> >> ---
> >>  drivers/net/virtio_net.c        | 6 ++++--
> >>  include/uapi/linux/virtio_net.h | 1 +
> >>  2 files changed, 5 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index fb5e68ed3ec2..e85b03988733 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
> >>  	VIRTIO_NET_F_GUEST_UFO,
> >>  	VIRTIO_NET_F_GUEST_CSUM,
> >>  	VIRTIO_NET_F_GUEST_USO4,
> >> -	VIRTIO_NET_F_GUEST_USO6
> >> +	VIRTIO_NET_F_GUEST_USO6,
> >> +	VIRTIO_NET_F_GUEST_HDRLEN
> >>  };
> >>  
> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> >> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
> >>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
> >>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> >>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
> >> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> >> +	VIRTIO_NET_F_GUEST_HDRLEN
> >>  
> >>  static unsigned int features[] = {
> >>  	VIRTNET_FEATURES,
> >> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> >> index b4062bed186a..12c1c9699935 100644
> >> --- a/include/uapi/linux/virtio_net.h
> >> +++ b/include/uapi/linux/virtio_net.h
> >> @@ -61,6 +61,7 @@
> >>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> >>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
> >>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
> >> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
> >>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
> >>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
> >>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> >> -- 
> >> 2.39.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
