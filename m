Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF1C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 12:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E49641090;
	Mon, 20 Feb 2023 12:55:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E49641090
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ACQGhoK/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJPbRuOfx3qj; Mon, 20 Feb 2023 12:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB5F540906;
	Mon, 20 Feb 2023 12:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB5F540906
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 821CAC0032;
	Mon, 20 Feb 2023 12:55:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABC4AC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 12:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 792FF81E96
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 12:55:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 792FF81E96
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ACQGhoK/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q7hon8OC6vxK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 12:55:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85F0381E91
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85F0381E91
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676897740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5T9bZZKt8QsdieBTdNvr7iToD1QjAmvloZaVLt8Qlc=;
 b=ACQGhoK/Rs9xZWf2yOeZuzbjIYdM0y+qcHMbNFg+Nv0xuMb//9SQ/d0iE4NT0sW/fwCIuQ
 O5CakJ8zRtZGj2xYb5N2oG2SqsSW6b/QcEGlTLSkRL/0SNb+eYe/mq1x+KpUmk4dcd2liv
 8ioY7NNjkPkGtQ++XMZDYV5ljKMs8ZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-364-5DMrCXKuOC2UFt4r82bMag-1; Mon, 20 Feb 2023 07:55:39 -0500
X-MC-Unique: 5DMrCXKuOC2UFt4r82bMag-1
Received: by mail-wr1-f69.google.com with SMTP id
 c14-20020adffb0e000000b002bfda39265aso358849wrr.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 04:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5T9bZZKt8QsdieBTdNvr7iToD1QjAmvloZaVLt8Qlc=;
 b=L7Osd+JIWhNGMqJ9wxEaZ38N7Hf0cqBgGbcb0wYkLP/Y4+wNDy/iPn/+QAu3KWzCE7
 TNUes1FGyyjhlHhzsbyC13utxlE3Gq+5svGl7b7MerEUTKzca1VRx4NgwXU9LGd0mouf
 rVNfaZEvjKhTPoI8uFxcX8jGrFEADl/dH17p5uSTTnxLc/YVnj853w58XUs/LPZ8fgOj
 rVeBnQ+Aq58Y/tjtNZw0mQ3gEQXjHeJl++J8zXjTuWjX2z/97sGXLwAaYUhZEXeizQtH
 WfnXCJCc7f9qDq5rvBHjenXNhrvG7b5yIypBF82YK0nIboIsr6A15650eyqQ1Gyg8jD5
 GZtQ==
X-Gm-Message-State: AO0yUKUFA1E1bh76QKZpYh2BBQYkwq8bcEZ4P18SlshX6Y04uw++CVkz
 bRR0hcfPgf1gF+NJOjB1IDOOv6tqwyq1xVu+X9KW9SLP/oQ4XKdii5n9harOVAsp2BDzzxjj/HY
 y7MKz05kgGJ9mv/V6hG1Rwk+lfl3NndZi5qlx9tjhOA==
X-Received: by 2002:a05:600c:319a:b0:3df:d431:cf64 with SMTP id
 s26-20020a05600c319a00b003dfd431cf64mr225442wmp.39.1676897737814; 
 Mon, 20 Feb 2023 04:55:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9MI/dsrz3E0sVvpzNF+oMUF9C/eNq3ChWdTY2lAFidx7zFfAjZqw7+KQ0K84Mn2XSwoT0xmg==
X-Received: by 2002:a05:600c:319a:b0:3df:d431:cf64 with SMTP id
 s26-20020a05600c319a00b003dfd431cf64mr225427wmp.39.1676897737450; 
 Mon, 20 Feb 2023 04:55:37 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 p8-20020a1c7408000000b003b47b80cec3sm151899wmc.42.2023.02.20.04.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Feb 2023 04:55:36 -0800 (PST)
Date: Mon, 20 Feb 2023 07:55:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <20230220074947-mutt-send-email-mst@kernel.org>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <Y/MwtAGru3yAY7r3@nanopsycho>
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

On Mon, Feb 20, 2023 at 09:35:00AM +0100, Jiri Pirko wrote:
> Fri, Feb 17, 2023 at 02:47:36PM CET, mst@redhat.com wrote:
> >On Fri, Feb 17, 2023 at 01:53:55PM +0100, Jiri Pirko wrote:
> >> Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
> >> >On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> >> >> 
> >> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> >> >> set implicates that the driver provides the exact size of the header.
> >> >> 
> >> >> The driver already complies to fill the correct value. Introduce the
> >> >> feature and advertise it.
> >> >> 
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >
> >> >Could you add a bit of motivation just for the record?
> >> >Does this improve performance for some card? By how much?
> >> >Expected to help some future card?
> >> 
> >> I can get that info, but isn't that rather something to be appended to
> >> the virtio-spec patch? I mean, the feature is there, this is just
> >> implementing it in one driver.
> >
> >It is more like using it in the driver.  It's not like we have to use
> >everything - it could be useful for e.g. dpdk but not linux.
> >Implementing it in the Linux driver has support costs - for example what
> >if there's a bug and sometimes the length is incorrect?
> >We'll be breaking things.
> 
> I understand. To my understanding this feature just fixes the original
> ambiguity in the virtio spec.
> 
> Quoting the original virtio spec:
> "hdr_len is a hint to the device as to how much of the header needs to
>  be kept to copy into each packet"
> 
> "a hint" might not be clear for the reader what does it mean, if it is
> "maybe like that" of "exactly like that". This feature just makes it
> crystal clear.
> 
> If you look at the tap implementation, it uses hdr_len to alloc
> skb linear part. No hint, it counts with the provided value.
> So if the driver is currently not precise, it breaks tap.

Well that's only for gso though right?
And making it bigger than necessary works fine ...

> I will add this to the patch description and send v2.
> 

I feel this does not answer the question yet, or maybe I am being dense.
My point was not about making hdr_len precise.  My point was that we are
making a change here for no apparent reason. I am guessing you are not
doing it for fun - so why? Is there a device with this feature bit
you are aware of?



> 
> >
> >The patch was submitted by Marvell but they never bothered with
> >using it in Linux. I guess they are using it for something else?
> >CC Vitaly who put this in.
> >
> >> 
> >> >
> >> >thanks!
> >> >
> >> >
> >> >> ---
> >> >>  drivers/net/virtio_net.c        | 6 ++++--
> >> >>  include/uapi/linux/virtio_net.h | 1 +
> >> >>  2 files changed, 5 insertions(+), 2 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> >> index fb5e68ed3ec2..e85b03988733 100644
> >> >> --- a/drivers/net/virtio_net.c
> >> >> +++ b/drivers/net/virtio_net.c
> >> >> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
> >> >>  	VIRTIO_NET_F_GUEST_UFO,
> >> >>  	VIRTIO_NET_F_GUEST_CSUM,
> >> >>  	VIRTIO_NET_F_GUEST_USO4,
> >> >> -	VIRTIO_NET_F_GUEST_USO6
> >> >> +	VIRTIO_NET_F_GUEST_USO6,
> >> >> +	VIRTIO_NET_F_GUEST_HDRLEN
> >> >>  };
> >> >>  
> >> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> >> >> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
> >> >>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
> >> >>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> >> >>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >> >> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
> >> >> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> >> >> +	VIRTIO_NET_F_GUEST_HDRLEN
> >> >>  
> >> >>  static unsigned int features[] = {
> >> >>  	VIRTNET_FEATURES,
> >> >> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> >> >> index b4062bed186a..12c1c9699935 100644
> >> >> --- a/include/uapi/linux/virtio_net.h
> >> >> +++ b/include/uapi/linux/virtio_net.h
> >> >> @@ -61,6 +61,7 @@
> >> >>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> >> >>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
> >> >>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
> >> >> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
> >> >>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
> >> >>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
> >> >>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> >> >> -- 
> >> >> 2.39.0
> >> >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
