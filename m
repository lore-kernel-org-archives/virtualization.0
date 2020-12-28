Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0CBC433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:48:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C514D2053B
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C514D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7642B86256;
	Mon, 28 Dec 2020 16:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKvHRsEwa66D; Mon, 28 Dec 2020 16:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BD378623E;
	Mon, 28 Dec 2020 16:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE103C1787;
	Mon, 28 Dec 2020 16:48:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAE22C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DF88086256
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yagK9rAN22TH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6125D8623E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:48:25 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id p7so5793967vsf.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=28E+iqzR/ZCpLV3rPjkQtUHGp1Pkn7UdNGwCfj37Ps8=;
 b=AltQHM8uT5Ta+3j7glS4xruGSVQWC59IBA9Pzn4+0b/3LymXjR6o4mNntV3BbdSBg7
 cGuqVQzDGnInYl3su80I/WfgnqsJScITEk18eOlsJmyYdDK1s/bs4DgZVG+G2+G12/+h
 EJ/J/kW4iudP6u2QwqNzfh8Fs8D9iALuF682uxIcFAZnVPS6eUosV4h137mK66XOXyMj
 4vEjbahnfwibIhtyE6OP7ATkYMz7b7LRyjh/mYEMyZ8g6/F1VzhxJmu3Zpd9OPwrq1Y9
 CZHv3r8v9iFGT4fyDBIGtJHi7WQDzhqiRNvUWRIrl/c4WYkO+pHbJM7WxYt6zZpK4XyD
 EASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=28E+iqzR/ZCpLV3rPjkQtUHGp1Pkn7UdNGwCfj37Ps8=;
 b=CVJFS8yuxWLhLNwC12dO+8SUeEbTunWTiAAZZMdTzJpxZwCD/aMAzPz+p6qEySP9vM
 fDQQSkCQY/lH0tk2mdwXnZ5sqz5mRy2tF93d5pEMYe/u62ft/bIldn2nMDw/Z1USw7jD
 SkectCARTyQSWBvVVD1j9DKUwKhJxZwnfpqD6IAlTk7huKqmGx2qH3TKusqJYDyVDCYy
 DSGALvx97CAU2cnqOwH0f4YlhJ8h3TZylYbFXX8OlXBEz+jSQa0YF7VYVK2WxCVa831K
 fZz99q8v1n5mjKheoUKFNTGXSym8ejjEjpSYerkBMV+/vCiYAnCnJBaM/LAQN5b3DM7v
 bLEQ==
X-Gm-Message-State: AOAM531rOe6OUjzbMxuRPMWedvmtCPBwo4ciYsSwcveI2CeSmpmnJH7c
 1mY5YGY9rHXbkzOtMWFf7347Bo1v8DM=
X-Google-Smtp-Source: ABdhPJyZ72VmT6TzZkv+ZrYoiJoeVdAQxyi5cjEAydoCsLBLb4+SJPKAh4Pw9QcTaevLzPn9hmeBMw==
X-Received: by 2002:a67:d898:: with SMTP id f24mr28222218vsj.19.1609174103719; 
 Mon, 28 Dec 2020 08:48:23 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51])
 by smtp.gmail.com with ESMTPSA id e3sm5366576vkh.11.2020.12.28.08.48.22
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 08:48:23 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id j140so5814122vsd.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:48:22 -0800 (PST)
X-Received: by 2002:a67:bd0a:: with SMTP id y10mr27448729vsq.28.1609174102391; 
 Mon, 28 Dec 2020 08:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-2-willemdebruijn.kernel@gmail.com>
 <20201228112657-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201228112657-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Dec 2020 11:47:45 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdYLxV2O2WiD3D0cy2vaVbiECWheW0j7OGKKgV84wkScA@mail.gmail.com>
Message-ID: <CA+FuTSdYLxV2O2WiD3D0cy2vaVbiECWheW0j7OGKKgV84wkScA@mail.gmail.com>
Subject: Re: [PATCH rfc 1/3] virtio-net: support transmit hash report
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 28, 2020 at 11:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 28, 2020 at 11:22:31AM -0500, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Virtio-net supports sharing the flow hash from host to guest on rx.
> > Do the same on transmit, to allow the host to infer connection state
> > for more robust routing and telemetry.
> >
> > Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
> > and updates these fields on error with sk_rethink_txhash. This feature
> > allows the host to make similar decisions.
> >
> > Besides the raw hash, optionally also convey connection state for
> > this hash. Specifically, the hash rotates on transmit timeout. To
> > avoid having to keep a stateful table in the host to detect flow
> > changes, explicitly notify when a hash changed due to timeout.
>
> I don't actually see code using VIRTIO_NET_HASH_STATE_TIMEOUT_BIT
> in this series. Want to split out that part to a separate patch?

Will do.

I wanted to make it clear that these bits must be reserved (i.e.,
zero) until a later patch specifies them.

The timeout notification feature requires additional plumbing between
the TCP protocol stack and device driver, probably an skb bit. I'd
like to leave that as follow-up for now.

Thanks for the fast feedback!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
