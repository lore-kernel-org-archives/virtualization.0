Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418DAC64ED9
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 08:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E8DF4056E;
	Mon, 20 Feb 2023 08:35:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E8DF4056E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jYU6POCx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5rYFB_ouMoct; Mon, 20 Feb 2023 08:35:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 063DF400EC;
	Mon, 20 Feb 2023 08:35:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 063DF400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA7B2C0032;
	Mon, 20 Feb 2023 08:35:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FF8AC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 08:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54E094056E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 08:35:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54E094056E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g2OnBTVv--q7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 08:35:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80653400EC
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80653400EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 08:35:03 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 l7-20020a05600c1d0700b003dc4050c94aso327926wms.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 00:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9SCHZxVrWwYhFPaFM40+xiOddaLbOPVW0nERIbBzocA=;
 b=jYU6POCxFUND3/EhWp0vLbfxGd6X9j+wTVfSZHOcl9SvJ6Ytgh31RoDZETK7XPQDe+
 OwTs8YchQVEzQWc6IzuxFoG/mE9zZCh3gg24Ghlc/bAkIIDIgsoTf68JXHcRaZeiyhoq
 jvL2WJgtNdbbOjhOzeYOAex4SEqts1ZpJFtVSmyQTKylXI2HqMgZEAULl8c2fyOwqDZv
 XpEeVJxIex6CDEgDpW7dhtELYs2E2Q7ZaVFw9uNKT3Jj5NtZAN9wr72ISaHV+0zlcot2
 24MAqeO1WtgHEM/pZ/AeD+4AUzI9N9UkhE2lqihtaVSQmjgaHy+aFCce+y0KVWHli4iC
 22wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SCHZxVrWwYhFPaFM40+xiOddaLbOPVW0nERIbBzocA=;
 b=jODz0YLiQCGndPeGtLIQ4PdUKL+pWeg2yJXqKjlco8VRLyEoAsErswDJSpUbEB7sa8
 pG3d1/dkOC3GLfiw1VWKYgcoRUbF1wXcDHBgPcHwUMRmFsTbPo4Rn3ekk4OUGA0iIQAi
 mjoDcZOKZiCbuLRqIV+XIK+saPv8+iUkHnTIDlkRMKqXkGjQ6bVI1H0nFEfReJtnqRLS
 2/GcnjaL4936SeCjvhn9VpcseKfnCKgayZ2c4QQRyrgQLxEWKy9oNgWfzPZDHfZfdZ4w
 3wdhyXT5RA/MIz4Sn67nSoQUugFcOcGahobcyO77+4eEdeauMX1KjIAmz/05+AxyXof0
 PLTQ==
X-Gm-Message-State: AO0yUKVgoPxajewTWtFLhNLdx4loXPHLSzztPpBj2EkJq3oUDQ5P8ADv
 rSHka1VNx/ssppn01lbMN7FNSw==
X-Google-Smtp-Source: AK7set8pFtDwXHwFt/xEKrv7KMNJQcIXafy9lFeFquhgZ29Gzy1IsywfC0RnGIiy0jnxAc9zFhSVtg==
X-Received: by 2002:a05:600c:13ca:b0:3e2:522:45f7 with SMTP id
 e10-20020a05600c13ca00b003e2052245f7mr105649wmg.13.1676882102026; 
 Mon, 20 Feb 2023 00:35:02 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 z6-20020adfe546000000b002425be3c9e2sm622456wrm.60.2023.02.20.00.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Feb 2023 00:35:01 -0800 (PST)
Date: Mon, 20 Feb 2023 09:35:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <Y/MwtAGru3yAY7r3@nanopsycho>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230217083915-mutt-send-email-mst@kernel.org>
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

Fri, Feb 17, 2023 at 02:47:36PM CET, mst@redhat.com wrote:
>On Fri, Feb 17, 2023 at 01:53:55PM +0100, Jiri Pirko wrote:
>> Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
>> >On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
>> >> 
>> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> >> set implicates that the driver provides the exact size of the header.
>> >> 
>> >> The driver already complies to fill the correct value. Introduce the
>> >> feature and advertise it.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >
>> >Could you add a bit of motivation just for the record?
>> >Does this improve performance for some card? By how much?
>> >Expected to help some future card?
>> 
>> I can get that info, but isn't that rather something to be appended to
>> the virtio-spec patch? I mean, the feature is there, this is just
>> implementing it in one driver.
>
>It is more like using it in the driver.  It's not like we have to use
>everything - it could be useful for e.g. dpdk but not linux.
>Implementing it in the Linux driver has support costs - for example what
>if there's a bug and sometimes the length is incorrect?
>We'll be breaking things.

I understand. To my understanding this feature just fixes the original
ambiguity in the virtio spec.

Quoting the original virtio spec:
"hdr_len is a hint to the device as to how much of the header needs to
 be kept to copy into each packet"

"a hint" might not be clear for the reader what does it mean, if it is
"maybe like that" of "exactly like that". This feature just makes it
crystal clear.

If you look at the tap implementation, it uses hdr_len to alloc
skb linear part. No hint, it counts with the provided value.
So if the driver is currently not precise, it breaks tap.

I will add this to the patch description and send v2.


>
>The patch was submitted by Marvell but they never bothered with
>using it in Linux. I guess they are using it for something else?
>CC Vitaly who put this in.
>
>> 
>> >
>> >thanks!
>> >
>> >
>> >> ---
>> >>  drivers/net/virtio_net.c        | 6 ++++--
>> >>  include/uapi/linux/virtio_net.h | 1 +
>> >>  2 files changed, 5 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> >> index fb5e68ed3ec2..e85b03988733 100644
>> >> --- a/drivers/net/virtio_net.c
>> >> +++ b/drivers/net/virtio_net.c
>> >> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
>> >>  	VIRTIO_NET_F_GUEST_UFO,
>> >>  	VIRTIO_NET_F_GUEST_CSUM,
>> >>  	VIRTIO_NET_F_GUEST_USO4,
>> >> -	VIRTIO_NET_F_GUEST_USO6
>> >> +	VIRTIO_NET_F_GUEST_USO6,
>> >> +	VIRTIO_NET_F_GUEST_HDRLEN
>> >>  };
>> >>  
>> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>> >> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
>> >>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>> >>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>> >>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>> >> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
>> >> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>> >> +	VIRTIO_NET_F_GUEST_HDRLEN
>> >>  
>> >>  static unsigned int features[] = {
>> >>  	VIRTNET_FEATURES,
>> >> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> >> index b4062bed186a..12c1c9699935 100644
>> >> --- a/include/uapi/linux/virtio_net.h
>> >> +++ b/include/uapi/linux/virtio_net.h
>> >> @@ -61,6 +61,7 @@
>> >>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>> >>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
>> >>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>> >> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
>> >>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>> >>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>> >>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>> >> -- 
>> >> 2.39.0
>> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
