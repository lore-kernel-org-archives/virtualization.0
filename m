Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE35DC6379F
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 12:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A3544016B;
	Fri, 17 Feb 2023 12:54:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A3544016B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=A96uSb+5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A87V2ginn62B; Fri, 17 Feb 2023 12:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA4DF40278;
	Fri, 17 Feb 2023 12:54:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA4DF40278
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0C31C0033;
	Fri, 17 Feb 2023 12:54:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02517C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3D3C60ADF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:54:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3D3C60ADF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=A96uSb+5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18WI4njIbVXD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:54:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC6CD60A71
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC6CD60A71
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:53:59 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 m21-20020a05600c3b1500b003e1f5f2a29cso904170wms.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=45KqkEB3XAWUGWP8wuflSuAHlvBrwamlrO1r+HT6bHo=;
 b=A96uSb+5vY+qrkurwuL+4BLvdu39RIjSO5Pn4Lw4zLJs2Mima7rztmqivSEwSXGQoi
 tGbqRJNF9EZ0yLyM6OLSxrHKut+/Lop8BYeFGZV6TsaTrqYDeFRgl8vF4pvWMMobJ1Ne
 FJWC7AwVZeUbARHRn+qv5CLMP8HCUL/QOipHMNzOcE+LmVO7CfOjIAvkE9OI8nOh3z3Z
 Z/Cb/+b4BSZGTOi28TGU2OL8BABtWUF2Rfv7FUpCOsEdy7PNPXCmsd8XXb8oyidF4PsO
 lZbqsCNW4iobw0LVVCSrpGVLvewIhHQ7i2p4wtTcT9o+ot7foKK7otMhsemcML3r9XSf
 er2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45KqkEB3XAWUGWP8wuflSuAHlvBrwamlrO1r+HT6bHo=;
 b=u7NF6tmSjd4Is2BZHs+GiHyz+ZLVmmA5gCSId9nR70a39u6Rv2DTWL90ROtFiIY42H
 gIXgDAEZhcC6hXEJ/C2jVB/LFVk6usgyCMH/+GquyKO9obbSmxNRUgwUnC+GCEUg9UbQ
 bIMCewgjhWQOYb4gelqBl91Z8d8TQlbFLUxzZYGMSXI+uwXX54XkHno56/kNXGhxwtbd
 c8ETkyNEzl5HHB3d8p7N7bYBALwdefuSAeL8S/vVPcTrQtKCjKHIY2sdtMHH5r13WJ36
 o83G40xbzDlhyYBqrQpxJcItN9VKXI3kLRizvfveikG7+cnAK/zrFC3pZvsdH2UtnPwN
 AqSQ==
X-Gm-Message-State: AO0yUKVEvAgsn4dHYQSzo5CDJ7KtDskQ/q4MoK6UyYs9vrPOWCKw9k1S
 b9bliRhqzjolo9D0N3JjPc851A==
X-Google-Smtp-Source: AK7set8Hp1taGatbfIOYJawb/0OAZoromM7OY6UpatF8LhVN3uM88z6cS36LKj5PPkejFWLqbVPQZQ==
X-Received: by 2002:a05:600c:747:b0:3dc:5a13:c7d1 with SMTP id
 j7-20020a05600c074700b003dc5a13c7d1mr1005383wmn.16.1676638437462; 
 Fri, 17 Feb 2023 04:53:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 c63-20020a1c3542000000b003df7b40f99fsm8980022wma.11.2023.02.17.04.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Feb 2023 04:53:56 -0800 (PST)
Date: Fri, 17 Feb 2023 13:53:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <Y+94418p73aUQyIn@nanopsycho>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230217072032-mutt-send-email-mst@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Fri, Feb 17, 2023 at 01:22:01PM CET, mst@redhat.com wrote:
>On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
>> 
>> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> set implicates that the driver provides the exact size of the header.
>> 
>> The driver already complies to fill the correct value. Introduce the
>> feature and advertise it.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Could you add a bit of motivation just for the record?
>Does this improve performance for some card? By how much?
>Expected to help some future card?

I can get that info, but isn't that rather something to be appended to
the virtio-spec patch? I mean, the feature is there, this is just
implementing it in one driver.


>
>thanks!
>
>
>> ---
>>  drivers/net/virtio_net.c        | 6 ++++--
>>  include/uapi/linux/virtio_net.h | 1 +
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index fb5e68ed3ec2..e85b03988733 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
>>  	VIRTIO_NET_F_GUEST_UFO,
>>  	VIRTIO_NET_F_GUEST_CSUM,
>>  	VIRTIO_NET_F_GUEST_USO4,
>> -	VIRTIO_NET_F_GUEST_USO6
>> +	VIRTIO_NET_F_GUEST_USO6,
>> +	VIRTIO_NET_F_GUEST_HDRLEN
>>  };
>>  
>>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
>>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
>> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>> +	VIRTIO_NET_F_GUEST_HDRLEN
>>  
>>  static unsigned int features[] = {
>>  	VIRTNET_FEATURES,
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index b4062bed186a..12c1c9699935 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -61,6 +61,7 @@
>>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
>>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
>>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>> -- 
>> 2.39.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
