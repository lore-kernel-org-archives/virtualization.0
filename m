Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A1C636D7
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 15:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F5F282C8F;
	Tue, 21 Feb 2023 15:12:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F5F282C8F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EIqFiA7L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tXSOUjeOkPn; Tue, 21 Feb 2023 15:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C271D82865;
	Tue, 21 Feb 2023 15:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C271D82865
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A904C0032;
	Tue, 21 Feb 2023 15:12:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4585C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71A1D82865
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71A1D82865
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8LybTKbTOwdF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:11:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC16182C8F
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC16182C8F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 15:11:55 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id op8so5577041qvb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2n1LmxSFVVYvXpnEg2BE1jr0IuaC3UX1/QkFU5QwEM=;
 b=EIqFiA7L6BXoJnj850Mtn8tf837gOgf+zvcPPvv+CgAweUpF+UcQrMAgggNCXHRgko
 aEIx9RRnkYzIP7BiVcRjBtYPS+oiStK+0L+pXvJAbQZDhgFE70xKUUrelYZ5VV12orfH
 k2eMuSvwxCXvNqrfPTwqCrWHCkwqhlasA8TcSEgdwFk/7/mI3/L1cxlXpMaZIgCY0rre
 TsuRSfbCloQ2zdAyJvNCXik0B/leqfLzt/3Bs1rOqPnr2et75otd+VRqbcKiPCzRRsnO
 H6NXC87IH1F8YIN2XJlETb2cFizF/sfM5QLukgwBUErqj7JpwLPtNOs8L0Y+8PSaRnjS
 WNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/2n1LmxSFVVYvXpnEg2BE1jr0IuaC3UX1/QkFU5QwEM=;
 b=lbaZr/qDf05IqYMwaATpeJw3PacjAjFemMGdMzzmWqpT3UIvyruEj/0rZ4xKlObwy0
 nGPWry1ld+Xt/5alJgbPRQTxEoABoIEtiPjcP07WoV+sQjY0DQhWxJN4sEBnTV5ODBHV
 1q5rwvF/dvKCME25aObGc+GehynSWeUTAInOD7iLBUBqOZuYXFBblefJdmPvoIWlukct
 x83iwTOyx5HW75GqunJRAFFC8FUvSHbM220yqFfow1qXusZK/pQfOWeZjuosX4BOcv8y
 xhVDjLu3vRZ4xAyphN/6zLKDghCEj1dfH+ekaZe0okwzMNZKoLlNJtpO7i9qWsn/NYBO
 ugbA==
X-Gm-Message-State: AO0yUKXiwBSEohq2ppQhwuCSoMhJSGCKRJOHO8i8h0EcocEtBqZwh7kJ
 JQPMWUzdIHUCKFdWLYLJkic=
X-Google-Smtp-Source: AK7set+b3tlj/r1WK8l+9lyPeiloTyCYHtosJmTw1LHA8gIcH1MOa0EA9ydxO/T85OgRdJVq7soUXw==
X-Received: by 2002:ad4:5de5:0:b0:56e:fef4:7ff1 with SMTP id
 jn5-20020ad45de5000000b0056efef47ff1mr7154614qvb.21.1676992314541; 
 Tue, 21 Feb 2023 07:11:54 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com.
 [34.150.157.240]) by smtp.gmail.com with ESMTPSA id
 196-20020a3707cd000000b0073ba97eb13csm9038385qkh.50.2023.02.21.07.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 07:11:54 -0800 (PST)
Date: Tue, 21 Feb 2023 10:11:53 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 netdev@vger.kernel.org
Message-ID: <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230221144741.316477-1-jiri@resnulli.us>
References: <20230221144741.316477-1-jiri@resnulli.us>
Subject: RE: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Mime-Version: 1.0
Cc: mst@redhat.com, vmireyno@marvell.com,
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
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> set implicates that the driver provides the exact size of the header.
> 
> Quoting the original virtio spec:
> "hdr_len is a hint to the device as to how much of the header needs to
>  be kept to copy into each packet"
> 
> "a hint" might not be clear for the reader what does it mean, if it is
> "maybe like that" of "exactly like that". This feature just makes it
> crystal clear and let the device count on the hdr_len being filled up
> by the exact length of header.
> 
> Also note the spec already has following note about hdr_len:
> "Due to various bugs in implementations, this field is not useful
>  as a guarantee of the transport header size."
> 
> Without this feature the device needs to parse the header in core
> data path handling. Accurate information helps the device to eliminate
> such header parsing and directly use the hardware accelerators
> for GSO operation.
> 
> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> The driver already complies to fill the correct value. Introduce the
> feature and advertise it.
> 
> Note that virtio spec also includes following note for device
> implementation:
> "Caution should be taken by the implementation so as to prevent
>  a malicious driver from attacking the device by setting
>  an incorrect hdr_len."
> 
> There is a plan to support this feature in our emulated device.
> A device of SolidRun offers this feature bit. They claim this feature
> will save the device a few cycles for every GSO packet.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - extended patch description

Is the expectation that in-kernel devices support this feature, and
if so how would it affect them? If I read the spec correctly, devices
still need to be careful against malicious drivers, so cannot assume
much beyond what they do today (i.e., a hint).

Might be good to point to the definition commit:
https://github.com/oasis-tcs/virtio-spec/commit/4f1981a1ff46b7aeb801c4c524ff76e93d9ce022
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
