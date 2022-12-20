Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF14EC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 23:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E26160A63;
	Tue, 20 Dec 2022 23:21:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E26160A63
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+CJtNED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkJkx3A7lm7a; Tue, 20 Dec 2022 23:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C833B608A5;
	Tue, 20 Dec 2022 23:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C833B608A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3795BC0035;
	Tue, 20 Dec 2022 23:21:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09DE3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 23:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A59E240239
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 23:21:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A59E240239
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+CJtNED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyI28aPW5Ggq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 23:21:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94F7940376
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94F7940376
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671578464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/yL2ss9yIdWHwPse2tigQEB/FE3FbjAM3XIM8TGekM=;
 b=i+CJtNEDzlCqFSQjn5lbwH/fx0H1nGPCSpVNDnHWbSw+YLblO2UMzzNXyKcoDkP8PewWr1
 A6nQ1ui+4K0lnNOyXqFh0hK8rKG+Qv7M3g0FjpqC6Fd80kHfPm9AKXBDu1cQ4Aq5BJGVn2
 d3qFNAkwtP+YBWR6brhHn80GGCS2Zz0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-5yzg7rtLOeCWtTlFOIvFNg-1; Tue, 20 Dec 2022 18:21:03 -0500
X-MC-Unique: 5yzg7rtLOeCWtTlFOIvFNg-1
Received: by mail-qk1-f199.google.com with SMTP id
 br6-20020a05620a460600b007021e1a5c48so10322368qkb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 15:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/yL2ss9yIdWHwPse2tigQEB/FE3FbjAM3XIM8TGekM=;
 b=wepN2ZIpr54S3Niny8ucjUVuZB7w7MHgN/cV/g2dJoWEZgr9n0MYH4BstasnUGIN5y
 RSgcBiD9fUbymHCP0jotvz/Gxo1wXUulwq92AToDj6e2yjaShqbfyabUHo8aOP3lxODJ
 A81ZNvhdrkveJLQKBowMrbyw4rDsriLOe4p5FLGJj371Q3Mse7mfGT3WvQumrRlMuReY
 WQitGYUt5W4f6vuCQDYZNaVziNlDbhQTsC75P1eSsiGgx9xAtIf/zUEmt/zLu+noBTNN
 ICw/7pJYQqNA4RcvIedIaT7RO3CiYH/GokM84nq8pV0g9/wUGWWtzClqj0sx5poxVhXw
 YzgA==
X-Gm-Message-State: AFqh2kqnLlHc3PhaCCsTv8y291TwDUGxo0mIjmlu/Q+zJC0vrxsZZRHi
 GY7OQ4XS50qbHNnAgoCwdj5QyLw96o5O/Q942QLJ3mxwtDqk+pJEtjqWmw7OdHIVPP9ZcL1LBVc
 N5MsmzRwkbCYKqjt7fc5zeY1w0YRar1LZ8bXs7iIE6A==
X-Received: by 2002:ad4:4c50:0:b0:4c7:2547:bc03 with SMTP id
 cs16-20020ad44c50000000b004c72547bc03mr14988655qvb.50.1671578462603; 
 Tue, 20 Dec 2022 15:21:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDl5nzwCTQTVtglgJWA2+tKSWwmW+GiT3UWFjEy1Jz1RZbeyhVIyRfPXdfqhBYgTBI7HoA+g==
X-Received: by 2002:ad4:4c50:0:b0:4c7:2547:bc03 with SMTP id
 cs16-20020ad44c50000000b004c72547bc03mr14988633qvb.50.1671578462340; 
 Tue, 20 Dec 2022 15:21:02 -0800 (PST)
Received: from redhat.com ([37.19.199.117]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05620a22d400b006e07228ed53sm9565979qki.18.2022.12.20.15.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 15:21:01 -0800 (PST)
Date: Tue, 20 Dec 2022 18:20:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221220182026-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
 <Y6IfwHicoMojJrIB@dev-arch.thelio-3990X>
MIME-Version: 1.0
In-Reply-To: <Y6IfwHicoMojJrIB@dev-arch.thelio-3990X>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
 llvm@lists.linux.dev, virtualization@lists.linux-foundation.org,
 bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
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

On Tue, Dec 20, 2022 at 01:49:04PM -0700, Nathan Chancellor wrote:
> On Tue, Dec 20, 2022 at 06:46:20PM +0200, Alvaro Karsz wrote:
> > Hi Nathan,
> > 
> > > This does not appear to be a false positive but what was the intent
> > > here? Should the local name variables increase their length or should
> > > the buffer length be reduced?
> > 
> > You're right, the local name variables and snprintf argument don't match.
> > Thanks for noticing.
> > I think that we should increase the name variables  to be
> > SNET_NAME_SIZE bytes long.
> > 
> > How should I proceed from here?
> > Should I create a new version for this patch, or should I fix it in a
> > follow up patch?
> 
> That is up to Michael at the end of the day (each maintainer handles
> their tree differently) but I would recommend sending a follow up fix,
> as it is easy to fold it in if they want to rebase the tree for it or
> just take it as a fix.
> 
> Thanks for the quick triage and response!
> 
> Cheers,
> Nathan

on top is ok but post soon please as i need to send this to Linus.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
