Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90968C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 13:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12CE741D5B;
	Fri, 27 Jan 2023 13:52:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12CE741D5B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bicu/tFl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oo9iMRmJJ_uz; Fri, 27 Jan 2023 13:52:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4808B41D51;
	Fri, 27 Jan 2023 13:52:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4808B41D51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 244CCC0033;
	Fri, 27 Jan 2023 13:52:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8DE2C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4D7341D59
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:52:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4D7341D59
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RfU67biGakuf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:52:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C699641D51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C699641D51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674827538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7PwQQfaQAAI4cWcMcSVvB/9kkzepsIAiNqYaNg7Vqg=;
 b=Bicu/tFl0PtlK5OTJuX7LIHSyGAAcNJXDlLyGYYGHpN1rKaTfR12/9o0HNmKV4giPqrVpC
 fHHSL5ytvK33RDdsCHy1Vk9qBh1dFqLgn3gh4cZmswA5Ju/frkowqorDWA7TpQAmzsiYgt
 2UBx3emKB6O+O1sIRy6xmccN8pZhbNg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-ONxUkLH2OvSeXuM5xDd3FQ-1; Fri, 27 Jan 2023 08:52:16 -0500
X-MC-Unique: ONxUkLH2OvSeXuM5xDd3FQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 m12-20020a056402430c00b0049e4ac58509so3622397edc.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 05:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7PwQQfaQAAI4cWcMcSVvB/9kkzepsIAiNqYaNg7Vqg=;
 b=50VqqAeuw0c9FbiwxSeSLDcOaMIlM7yQ4Tc/M1ipezxVjRLiLOAhK2lIFl2RAqHpQ8
 B9Yl3U1DVmrXiTtGPxcDm9CPPs6ezkpmKm0n3sg6/kHNU+IcS+BKIz35vhXhFVJAs7tf
 3+iqZtt9By5eVDsBrhugZRIYU7sVG225HuvLjY5wZdQipsk0G2pY/bVLuSnP742814D8
 RvHNrM0Gz89LzYpks9S0Wdx3DS77CNkx/n/B0BE3NfXIxx2bOYiRG6VoPbiwuzjcTxCU
 F6LNCG1NDQ6UKD8JoaDBDM8GG0DFKZ2VVebD4o1z1F33l08wL3NfO3mdhRh8ft3dsmtW
 Nqbg==
X-Gm-Message-State: AFqh2koUaJeU3dpFfFDxUfQZNyW+xMIxX/GuAVuP6785wWn1F3q+aP2g
 4H63rFz0wI2atSreISZQpq8vBaaz2mFGtzquA6AhGrUuU0ype/msDyzLI1bLQEozannK+gXJsJr
 34aN5GppZzFbuhhiv+PzzS4mft+OpNosAHbDIRognlQ==
X-Received: by 2002:a17:906:9f1c:b0:870:3c70:8c8d with SMTP id
 fy28-20020a1709069f1c00b008703c708c8dmr35780280ejc.17.1674827535254; 
 Fri, 27 Jan 2023 05:52:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv6Rvl5hVCAcmib+Ajlnf9hxYLH9FQSlnb3lj94uj3kByJbvLhBcQF3Wx5PXW8TJDK2Yh5ogw==
X-Received: by 2002:a17:906:9f1c:b0:870:3c70:8c8d with SMTP id
 fy28-20020a1709069f1c00b008703c708c8dmr35780264ejc.17.1674827535048; 
 Fri, 27 Jan 2023 05:52:15 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 sb25-20020a1709076d9900b0086faa5b06d4sm2262152ejc.181.2023.01.27.05.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 05:52:14 -0800 (PST)
Date: Fri, 27 Jan 2023 08:52:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127085006-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <87edrgp2is.fsf@ubik.fi.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elena.reshetova@intel.com, kirill.shutemov@linux.intel.com
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

On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> >> >> When handling control messages, instead of peeking at the device memory
> >> >> to obtain bits of the control structure,
> >> >
> >> > Except the message makes it seem that we are getting data from
> >> > device memory, when we do nothing of the kind.
> >> 
> >> We can be, see below.
> >> 
> >> >> take a snapshot of it once and
> >> >> use it instead, to prevent it from changing under us. This avoids races
> >> >> between port id validation and control event decoding, which can lead
> >> >> to, for example, a NULL dereference in port removal of a nonexistent
> >> >> port.
> >> >> 
> >> >> The control structure is small enough (8 bytes) that it can be cached
> >> >> directly on the stack.
> >> >
> >> > I still have no real idea why we want a copy here.
> >> > If device can poke anywhere at memory then it can crash kernel anyway.
> >> > If there's a bounce buffer or an iommu or some other protection
> >> > in place, then this memory can no longer change by the time
> >> > we look at it.
> >> 
> >> We can have shared pages between the host and guest without bounce
> >> buffers in between, so they can be both looking directly at the same
> >> page.
> >> 
> >> Regards,
> >
> > How does this configuration work? What else is in this page?
> 
> So, for example in TDX, you have certain pages as "shared", as in
> between guest and hypervisor. You can have virtio ring(s) in such
> pages.

That one's marked as dma coherent.

> It's likely that there'd be a swiotlb buffer there instead, but
> sharing pages between host virtio and guest virtio drivers is possible.

It's not something console does though, does it?

> Apologies if the language is confusing, I hope I'm answering the
> question.
> 
> Regards,
> --
> Alex

I'd like an answer to when does the console driver share the buffer
in question, not when generally some pages shared.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
