Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930DAC4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 16:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF1E46134F;
	Tue,  7 Nov 2023 16:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF1E46134F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S0sax7JO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bnzAikOQbth; Tue,  7 Nov 2023 16:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 70CDE61313;
	Tue,  7 Nov 2023 16:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70CDE61313
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D476C0071;
	Tue,  7 Nov 2023 16:11:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 572A2C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 16:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3225E6134F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 16:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3225E6134F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iY0CWYG7WKjf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 16:11:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CF3F61313
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 16:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CF3F61313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699373479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fw4FStypu9syAQ3xa9mC4mwCaAdKKxAxHhWjdd8hiZw=;
 b=S0sax7JOkT5AbXgv7t2fc3Nfs8EHBpP3nemCxMBPjHTPD3UOhhuU1xQinHdujBkTo0Nf2M
 0ESerMoX0BJ5QjEjov0Hs5UtWJ0lKm3ToNS7waNOYJgmec13W2da3FZH5U8pbsEJKQeH9D
 VSw3yaSDvRHxQIN8hCWGh3B2YZUvIm0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-8UcX3jHzN0ux_wvcmNPKkw-1; Tue, 07 Nov 2023 11:11:15 -0500
X-MC-Unique: 8UcX3jHzN0ux_wvcmNPKkw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d9cd6eb0bso2981447f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Nov 2023 08:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699373473; x=1699978273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw4FStypu9syAQ3xa9mC4mwCaAdKKxAxHhWjdd8hiZw=;
 b=kibnXdkEMVDiewGw4cDqAShd0tUV5hPRygNIPo+Hqr6AEsz6hK3r44V3yfq+bwY6Jh
 WvkPHt0USzqt1o42HqKmno3kz1wwkulLau1+HwEDykqCDOXT//k4QJ3RVBJR8fqjq++7
 tid/Vl6RoLXaTIEezdhkfotkvlLmixBq7qCy/DVEWyLaKMM9w/26q/VCVCwSEtgtjBY3
 ErhDVXeQJ5ohBiCT4fsgzLF0ra8uva+pk1lbmkhC7MEFnbgRMcpawDX0nryLpLcDCFGR
 +LDCkEHLFsJSnHBen5OarnVzGkt0DJDcqrdk4VA8a65WywpaFeEAbneGGe136vJQQ+Or
 LlEA==
X-Gm-Message-State: AOJu0Ywxj58k7BNfyRDaQlfzDahomsC2FZxmYaIR5j2D61d/IDQgbHXC
 9gVtnJLtMCBnWRkUBw6BGoEKFoKG3XuRlLQ8wTjUk6kMfrXoTLg+T2HHW+9Ua4k88m4QMkEdCS5
 qAndYJnorwPSWko/1cp/Q3gfpY9qq25NF0MToWgJJGw==
X-Received: by 2002:a5d:4242:0:b0:32d:a910:6c2a with SMTP id
 s2-20020a5d4242000000b0032da9106c2amr20392847wrr.30.1699373473052; 
 Tue, 07 Nov 2023 08:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgMckOifCcs2vvNetl9dhM/47Y7sLJxike1OKMQTMQ/IMLbHJBruMwhH1ayLRP/5336FfqBA==
X-Received: by 2002:a5d:4242:0:b0:32d:a910:6c2a with SMTP id
 s2-20020a5d4242000000b0032da9106c2amr20392827wrr.30.1699373472700; 
 Tue, 07 Nov 2023 08:11:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 u3-20020adfed43000000b003140f47224csm2739390wro.15.2023.11.07.08.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 08:11:11 -0800 (PST)
Date: Tue, 7 Nov 2023 11:11:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107105718-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107094818-mutt-send-email-mst@kernel.org>
 <20231107154848.GP4488@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231107154848.GP4488@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, Cindy Lu <lulu@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Nov 07, 2023 at 11:48:48AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 09:55:26AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> > > IMHO, this patch series needs to spend more time internally to Red Hat
> > > before it is presented to the community.
> > 
> > Just to add an example why I think this "internal review" is a bad idea
> > I seem to recall that someone internal to nvidia at some point
> > attempted to implement this already. The only output from that
> > work we have is that "it's tough" - no pointers to what's tough,
> > no code to study even as a bad path to follow.
> > And while Red Hat might be big, the virt team is rather smaller.
> 
> I don't think Nicolin got to a presentable code point.
> 
> But you can start to see the issues even in this series, like
> simulator is complicated. mlx5 is complicated. Deciding to omit those
> is one path. Come with a proposal and justification to take it out,
> not a patch with an unexplained #ifdef.

Right. Simulator I don't think we need to support, or at least
not necessarily to get this merged - it does not really
benefit from any iommufd features.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
