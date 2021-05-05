Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A35C433ED
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 10:34:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3A7613C0
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 10:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3A7613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55BF5402DF;
	Wed,  5 May 2021 10:34:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r_IZw9pDjIRu; Wed,  5 May 2021 10:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A15E64051E;
	Wed,  5 May 2021 10:34:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82472C000D;
	Wed,  5 May 2021 10:34:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04D5EC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DACD683D91
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kFmkYpZGw-Ks
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDDB083D84
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620210891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LAdibQNHcesWzNPH9BqbDTreBpIcgTRR/VqFx1/qiSU=;
 b=V/37cwj12x4IoczDIATXShwTw2pSA07o896ADDnCstfjIOUhuzb7BCYTAGhn6UvAJIY4o+
 eHCzAglvES5Hc0t174nWsuZu+i8MEGmKTJM+LG0JvR7KtuzbQerf4Ug/7t3g1h97I9slDC
 f/srHin59/C2zTn+wv5moHFyrbz0vNE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Oe4GX_ukM_uSH2sspwN_FQ-1; Wed, 05 May 2021 06:34:48 -0400
X-MC-Unique: Oe4GX_ukM_uSH2sspwN_FQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 p19-20020adfc3930000b029010e10128a04so527648wrf.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 03:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LAdibQNHcesWzNPH9BqbDTreBpIcgTRR/VqFx1/qiSU=;
 b=AX6Lut7Ry202ufm7ekGruW/MzpLh6T462UbRmy1UGIPcYWQHiLtv3hPfVMTVvAzvBZ
 7xxc23ej3ICuGSXSLztigLyFmHn6KFMA3CV+1whmc9hlESZbLPQJqOrbFmEdnBZroV6r
 i1cagJk63BmIKvlCyVybw93d+dUv6K3yTMq6rNaSyMc83Y/PS/U57fwsg8WeU6dyK9Ep
 cHZahf9WAEgA69InwWELo92Ehd6z2GV88XjyMBqW1W8WoK2R7ynvP8eMHeB6ggssuhs4
 UI6gcxwxlkj4jder6VAEV/QxpRlwm8th9eaIonNc9NDsc5wBFFNAGUIlMpm4+uXz3KNe
 edFw==
X-Gm-Message-State: AOAM530Y2aDBeOF4v2/JH/yuSadK+tyNT3MhbGu2c2nzfEDydOjdZNFQ
 1ieY7J3SIkSL1FkYcl6RRFGBHy9DTD1XZBzCX8TfP2xGTUFyfrK6bnD3WQN/8e1bqLPmPmsmDoR
 Wp04UPMO730xN0LiGsMRcDHRbQENv2ck8pBJqo35CWA==
X-Received: by 2002:adf:9cc1:: with SMTP id h1mr36481143wre.135.1620210887480; 
 Wed, 05 May 2021 03:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdim0c3dVv47Vb8Rdgntrsc4jzgK7i6ZC4zc7EC8pfwqP4u0d9A/2di4UCuugF1EfbSZUAcg==
X-Received: by 2002:adf:9cc1:: with SMTP id h1mr36481124wre.135.1620210887284; 
 Wed, 05 May 2021 03:34:47 -0700 (PDT)
Received: from redhat.com (bzq-79-181-137-172.red.bezeqint.net.
 [79.181.137.172])
 by smtp.gmail.com with ESMTPSA id g25sm5422740wmk.43.2021.05.05.03.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 03:34:46 -0700 (PDT)
Date: Wed, 5 May 2021 06:34:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Enrico Granata <egranata@google.com>
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210505062458-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
 <20210502045740-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210502045740-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: hch@infradead.org, virtio-dev@lists.oasis-open.org,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, May 02, 2021 at 05:12:14AM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > In the course of review, some concerns were surfaced about the
> > original virtio-blk lifetime proposal, as it depends on the eMMC
> > spec which is not open
> > 
> > Add a more detailed description of the meaning of the fields
> > added by that proposal to the virtio-blk specification, as to
> > make it feasible to understand and implement the new lifetime
> > metrics feature without needing to refer to JEDEC's specification
> > 
> > This patch does not change the meaning of those fields nor add
> > any new fields, but it is intended to provide an open and more
> > clear description of the meaning associated with those fields.
> > 
> > Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Enrico it's great that you are reaching out to the
> wider storage community before making spec changes.
> 
> Christoph could you please comment on whether this addresses
> your concerns with the lifetime feature.
> You wrote "it really needs to stand a lone and be properly documented"
> and this seems to be the direction this patch is going in.
> 
> 
> > ---
> >  content.tex | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index 9232d5c..7e14ccc 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4669,13 +4669,32 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> >  \end{lstlisting}
> >  
> >  The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
> > -and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
> > -specification for the extended CSD register fields \field{PRE_EOL_INFO}
> > -\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
> > -respectively.
> > +and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
> >  
> > -JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> > -pursuant to JEDEC's licensing terms and conditions.
> > +The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> > +pursuant to JEDEC's licensing terms and conditions.
> 
> These links really belong in either normative or non-normative
> references section.
> 
> > For the purposes of this
> > +specification, these fields are defined as follows.
> 
> All this seems kind of vague. What does one need that spec for?
> Is it just a note for pass-through developers?
> 
> How about "to simplify pass-through
> from eMMC devices the format of fields 
>   pre_eol_info, device_lifetime_est_typ_a and device_lifetime_est_typ_b
> matches PRE_EOL_INFO, DEVICE_LIFETIME_EST_TYP_A and DEVICE_LIFETIME_EST_TYP_B
> in the 
> \hyperref[intro:PCI]{[PCI]}.
> 
> 
> 
> Also, now that I mention it, what about NVMe pass-through? Arguably
> nvme is getting more popular. Will we be able to support that use-case
> as well? Or is more data needed? What is the plan there?
> 
> > +
> > +The \field{pre_eol_info} will have one of these values:

Besides specifying the values what does it mean exactly?
E.g. what are blocks?

E.g. "pre_eol_info specifies the percentage of blocks consumed
on the device" and explain what blocks are here.

> > +
> > +\begin{lstlisting}
> > +// Value not available
> > +#define PRE_EOL_INFO_UNDEFINED    0
> > +// < 80% of blocks are consumed
> > +#define PRE_EOL_INFO_NORMAL       1
> > +// 80% of blocks are consumed
> > +#define PRE_EOL_INFO_WARNING      2
> > +// 90% of blocks are consumed
> > +#define PRE_EOL_INFO_URGENT       3
> > +// All others values are reserved


Also please prefix with VIRTIO_BLK_ for consistency.

> 
> 
> Block comments /* */ should be used as these are documented
> in the introduction.
> 
> > +\end{lstlisting}
> > +
> > +The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided in
> > +increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime used, and so on,
> > +thru to 11 meaning estimated lifetime exceeded. All values above 11 are reserved.
> > +
> > +The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided with
> > +the same semantics as \field{device_lifetime_est_typ_a}.
> >  
> >  The final \field{status} byte is written by the device: either
> >  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> > @@ -4812,7 +4831,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> >  or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
> >  flag. The flag MUST NOT be offered if the device is backed by storage for which
> >  the lifetime metrics described in this document cannot be obtained or for which
> > -such metrics have no useful meaning.
> > +such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
> > +send any reserved values, as defined in this specification.
> >  
> >  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
> >  When using the legacy interface, transitional devices and drivers
> > -- 
> > 2.31.1.368.gbe11c130af-goog
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
