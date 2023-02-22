Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26250C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 11:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEB4F4188A;
	Wed, 22 Feb 2023 11:32:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEB4F4188A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=xWNgHhp8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mm5VJim5ukQz; Wed, 22 Feb 2023 11:32:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 903C44187A;
	Wed, 22 Feb 2023 11:32:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 903C44187A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63065C0032;
	Wed, 22 Feb 2023 11:32:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D33D6C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 11:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A040B60E25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 11:32:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A040B60E25
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=xWNgHhp8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PIQEQwmPTsGI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 11:32:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C112260E24
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C112260E24
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 11:32:13 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id z5so7461651ljc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/ie1EAFQskbLzZ9c2yaNowwo9PJlaG1TNIeFawZhYi0=;
 b=xWNgHhp8xCIMwy7xA2QF5fvHhjJIN7RaD2lzH5hVBAweuJCGQVwDtqwoDrDKNsHdj/
 6xuR4XRfzJBp6jc4zWN9+83WCqmZMYauiH0QbaxWN2cX0edNa7GksmJDl1ONaOjMZln5
 9vqOtwaXQDvMnpCHDv/g3Qf8IXdPjR3KMnFulByRAhMWY77/7Z6PZsEeptCYPaHb33rV
 sMFWqIyEdU3fAAS3VOmzDm51cvES0MtscEuuMXeLTMjE278Xzpc6FDmOxvTCnWxqr+jI
 dVs+unrHiugxXC14B8PYzY8HeQahpyXG8o0DPjui9fwxBfFaq/LGDNvmaj5RrWKQNi6B
 nO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ie1EAFQskbLzZ9c2yaNowwo9PJlaG1TNIeFawZhYi0=;
 b=TEZzOpl+DTWbotXGYPFCZ7I5gcA3TGiCrwj98O1YcHXGQ/Bj/dUQOSGdmwwFdWCV0r
 g9JBtUZjv9yEWs+xbYKBwakGd7RWc0d3k9cKWGlQI3mkTpyNk69C22rWCUbEycg/5ibi
 Iv+8P3CjFWFIqNnT1OxTJUt2ESakrLUuZ91sk7sCO12JPN+/Hdb/5kIvFC/Tlx/5rIgp
 /jNagkRsIpGBlEjw+uUUfZhSuMliHWWNWm6bHhGumQQjmXkUBDe9LbpP+0nBMfkB5qNi
 mIOKXG7NTcLrUbNzzqVf3mwFDJ0vjq0Xd3WmgrRoWdSnzQxo/iHxPsz78r/WWULIEX9o
 O0Eg==
X-Gm-Message-State: AO0yUKXWvebWZvT6mfMsLcZWKMcp/yYxdvrtyCAPanYg1v7sgd6Fe375
 ObS+Z9OLrX4QZh6nnUE/PSNlgw==
X-Google-Smtp-Source: AK7set+I8w4pkOUhwzpfmgCYOfKOm3eSL1n1kvZ0XXIfmWo9tLlMJhHKbv1hRKDeX2oMfvGFV/1esA==
X-Received: by 2002:a2e:505e:0:b0:293:4e64:1058 with SMTP id
 v30-20020a2e505e000000b002934e641058mr2951517ljd.35.1677065530839; 
 Wed, 22 Feb 2023 03:32:10 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 t5-20020a2e9c45000000b002934baca39bsm913872ljj.47.2023.02.22.03.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Feb 2023 03:32:10 -0800 (PST)
Date: Wed, 22 Feb 2023 12:32:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [patch net-next v3] net: virtio_net: implement exact header
 length guest feature
Message-ID: <Y/X9OKgGEbxCVdn9@nanopsycho>
References: <20230222080638.382211-1-jiri@resnulli.us>
 <20230222062208-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230222062208-mutt-send-email-mst@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, vmireyno@marvell.com,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

Wed, Feb 22, 2023 at 12:24:18PM CET, mst@redhat.com wrote:
>On Wed, Feb 22, 2023 at 09:06:38AM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> which when 
>
>which when which when is probably unintentional :)

I copy-pasted your text :)

Anyway, I guess net-next is closed anyway. Will fix&send after merge
window closes.


>
>>set implicates that device benefits from knowing the exact
>> size of the header. For compatibility, to signal to the device that
>> the header is reliable driver also needs to set this feature.
>> Without this feature set by driver, device has to figure
>> out the header size itself.
>> 
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
>> Link: https://docs.oasis-open.org/virtio/virtio/v1.2/cs01/virtio-v1.2-cs01.html#x1-230006x3
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> v2->v3:
>> - changed the first paragraph in patch description according to
>>   Michael's suggestion
>> - added Link tag with link to the spec
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
