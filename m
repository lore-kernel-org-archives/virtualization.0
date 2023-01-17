Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415B6C63797
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 15:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0FA3607B4;
	Tue, 17 Jan 2023 15:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0FA3607B4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYnGwywu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mnKOdhNSZkD; Tue, 17 Jan 2023 15:27:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79F8F60BCE;
	Tue, 17 Jan 2023 15:27:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79F8F60BCE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFFFC0032;
	Tue, 17 Jan 2023 15:27:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE8EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC8E981EA6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC8E981EA6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYnGwywu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Fp2w8eLod5Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:27:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE9F781EB2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE9F781EB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673969272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mf4+kXwb5Y62UKaWEsmrSR/GmJpI00PMSlFTIvem3xI=;
 b=ZYnGwywub/pw7feIfSuP2bjAEnMRqTaCj77gnije+b2HPghOhpZ60avQHtLDHzt8snQyfh
 KY3Vf0FCtremcrCYciEyiVnhsfzLaHYFC6QI+DM5n2DkCPvIylXuFYOdQdtoWvK4o05ke/
 DN/7Frc7y0EXsDr3fdl44cgBbizwk6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-82qAupu1NSSoRDjObWanLw-1; Tue, 17 Jan 2023 10:27:38 -0500
X-MC-Unique: 82qAupu1NSSoRDjObWanLw-1
Received: by mail-wm1-f69.google.com with SMTP id
 z22-20020a7bc7d6000000b003daf671f7b2so1590689wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 07:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf4+kXwb5Y62UKaWEsmrSR/GmJpI00PMSlFTIvem3xI=;
 b=u1mAYBDD5OzcHlRkw//m2Y+GCiR+YicuMD3MqKN82+tE8GArOKi1GLuDOMbbjUulsT
 0hyC2fL9DolQx0srX6EjphK4lA7zNr4PaIShSSHKfDhEcE2LdrkqM5a9kKXTcigmduwQ
 FD7CwmKyN3Nl5uDwdla+vym1WDtlvKlwrAYo3Q+dxUveV8atu8Yyl/QpkyfFw/g0vQ03
 +8hD1Qi+MXdS+RUBfjo9mZS6TC8JwwSalMXy1D0UfgtQy2UV4AFbfZxNKb+k5pyH8uc/
 a38R+9juZl9vFHvF+1plk1CfwzQBrWKncLY+WKVzcCuQ+8wihrgpSRMtRU6y9SoVwFKn
 JJhQ==
X-Gm-Message-State: AFqh2ko17RD6Cqk4l0UMPgjdB5x+G9VTku6kuJ7i0XeDZwBFKQBNKhBL
 E+jnb5fs1Tl57UuKvlrXWalfGC63nvYsQsfpXiPIX18QBChtrOGx5B4vArBFAmL4LauyWfvGIBc
 polpxZV4RA4lg2R1wctpuj9djofydDB2sdtOJHi1z0A==
X-Received: by 2002:adf:cf0f:0:b0:2bb:de14:a18 with SMTP id
 o15-20020adfcf0f000000b002bbde140a18mr11785260wrj.14.1673969248205; 
 Tue, 17 Jan 2023 07:27:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtV9r/mt18AC8LxASroBvb/ychDU3U7PGrr0s2GWK6qvRfiIUzFbsJWk1jbxC5ku242LIPAjA==
X-Received: by 2002:adf:cf0f:0:b0:2bb:de14:a18 with SMTP id
 o15-20020adfcf0f000000b002bbde140a18mr11785250wrj.14.1673969247941; 
 Tue, 17 Jan 2023 07:27:27 -0800 (PST)
Received: from redhat.com ([2.52.28.74]) by smtp.gmail.com with ESMTPSA id
 bu3-20020a056000078300b002bbe7efd88csm24327964wrb.41.2023.01.17.07.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jan 2023 07:27:27 -0800 (PST)
Date: Tue, 17 Jan 2023 10:27:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 0/5] Harden a few virtio drivers
Message-ID: <20230117102035-mutt-send-email-mst@kernel.org>
References: <20230117135800.39184-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230117135800.39184-1-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Tue, Jan 17, 2023 at 03:57:55PM +0200, Alexander Shishkin wrote:
> Hi,
> 
> Here are 5 patches that harden console, net and 9p drivers against
> various malicious host input.

So I'm all for hardening against buggy devices.
But, if it's malicious host you are worried about, shouldn't
we worry about all the spectre things?



> Alexander Shishkin (2):
>   virtio console: Harden control message handling
>   virtio_net: Guard against buffer length overflow in
>     xdp_linearize_page()
> 
> Andi Kleen (3):
>   virtio console: Harden multiport against invalid host input
>   virtio console: Harden port adding
>   virtio 9p: Fix an overflow
> 
>  drivers/char/virtio_console.c | 19 ++++++++++++-------
>  drivers/net/virtio_net.c      |  4 +++-
>  net/9p/trans_virtio.c         |  2 +-
>  3 files changed, 16 insertions(+), 9 deletions(-)
> 
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
