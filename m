Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99591C3DA7D
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 153B740385;
	Tue, 27 Dec 2022 07:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 153B740385
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gjuKed5Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dxrONtsNZGB; Tue, 27 Dec 2022 07:04:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8863E400D1;
	Tue, 27 Dec 2022 07:04:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8863E400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 645A4C0032;
	Tue, 27 Dec 2022 07:04:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58F3DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C68D80B6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:04:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C68D80B6F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gjuKed5Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmHNnjPjM1BL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:04:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CB5A80B6C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CB5A80B6C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aoTymnMJhMCAhdxLx/6Xd8j2K/EbpmVCnrzJwfgh2hQ=;
 b=gjuKed5QBwXNcfMp9j3eUvlXusUGm9TwpT6r41jEC0+y0Qw+T0CtJPLbxFR6cJEwFsBbYN
 REKxXbxpt5SZS/rMzoVhHYSGKK/cyu7YQvFdI2dFYkOXoNVTlnK2DvkSr5m+Ck5IiYEMl8
 vnA6fkC1s0IrrHIacQitLU3NGU0OOJE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-m7hM7yqENx-g_nn1jjd0Bw-1; Tue, 27 Dec 2022 02:04:23 -0500
X-MC-Unique: m7hM7yqENx-g_nn1jjd0Bw-1
Received: by mail-ej1-f70.google.com with SMTP id
 sc9-20020a1709078a0900b0084c4e8dc14eso2980496ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoTymnMJhMCAhdxLx/6Xd8j2K/EbpmVCnrzJwfgh2hQ=;
 b=llLrcM3zkGcXVcCCb/oclzWSq64RKgSyvi1DwdYG1N0U6Kjq72H2OM0LAiAxbqV5EN
 jAyBxdVDpBY/1M2In0lHgZpDmlNun6dE6SyxYjCbWz7P4amPOoC+PslhK/dRBBQXNCxu
 WZ6kIjKnmcPEL70qZLWW+lYwQxkYgEp6qHvNdUbjXewBSJy8dELdLM9zeSTIGm+Hg/mS
 UzzPGnCa/jXcm3EHM675z9C6d4DpuuFwpIrohbpswXYP/JITMWvFSRbgQ7oRZ7T8/nKB
 RHA0vVPiMSADIPagOgDAPSKwSd9s2a0NFGdVna6IwMqVY8pWcsDQ3jK6yb+oBH/bBQn/
 Blqg==
X-Gm-Message-State: AFqh2krzNsc1xcnrP36hUKorWhEFh5kScAuB3PFtYxwjPjmMg07TVMJ4
 nZhWtzu2squQx7852nf8FlBIZ2VEpfUP77wVulWaBLJOvXBiKTmM4NSGzD5gXKm07Q6/beVvNNh
 GXzk/eApEyjCddSpDI5sRSFt+KmpZa1o8xCucymtOeA==
X-Received: by 2002:a17:907:2388:b0:7c0:e0d9:d20d with SMTP id
 vf8-20020a170907238800b007c0e0d9d20dmr19088745ejb.37.1672124662541; 
 Mon, 26 Dec 2022 23:04:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6gAxH/ncrPcbp+Eit49juvH4l55QVsieawsjzQ5QHGjjI86Ork+Wd8xiQwiDtwhCgj4ZHBw==
X-Received: by 2002:a17:907:2388:b0:7c0:e0d9:d20d with SMTP id
 vf8-20020a170907238800b007c0e0d9d20dmr19088733ejb.37.1672124662287; 
 Mon, 26 Dec 2022 23:04:22 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 k13-20020a1709061c0d00b0082000f8d871sm5695709ejg.152.2022.12.26.23.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:04:21 -0800 (PST)
Date: Tue, 27 Dec 2022 02:04:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 4/9] vringh: unify the APIs for all accessors
Message-ID: <20221227020007-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20221227022528.609839-5-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
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

On Tue, Dec 27, 2022 at 11:25:26AM +0900, Shunsuke Mie wrote:
> Each vringh memory accessors that are for user, kern and iotlb has own
> interfaces that calls common code. But some codes are duplicated and that
> becomes loss extendability.
> 
> Introduce a struct vringh_ops and provide a common APIs for all accessors.
> It can bee easily extended vringh code for new memory accessor and
> simplified a caller code.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/vhost/vringh.c | 667 +++++++++++------------------------------
>  include/linux/vringh.h | 100 +++---
>  2 files changed, 225 insertions(+), 542 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index aa3cd27d2384..ebfd3644a1a3 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -35,15 +35,12 @@ static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
>  }
>  
>  /* Returns vring->num if empty, -ve on error. */
> -static inline int __vringh_get_head(const struct vringh *vrh,
> -				    int (*getu16)(const struct vringh *vrh,
> -						  u16 *val, const __virtio16 *p),
> -				    u16 *last_avail_idx)
> +static inline int __vringh_get_head(const struct vringh *vrh, u16 *last_avail_idx)
>  {
>  	u16 avail_idx, i, head;
>  	int err;
>  
> -	err = getu16(vrh, &avail_idx, &vrh->vring.avail->idx);
> +	err = vrh->ops.getu16(vrh, &avail_idx, &vrh->vring.avail->idx);
>  	if (err) {
>  		vringh_bad("Failed to access avail idx at %p",
>  			   &vrh->vring.avail->idx);

I like that this patch removes more lines of code than it adds.

However one of the design points of vringh abstractions is that they were
carefully written to be very low overhead.
This is why we are passing function pointers to inline functions -
compiler can optimize that out.

I think that introducing ops indirect functions calls here is going to break
these assumptions and hurt performance.
Unless compiler can somehow figure it out and optimize?
I don't see how it's possible with ops pointer in memory
but maybe I'm wrong.

Was any effort taken to test effect of these patches on performance?

Thanks!


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
