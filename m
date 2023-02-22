Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF582C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 07:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FA5640150;
	Wed, 22 Feb 2023 07:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FA5640150
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zIORBVKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R5hLhg223bYD; Wed, 22 Feb 2023 07:58:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B717B403BE;
	Wed, 22 Feb 2023 07:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B717B403BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8835FC0032;
	Wed, 22 Feb 2023 07:58:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B012C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E226281E48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:58:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E226281E48
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=zIORBVKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vD1RRbrwtmaX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:58:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22BE981E37
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22BE981E37
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:58:30 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id s26so26808326edw.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tMiHi/cBJFvMvMXsiQE7+Z5SH+iPrBno2vV9oiQq5+M=;
 b=zIORBVKs5wvYIt/NE+95SxKobhocieC/ab4iUtKOu1iTlcULph/CGpmg5l/fsuByuy
 YUD48KmVUS6hbh8FjmN2MD0s0ES0djEMXJyDq9erNtjOSUlwVkuwP455NYItUOATyhhl
 0HOaV86zenfQ/PbZ2PFoR5/TcMqf7z59TjW7gycrn1LIDH8TKPc/vhMWD619wVQz8JR1
 0I1/EYMzB72FMU24Ae7DZyaZTMo/6era7fWdGS45TNAqnJ7srPqlQwKlrIKTBm3Fs7gJ
 0yyhs5Fo645+P82hUzsDUuDjk/5TTT3bcRH/Be6TjFbXBar/nsRF2ox/gfUJdD4F58GR
 K8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMiHi/cBJFvMvMXsiQE7+Z5SH+iPrBno2vV9oiQq5+M=;
 b=AWKp0ncKWvldbP8+D/eS2rFx4CwOLu9QJuqUu5NUDdbMXboy/8r4eZM2EZW+NysePM
 285waKrkwI/J+IJpdvKkyMttn8JexDIZzJRA3YhzG8ALJCGgWGgheXer2fEmiAf6LHSB
 6iKNMd7kuSSrWhOYueuxWrcGCg5lpb5tHLXX72sFlC2s+agTPWmRDD7VEY0dxC1EM/kS
 v7Rt8tf6wy4lGYmDbvicSAC3Fa/9hUDgNirofilm/temFJN9635O99A/Uh/Nqz4bfgNo
 mNzbOfYM32IAsSFx3bMDCWyKhddBJiVS+ET14MX6IA63TwaHbvip6g/cPfVGiH2f0PLt
 jmpw==
X-Gm-Message-State: AO0yUKWVjphkB7E8uuO9AlCAyXQwIacNRNppm7kFAeuiOsiXAorFcFqz
 s09T+ry3ZCHyDMJrHVI60ZmSCg==
X-Google-Smtp-Source: AK7set+BkOGRM5kYs510JAPgZTtyESbkJMRNL8UAs6qXdnNB0GfMt1fVlMxFEvZx9acOG/OyHuCbgQ==
X-Received: by 2002:a17:907:a40d:b0:878:7349:5ce6 with SMTP id
 sg13-20020a170907a40d00b0087873495ce6mr19275302ejc.71.1677052708175; 
 Tue, 21 Feb 2023 23:58:28 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 y6-20020a50ce06000000b004acc6c67089sm3676070edi.75.2023.02.21.23.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 23:58:27 -0800 (PST)
Date: Wed, 22 Feb 2023 08:58:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Message-ID: <Y/XLIs+4eg7xPyF0@nanopsycho>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
 <Y/TltJnD4k5hB6Z1@nanopsycho>
 <63f4ed716af37_d174a20880@willemb.c.googlers.com.notmuch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63f4ed716af37_d174a20880@willemb.c.googlers.com.notmuch>
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

Tue, Feb 21, 2023 at 05:12:33PM CET, willemdebruijn.kernel@gmail.com wrote:
>Jiri Pirko wrote:
>> Tue, Feb 21, 2023 at 04:11:53PM CET, willemdebruijn.kernel@gmail.com wrote:
>> >Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
>> >> set implicates that the driver provides the exact size of the header.
>> >> 
>> >> Quoting the original virtio spec:
>> >> "hdr_len is a hint to the device as to how much of the header needs to
>> >>  be kept to copy into each packet"
>> >> 
>> >> "a hint" might not be clear for the reader what does it mean, if it is
>> >> "maybe like that" of "exactly like that". This feature just makes it
>> >> crystal clear and let the device count on the hdr_len being filled up
>> >> by the exact length of header.
>> >> 
>> >> Also note the spec already has following note about hdr_len:
>> >> "Due to various bugs in implementations, this field is not useful
>> >>  as a guarantee of the transport header size."
>> >> 
>> >> Without this feature the device needs to parse the header in core
>> >> data path handling. Accurate information helps the device to eliminate
>> >> such header parsing and directly use the hardware accelerators
>> >> for GSO operation.
>> >> 
>> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
>> >> The driver already complies to fill the correct value. Introduce the
>> >> feature and advertise it.
>> >> 
>> >> Note that virtio spec also includes following note for device
>> >> implementation:
>> >> "Caution should be taken by the implementation so as to prevent
>> >>  a malicious driver from attacking the device by setting
>> >>  an incorrect hdr_len."
>> >> 
>> >> There is a plan to support this feature in our emulated device.
>> >> A device of SolidRun offers this feature bit. They claim this feature
>> >> will save the device a few cycles for every GSO packet.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >> v1->v2:
>> >> - extended patch description
>> >
>> >Is the expectation that in-kernel devices support this feature, and
>> >if so how would it affect them? If I read the spec correctly, devices
>> 
>> Well, the tap driver actually trusts the hdr_len to be of correct header
>> size nowadays.
>
>tap_get_user performs basic bounds checking on the length passed.

Sure. It trusts the hdr_len, but it sanitizes the input.


> 
>> 
>> >still need to be careful against malicious drivers, so cannot assume
>> >much beyond what they do today (i.e., a hint).
>> 
>> Malicious how? There is upper limit of size in tap which is checked.
>> I assume that for hw implementation, that would be the same.
>
>A device cannot blindly trust a hdr_len passed from a driver. We have
>had bugs in the kernel with this before, such as the one fixed in
>commit 57031eb79490 ("packet: round up linear to header len").
>
>> But anyway, this discussion would be rather part of the spec/device
>> patch, don't you think?
>
>I disagree. If it's not much effort to make a commit self-documenting
>that is preferable. And if not, then an explicit reference to an
>authoratitive external reference is preferable over "it is trivial to
>look it up".

Sorry, I don't follow. What exactly do you want me to do?


> 
>> 
>> >
>> >Might be good to point to the definition commit:
>> >https://github.com/oasis-tcs/virtio-spec/commit/4f1981a1ff46b7aeb801c4c524ff76e93d9ce022
>> 
>> There were couple of fixes to the spec since then, that's why I didn't
>> include it. It is trivial to look it up in the spec.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
