Return-Path: <SRS0=Ae13=GB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E0DC433DB
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 01:20:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A15216C4
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 01:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A15216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 828B61FEDF;
	Tue, 29 Dec 2020 01:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zad+RTgznSuR; Tue, 29 Dec 2020 01:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 42F142010D;
	Tue, 29 Dec 2020 01:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23BF9C1D9C;
	Tue, 29 Dec 2020 01:20:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8309C0174
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DBE4A86DF5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1V-YDEsCkxfA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:20:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3AA0286DFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:20:38 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id 17so3894461uaq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FwLto/ZBV2G6H0YpMzAWzKM7ccpLka7+kI4pzhpyY60=;
 b=dIfi5/b5mryN/OQ7oVFTqmUS9y1O0luF9cN505GMc28VviwUetdzp9Fm7cxIANVBCg
 yTNZYi6hARw9n+u9UxSa6R62Ibs+/1CeBt4b2dSXn5XY9zOjpT4h8w8+OZde8hkgvh2u
 j6vUOwJPa6HOpWoumLawwzRHfSEMTJh01gFrhZGljmLDYKbtkiQwG7j8opiAugTOTlhM
 x6poKkAy5Cwi/+NGygWwYJ9EUAHF+gq8uHz9y4oEFuXIh1RfcEIKn5DJJGspyl153hQr
 tJVzYhi+tZ8st9PG97u7igwpGW4eRO/ExmiHn+v/SfxqcVydY/Qt+jzm+eEv50hs0FnF
 gKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FwLto/ZBV2G6H0YpMzAWzKM7ccpLka7+kI4pzhpyY60=;
 b=rZg0QcIjqw69NCe0SbxpdH9D9yfOXCUv3nB8cCbpcQOUozjlFvqrxHocJHln8Q0d4X
 F/Wp/JP18VlISRM7Y5RXrKHxF/8XGFUvmCJ+NdPNzJtOfaN+XMmji1nguhtcnDMsk1Hd
 OD6jEbrXmW/YXLUfWtcowHmoSMP65egrdOS3IocuS9BfqfFrsOHulZFDF2UaRY+MJbg+
 IO42sUgc65j+QQkpwtuzusgtiDuXv+NmU53JmBKz1g8Y6/OQZky7Kfm9WbXoZlFM8Sye
 7mQGWn6PBvhAm2+zDTPR8rCvYXflEgufbk7aRWLZzHBXnnhdcGBDvYQK5ba2jcC55ltD
 h/kg==
X-Gm-Message-State: AOAM533zwwggJkGfizhxfuWIf3owl0aGoyhvMR1gupacgh0WA0nyPf/C
 umeA8tU9LcTGyRKo4JwUmNj5/e0EDIY=
X-Google-Smtp-Source: ABdhPJwIRz/nLFuT0O/LJHpdHDcokhoeqIa82/m5x4pM3bhwzy74odfAmXhWEhX2zIke3/Zteq6PmQ==
X-Received: by 2002:ab0:e14:: with SMTP id g20mr22411467uak.112.1609204836689; 
 Mon, 28 Dec 2020 17:20:36 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47])
 by smtp.gmail.com with ESMTPSA id m186sm5243635vkm.15.2020.12.28.17.20.35
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 17:20:36 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id h6so6386772vsr.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:20:35 -0800 (PST)
X-Received: by 2002:a67:3201:: with SMTP id y1mr29614104vsy.22.1609204835326; 
 Mon, 28 Dec 2020 17:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-2-willemdebruijn.kernel@gmail.com>
 <20201228112657-mutt-send-email-mst@kernel.org>
 <CA+FuTSdYLxV2O2WiD3D0cy2vaVbiECWheW0j7OGKKgV84wkScA@mail.gmail.com>
 <20201228122155-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201228122155-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Dec 2020 20:19:58 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdDAS9sxLX5j31YzA54UPx0Gu+knHqnnJP+btR2PwAYxg@mail.gmail.com>
Message-ID: <CA+FuTSdDAS9sxLX5j31YzA54UPx0Gu+knHqnnJP+btR2PwAYxg@mail.gmail.com>
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

On Mon, Dec 28, 2020 at 12:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 28, 2020 at 11:47:45AM -0500, Willem de Bruijn wrote:
> > On Mon, Dec 28, 2020 at 11:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 11:22:31AM -0500, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > Virtio-net supports sharing the flow hash from host to guest on rx.
> > > > Do the same on transmit, to allow the host to infer connection state
> > > > for more robust routing and telemetry.
> > > >
> > > > Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
> > > > and updates these fields on error with sk_rethink_txhash. This feature
> > > > allows the host to make similar decisions.
> > > >
> > > > Besides the raw hash, optionally also convey connection state for
> > > > this hash. Specifically, the hash rotates on transmit timeout. To
> > > > avoid having to keep a stateful table in the host to detect flow
> > > > changes, explicitly notify when a hash changed due to timeout.
> > >
> > > I don't actually see code using VIRTIO_NET_HASH_STATE_TIMEOUT_BIT
> > > in this series. Want to split out that part to a separate patch?
> >
> > Will do.
> >
> > I wanted to make it clear that these bits must be reserved (i.e.,
> > zero) until a later patch specifies them.
>
> Already the case for the padding field I think ...

Good. Is this something that the device should enforce? Meaning, drop
requests with reserved bits set.

Once a bit is defined and device updated to accept it, it cannot
distinguish between a new driver aware of the bit and an old one that
wrote to padding. More problematic, a well behaved new driver will
gets packets dropped by an old device.

The proper way is to negotiate this is through features, of course.
But I don't think we want to add one for each new bit. That's why I
squished the bit definition in here, even in absence of an
implementation.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
