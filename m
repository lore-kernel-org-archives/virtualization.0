Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D12CD5BC7
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 14:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F01F82D0F;
	Tue, 19 Sep 2023 14:19:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F01F82D0F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PsWuv6+U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUXpH4ylUiLp; Tue, 19 Sep 2023 14:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12ACB82CCA;
	Tue, 19 Sep 2023 14:19:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12ACB82CCA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3C83C0071;
	Tue, 19 Sep 2023 14:19:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2C60C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7E1B82CF1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7E1B82CF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMGL_gwUlmkp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:19:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8AF182CCA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:19:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8AF182CCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695133144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mHsPb4vwC+hSL0GCp3HRQ13LaXYANF8EE6mc0h6Oj8g=;
 b=PsWuv6+U2b+GK64JSTINZpe/Qodcl5XQ3ccnfDCG6c2i3OBPVojHnYcIthgPaK/gllD8cF
 b612RwfjNOt8maPEcvoyVrkhBY4bcAwaHaOskasG7lnL+JhK8IhxDjWZnuqHG4Vo2ykC3h
 q89Nl7e4GLD7L97vVQ+QEYcGIDSvN2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-AK09J2k1PPi_lk3SCYdbRw-1; Tue, 19 Sep 2023 10:19:02 -0400
X-MC-Unique: AK09J2k1PPi_lk3SCYdbRw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401c4f03b00so45428685e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 07:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695133141; x=1695737941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHsPb4vwC+hSL0GCp3HRQ13LaXYANF8EE6mc0h6Oj8g=;
 b=iSvPmHSMijzqGdI8gvpNHiMKw16aZ3OXAehsZqWRFMeMiG9BCinqsCjBh9oaT6p4Lj
 OXH4icrESfKzEPJ8TyADHgeePWZJ64JgfaPW970PW/TZ5bJlhNiBfGSpXXHnRX+rnecT
 lN4Gp/a9c5KXtGsLNuW2PZyhNyFBpnvimRMFWFU4VeRdX+7NnP78W3OJW4/P/IBWODic
 OqESriX7dsYlY7t73ARwcu7yfzp7msXfq0GtYXY32N/+TuB5scoAG9gasnV8sCQE+W7H
 Z0btnsmew3WecXP11PhWSqOoc6eozKn+0SHWAdSkgB9SFdbCsW2zPjyXB6Nc4KoYTMlt
 WooA==
X-Gm-Message-State: AOJu0Yz3pYUSkijekXEuU5scBeDeMF2GrEza3e80MtTHvD566HDw7uHK
 zmshUaFeJPniuxWmMV1gLTMCtlQ55Wk355WKRl7Ab3ABKbBHWVynO2bEcdJHVP/uzCD0+bjBZR5
 omyTFwcu7GAEOIoejgHmWFPrh2LhoQgfW7sEpQiSQwA==
X-Received: by 2002:a05:600c:2a4e:b0:401:c338:ab96 with SMTP id
 x14-20020a05600c2a4e00b00401c338ab96mr10435238wme.34.1695133140888; 
 Tue, 19 Sep 2023 07:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHULrW8YH1mAvut0fZRQ8pHQtMqOvI3PTpgt45Tanm07z1GXdEHC8fUEBACgIXmq28KDQvcCw==
X-Received: by 2002:a05:600c:2a4e:b0:401:c338:ab96 with SMTP id
 x14-20020a05600c2a4e00b00401c338ab96mr10435220wme.34.1695133140545; 
 Tue, 19 Sep 2023 07:19:00 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05600c029000b003fee8793911sm15444202wmk.44.2023.09.19.07.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 07:18:59 -0700 (PDT)
Date: Tue, 19 Sep 2023 16:18:57 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-sound linux driver conformance to spec
Message-ID: <ZQmt0Z8lbPMuFzR+@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <20230919054054-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230919054054-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-comment@lists.oasis-open.org, stefanha@redhat.com,
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

On Tue, Sep 19, 2023 at 05:43:56AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
> > Hello,
> > 
> > This email is to report a behavior of the Linux virtio-sound driver that
> > looks like it is not conforming to the VirtIO specification. The kernel
> > driver is moving buffers from the used ring to the available ring
> > without knowing if the content has been updated from the user. If the
> > device picks up buffers from the available ring just after it is
> > notified, it happens that the content is old.
> 
> Then, what happens, exactly? Do things still work?

We are currently developing a vhost-user backend for virtio-sound and
what happens is that if the backend implementation decides to copy the
content of a buffer from a request that just arrived to the available
ring, it gets the old content thus reproducing some sections two times.
For example, we observe that when issuing `aplay FrontLeft.wav`, we hear
`Front, front left...`. To fix this issue, our current implementation
delays reading from guest memory just until the audio engine requires.
However, the first implementation shall also work since it is conforming
to the specification.

Matias

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
