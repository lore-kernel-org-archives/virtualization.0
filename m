Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE20C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 14:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 889F782FCE;
	Fri, 27 Jan 2023 14:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 889F782FCE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpvEWpCN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yF_M1OKkLGx8; Fri, 27 Jan 2023 14:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C075682FD5;
	Fri, 27 Jan 2023 14:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C075682FD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC0AC0032;
	Fri, 27 Jan 2023 14:46:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1767FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D172D41D5F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D172D41D5F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpvEWpCN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IxjsMAvfm0PD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:46:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E9A741D59
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E9A741D59
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674830813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpgxDVEC7+0c0qata4U+nz7dWR4hklZ05tT76C3hVlU=;
 b=UpvEWpCNLPK5MkSxe/oy8OS3epbJyvsq8IXGk02gOKZtoqm8UrJ50t52UGb369n/puGQCo
 WsL5d9R3eTq/JP/WvibR/dN+x4lWOXiXGzyusUDH1M3LKcXHxjXe9d44h+9S9SztWPdcON
 4NHl8SEfuxjhDMDoPqQAW7XWbcGMRuA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-WtNGV12YNpai8u9R8FjQPw-1; Fri, 27 Jan 2023 09:46:51 -0500
X-MC-Unique: WtNGV12YNpai8u9R8FjQPw-1
Received: by mail-ed1-f72.google.com with SMTP id
 w16-20020a056402129000b004a1f1a2e79dso1500417edv.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 06:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpgxDVEC7+0c0qata4U+nz7dWR4hklZ05tT76C3hVlU=;
 b=12lvcsmO5x6209uuTLILhPtGm6lYHZACWGWMhSAyuoy7DY+SmolUgEwJWVQtvvpPbq
 nd8ePFIPhMYTwbic3s1T5ckfVmTHlpeEVxrUPLfjgHREaLE3AVoPojK1xYLDCIPfzHdn
 2H2uw3X4wkdkoz9wrwXJTKzoL4sGMK0vCg0Enx/ShhsQ2dd9vzXWwTPN2t6gEqZf13q9
 W2heoF4vOyIY5WHLTRiwfUXEiECMaclTWvyOqWEG9AJJScs4iLPyOpV4dyTOvMkfwJBY
 b+L6BID2OqW3sirCbXLYPqvWnEp6KyrA9OSP5Oo4wt5UKWIQM9bSAA6BkE3agOltOzCe
 50uA==
X-Gm-Message-State: AO0yUKVv2siJUsqC6BG7WxMcKjARFf3FEyjv/oGoS1W/v9ufYS/m0kN5
 ojOa0qi5mps5gd6W37OHjTrwi2+k7b9eqHAhz/h6Ico7K7OfWXKJezrJs8jw2fhLAeFruvWMh3F
 murAf/YKiqaH54b//kZzwTUqsBb1O7XsT7zVM5sbCHw==
X-Received: by 2002:a17:907:ea3:b0:87c:6aa5:ce24 with SMTP id
 ho35-20020a1709070ea300b0087c6aa5ce24mr1556475ejc.71.1674830810143; 
 Fri, 27 Jan 2023 06:46:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+G9T3BxQ2uASepzL4Az/FbSILbMgk/fWjAvHrhUKtSSSXMQoFwgu2i+XKQHEZyOl3z79y1qg==
X-Received: by 2002:a17:907:ea3:b0:87c:6aa5:ce24 with SMTP id
 ho35-20020a1709070ea300b0087c6aa5ce24mr1556459ejc.71.1674830809916; 
 Fri, 27 Jan 2023 06:46:49 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 w9-20020a170906184900b007c0f217aadbsm2320342eje.24.2023.01.27.06.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 06:46:49 -0800 (PST)
Date: Fri, 27 Jan 2023 09:46:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127094425-mutt-send-email-mst@kernel.org>
References: <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com> <Y9PSObAeUyHK2cc3@kroah.com>
 <87bkmkoyd1.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <87bkmkoyd1.fsf@ubik.fi.intel.com>
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

On Fri, Jan 27, 2023 at 04:17:46PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> >> >> We can have shared pages between the host and guest without bounce
> >> >> buffers in between, so they can be both looking directly at the same
> >> >> page.
> >> >> 
> >> >> Regards,
> >> >
> >> > How does this configuration work? What else is in this page?
> >> 
> >> So, for example in TDX, you have certain pages as "shared", as in
> >> between guest and hypervisor. You can have virtio ring(s) in such
> >> pages. It's likely that there'd be a swiotlb buffer there instead, but
> >> sharing pages between host virtio and guest virtio drivers is possible.
> >
> > If it is shared, then what does this mean?  Do we then need to copy
> > everything out of that buffer first before doing anything with it
> > because the data could change later on?  Or do we not trust anything in
> > it at all and we throw it away?  Or something else (trust for a short
> > while and then we don't?)
> 
> The first one, we need a consistent view of the metadata (the ckpt in
> this case), so we take a snapshot of it. Then, we validate it (because
> we don't trust it) to be correct. If it is not, we discard it, otherwise
> we act on it. Since this is a ring, we just move on to the next record
> if there is one.
> 
> Meanwhile, in the shared page, it can change from correct to incorrect,
> but it won't affect us because we have this consistent view at the
> moment the snapshot was taken.
> 
> > Please be specific as to what you want to see happen here, and why.
> 
> For example, if we get a control message to add a port and
> cpkt->event==PORT_ADD, we skip validation of cpkt->id (port id), because
> we're intending to add a new one. At this point, the device can change
> cpkt->event to PORT_REMOVE, which does require a valid cpkt->id and the
> subsequent code runs into a NULL dereference on the port value, which
> should have been looked up from cpkt->id.
> 
> Now, if we take a snapshot of cpkt, we naturally don't have this
> problem, because we're looking at a consistent state of cpkt: it's
> either PORT_ADD or PORT_REMOVE all the way. Which is what this patch
> does.
> 
> Does this answer your question?
> 
> Thanks,
> --
> Alex


Not sure about Greg but it doesn't answer my question because either the
bad device has access to all memory at which point it's not clear why
is it changing cpkt->event and not e.g. stack. Or it's restricted to
only access memory when mapped through the DMA API. Which is not the
case here.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
