Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B29C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 13:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 970F741548;
	Mon, 20 Feb 2023 13:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 970F741548
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OFnIfuLY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3neubt6CNQMb; Mon, 20 Feb 2023 13:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 400F54094B;
	Mon, 20 Feb 2023 13:56:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 400F54094B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FA4C0033;
	Mon, 20 Feb 2023 13:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3047C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 13:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A096740128
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 13:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A096740128
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=OFnIfuLY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2u3L6bpz782K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 13:56:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87F764010C
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87F764010C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 13:56:11 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id bg28so1010166wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5TI0FnePyDOUhU+On7dSLel1yi71Cx9S3RMroLl68dM=;
 b=OFnIfuLYXofnnYMBT3bBLG/v6ULsiigRkSjnL0G+B8ihb6CnpoY7DhBwMSLsgEYoVe
 t+c4tmaZKn6Ki7HatZEk0/bqtYGt4flKh69Gp/qkSbE1QLSBwQHB/Qxw+NdFBuZCeGV7
 pqfKAUl1bwpcyrjkcGd3cig24zV1Vc4eVHDUHnMwctPgZVxlCPByn2PV6p9jHRQrsTpX
 +patCT0WXGqP7ifBMpokpwNRUy5clA5ptpx6vbpRwLPaBNYG00tFzYWl4c2b6mscm+Rj
 RLSQg875BHQgyOfPUtoNsu965jax6sERWHkSseyISzA8ltysUirjK9v6SlcnZPEwTAna
 Ay4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TI0FnePyDOUhU+On7dSLel1yi71Cx9S3RMroLl68dM=;
 b=iPPzyt00Mb7fIPDdNaVKUTVLFDTwjp+xfrAZC6aGSW01OJ3H07zmiXoD31XJ4o61aD
 ShxLheuPKuGZ4l+FmsF4Qf1mtkxwbbypE/uOh4E3McZOB7cqhBso5F0qx54F5bYCqbps
 tlbWXvHEoHfVLp4SNFly+Ocb60m/sls4Ta442A3GkF6kbzlyRNlsajZb4KC900pzp+zW
 3x88ZaCkwzPk5Oo5wtxHisiUt/ZXcR6HpKYRmM/PQLWdQ3ugvLyyEFm0UNDmJTqJ5JJu
 oKLzTRUFGcoLWRb/1+I/7zsU7EgLFnsym57QfHKEJBJfnH/tvyGeIn1vK7fOd/f0Gjc9
 iTHQ==
X-Gm-Message-State: AO0yUKXbk5eZDRKwvu6cK71DdZBIx6I1L+ZNbiS+0JHBMy7GgEd1oObt
 9PauNMHkgMinYR/oGlFvIsE3Yg==
X-Google-Smtp-Source: AK7set99fIKkXrvn/oCTav4AnLFbRZce7OdCjH/jrgrJp7Jyd+6YU1CWfu5ZuRl7nG7wb1xXBm8clg==
X-Received: by 2002:a05:600c:1d12:b0:3df:ee44:e45a with SMTP id
 l18-20020a05600c1d1200b003dfee44e45amr578492wms.15.1676901369720; 
 Mon, 20 Feb 2023 05:56:09 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 fm18-20020a05600c0c1200b003dc1d668866sm1572626wmb.10.2023.02.20.05.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Feb 2023 05:56:09 -0800 (PST)
Date: Mon, 20 Feb 2023 14:56:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <Y/N7+IJ+gzvP0IEf@nanopsycho>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho>
 <20230220074947-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230220074947-mutt-send-email-mst@kernel.org>
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

Mon, Feb 20, 2023 at 01:55:33PM CET, mst@redhat.com wrote:
>On Mon, Feb 20, 2023 at 09:35:00AM +0100, Jiri Pirko wrote:
>> Fri, Feb 17, 2023 at 02:47:36PM CET, mst@redhat.com wrote:
>> >On Fri, Feb 17, 2023 at 01:53:55PM +0100, Jiri Pirko wrote:
>> >> Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
>> >> >On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
>> >> >> 
>> >> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> >> >> set implicates that the driver provides the exact size of the header.
>> >> >> 
>> >> >> The driver already complies to fill the correct value. Introduce the
>> >> >> feature and advertise it.
>> >> >> 
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >
>> >> >Could you add a bit of motivation just for the record?
>> >> >Does this improve performance for some card? By how much?
>> >> >Expected to help some future card?
>> >> 
>> >> I can get that info, but isn't that rather something to be appended to
>> >> the virtio-spec patch? I mean, the feature is there, this is just
>> >> implementing it in one driver.
>> >
>> >It is more like using it in the driver.  It's not like we have to use
>> >everything - it could be useful for e.g. dpdk but not linux.
>> >Implementing it in the Linux driver has support costs - for example what
>> >if there's a bug and sometimes the length is incorrect?
>> >We'll be breaking things.
>> 
>> I understand. To my understanding this feature just fixes the original
>> ambiguity in the virtio spec.
>> 
>> Quoting the original virtio spec:
>> "hdr_len is a hint to the device as to how much of the header needs to
>>  be kept to copy into each packet"
>> 
>> "a hint" might not be clear for the reader what does it mean, if it is
>> "maybe like that" of "exactly like that". This feature just makes it
>> crystal clear.
>> 
>> If you look at the tap implementation, it uses hdr_len to alloc
>> skb linear part. No hint, it counts with the provided value.
>> So if the driver is currently not precise, it breaks tap.
>
>Well that's only for gso though right?

Yep.


>And making it bigger than necessary works fine ...

Well yeah. But tap does not do that, does it? it uses hdr_len directly.


>
>> I will add this to the patch description and send v2.
>> 
>
>I feel this does not answer the question yet, or maybe I am being dense.
>My point was not about making hdr_len precise.  My point was that we are
>making a change here for no apparent reason. I am guessing you are not
>doing it for fun - so why? Is there a device with this feature bit
>you are aware of?

Afaik real hw which does emulation of virtio_net would benefit from
that, our hw including.


>
>
>
>> 
>> >
>> >The patch was submitted by Marvell but they never bothered with
>> >using it in Linux. I guess they are using it for something else?
>> >CC Vitaly who put this in.
>> >
>> >> 
>> >> >
>> >> >thanks!
>> >> >
>> >> >
>> >> >> ---
>> >> >>  drivers/net/virtio_net.c        | 6 ++++--
>> >> >>  include/uapi/linux/virtio_net.h | 1 +
>> >> >>  2 files changed, 5 insertions(+), 2 deletions(-)
>> >> >> 
>> >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> >> >> index fb5e68ed3ec2..e85b03988733 100644
>> >> >> --- a/drivers/net/virtio_net.c
>> >> >> +++ b/drivers/net/virtio_net.c
>> >> >> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
>> >> >>  	VIRTIO_NET_F_GUEST_UFO,
>> >> >>  	VIRTIO_NET_F_GUEST_CSUM,
>> >> >>  	VIRTIO_NET_F_GUEST_USO4,
>> >> >> -	VIRTIO_NET_F_GUEST_USO6
>> >> >> +	VIRTIO_NET_F_GUEST_USO6,
>> >> >> +	VIRTIO_NET_F_GUEST_HDRLEN
>> >> >>  };
>> >> >>  
>> >> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>> >> >> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
>> >> >>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>> >> >>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>> >> >>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>> >> >> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
>> >> >> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>> >> >> +	VIRTIO_NET_F_GUEST_HDRLEN
>> >> >>  
>> >> >>  static unsigned int features[] = {
>> >> >>  	VIRTNET_FEATURES,
>> >> >> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> >> >> index b4062bed186a..12c1c9699935 100644
>> >> >> --- a/include/uapi/linux/virtio_net.h
>> >> >> +++ b/include/uapi/linux/virtio_net.h
>> >> >> @@ -61,6 +61,7 @@
>> >> >>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>> >> >>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
>> >> >>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>> >> >> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
>> >> >>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>> >> >>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>> >> >>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>> >> >> -- 
>> >> >> 2.39.0
>> >> >
>> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
