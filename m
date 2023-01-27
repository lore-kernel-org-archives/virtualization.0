Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E8DC54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 12:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C7D8417DC;
	Fri, 27 Jan 2023 12:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C7D8417DC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcOdV1gV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQfVExE5By68; Fri, 27 Jan 2023 12:13:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DBE4400CF;
	Fri, 27 Jan 2023 12:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DBE4400CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0138AC0033;
	Fri, 27 Jan 2023 12:13:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9268AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C7BB82C1E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C7BB82C1E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcOdV1gV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RV7zbqgg9d6v
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:13:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B826A82BF5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B826A82BF5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674821579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wDKTzv01CYcLKHmBuAfl2OIpCwnlZ9/jR50g20y4qAI=;
 b=FcOdV1gVrms3jbR7CQsDGlLfSshuTS6/KuJGyOJ1DJ2k9VT7PtMbafk8N6Ls+tZ61EMCsj
 keIrj4GiDITNvXuNiSQp/wLgEsUOgNc3tdRx42XqHiSEDYD7hUOdIctIwLuvDbpneFe71k
 NkHxfru3YdMPqgcp3+E9EFHKrJV0A4Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-tBTimuMvNUqVkVZ2corlyg-1; Fri, 27 Jan 2023 07:12:58 -0500
X-MC-Unique: tBTimuMvNUqVkVZ2corlyg-1
Received: by mail-wm1-f70.google.com with SMTP id
 z11-20020a1c4c0b000000b003db062505b9so1347262wmf.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 04:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDKTzv01CYcLKHmBuAfl2OIpCwnlZ9/jR50g20y4qAI=;
 b=kRBdyleNXS4H5v6cof+HxWuT4QCa5TYsPO0fryBJff2fGtGqF6f6Uswl4b0G4+TpRL
 tq6KReAMt4bCwzOUX3BoKAVGrcLxsNVH2A1L8PzAbP3XS4CYSr1b2yIu+p+gsGQtn5ea
 8FeqlUXGOJ/MfM49PeweogzQnKBJ9+AX+747CtjcbrP3EV8zwffNxyfMWJL/OwkX1exJ
 kUrZwylZM4tf94UBeF24ZcFOpQ9nV9/REWRJ06yJ3fLONDtqlnu17yAr0c+mMYJdTqBr
 wV8zWRp3lg4fIsm+2X6tzi7w6BHK9Dk0KwEVQ2cCoXk9QGez8g9MMghYtfCvZdSmfUuw
 sCNA==
X-Gm-Message-State: AO0yUKXljg3V+uLCvXn5rytefvwGX3AdpiXnU41H77YmEts2bKS9vz5s
 HLpkf7FDvOeNPe2jBEQtbdG8N3h11Ns0TihmRvqTMBLefvGf+Ux2yGqOun8qszM4QDynVvvia3i
 K12Fkjo8rfERUxZvZgsLoUa0c4+GHgS6RVBUsEuDO9A==
X-Received: by 2002:adf:b355:0:b0:2bf:b5ec:4844 with SMTP id
 k21-20020adfb355000000b002bfb5ec4844mr10990498wrd.19.1674821577063; 
 Fri, 27 Jan 2023 04:12:57 -0800 (PST)
X-Google-Smtp-Source: AK7set9GmxGoo8X9oAcX4fMwSdtSw/rq5da5Wkddl56eOmBN1nVCfWeny924/48xTuzSrJu0vw90VQ==
X-Received: by 2002:adf:b355:0:b0:2bf:b5ec:4844 with SMTP id
 k21-20020adfb355000000b002bfb5ec4844mr10990482wrd.19.1674821576836; 
 Fri, 27 Jan 2023 04:12:56 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 t16-20020adfe450000000b002bbdcd15e44sm3788409wrm.37.2023.01.27.04.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 04:12:56 -0800 (PST)
Date: Fri, 27 Jan 2023 07:12:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127071152-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <87k018p4xs.fsf@ubik.fi.intel.com>
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

On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> >> When handling control messages, instead of peeking at the device memory
> >> to obtain bits of the control structure,
> >
> > Except the message makes it seem that we are getting data from
> > device memory, when we do nothing of the kind.
> 
> We can be, see below.
> 
> >> take a snapshot of it once and
> >> use it instead, to prevent it from changing under us. This avoids races
> >> between port id validation and control event decoding, which can lead
> >> to, for example, a NULL dereference in port removal of a nonexistent
> >> port.
> >> 
> >> The control structure is small enough (8 bytes) that it can be cached
> >> directly on the stack.
> >
> > I still have no real idea why we want a copy here.
> > If device can poke anywhere at memory then it can crash kernel anyway.
> > If there's a bounce buffer or an iommu or some other protection
> > in place, then this memory can no longer change by the time
> > we look at it.
> 
> We can have shared pages between the host and guest without bounce
> buffers in between, so they can be both looking directly at the same
> page.
> 
> Regards,

How does this configuration work? What else is in this page?

> --
> Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
