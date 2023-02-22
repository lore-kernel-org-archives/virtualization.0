Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21605C636D6
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 15:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9062941972;
	Wed, 22 Feb 2023 15:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9062941972
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kZ1fJnQ2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hmX83N1jTGs; Wed, 22 Feb 2023 15:14:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF7CE4197A;
	Wed, 22 Feb 2023 15:14:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF7CE4197A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEF4AC0032;
	Wed, 22 Feb 2023 15:14:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1616C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 15:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BAAE820FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 15:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BAAE820FA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=kZ1fJnQ2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pBrEVrqBBP-i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 15:14:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A00DD820F8
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A00DD820F8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 15:14:23 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id bt6so7837798qtb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MP1pABxMzHpo8AMSOhxmhgtFnSUnUlB+dz2nSbkmVCQ=;
 b=kZ1fJnQ2f3gOa5uXlR2LpEgx6VA++mAR1qwnk0jNLxQIaqMmCKjpuI84eJL7NafRnD
 XxT+fvn+mo7gXp+UEUecXMoXKRAMvwQ9N4xwvwGpQyC/SJs0WoXUtDi9gALRFKzKYnQq
 Y01H1UF0RiJOxBiuUSj9w+PyyM6Zsk0Htyc/M6Z0ZkuqjiohQ48Yt4syLlsdu+V6tfqb
 m7oIRQ7CehOYcX6No6m8n1oQP8WMS0C7gy3dLGJOB1EwQhNF9eOPr6z2IaJFkIZwJf4i
 fLGGhI6AlF1JG7cIgeFFQOO2a9WhUF0vak2xm6jDjEKVi/vEAd8h2GIGxNWau0+rUbox
 QREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MP1pABxMzHpo8AMSOhxmhgtFnSUnUlB+dz2nSbkmVCQ=;
 b=b9XXlL/FQpFB0mXqRCcEuhePjGQYzk5WYD9xymaHvv8hFZQCdQwL8fCFmVOSLuo5qj
 D3Gj4Bycyde9R698BE651Y2vsYhzXRKna0UE52TDJ9rCvLDW17rtqu5c/xaa52PBTmbh
 ndVkwFEoe8re2T7iq/oLYt2ABFwU9ttq2vRN03PvSysG/EAO0x0FRh3tty+WfMA/IpNy
 9ps83S5KK1I0oZa0kd7EaOwEoKV3FGnEIOAu7b7KJqEtatp0VSALARmdH46TlN35+Hw6
 y8UoGU53SsVM3OIS4X3s7qHsI9jvOJaY9JNAfi4uuhLjd9NX6nGudcsAfAPYshwJUh3p
 96Cg==
X-Gm-Message-State: AO0yUKUvX2xLKHd+PTUIe7qhK/lEKIOAvJLIIhv3CRpWMNNUGIyijc0h
 WARWSLNWhPHZNISttSIR//E=
X-Google-Smtp-Source: AK7set+Q2a5jr0Nuelg2LNI7xaz7htgjSkqBaSR0VnulEScQizwo/0NwhpPrYspCF+rzIDzIb9ZI9w==
X-Received: by 2002:ac8:5cce:0:b0:3b8:2a6c:d1e9 with SMTP id
 s14-20020ac85cce000000b003b82a6cd1e9mr11314604qta.18.1677078862133; 
 Wed, 22 Feb 2023 07:14:22 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com.
 [34.150.157.240]) by smtp.gmail.com with ESMTPSA id
 x6-20020ac86b46000000b003b860983973sm4060867qts.60.2023.02.22.07.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Feb 2023 07:14:21 -0800 (PST)
Date: Wed, 22 Feb 2023 10:14:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <63f6314d678bc_2ab6208a@willemb.c.googlers.com.notmuch>
In-Reply-To: <Y/XLIs+4eg7xPyF0@nanopsycho>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
 <Y/TltJnD4k5hB6Z1@nanopsycho>
 <63f4ed716af37_d174a20880@willemb.c.googlers.com.notmuch>
 <Y/XLIs+4eg7xPyF0@nanopsycho>
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
> Tue, Feb 21, 2023 at 05:12:33PM CET, willemdebruijn.kernel@gmail.com wrote:
> >Jiri Pirko wrote:
> >> Tue, Feb 21, 2023 at 04:11:53PM CET, willemdebruijn.kernel@gmail.com wrote:
> >> >Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> >> >> set implicates that the driver provides the exact size of the header.
> >> >> 
> >> >> Quoting the original virtio spec:
> >> >> "hdr_len is a hint to the device as to how much of the header needs to
> >> >>  be kept to copy into each packet"
> >> >> 
> >> >> "a hint" might not be clear for the reader what does it mean, if it is
> >> >> "maybe like that" of "exactly like that". This feature just makes it
> >> >> crystal clear and let the device count on the hdr_len being filled up
> >> >> by the exact length of header.
> >> >> 
> >> >> Also note the spec already has following note about hdr_len:
> >> >> "Due to various bugs in implementations, this field is not useful
> >> >>  as a guarantee of the transport header size."
> >> >> 
> >> >> Without this feature the device needs to parse the header in core
> >> >> data path handling. Accurate information helps the device to eliminate
> >> >> such header parsing and directly use the hardware accelerators
> >> >> for GSO operation.
> >> >> 
> >> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> >> >> The driver already complies to fill the correct value. Introduce the
> >> >> feature and advertise it.
> >> >> 
> >> >> Note that virtio spec also includes following note for device
> >> >> implementation:
> >> >> "Caution should be taken by the implementation so as to prevent
> >> >>  a malicious driver from attacking the device by setting
> >> >>  an incorrect hdr_len."
> >> >> 
> >> >> There is a plan to support this feature in our emulated device.
> >> >> A device of SolidRun offers this feature bit. They claim this feature
> >> >> will save the device a few cycles for every GSO packet.
> >> >> 
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> ---
> >> >> v1->v2:
> >> >> - extended patch description
> >> >
> >> >Is the expectation that in-kernel devices support this feature, and
> >> >if so how would it affect them? If I read the spec correctly, devices
> >> 
> >> Well, the tap driver actually trusts the hdr_len to be of correct header
> >> size nowadays.
> >
> >tap_get_user performs basic bounds checking on the length passed.
> 
> Sure. It trusts the hdr_len, but it sanitizes the input.
>
> 
> > 
> >> 
> >> >still need to be careful against malicious drivers, so cannot assume
> >> >much beyond what they do today (i.e., a hint).
> >> 
> >> Malicious how? There is upper limit of size in tap which is checked.
> >> I assume that for hw implementation, that would be the same.
> >
> >A device cannot blindly trust a hdr_len passed from a driver. We have
> >had bugs in the kernel with this before, such as the one fixed in
> >commit 57031eb79490 ("packet: round up linear to header len").
> >
> >> But anyway, this discussion would be rather part of the spec/device
> >> patch, don't you think?
> >
> >I disagree. If it's not much effort to make a commit self-documenting
> >that is preferable. And if not, then an explicit reference to an
> >authoratitive external reference is preferable over "it is trivial to
> >look it up".
> 
> Sorry, I don't follow. What exactly do you want me to do?

Either including the link that Michael shared or quoting the relevant
part verbatim in the commit message would help, thanks.

Thinking it over, my main concern is that the prescriptive section in
the spec does not state what to do when the value is clearly garbage,
as we have seen with syzkaller.

Having to sanitize input, by dropping if < ETH_HLEN or > length, to
me means that the device cannot trust the field, as the spec says it
should. 

Sanitization is harder in the kernel, because it has to support all
kinds of link layers, including variable length.

Perhaps that's a discussion for the spec rather than this commit. But
it's a point to clarify as we add support to the code.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
