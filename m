Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2914EC636D7
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 16:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B38C682849;
	Tue, 21 Feb 2023 16:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B38C682849
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=K0OiTMBf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAHHd8x1zjNI; Tue, 21 Feb 2023 16:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C772823F6;
	Tue, 21 Feb 2023 16:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C772823F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5A5EC0033;
	Tue, 21 Feb 2023 16:12:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8471C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 16:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B48C842E5E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 16:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B48C842E5E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=K0OiTMBf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gwK1PxXhGTZ1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 16:12:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A18642DD9
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A18642DD9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 16:12:35 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id k20so1473191qtj.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOVbf0Jj7n0h+rN9B1b7a1tvZN7i0xM79+a5LjkHtlE=;
 b=K0OiTMBfOnSIY8WOlxZhTFPJvou6xpIF16T/n7FMod0hUZcxYky8baFfXb0uUQy3bi
 PLXqH885WLbdNgSdVL/drKFtRK+De6tto3o1TjV6YuBH7LwkhsZX4e2GTefmB0QlBujH
 45xvv6Zw5VYxfEoKpPm7aNPjvB7sLpSQ3ejOBMbkS2OEj/hvPibfbxi74AXIpjphLZHO
 7RVwNQwf8Dyr9RoEMtHm62X9C/h9vlCP5MZWS1L/W0KrVcMoiyv7nllzhGk8gPhdbdIL
 ol1Md3RK1C2LyQtVURYrsEF56LX8nW9GOzKopkKesHi0HoPXCdsV8mL99uWM7aS8sDGt
 CYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iOVbf0Jj7n0h+rN9B1b7a1tvZN7i0xM79+a5LjkHtlE=;
 b=oVrlha5bLRjKhNRcyTL/ob3lMYzt/7XFoMoXs5AD4zo90XU64FZFcvx2+Fh+BQcGVd
 KyB9s6XCWlUGigUqRmqiKfu2XiP3sYScXJAWMC6iOOZjuycsABdR5TUCRMRn8RAqx87n
 ENCTyXcO8G3dNJlXD/MHZZDRhBTDI1bgUd7YVEcojpNWzxxUTJK2axYEJMoK/JWx9lyA
 AnG4Ake4nbu02LmpAH388RJBDjIVZUEo/Oz56gDREfICmMzbAcnXdFxDbnqgO33+oHQt
 xNG4wxKVsgArI7P4IybsvuBJenTE1VUtCisFJWoXN/Mht0xnqG7oDZIqI4BWQmcUDVDx
 Nxzg==
X-Gm-Message-State: AO0yUKU/NbDr2qiouYLGEuUXYk/n+f4hGceT/61ZUbS4RdxHC2c4cY/z
 3418ajFex/mndtxPPAlCekQ=
X-Google-Smtp-Source: AK7set9eeoptqYWwTH+BLMC80x39U+80hiB79zey4MYkBCR4KDidVutUrAIBq2AGQo1Shhv9o8oMyg==
X-Received: by 2002:ac8:5f13:0:b0:3b9:abfb:61cd with SMTP id
 x19-20020ac85f13000000b003b9abfb61cdmr8641505qta.26.1676995954091; 
 Tue, 21 Feb 2023 08:12:34 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com.
 [34.150.157.240]) by smtp.gmail.com with ESMTPSA id
 ca26-20020a05622a1f1a00b003b62e8b77e7sm2516427qtb.68.2023.02.21.08.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 08:12:33 -0800 (PST)
Date: Tue, 21 Feb 2023 11:12:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <63f4ed716af37_d174a20880@willemb.c.googlers.com.notmuch>
In-Reply-To: <Y/TltJnD4k5hB6Z1@nanopsycho>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
 <Y/TltJnD4k5hB6Z1@nanopsycho>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Mime-Version: 1.0
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

Jiri Pirko wrote:
> Tue, Feb 21, 2023 at 04:11:53PM CET, willemdebruijn.kernel@gmail.com wrote:
> >Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> >> set implicates that the driver provides the exact size of the header.
> >> 
> >> Quoting the original virtio spec:
> >> "hdr_len is a hint to the device as to how much of the header needs to
> >>  be kept to copy into each packet"
> >> 
> >> "a hint" might not be clear for the reader what does it mean, if it is
> >> "maybe like that" of "exactly like that". This feature just makes it
> >> crystal clear and let the device count on the hdr_len being filled up
> >> by the exact length of header.
> >> 
> >> Also note the spec already has following note about hdr_len:
> >> "Due to various bugs in implementations, this field is not useful
> >>  as a guarantee of the transport header size."
> >> 
> >> Without this feature the device needs to parse the header in core
> >> data path handling. Accurate information helps the device to eliminate
> >> such header parsing and directly use the hardware accelerators
> >> for GSO operation.
> >> 
> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> >> The driver already complies to fill the correct value. Introduce the
> >> feature and advertise it.
> >> 
> >> Note that virtio spec also includes following note for device
> >> implementation:
> >> "Caution should be taken by the implementation so as to prevent
> >>  a malicious driver from attacking the device by setting
> >>  an incorrect hdr_len."
> >> 
> >> There is a plan to support this feature in our emulated device.
> >> A device of SolidRun offers this feature bit. They claim this feature
> >> will save the device a few cycles for every GSO packet.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >> v1->v2:
> >> - extended patch description
> >
> >Is the expectation that in-kernel devices support this feature, and
> >if so how would it affect them? If I read the spec correctly, devices
> 
> Well, the tap driver actually trusts the hdr_len to be of correct header
> size nowadays.

tap_get_user performs basic bounds checking on the length passed.
 
> 
> >still need to be careful against malicious drivers, so cannot assume
> >much beyond what they do today (i.e., a hint).
> 
> Malicious how? There is upper limit of size in tap which is checked.
> I assume that for hw implementation, that would be the same.

A device cannot blindly trust a hdr_len passed from a driver. We have
had bugs in the kernel with this before, such as the one fixed in
commit 57031eb79490 ("packet: round up linear to header len").

> But anyway, this discussion would be rather part of the spec/device
> patch, don't you think?

I disagree. If it's not much effort to make a commit self-documenting
that is preferable. And if not, then an explicit reference to an
authoratitive external reference is preferable over "it is trivial to
look it up".
 
> 
> >
> >Might be good to point to the definition commit:
> >https://github.com/oasis-tcs/virtio-spec/commit/4f1981a1ff46b7aeb801c4c524ff76e93d9ce022
> 
> There were couple of fixes to the spec since then, that's why I didn't
> include it. It is trivial to look it up in the spec.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
