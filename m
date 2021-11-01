Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC75C4167B
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:19:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D566112F
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2D566112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68A746064E;
	Mon,  1 Nov 2021 16:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HbsiKa3ePiyy; Mon,  1 Nov 2021 16:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19561605AD;
	Mon,  1 Nov 2021 16:19:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0290BC0019;
	Mon,  1 Nov 2021 16:19:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AEABC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFAB260605
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y35cFP8eAMFk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:19:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55E4B605AD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
 b=ioV3bcGv85AIWOyDAkvGTS2TjAGuZiacWuWeZda+/ETDMsG5qLftSzKgmpK4q7FS2Umsnf
 OuoVbJYNu0QBQKDOLBcLohvnvmr9NWJFWEYFcXZ9DiQb5Vo6bNW/Ia5YX9AjfY0Qa//PCi
 FpPo81IXuUBBkxwQAldvhalUJRAF/xs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-eS-yO2yWPpKDZKiZ29aPNw-1; Mon, 01 Nov 2021 12:19:21 -0400
X-MC-Unique: eS-yO2yWPpKDZKiZ29aPNw-1
Received: by mail-qk1-f199.google.com with SMTP id
 v14-20020a05620a0f0e00b0043355ed67d1so10842711qkl.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 09:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
 b=k0tI7qlSOo31BlVi1TXk6gGkrKgQZadXXzUb51bRW1/QwNhEq+8WZJRiB6t6l19FEL
 ZWiNqMUOVQfKSDII3eT2AnPABnQaKSs8q34neropNGawJWQZzSYj3MJ2SHbHP3M+QCRJ
 VltmKpKu0/m5N6bx4yI0zGffvhAirnrhjmMlyERXhXRsb13ncdwlFL/IenDH2Z7xdKKJ
 qzc/u1e02jousSXPdaSZ7RPp7Xh2sM3dgbM16YsBXFcH1jG0iIzgf/QkH+8Vjz5g0F0u
 SF2+j2rdn5VejV/q5R8kIPgwsO+d9d2lbVHrN75zq9tKaw2KRZN29s63DOEbzYhhbBc5
 x/UQ==
X-Gm-Message-State: AOAM532SJ0en16bHadN8jwedjNEALgMY+sn5gnuxWl0GlVQ2v6FhoS0j
 ZCoCQUptsSlEXjjabuFaoAwCCArbvDbL/ck8G9ogvDFavPJr5vqrn5BtxcNt1E1A+CtKKFQNDj7
 xTjsDQ9z/tKWMwH7ZzX/+9e4VLf/ylSOABM11bNkU
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270549qvf.21.1635783560973; 
 Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvmIEea110PcdB5LDCY7U1ej3BdqkCE7DUWVGoDnBFq+m2W3EEPnU5Ptqvnzv3GNnSJbsMew==
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270537qvf.21.1635783560844; 
 Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id g8sm1775746qko.27.2021.11.01.09.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:19:19 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 09/11] dm-log-writes: add a log_writes_dax_pgoff helper
Message-ID: <YYATh6yxGehyjpcm@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-10-hch@lst.de>
 <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Oct 27 2021 at  9:36P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Looks good.
> 
> Mike, ack?
> 

Acked-by: Mike Snitzer <snitzer@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
