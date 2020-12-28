Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1968C433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 21:38:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC7B21534
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 21:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC7B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C81C72033D;
	Mon, 28 Dec 2020 21:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMUi24aFw3M6; Mon, 28 Dec 2020 21:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D600023039;
	Mon, 28 Dec 2020 21:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADCF3C0893;
	Mon, 28 Dec 2020 21:38:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 363A8C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1C4F023042
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JLnv8atP9nJx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8CA0323039
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609191521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+h6xBZQ8ndgC3VNMVrPXo1dbdTCDoH6RKRNge8RjHo=;
 b=TIrPVDneZC+rU7QQvDN7BKfs7ibT8KM+2VlTNkiPy0SuPYMjG770FEV9AURoPHhLkODTlR
 OB64lh5ptC8NpDr0+US6Ua6pKzgqI84CVhdaFcA5gO5sPK+p1QfJG4TUjYQURDa2wL6e7A
 W2r1/r8oWfAlN9BAO5H2oq2iMHMaDJU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-pMWO5nCLP8Gax2ExqbVOYg-1; Mon, 28 Dec 2020 16:38:38 -0500
X-MC-Unique: pMWO5nCLP8Gax2ExqbVOYg-1
Received: by mail-wr1-f71.google.com with SMTP id r11so6759184wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 13:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X+h6xBZQ8ndgC3VNMVrPXo1dbdTCDoH6RKRNge8RjHo=;
 b=aoUeVX901ZsaCEPuxhYaJSFUtNfMKYpQZubOig3tJpelU/Nz/nuMQniL7WO3VQi/1E
 TaRl/uHPdGoDZXaibsdIZ0OxcgFp86HjncB5+CuRo8SpSzJFvEZjbDVkwPpwSnHT4MF1
 VoUvIZ10RW6pTAGU0VOzuoCwB+tdn7qMhp95j6/co8rIdkIaoNijoVkYd1XRa4P0fRN1
 rYnOXQRujCS1SZknhmXPbHQvA1/zRgWjigupwYdt45/JlmNrRhi5WDTuGZx86tSSUWLd
 yyztcdSM/ROkx34r5Bf16GGsR3sAkm+eglDbvWR03mWcK+iVutSI/1SpoVW1eS05CllO
 5boQ==
X-Gm-Message-State: AOAM5304EVh2OE3lenJ4WCkbbx0l4ATHTxgKkB/alnWASpRI/X0W5Dh6
 SMz+fEpmPNIeFDBSnLcaQEXVWhgnT78J89ixS5p/EZPPdWNl+sQwoyBpmigXzEb6zaS30imjggG
 EMIPfj85XafVXI2lEF+JF2E/ezOvpDHRwiqmZXqJJ6w==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr712219wml.78.1609191517158; 
 Mon, 28 Dec 2020 13:38:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLvHKsMhRWVlc2v2JHTTq6/C+o0cYwmf6h/6sEiwqjtzKc8WKyVPgo5VIW58g/+CS4LJb6Ng==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr712211wml.78.1609191516992; 
 Mon, 28 Dec 2020 13:38:36 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id c20sm707561wmb.38.2020.12.28.13.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 13:38:36 -0800 (PST)
Date: Mon, 28 Dec 2020 16:38:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 0/3] virtio-net: add tx-hash, rx-tstamp and tx-tstamp
Message-ID: <20201228163809-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228122911-mutt-send-email-mst@kernel.org>
 <CA+FuTScXQ0U1+rFFpKxB1Qn73pG8jmFuujONov_9yEEKyyer_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTScXQ0U1+rFFpKxB1Qn73pG8jmFuujONov_9yEEKyyer_g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
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

On Mon, Dec 28, 2020 at 02:51:09PM -0500, Willem de Bruijn wrote:
> On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 28, 2020 at 11:22:30AM -0500, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > RFC for three new features to the virtio network device:
> > >
> > > 1. pass tx flow hash and state to host, for routing + telemetry
> > > 2. pass rx tstamp to guest, for better RTT estimation
> > > 3. pass tx tstamp to host, for accurate pacing
> > >
> > > All three would introduce an extension to the virtio spec.
> > > I assume this would require opening three ballots against v1.2 at
> > > https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> > >
> > > This RFC is to informally discuss the proposals first.
> > >
> > > The patchset is against v5.10. Evaluation additionally requires
> > > changes to qemu and at least one back-end. I implemented preliminary
> > > support in Linux vhost-net. Both patches available through github at
> > >
> > > https://github.com/wdebruij/linux/tree/virtio-net-txhash-1
> > > https://github.com/wdebruij/qemu/tree/virtio-net-txhash-1
> >
> > Any data on what the benefits are?
> 
> For the general method, yes. For this specific implementation, not  yet.
> 
> Swift congestion control is delay based. It won the best paper award
> at SIGCOMM this year. That paper has a lot of data:
> https://dl.acm.org/doi/pdf/10.1145/3387514.3406591 . Section 3.1 talks
> about the different components that contribute to delay and how to
> isolate them.

And for the hashing part?

> BBR and BBRv2 also have an explicit ProbeRTT phase as part of the design.
> 
> The specific additional benefits for VM-based TCP depends on many
> conditions, e.g., whether a vCPU is exclusively owned and pinned. But
> the same reasoning should be even more applicable to this even longer
> stack, especially in the worst case conditions.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
