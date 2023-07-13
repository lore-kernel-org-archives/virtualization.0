Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DABC001B0
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 15:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FAD04167B;
	Thu, 13 Jul 2023 15:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FAD04167B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0ZZv4vL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xEdTl0ITmZ5K; Thu, 13 Jul 2023 15:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A87744089C;
	Thu, 13 Jul 2023 15:03:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A87744089C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A522C0071;
	Thu, 13 Jul 2023 15:03:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C34CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C46B941760
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:03:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C46B941760
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0ZZv4vL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OLTirEvsSRHg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:03:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DE7E4174E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DE7E4174E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689260595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cFIn1CK6FnjNQCiz1JGiV9ILeppGAa06PwBz7dUeBjo=;
 b=V0ZZv4vLUkYAuiJxhjCOCMfJ0fd0Mt/zOOGoidB4UQOtsmeI8Va+/gx2GPXtQs8rxJDUwo
 WOb+KSZ3NjlKDNqWO1NU/5bjo8YywMx70RZ3dOaWuzyPflEcJa/mwwyzgz88xUtrE3XWKD
 YZ0BAtkH6p6+Zih4di2mbZBKpBZWWd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-nBjbqTMZNOCOO_A2G-nQZw-1; Thu, 13 Jul 2023 11:03:13 -0400
X-MC-Unique: nBjbqTMZNOCOO_A2G-nQZw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3141c6f4173so547021f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 08:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689260592; x=1691852592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFIn1CK6FnjNQCiz1JGiV9ILeppGAa06PwBz7dUeBjo=;
 b=PH+fUsvI9R+wbEgCtFmzsV4unpAvXZe13DwYZ1A4u5CgYrBbzvHrWWNpXjuXgenrww
 5XiS683ZzQ2sDTlY7fS80F/wLkVsACUvE0mUGd4N/fGT9QtnbAMUV8tFhh/8QvdR5kEL
 4iBm7FrwoIQ4PcnFBaBguRn494a1orYdjFwY33Gv/J5e8hmVgwcGCr+qSwZcUMiNvcDF
 PqQCYqWEjqK5/Fcjki+99jFKNdUht99ncDiJl7cO4cRuS6bdcHPVDaKUcPaoPy0U5IFA
 lhpqiSHtsuCqYrRVWpwVOYSkJ6KME0q0ifNo/+7ZjgdSxuMfi/+qtcw+2unsTWu2hLM1
 aNXQ==
X-Gm-Message-State: ABy/qLZS9AFHtUH1ucn6Z3jf8ZocjPA07/1cv/MrzmduOZ5H+nTMZl2n
 p8TZi90ajSjMAW6MuMTvmHNI6GDp2jTuoQTOujBLRdwyyhEOm+3LMryzqVwsQg1kLpyxRyd5XX8
 JM2+GFPRfkHn7hdsEWTVBf4ye+LB5YsEtNhi2IPR9QQ==
X-Received: by 2002:a5d:4990:0:b0:314:38e4:259f with SMTP id
 r16-20020a5d4990000000b0031438e4259fmr1715195wrq.37.1689260592554; 
 Thu, 13 Jul 2023 08:03:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaDnc8gCmS/iGE+xN/QIqC6uWksocY8EZzAU7Kes71J35fzl/XzIXfSkkw7EmyOclyba4XlQ==
X-Received: by 2002:a5d:4990:0:b0:314:38e4:259f with SMTP id
 r16-20020a5d4990000000b0031438e4259fmr1715172wrq.37.1689260592174; 
 Thu, 13 Jul 2023 08:03:12 -0700 (PDT)
Received: from redhat.com ([2.52.158.233]) by smtp.gmail.com with ESMTPSA id
 w8-20020adfd4c8000000b003141e629cb6sm8119734wrk.101.2023.07.13.08.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 08:03:11 -0700 (PDT)
Date: Thu, 13 Jul 2023 11:03:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 0/4] virtio-mem: memory unplug/offlining related
 cleanups
Message-ID: <20230713110235-mutt-send-email-mst@kernel.org>
References: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230713145551.2824980-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-mm@kvack.org,
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

On Thu, Jul 13, 2023 at 04:55:47PM +0200, David Hildenbrand wrote:
> Some cleanups+optimizations primarily around offline_and_remove_memory().
> 
> Patch #1 drops the "unsafe unplug" feature where we might get stuck in
> offline_and_remove_memory() forever.
> 
> Patch #2 handles unexpected errors from offline_and_remove_memory() a bit
> nicer.
> 
> Patch #3 handles the case where offline_and_remove_memory() failed and
> we want to retry later to remove a completely unplugged Linux memory
> block, to not have them waste memory forever.
> 
> Patch #4 something I had lying around for longer, which reacts faster
> on config changes when unplugging memory.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

This looks like something that's reasonable to put in this linux, right?
These are fixes even though they are for theoretical issues.

> David Hildenbrand (4):
>   virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
>   virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
>   virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub
>     Block Mode (SBM)
>   virtio-mem: check if the config changed before fake offlining memory
> 
>  drivers/virtio/virtio_mem.c | 168 ++++++++++++++++++++++++------------
>  1 file changed, 112 insertions(+), 56 deletions(-)
> 
> 
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
