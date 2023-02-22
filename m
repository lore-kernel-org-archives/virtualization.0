Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0976BC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 07:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9358681E48;
	Wed, 22 Feb 2023 07:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9358681E48
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=BET73045
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-55gGlQZnwc; Wed, 22 Feb 2023 07:59:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7DB381E55;
	Wed, 22 Feb 2023 07:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7DB381E55
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE1E2C0032;
	Wed, 22 Feb 2023 07:59:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F168C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68D53410E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:59:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68D53410E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=BET73045
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9k-8_cjPUGQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:59:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AAD94093F
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AAD94093F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:59:26 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so23040146edb.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 23:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bdeW3qvNiBrob62Gc9itLcHMQJwmSDCiKfujNANS15g=;
 b=BET73045gSuaO3DWFxmcjffkcUX+ZNsva/jAmxbxXxdmmb758l6sLQccXWo3JztpDC
 DCrwCNy8/GnIt6DHSWGfhTqgdYbnY4Iz3aWa9GXULHEqEm4VIXQ486aBfkV0GoQqjRDW
 tZ5mKNV8ttcqr862ksL99sp6tY+JfBkPH/BrliejHdYBZ39I0bd9LkUsIRDjNSaAl3N5
 1r7BSZcoUV2oxOzMz0oj+w8U5a1dYHEyPoaXsqj8/kJ+V/AMeoNHF/M4BNBY5gAw74nx
 OgyYiodPgY1Iv/+MC9HtO0z/+CtXFsa/1yByCvP3aPLL6aKD/7ha9oZLC8QK90vGzhIC
 x8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdeW3qvNiBrob62Gc9itLcHMQJwmSDCiKfujNANS15g=;
 b=ft2vC3/muFuo270/AbFdniBnxxXDlRNeUdGkn99P4bcS1s5vcHicC7ZxTn81kc8uFh
 M7OAw1rzJoDfEC2eAgYCE1HQz5yi+pQVaeEHNJuo7RD3CzxTWrtJIruXvrJDH4LOWIZl
 1WXB3r6RKbvN6z4U8VI5Q7mVl7vrpoi2hRs31ujBjXSm7T25EDi2R6yvTzkX/2/4LZ6r
 ZkFBzr8I5SiSneoyy7Mk8vT9UPQM2V78vAti1lVLL9C0Om/t6vFyDgIsUxG0/DU4xi4B
 yDXrzAQJBSCySFpRanKWj8/p/3uux44Oz2x1RxI3lYD2BcanzSw7qccWqaIVo5V9lqAb
 Mhfg==
X-Gm-Message-State: AO0yUKXHv878vufiwkuDYu/PIP4hrDCCJB64Lhs4HFnmSH9+OUjhQduI
 m42jYXviYw7cGTmQ4gvVAlMoIw==
X-Google-Smtp-Source: AK7set+fdkYCHTMeo/1ZRh5HPwWYECuoIvfh703JiWElK3dGPBJ8iL1u6xVXoltujVpfxyATfulZbQ==
X-Received: by 2002:a17:906:e294:b0:8b1:7b54:a013 with SMTP id
 gg20-20020a170906e29400b008b17b54a013mr15627130ejb.57.1677052764520; 
 Tue, 21 Feb 2023 23:59:24 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 gh31-20020a1709073c1f00b008b1797b77b2sm7422313ejc.221.2023.02.21.23.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 23:59:23 -0800 (PST)
Date: Wed, 22 Feb 2023 08:59:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Message-ID: <Y/XLWlw9XJUd6jel@nanopsycho>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <20230221121543-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230221121543-mutt-send-email-mst@kernel.org>
Cc: vmireyno@marvell.com, netdev@vger.kernel.org,
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

Tue, Feb 21, 2023 at 06:21:16PM CET, mst@redhat.com wrote:
>On Tue, Feb 21, 2023 at 03:47:41PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> set implicates that the driver provides the exact size of the header.
>
>OK but I feel this is not the important point. The important points are:
>- this bit means device needs this info
>- driver also has to set this bit
>For example one might replace above with:
>
>	Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>	which when set implicates that device benefits from knowing the exact
>	size of the header. For compatiblity, to signal to the device that the header
>	is reliable driver also needs to set this feature.
>	Without this feature set by driver, device has to figure
>	out the header size itself.
>
>and the below is ok.
>
>> Quoting the original virtio spec:
>> "hdr_len is a hint to the device as to how much of the header needs to
>>  be kept to copy into each packet"
>> 
>> "a hint" might not be clear for the reader what does it mean, if it is
>> "maybe like that" of "exactly like that". This feature just makes it
>> crystal clear and let the device count on the hdr_len being filled up
>> by the exact length of header.
>> 
>> Also note the spec already has following note about hdr_len:
>> "Due to various bugs in implementations, this field is not useful
>>  as a guarantee of the transport header size."
>> 
>> Without this feature the device needs to parse the header in core
>> data path handling. Accurate information helps the device to eliminate
>> such header parsing and directly use the hardware accelerators
>> for GSO operation.
>> 
>> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
>> The driver already complies to fill the correct value. Introduce the
>> feature and advertise it.
>> 
>> Note that virtio spec also includes following note for device
>> implementation:
>> "Caution should be taken by the implementation so as to prevent
>>  a malicious driver from attacking the device by setting
>>  an incorrect hdr_len."
>> 
>> There is a plan to support this feature in our emulated device.
>> A device of SolidRun offers this feature bit. They claim this feature
>> will save the device a few cycles for every GSO packet.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>I'm fine with patch itself. with commit log tweak:
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Okay. Will do. I will put link to the spec as well

Thanks!

>
>
>> ---
>> v1->v2:
>> - extended patch description
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
