Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60478C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 03:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7579404A5;
	Tue, 23 Nov 2021 03:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4wMM1bCYhBb; Tue, 23 Nov 2021 03:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90C104047F;
	Tue, 23 Nov 2021 03:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67571C001E;
	Tue, 23 Nov 2021 03:41:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6C62C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0D9960605
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T47osv-6ylGE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:41:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42C48605F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:41:13 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so1231829pjj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 19:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yuisy9zT1caIpoCJEL+LfomruK38WXIi70xmI7lYDdI=;
 b=Y08/be2uy1a6FHo2yuq5V6dIERIFe+eeTyXLXTKFjFxfAYARUBwDdqRv9XulygxcF5
 4zZfKtYGqV6eckQSPyIqI+Gn3GMQFWIP9FXR6DHHwN+9GDnZm18bVZGFa88rvhT3Zhp8
 eBxG8SJu0LWqmuhUvXdN5Q8E0N7Fv2c7+1ZOSnPpTxrI3q5JIXNMGFvAj0k+TWuhQgQG
 tLoyO8DVm7L0ndxV5dBnp+whJ587dE90ANm0vqzPKJbxSHtsEtd3ERFpgMcAPItk+09G
 dbm69RRAjzWoV6a6vlvEHV0tkZfEJqiOGj5p0uoKbINk6WBGJnIFfCSAm3gIT8TG78mL
 kVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yuisy9zT1caIpoCJEL+LfomruK38WXIi70xmI7lYDdI=;
 b=7sw8z5+AqWZyk16aOgO/2k823yjE1kr+EizZDyslnRbn4Y23+zWlWzsZXdCUufuiiO
 yFL1YlIENicVrnmOqyN6Mbo4ijwqVoRifgeAygFypyRIyIMOTTFar5VWuhROsFyoZLoW
 DXTRwp5jpwikYIGBPzL0pXLmOB+W4/WqbA57Nu8IPP8WXoPMwyKAgK1DyaF3ShI0a6FV
 kivOZk39RfsNA/JCYdL5HDaIhGvaJEo1J67CkF2Fpu8fwQRUxl4HS7KXI+xfZnHJx1hl
 c850TlQHqvfGzFDFa+ttJcg0tQaMeoQOM0yrtqMZbO3JZLZ2oA2YZM9y25Aa9Q4/vs6C
 VMsg==
X-Gm-Message-State: AOAM530DdmS2Z1OvIx2njhmBPUJCXBp7UkyOEy1nffcsBhXFDPa/10jg
 wExCVC6pTRA5DjiSQOH7xfUtP9TG8w3HbF7N2k2eYg==
X-Google-Smtp-Source: ABdhPJwgBzEQtBEEt5JgwawqvX/CZbZsaXh/qAQWeeflxeagBI6MsJ+fyqKdfOXHrkiL5G4d5gMRZlq/mNM2Mj9gTds=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr2525502pjb.93.1637638872640; 
 Mon, 22 Nov 2021 19:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-7-hch@lst.de>
In-Reply-To: <20211109083309.584081-7-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 19:41:01 -0800
Message-ID: <CAPcyv4imYR=NLizABpZA+gKH+amNQ6jcVNQhtF+1jyevdWzmBw@mail.gmail.com>
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into
 fs_dax_get_by_bdev
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.
>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
