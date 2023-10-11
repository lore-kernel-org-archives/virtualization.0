Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C7CDB46A
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 17:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EF7F418F8;
	Wed, 11 Oct 2023 17:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EF7F418F8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtddPbPe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwPT5txe72_z; Wed, 11 Oct 2023 17:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADBF6414C6;
	Wed, 11 Oct 2023 17:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADBF6414C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 808F5C0071;
	Wed, 11 Oct 2023 17:03:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 931E5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AC2761241
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AC2761241
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtddPbPe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFp_ae-D05px
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:03:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 092C560BB2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 092C560BB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697043806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vQwaI6qzCKHaJR2pCcBdNfGrnFseeUjFkznqcANewvA=;
 b=dtddPbPeMlQeswPoehp5uriLU4glNATUKO91DNP/+ftiuqdEc3iH2iBJR1rS8/CyaGa1qQ
 4ZxYkp9J1ZnqvPYT9JGfrTA8ZP1alMamHH/ja4oA5kseZ96SqDMoPwY8jErQcUwuabYSHl
 a4uyiBHe08M6RIcAm9CArohOtDjjdAs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-zEIM08eOOLuECinj04PKlw-1; Wed, 11 Oct 2023 13:03:15 -0400
X-MC-Unique: zEIM08eOOLuECinj04PKlw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-323306960e3so12029f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 10:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697043793; x=1697648593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQwaI6qzCKHaJR2pCcBdNfGrnFseeUjFkznqcANewvA=;
 b=ToO/9Wi52oWJ6UKvMuleR/SYcMpRYGe2q4UbK3RXaANGFKAJObYIXQUPz9UxrYrMvh
 nGa1yMHFPs8iTGnvABdvEcgLSmtOnKgvqinEh1UWzvgJ89trrsu4vwOtOIn85ydRHOm0
 EheoaTz93VYFx/Gc1Gdhz/Tq5wZLmgVgFbAKqQoYHP8Hhcpkw10ehX0kNq4YGirQqzri
 AJOjSBE9FEwx999SAJrOwjtYderq6OItiTBwsYAdSESyVz8UczxL5t4T+lyFgx7XT1IU
 RWkmBH8gT1kIRpHMJYPDqIj3+BkB5PJmKWJ7s5e1rOw37GZm8oC+j2SkuIx/P5duS+9U
 P6dQ==
X-Gm-Message-State: AOJu0YzG0v3bzscmFx0uuvaRTdxrwTGRXrEiq1VB7JehMQ3EduQMuQ99
 8v7jyHa7q+JUEz9OlH2lU1+BqZBcfpHWcZjC4s1sOmzEuvoUR3N4GZQEMQPFdT0M0+8PcFOzev5
 Hu5HX8Zh1La0kGYB6ZtTZrVPtfGgnv0ytcf2NGXDU3Q==
X-Received: by 2002:a05:6000:613:b0:329:6d09:61ff with SMTP id
 bn19-20020a056000061300b003296d0961ffmr16729098wrb.62.1697043793738; 
 Wed, 11 Oct 2023 10:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEoqjIfx0YMUmsiEqzUF6aUikcBac9FEtKjQD1Evi5nTkjChgZ9sJaB9Sh0FuZqZOrByFhCQ==
X-Received: by 2002:a05:6000:613:b0:329:6d09:61ff with SMTP id
 bn19-20020a056000061300b003296d0961ffmr16729072wrb.62.1697043793440; 
 Wed, 11 Oct 2023 10:03:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 c14-20020adfed8e000000b00317b0155502sm15903900wro.8.2023.10.11.10.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 10:03:11 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:03:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011130018-mutt-send-email-mst@kernel.org>
References: <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231011040331-mutt-send-email-mst@kernel.org>
 <20231011121849.GV3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231011121849.GV3952@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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

On Wed, Oct 11, 2023 at 09:18:49AM -0300, Jason Gunthorpe wrote:
> The simple way to be sure is to never touch the PCI function that has
> DMA assigned to a VM from the hypervisor, except through config space.

What makes config space different that it's safe though?
Isn't this more of a "we can't avoid touching config space" than
that it's safe? The line doesn't look that bright to me -
if there's e.g. a memory area designed explicitly for
hypervisor to poke at, that seems fine.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
