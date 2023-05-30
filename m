Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D446AC77B7A
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 15:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CF4981E97;
	Tue, 30 May 2023 15:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CF4981E97
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AYUnknhg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XrLhihmdNoFb; Tue, 30 May 2023 15:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC4E181BB0;
	Tue, 30 May 2023 15:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC4E181BB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9327BC0035;
	Tue, 30 May 2023 15:18:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A2EBC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 15:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25C4C415F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 15:18:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25C4C415F2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AYUnknhg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtuS1o6201hz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 15:18:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 294BB415AE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 294BB415AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685459933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzUmgv4c0PPfLXFfcu4AEjs2wLKMpfg6cT4UKZmFGvQ=;
 b=AYUnknhgeQyC/AhbPz5xiH36ve7hqOlpxG9Tx1nFzKodamXqMV8vH7lzspsxmWu7RowMdR
 R1UtpZe9mTEHpn4sK5H1HcsAU14KlRJ/zO61YsX+HdkectgwShpn3qs4RwKEoRi9bs7hV0
 kmm3Ad5fWyO90rq2DhVFk1pmLcLt7eU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618--ejvRYHDPwGaMEWsTvM7eQ-1; Tue, 30 May 2023 11:18:51 -0400
X-MC-Unique: -ejvRYHDPwGaMEWsTvM7eQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6069f764bso77279555e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 08:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459930; x=1688051930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzUmgv4c0PPfLXFfcu4AEjs2wLKMpfg6cT4UKZmFGvQ=;
 b=MusFY6H5CsGowjWgJMlyqvxyxeGqw0HpoP9dEZ8rC4QREoEdaNr4JKvT08adDF2LGM
 u9lgmIzI+njNKjGaIgRgsiLRCpN+XEVgnRtzuX1Zq2OcHXqlQGg3NaYvSg4WPuCV1QjU
 9OQGaUx5CfUxY7hb+OduLOskF4omsRhMMWga4QqVZA5XBhshtHES/HpLdH1Ot7/KfL0k
 BUskNeMLjAZX9xEM9DJ2aGVAAhb+YH0ZB1PtegKVz6iChAnAIvNmueN4dZDfSeZ7fdST
 FnlvoQAavj3Tt0mbJMEt8O9IiitQCrMX++H3Vext4zgoDxLq5lSewrdYLDDyxUw1qJNE
 gFcQ==
X-Gm-Message-State: AC+VfDxXARaH2yXuVAb34k/4dVMPbNhh38uzhar4720zgDh61ebqfYZG
 xQKIMtRGQGN9Pup+/nbz3smwnoA5gxK+yjGXDhxH9/PCjvZPh8kjFb5QueYHELEvUOkgks2I+6y
 FMUW+UReDeYlWp3lg814tU3NX1opzSSsJv5NixUtHyQ==
X-Received: by 2002:a05:600c:2208:b0:3f6:a66:a36d with SMTP id
 z8-20020a05600c220800b003f60a66a36dmr1945448wml.10.1685459930665; 
 Tue, 30 May 2023 08:18:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67j8zXMzDSexJ/DlnFeRckDXeWoBOmhzeJlskTQXAtICps4DBhodE0KhKNReQJ7N+WmLdGVw==
X-Received: by 2002:a05:600c:2208:b0:3f6:a66:a36d with SMTP id
 z8-20020a05600c220800b003f60a66a36dmr1945441wml.10.1685459930398; 
 Tue, 30 May 2023 08:18:50 -0700 (PDT)
Received: from redhat.com ([2.52.11.69]) by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b003f09d7b6e20sm17727697wmj.2.2023.05.30.08.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 08:18:49 -0700 (PDT)
Date: Tue, 30 May 2023 11:18:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v1] virtio-pci: Improve code style for including header
 files
Message-ID: <20230530111818-mutt-send-email-mst@kernel.org>
References: <20230529181729.15745-1-feliu@nvidia.com>
 <20230530072642-mutt-send-email-mst@kernel.org>
 <9d183df9-7047-0eee-b6d4-b0f9b8d21036@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <9d183df9-7047-0eee-b6d4-b0f9b8d21036@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jiri Pirko <jiri@nvidia.com>,
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

On Tue, May 30, 2023 at 10:07:23AM -0400, Feng Liu wrote:
> 
> 
> On 2023-05-30 a.m.7:27, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, May 29, 2023 at 02:17:29PM -0400, Feng Liu wrote:
> > > Fix code style related to including header file. Include header files
> > > before declaring macro definitions to avoid conflicts.
> > > 
> > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > 
> > Which conflicts? These macros are there precisely to change
> > how the header behaves.
> > 
> 
> Hi Michael
>     I think including the header files should be placed before the macro
> definition.
>     If VIRTIO_PCI_NO_LEGACY and VIRTIO_RING_NO_LEGACY are needed for control
> header file, we should put them at the beginning of virtio_pci_common.h.
> 
> What do you think?

I think you should read the code in question not make guesses.

> > > ---
> > >   drivers/virtio/virtio_pci_modern.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index d6bb68ba84e5..b21a489e0086 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -15,9 +15,10 @@
> > >    */
> > > 
> > >   #include <linux/delay.h>
> > > +#include "virtio_pci_common.h"
> > > +
> > >   #define VIRTIO_PCI_NO_LEGACY
> > >   #define VIRTIO_RING_NO_LEGACY
> > > -#include "virtio_pci_common.h"
> > > 
> > >   static u64 vp_get_features(struct virtio_device *vdev)
> > >   {
> > > --
> > > 2.37.1 (Apple Git-137.1)
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
