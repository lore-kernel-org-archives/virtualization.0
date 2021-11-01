Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F37C433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:13:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC2960F24
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEC2960F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F5CB401FE;
	Mon,  1 Nov 2021 16:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-01BlqmLGaZ; Mon,  1 Nov 2021 16:13:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED71540153;
	Mon,  1 Nov 2021 16:13:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1F1AC0019;
	Mon,  1 Nov 2021 16:13:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A26E0C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CF3B605D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DO9LNzQWiHs4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:12:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E51FC605D5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
 b=OSGCzH7a9iwXipiTHXUGo0ViW4DQj+HOpxAD9jdj6SQT3OMsIMINUJqLIoxrv37CEdPivy
 BBYalGl+Hf/j1rPWI5ToSbwXQmb4zIXtemJC726Rt+HykiFddlTIctqsfIt08KH+Wtk5NW
 nmF8FM6EQKMZHFJ7vPOmuIz1BuWLhjk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-OLAyW36-O7m838saNZlsfA-1; Mon, 01 Nov 2021 12:12:55 -0400
X-MC-Unique: OLAyW36-O7m838saNZlsfA-1
Received: by mail-qv1-f69.google.com with SMTP id
 kc11-20020a056214410b00b003886a263a48so13471156qvb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
 b=m8/WGnrr5962NMmC/ZgbIhMUD6tiP8Omp7D8X3d5XbZqe+hc4jAB8YTbFE+Ipmnn5u
 OIQSBIJJ72M5JK0PcO/HcgE1g6dq8HzacGhG01tmejMO3VovVHLbhfTYkxCv+K+n1p8e
 oNNOr5C4vYsax0jiTetsKbC8PKdEOJTatshIMOAgVIY/oUke0RsBBrVaM5WA0dcE2mSg
 PMlZa0IF7JmmnSqFTCXbYIeDYoGa12uNndqL9tRGDjxFm189GzR3ic5qSBJbP+XbYOlt
 vwHkSuzP5aSvOmNbpbngRToKvenpUGhJgrLCUdUFCQm6NlgeObua0soBKBM/0dDnCQUO
 bCoA==
X-Gm-Message-State: AOAM530LKk/8syx0rfSzHhuUSVtLW4exy82knDt39veI7TIoY+w2LreE
 x5gep3A1kT6BnvkiT0E4mV+WzLEYzM4ZJKUspgQrzMrECtRoEPeZKBlpbB8hXU0D4XOgcFRbpJd
 cYsH+PhHJ7l5nLn7xwiTc3o+BwTxDlWa8rEwKeDj4
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264795qvn.62.1635783175421; 
 Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/H7B1fdn7PP13//AwKmpta1av9FRTtOajPRoBskVHgoJcCnXd+0D44u/s4udzcALoTqA+Rw==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264758qvn.62.1635783175189; 
 Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id v16sm167031qtw.90.2021.11.01.09.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:12:54 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:12:53 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
Message-ID: <YYASBVuorCedsnRL@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-2-hch@lst.de>
 <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
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

On Wed, Oct 27 2021 at  4:53P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The device mapper DAX support is all hanging off a block device and thus
> > can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> > of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> > be built under CONFIG_FS_DAX now.
> 
> Looks good.
> 
> Mike, can I get an ack to take this through nvdimm.git? (you'll likely
> see me repeat this question on subsequent patches in this series).

Sorry for late reply, but I see you punted on pushing for 5.16 merge
anyway (I'm sure my lack of response didn't help, sorry about that).

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
