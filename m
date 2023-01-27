Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A3C61DA4
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 10:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FCA381412;
	Fri, 27 Jan 2023 10:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FCA381412
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUXBgCXg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwzXFpP85VaK; Fri, 27 Jan 2023 10:58:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A5C29813D0;
	Fri, 27 Jan 2023 10:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5C29813D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A2AC0032;
	Fri, 27 Jan 2023 10:58:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBA39C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93BD760B2A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93BD760B2A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUXBgCXg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4z2rIfekG9j
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF7ED60AAA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF7ED60AAA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674817116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFcJR84Ivdwd5OdBWBVJmXHz74QDbr0DcFcXGw8g9+s=;
 b=gUXBgCXgBeNTt/CdM1c4UzljTnHG5WSvGGxxgI5P94sLe5DxRen0H9ZCdfaTcjFHFlkVKM
 rpzeLoELItWBHRirsAlWF/JpgAhXy6WI/0JZU8xm4wNVSF09szxgaT8n3BEiy4ELKWQFDT
 GPc8vGMK69KqgBycdqbTmAoGiI1t/+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-MOzRdAl3PfCGj4HupuaEWw-1; Fri, 27 Jan 2023 05:58:35 -0500
X-MC-Unique: MOzRdAl3PfCGj4HupuaEWw-1
Received: by mail-wm1-f71.google.com with SMTP id
 z22-20020a7bc7d6000000b003daf671f7b2so1262723wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 02:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFcJR84Ivdwd5OdBWBVJmXHz74QDbr0DcFcXGw8g9+s=;
 b=Fmy7hBp7XRha316yB43hkG9M0Bp/y6BM2fuHc6/oTs79BUtYxq/x+3nCioRoloHpMZ
 wUICdvu82078QAr8bmbT2cX64b/ZfceHjyewEKVVqIlCpndx8l70WWmPTUZEWnnzQNH7
 LqWGWolGpNypu8WwGadWyhWiRw33/qMzvbcV2h38NK5EpFovXkjaykAAqY7SSC3g0AZR
 bpx+vfwfj45L6cIpcni3lgs4TG8Z5agSInKsg1ShqGT7kn/jdSMdy8CQzQquOtJ7Y3SQ
 /l98U564M+48s3yFKvKcDtyMjhAjmGOhOR5tiFDQSYbJLxZR6aI1GP42TlOlBr/wjoV/
 9u/A==
X-Gm-Message-State: AO0yUKUd0CdkdS3nH9KqUl5Svhp8I9RtSRUmetJgP22SSLVumwFQqE/O
 VZtFdLxmP8741ch96duGuhHyLZkrdWb46NRyZrcJaGBfjFCMf7T7YnG59H3Yj9JeulpKeEnruTj
 f7bOfCgyRwbGewtwEh/YZaSKE1jXntFTLAbqzJMz31Q==
X-Received: by 2002:adf:e785:0:b0:2bf:c09e:e7bc with SMTP id
 n5-20020adfe785000000b002bfc09ee7bcmr6193455wrm.7.1674817114377; 
 Fri, 27 Jan 2023 02:58:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/VtT9x0wKextkzcIfFv9ipItxc2L0qOJGaLpXlCHlGb8GPoxQl1tE5XCj751BlFNolOBlC1w==
X-Received: by 2002:adf:e785:0:b0:2bf:c09e:e7bc with SMTP id
 n5-20020adfe785000000b002bfc09ee7bcmr6193441wrm.7.1674817114159; 
 Fri, 27 Jan 2023 02:58:34 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 b14-20020adff90e000000b002be34f87a34sm3815513wrr.1.2023.01.27.02.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 02:58:33 -0800 (PST)
Date: Fri, 27 Jan 2023 05:58:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
Message-ID: <20230127055514-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
 <Y8lgIS+jygB7SGrn@kroah.com>
 <20230120074120-mutt-send-email-mst@kernel.org>
 <87y1pxp39k.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <87y1pxp39k.fsf@ubik.fi.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elena.reshetova@intel.com,
 kirill.shutemov@linux.intel.com
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

On Fri, Jan 20, 2023 at 06:41:27PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jan 19, 2023 at 04:22:09PM +0100, Greg Kroah-Hartman wrote:
> >> On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
> >> > In handle_control_message(), we look at the ->event field twice, which
> >> > gives a malicious VMM a window in which to switch it from PORT_ADD to
> >> > PORT_REMOVE, triggering a null dereference further down the line:
> >> 
> >> How is the other VMM have full control over the full message here?
> >> Shouldn't this all have been copied into our local memory if we are
> >> going to be poking around in it?  Like I mentioned in my other review,
> >> copy it all once and then parse it.  Don't try to mess with individual
> >> fields one at a time otherwise that way lies madness...
> >> 
> >> thanks,
> >> 
> >> greg k-h
> >
> > I agree and in fact, it is *already* copied since with malicious
> > device we generally use a bounce buffer.
> 
> Right, but the code should probably be able to handle bad input on its
> own, or what do you think?

Basically I think it's ok to look at the same field twice unless
it's mapped as dma coherent. Is that what you are asking about?

> > Having said that, the patch is actually a cleanup, e.g. it's clearer
> > to byte-swap only once.
> > Just don't oversell it as a security thing.
> 
> Well, security was the original motivation, so that's what it said in
> the commit message. But we settled on [0] yesterday with Greg, which
> would replace this patch and 2/6.
> 
> [0] https://lore.kernel.org/all/87a62eqo4h.fsf@ubik.fi.intel.com/
> 
> Regards,

At this point I will drop this series and pls post new series
with just the stuff you want included. Include acks if patches
are unchanged.

Thanks!

> --
> Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
