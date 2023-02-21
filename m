Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB61C61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 15:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57D0F611F3;
	Tue, 21 Feb 2023 15:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57D0F611F3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wEIZixv0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvDS_shlbC8N; Tue, 21 Feb 2023 15:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93BB0610F3;
	Tue, 21 Feb 2023 15:39:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93BB0610F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6754AC0032;
	Tue, 21 Feb 2023 15:39:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D836C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A79842C8C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:39:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A79842C8C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=wEIZixv0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UPAkXncJEQjq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:39:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1F0941868
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1F0941868
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:39:37 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id i9so6083802lfc.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 07:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HutO66KxdGHGXw1VHimKBSyzTw6e0TxvcOhPJxxjBb0=;
 b=wEIZixv04yJaFPEtg6JdN9oobN3EhiImcU0Co823WH+CzQNc6Ow3t7pJAET3RbY510
 vCCezjypPz/mj2XD0rEwYmJahaENiyWpBPqO28pHhu1ERoeMIuOyod69izUU/ejva0fr
 ktLc9UVkP/ZiboLkh5xKHHpvIE6M+ZPS+NzPtVseb7rK9plTiE6OMzYWGVpsA/RcPOr7
 TJ7r/hGnWEc9p9TGMfoNqZXAiqwVCDrt+Hf41n1T5c8Y8FJnMYz/ypv9EbV9sdfsHZXJ
 55DX9q3NDoWQzFLBCnG8tjGpPIvKAaF7tNlVUYr+CQEZ6DULfIow43bGa53NR5lw+qsT
 loWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HutO66KxdGHGXw1VHimKBSyzTw6e0TxvcOhPJxxjBb0=;
 b=FbIrrw8ILbfwhmIM0wYc80ILM9mQuETaQWetM1Uj08yVzFgAclPXTdZNo5ymDGOzJS
 SfKHZ//FPHO+0797vfp3zUoM0FxnFcVwCuFPICPLhsvNCJ2OzdpRjArExGuUSibof0eR
 3g01iUeSrsQ4+yV4r0B4mVikDy9HZC+fVy+j53MJj/0+UMVjnkTgTd7AWIqO2CsqfMk2
 WDWBtdkh9kqbFXIbu7lzWa61yEAo7YkzTeS4A0ccIBWOzN2OTZx9DQDVUN736U+CYmvh
 1JjrrzSBe1fsmM+lKrpAhBzWahLDYtGOMrySTNB++7lqHd4ntYsx0EXHmX6smM6xzpcH
 E+SQ==
X-Gm-Message-State: AO0yUKWsnAue8Of5xJo6pbTfi/c7WdJfnVWB2wQsTE9AkdS2jvlBym78
 2+2ZNyBsiZYYVwntg87+HeeInQ==
X-Google-Smtp-Source: AK7set/vRNIeWrREIcRiKHq0u5h+Fj+Gsr9w4Yql0nAXYDncrBF9KTq5y19jLB+EEC6drEZoWOepGQ==
X-Received: by 2002:a05:6512:32c5:b0:4d8:86c1:4781 with SMTP id
 f5-20020a05651232c500b004d886c14781mr2106698lfg.22.1676993974766; 
 Tue, 21 Feb 2023 07:39:34 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 q10-20020ac25a0a000000b004dc4b0ca734sm385566lfn.250.2023.02.21.07.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 07:39:34 -0800 (PST)
Date: Tue, 21 Feb 2023 16:39:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Message-ID: <Y/TltJnD4k5hB6Z1@nanopsycho>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
Cc: mst@redhat.com, netdev@vger.kernel.org, vmireyno@marvell.com,
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

Tue, Feb 21, 2023 at 04:11:53PM CET, willemdebruijn.kernel@gmail.com wrote:
>Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> set implicates that the driver provides the exact size of the header.
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
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - extended patch description
>
>Is the expectation that in-kernel devices support this feature, and
>if so how would it affect them? If I read the spec correctly, devices

Well, the tap driver actually trusts the hdr_len to be of correct header
size nowadays.


>still need to be careful against malicious drivers, so cannot assume
>much beyond what they do today (i.e., a hint).

Malicious how? There is upper limit of size in tap which is checked.
I assume that for hw implementation, that would be the same.

But anyway, this discussion would be rather part of the spec/device
patch, don't you think?


>
>Might be good to point to the definition commit:
>https://github.com/oasis-tcs/virtio-spec/commit/4f1981a1ff46b7aeb801c4c524ff76e93d9ce022

There were couple of fixes to the spec since then, that's why I didn't
include it. It is trivial to look it up in the spec.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
