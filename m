Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3BC47087
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 14:08:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1516142C
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 14:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1516142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84B36403BD;
	Tue, 25 May 2021 14:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zjyWrcgGRwra; Tue, 25 May 2021 14:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45967401B7;
	Tue, 25 May 2021 14:08:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF461C000E;
	Tue, 25 May 2021 14:08:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8177C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C578A4027B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIDqWAk0ARQg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:08:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6369B40248
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621951702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6JWIrp1X2QWT7DZ7p/eDKEr77BtjgN6Key1F3L5mgM=;
 b=YZed9KBVS/VAiy91UJH98frlnaKnZyTgnXt4V/ezUEiKPwg/s7F41SqmGRAirZpua5MJGU
 CZDt1yzXZ/074nyZgA5eCw0klcg5tVVEGt4llnzORDSTVzy/8EkPtYQPPC3Wm0CMzlENfV
 F5hRscNObifwRqNhb979S2aVyxlqp5Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-2Abnha-4M9iJmLv8mx6SGQ-1; Tue, 25 May 2021 10:08:20 -0400
X-MC-Unique: 2Abnha-4M9iJmLv8mx6SGQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 i3-20020aa7dd030000b029038ce772ffe4so17528566edv.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C6JWIrp1X2QWT7DZ7p/eDKEr77BtjgN6Key1F3L5mgM=;
 b=a6ti78Zj8Y/AoCFJQNnPK9y8V7rt4yIINdQzLsIWeHfWmaH1R5WxU6ooF1zWiA8GDK
 0b9GQQsd2hyBLE+Cci08vni74FznsHr6WepiZRG3MxBk5NiyUxgmZ5O/rl/4x/Fc8rvF
 LMLU0B0UVQUbdyqpncjffmzjBRqQ8leDp/excC4ZW9cGV10bNcntveYf8dwPh9KffE3R
 mwcZhWv8FhEHi5WYuNPO9xnWXYlNSQVu9JuepSrGflRvXW9YJ0qyf/N4nQTPvzwR5NbP
 n/QSZDiK6Dz6+LbLBuk7cQLoF64/+1VYRJI+azppEyWLILg5yukTynWG/7ruNbv8HxvG
 fVVA==
X-Gm-Message-State: AOAM531Ij46ntyB6F1IDtn2+JzxwEOp9hP33j6Zv4GTRFfimtK9ROnWh
 t8Zbg2uZrPO+27wBFTAt257jg+Fnb75KGq40mpJrodl4OZODBxijsvZg0AVnI8fIKf2NgJ5zFmc
 D1Bcl4kfTUXEl29UybPnlZZg+MuDRdM0eN5SnFfnujA==
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr29324500ejc.1.1621951699060; 
 Tue, 25 May 2021 07:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ8NCBc55GgItfBceAaBuINHwCsxN0ByhZnfYq7Pj5KNr0oNXheshEkj931t4BMHAxbsJicQ==
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr29324460ejc.1.1621951698877; 
 Tue, 25 May 2021 07:08:18 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id gt12sm9078897ejb.60.2021.05.25.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 07:08:18 -0700 (PDT)
Date: Tue, 25 May 2021 16:08:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 04/18] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210525140816.btiv5v6e3vguxxun@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 20, 2021 at 10:16:08PM +0300, Arseny Krasnov wrote:
>Add receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there are differences:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside one loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>
> include/net/af_vsock.h   |  4 +++
> net/vmw_vsock/af_vsock.c | 72 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 75 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
