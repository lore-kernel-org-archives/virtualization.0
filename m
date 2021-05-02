Return-Path: <SRS0=xhqI=J5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E906C433ED
	for <virtualization@archiver.kernel.org>; Sun,  2 May 2021 09:12:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1765613E1
	for <virtualization@archiver.kernel.org>; Sun,  2 May 2021 09:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1765613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57A48606E1;
	Sun,  2 May 2021 09:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TO9I718uh5zD; Sun,  2 May 2021 09:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DADA660730;
	Sun,  2 May 2021 09:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB13C000D;
	Sun,  2 May 2021 09:12:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE1CC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 May 2021 09:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06BDB851F6
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 May 2021 09:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DIQ8h7zAPysu
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 May 2021 09:12:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDF3B851F5
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 May 2021 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619946739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hWwZGLdaGBnu7du6ieoJeVqv8Y1BBlHwek4tKB9bhs8=;
 b=BTwAlQG19342wNMTMtx+8xoXmXg0aQpx1ea7Ehe7w3bsAdlP1cEgUPBB3sY/ILO8ijQZIJ
 VPExpaGllr5ByUzsTOJDlIH/8P1UlBvCG9E6VGAr0Crjn0y2Bh/ULDfMNmztw8obXP4mwJ
 3KBf3+6WWJ2gaDGhheaOn4AoxG8OkpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-cuvaEKHeP8m8IZV6karfQg-1; Sun, 02 May 2021 05:12:16 -0400
X-MC-Unique: cuvaEKHeP8m8IZV6karfQg-1
Received: by mail-wr1-f70.google.com with SMTP id
 h104-20020adf90710000b029010de8455a3aso82789wrh.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 May 2021 02:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hWwZGLdaGBnu7du6ieoJeVqv8Y1BBlHwek4tKB9bhs8=;
 b=h0QpEf13JEn8m3L999P1IXspIq9/MSj4ItgdKwJ9JyMRAkOm4cPfhSo3Nry/XYSeCK
 9EeiBUkdXpqHtHKDJ8fPFDWsUNNuxxJr/5pHfZyBWvu0ax4yqpZrRrnovZR7y7/B08Xo
 JeCyvVIh0NoZQ4kbTBeJp3l8Yt4fWwDr6Lsc+65+/+TDYTEi+ak0O3cSdvOuZXkcf1QN
 i1n/9XlQATaWPR1b8Qp4QteEIT5NPvMg1XZ7sZo4ssyH9LLEa4GsAu45Y2iJpWkv/BPT
 T72MQk7RfRPQHQncNbXudG011C7QUsnfru+URxqXgPUOFlN7Gsq7ihqpD3AoZD2hYNoT
 iq7w==
X-Gm-Message-State: AOAM531L8S1J9U0diHubc3oMLmP+afs9JrPVnVCkxg0YC0JA2b4d1OqN
 PfCFSrnCBIItmEknwO1SNDeo4XZrF/2Ws/utxvhEeOlo/IzRDiM8D1rZj55684WQRzmlq9QTnFF
 hr9awZ2B+A+tljHCO9c3tbjmndz8CeuheQhYewOtpag==
X-Received: by 2002:adf:f74a:: with SMTP id z10mr18563142wrp.406.1619946734932; 
 Sun, 02 May 2021 02:12:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVkZyL+2vuum44t8EKk144CbaOWB5l4YsegxZG7LMzEdFXY0YjhqUpAVXGDPDXJvmcu0qF2g==
X-Received: by 2002:adf:f74a:: with SMTP id z10mr18563129wrp.406.1619946734759; 
 Sun, 02 May 2021 02:12:14 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id n10sm8324376wrw.37.2021.05.02.02.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 02:12:14 -0700 (PDT)
Date: Sun, 2 May 2021 05:12:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Enrico Granata <egranata@google.com>
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210502045740-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
MIME-Version: 1.0
In-Reply-To: <20210420162556.217350-1-egranata@google.com>
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

On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> In the course of review, some concerns were surfaced about the
> original virtio-blk lifetime proposal, as it depends on the eMMC
> spec which is not open
> 
> Add a more detailed description of the meaning of the fields
> added by that proposal to the virtio-blk specification, as to
> make it feasible to understand and implement the new lifetime
> metrics feature without needing to refer to JEDEC's specification
> 
> This patch does not change the meaning of those fields nor add
> any new fields, but it is intended to provide an open and more
> clear description of the meaning associated with those fields.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

Enrico it's great that you are reaching out to the
wider storage community before making spec changes.

Christoph could you please comment on whether this addresses
your concerns with the lifetime feature.
You wrote "it really needs to stand a lone and be properly documented"
and this seems to be the direction this patch is going in.


> ---
>  content.tex | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 9232d5c..7e14ccc 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4669,13 +4669,32 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  \end{lstlisting}
>  
>  The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
> -and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
> -specification for the extended CSD register fields \field{PRE_EOL_INFO}
> -\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
> -respectively.
> +and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
>  
> -JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> -pursuant to JEDEC's licensing terms and conditions.
> +The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> +pursuant to JEDEC's licensing terms and conditions.

These links really belong in either normative or non-normative
references section.

> For the purposes of this
> +specification, these fields are defined as follows.

All this seems kind of vague. What does one need that spec for?
Is it just a note for pass-through developers?

How about "to simplify pass-through
from eMMC devices the format of fields 
  pre_eol_info, device_lifetime_est_typ_a and device_lifetime_est_typ_b
matches PRE_EOL_INFO, DEVICE_LIFETIME_EST_TYP_A and DEVICE_LIFETIME_EST_TYP_B
in the 
\hyperref[intro:PCI]{[PCI]}.



Also, now that I mention it, what about NVMe pass-through? Arguably
nvme is getting more popular. Will we be able to support that use-case
as well? Or is more data needed? What is the plan there?

> +
> +The \field{pre_eol_info} will have one of these values:
> +
> +\begin{lstlisting}
> +// Value not available
> +#define PRE_EOL_INFO_UNDEFINED    0
> +// < 80% of blocks are consumed
> +#define PRE_EOL_INFO_NORMAL       1
> +// 80% of blocks are consumed
> +#define PRE_EOL_INFO_WARNING      2
> +// 90% of blocks are consumed
> +#define PRE_EOL_INFO_URGENT       3
> +// All others values are reserved


Block comments /* */ should be used as these are documented
in the introduction.

> +\end{lstlisting}
> +
> +The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided in
> +increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime used, and so on,
> +thru to 11 meaning estimated lifetime exceeded. All values above 11 are reserved.
> +
> +The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided with
> +the same semantics as \field{device_lifetime_est_typ_a}.
>  
>  The final \field{status} byte is written by the device: either
>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> @@ -4812,7 +4831,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
>  flag. The flag MUST NOT be offered if the device is backed by storage for which
>  the lifetime metrics described in this document cannot be obtained or for which
> -such metrics have no useful meaning.
> +such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
> +send any reserved values, as defined in this specification.
>  
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.31.1.368.gbe11c130af-goog
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
