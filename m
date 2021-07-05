Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329EAC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:26:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D220E6196C
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D220E6196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0E824049D;
	Mon,  5 Jul 2021 18:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNNUNRJVqaGC; Mon,  5 Jul 2021 18:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 248324048B;
	Mon,  5 Jul 2021 18:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F120BC0010;
	Mon,  5 Jul 2021 18:26:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3261EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20EB04018D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zu-l2Ki5Ss01
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:26:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7F80400D2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625509599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRRrtMgruURgChxNxWwRZrL7plq4LfVLAvPpmCv92RU=;
 b=XK91vIPuiVFWkedjaL15FkF9kQ0Lf63CoDdb5obdvVFh2eGhoPW1yPCYAKvSGuDryQ+hT/
 GK/IuCui3kaWp+n8HJtjoc8rzSvJKVOhNMFptQVSMLLg8q275u3ZSROij6kfBLW8I43gQP
 iN0DSt9gGyWn6236d84/Ceb7vdps9aA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-B--b1_X5PC--M2hNKBBY-w-1; Mon, 05 Jul 2021 14:26:38 -0400
X-MC-Unique: B--b1_X5PC--M2hNKBBY-w-1
Received: by mail-wr1-f71.google.com with SMTP id
 a4-20020adffb840000b02901304c660e75so3288929wrr.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 11:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oRRrtMgruURgChxNxWwRZrL7plq4LfVLAvPpmCv92RU=;
 b=JAzCU7geutO8ZKcOThZawm8zJAEWZWsvNYA4GNckZKOw/8zNAPBEGVBa79lpjBQY4K
 9lU0qs/cTZ9TdBr7TMT8pZIwYTDcgs9x0B5TByL3yoF/a4arBUPBhr8nQdzp7xk0Ky/p
 EEig4fMlALMnTN/tqI0ZT27y14YW7Ymeyfg421Q1Mh88Dg8/B2FNv6O1OhhRvOUz2BnR
 3umfHsVsZjpRucBCV13iUKYKQnwMUC8aDqY9O9BisiUUzP18BEMSTu0Rrds/d8lj4c8j
 wh5i2eesn97TCr95O2As/RemjLQP/+GYjxt/+eSHlnk4aJZEImNrG1HbGJKtFedp28UF
 YnFg==
X-Gm-Message-State: AOAM532o5THIiYKbRt0SzNAc35YrL0IjzaHQfrCcqqGcrIQBNNJdptxJ
 5USpwpcOFXyaKVg2E7vqp6Ngj309xWNkhSM0jky3fEkb5nCL95A3xg2Le0iuGEllsVjQID6SAHR
 7FFJRut52yXKIcinrsx1pucHU0bAd0aB0MGueGB6n7A==
X-Received: by 2002:a1c:2142:: with SMTP id h63mr16343503wmh.84.1625509597503; 
 Mon, 05 Jul 2021 11:26:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxg6lV2mV2E4Ksstg1b9UaYYm1/na0HeVq/bH0oy4JNEBKaSdID8JncYLnj87O5OZ1B8dHdg==
X-Received: by 2002:a1c:2142:: with SMTP id h63mr16343485wmh.84.1625509597375; 
 Mon, 05 Jul 2021 11:26:37 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id n8sm13899936wrt.95.2021.07.05.11.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 11:26:36 -0700 (PDT)
Date: Mon, 5 Jul 2021 14:26:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <20210705142555-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
MIME-Version: 1.0
In-Reply-To: <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: deanbo422@gmail.com, yury.norov@gmail.com, nickhu@andestech.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 ndesaulniers@gooogle.com, green.hu@gmail.com, ojeda@kernel.org,
 kuba@kernel.org, akpm@linux-foundation.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, davem@davemloft.net
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

On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> On 2021/7/5 17:56, Andy Shevchenko wrote:
> > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> >> tools/include/* have a lot of abstract layer for building
> >> kernel code from userspace, so reuse or add the abstract
> >> layer in tools/include/ to build the ptr_ring for ringtest
> >> testing.
> > 
> > ...
> > 
> >>  create mode 100644 tools/include/asm/cache.h
> >>  create mode 100644 tools/include/asm/processor.h
> >>  create mode 100644 tools/include/generated/autoconf.h
> >>  create mode 100644 tools/include/linux/align.h
> >>  create mode 100644 tools/include/linux/cache.h
> >>  create mode 100644 tools/include/linux/slab.h
> > 
> > Maybe somebody can change this to be able to include in-tree headers directly?
> 
> If the above works, maybe the files in tools/include/* is not
> necessary any more, just use the in-tree headers to compile
> the user space app?
> 
> Or I missed something here?

why would it work? kernel headers outside of uapi are not
intended to be consumed by userspace.


> > 
> > Besides above, had you tested this with `make O=...`?
> 
> You are right, the generated/autoconf.h is in another directory
> with `make O=...`.
> 
> Any nice idea to fix the above problem?
> 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
