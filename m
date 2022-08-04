Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199CCC00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 06:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F57D81D5A;
	Thu,  4 Aug 2022 06:30:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F57D81D5A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aN1FEc6V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GfTL4adrwpf8; Thu,  4 Aug 2022 06:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1BE5B81D16;
	Thu,  4 Aug 2022 06:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BE5B81D16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1712C0033;
	Thu,  4 Aug 2022 06:30:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEA4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1185341747
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1185341747
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aN1FEc6V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vg-vaM0Ri6bW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:30:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEB01416F7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEB01416F7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659594621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWV5Nzom/r2DGzRPPrdWv7ziLpfysDgq8ouqI6VTgyo=;
 b=aN1FEc6V0BZRlApSpDtO1eme88FAmrzp5MbQHHMgxEhPeRhx1A3xFGT64ssTsHm7gr8C9I
 jKWqi/HqGv4pt4UfYhd8zozcZDD3+E3z/Zov/jHtQTVH9vPrxcehZCeeNNLDkzBRin+4Hk
 hUVxmJXCwdDkQTUXybqNBQGMWYwrnIE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-tSC9ms8YMpijtiS6Ytg0sg-1; Thu, 04 Aug 2022 02:30:19 -0400
X-MC-Unique: tSC9ms8YMpijtiS6Ytg0sg-1
Received: by mail-wr1-f71.google.com with SMTP id
 d27-20020adfa41b000000b0021ee714785fso4539532wra.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 23:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=jWV5Nzom/r2DGzRPPrdWv7ziLpfysDgq8ouqI6VTgyo=;
 b=csm5SRd6N7E1CAhATj0AuTjLU8WcNdTY/0Ywob/0qa2C6hOwQdnqqQJes4urrEKViB
 wmrsEOnctvFK0u+X2edRTfj5YcrpaFw6XiLOFbTqiZzTq2AvhS4Zf0Gq12Bu+1A2poKf
 8BkWCGO/Oof5x9PzRK2WY02vpXuDHHTC2xzvisRRvwP+hGILNX64Zgwp0y84yqb+U14n
 6WG+zyA0ijKAAq5U//Y9qeu9rpsmRxdLb/tcRVKzNKzYwi1smiuGoiT+K+SZxkmYbFGf
 hujdgZODTaKrs5v0jruVlijO6YAew+35TfgdZhwE176ALcfcPZz7fIVNeAOx2CVfqm2P
 CU1g==
X-Gm-Message-State: ACgBeo3NJeYXRHw0t5Oz6sA3H6/gP7dYhKd6NKn9iefylZ+CKM/YxPiP
 BNfv0vENdNpsZVc34yv9yymvFFBm/fOEIMwLpXGFSLz3yJMQitu0H2VMOA2DD3N8T8rx+GbXXbQ
 7zxlPGxIrSy+QkSka33sM48YC8vjgIMrPxne4R7tWQQ==
X-Received: by 2002:a05:600c:1f13:b0:3a3:3f0d:d9d4 with SMTP id
 bd19-20020a05600c1f1300b003a33f0dd9d4mr5234145wmb.4.1659594618545; 
 Wed, 03 Aug 2022 23:30:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6faFq4v+P/KtznsTsLPMFwj/8I3/jsMtIU28MRRb9+5HjUgXhl9Z049FISpZX8Z8uJkXVeTA==
X-Received: by 2002:a05:600c:1f13:b0:3a3:3f0d:d9d4 with SMTP id
 bd19-20020a05600c1f1300b003a33f0dd9d4mr5234131wmb.4.1659594618283; 
 Wed, 03 Aug 2022 23:30:18 -0700 (PDT)
Received: from redhat.com ([2.54.191.86]) by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c351300b003a501ad8648sm238416wmq.40.2022.08.03.23.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Aug 2022 23:30:17 -0700 (PDT)
Date: Thu, 4 Aug 2022 02:30:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: memory locking in vhost-vdpa
Message-ID: <20220804022815-mutt-send-email-mst@kernel.org>
References: <780fba4c-458f-0abc-ae48-4cf806401228@virtuozzo.com>
 <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, den@virtuozzo.com,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Aug 04, 2022 at 09:52:47AM +0800, Jason Wang wrote:
> On Thu, Aug 4, 2022 at 1:46 AM Andrey Zhadchenko
> <andrey.zhadchenko@virtuozzo.com> wrote:
> >
> > Hi!
> >
> > Recently I sent vhost-blk patchset and Stefano suggested to instead join
> > efforts on developing vdpa-blk.
> > I played with it a bit and looks like vdpa itself pins the whole guest
> > memory. Is there a way to control it or reduce pinned amount to the
> > device pages?
> > Looks like even vdpa-sim requires all memory to be pinned [1]. Pinning
> > this much will surely impact guest density.
> 
> It depends on the parent.
> 
> When allocating the vDPA device, the parent can clams it supports
> virtual address then pinning is avoided:
> 
> /**
>  * __vdpa_alloc_device - allocate and initilaize a vDPA device
>  * This allows driver to some prepartion after device is
>  * initialized but before registered.
> ...
>  * @use_va: indicate whether virtual address must be used by this device
>  */
> 
> The only user so far is VDUSE which is a software parent in the
> userspace with a customized swiotlb for kernel drivers.
> 
> Simulator came before this feature so we stick to the pinning method,
> technically we can switch to use the va mode, but it might have some
> performance impact (mostly the copy_from|to_user()).
> 
> This option might be useful for hardware parent if PRI or device page
> fault is supported in the future.
> 
> Thanks

Well VDUSE has this funky bounce buffer design. It works but
is costly performance wise.



> >
> > Kind regards,
> > Andrey
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868535
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
