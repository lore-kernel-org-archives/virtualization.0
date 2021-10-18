Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F60C433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 09:15:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04DC6103B
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 09:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D04DC6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2C4C8258D;
	Mon, 18 Oct 2021 09:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3f7lscf5cSgZ; Mon, 18 Oct 2021 09:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6814182404;
	Mon, 18 Oct 2021 09:15:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50B59C000F;
	Mon, 18 Oct 2021 09:15:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2257EC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1060D402BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-0gBphYjvDa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39581400FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634548552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTN8zOIfI1WvHf0Oikwm+Yh3KRyiSoNVV6Q4t9QRtZs=;
 b=NwSW3rwQUWsgnM4HrW7zWvoYpNB18gKq+GSsUOvIDPiCponj4fpkun8qH4PN7Rej+K76fp
 jeyO23ZAml4jsussruFNp7vE0f8FrV6VemzKevVJEDPcX2jlnKdMorqqwasTICeoxx79ow
 WtANuYHfZr2YcH/kBoSgVHam46nxH74=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-kFzbdB22OfGmgIhta6P-Yg-1; Mon, 18 Oct 2021 05:15:51 -0400
X-MC-Unique: kFzbdB22OfGmgIhta6P-Yg-1
Received: by mail-ed1-f69.google.com with SMTP id
 z23-20020aa7cf97000000b003db7be405e1so13814577edx.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 02:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uTN8zOIfI1WvHf0Oikwm+Yh3KRyiSoNVV6Q4t9QRtZs=;
 b=SCuvpRysmqjA1zMret8BK0jPlUg7s8R6z3ROI8L9psw/H9F67Bm7ZKUTc7sCxHBmou
 YAOKmcIBf/mdRGbrcVrEgkJHPl7NZBDg9g1xfcnTDr1hWdqMrdhwCvkaZaWUDFPP1rp2
 EQmAXa9bmBUxlUXat6tjic6EJrDSAms5vTK6u5TWWnWKfihce03p7ThLSumxsnUWWZ+O
 hhdXkNir/r8l+8BEMc2xynJ4yFxj27Uk7oYyYlqJbsQbop1P5r8hFA7jr1yqiTfTKczo
 Bvh+RWP8527sq1und08CxPnKcRhsfiuNS6EETYsZ5X7WX562KnlhWpeoDgyH+MpHIFp0
 W08A==
X-Gm-Message-State: AOAM532PJ4W8TAaKHBK9QNwiYdhJtY8XBgQKUhlDiW9/1GZl8mNw2nk6
 LQHDE/O/qPJb1I2AFAk690Iz1mjzOWxXLIaVErXLhF5lde3japL6fcTQsSDWj3x+yvln5uJlPe7
 5YZuNuA+Oo+WeivfsaEgzLGRTP0MEt6Po6a19p3txrw==
X-Received: by 2002:aa7:cb41:: with SMTP id w1mr43209727edt.327.1634548549943; 
 Mon, 18 Oct 2021 02:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx30oIX/+Ug3FvHspHTtkdF7zPjyCzKUtAKQWRcXsp4Wh/D1lfCsh9jDf0+zgx3GqNnqtcnzw==
X-Received: by 2002:aa7:cb41:: with SMTP id w1mr43209709edt.327.1634548549772; 
 Mon, 18 Oct 2021 02:15:49 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it.
 [79.34.250.211])
 by smtp.gmail.com with ESMTPSA id e13sm8494236eje.95.2021.10.18.02.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 02:15:49 -0700 (PDT)
Date: Mon, 18 Oct 2021 11:15:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 2/3] vdpa: Add vhost_vdpa_section_end
Message-ID: <20211018091547.4l6mscjuqhyi2rr3@steredhat>
References: <20211014141236.923287-1-eperezma@redhat.com>
 <20211014141236.923287-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211014141236.923287-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 14, 2021 at 04:12:35PM +0200, Eugenio P=E9rez wrote:
>Abstract this operation, that will be reused when validating the region
>against the iova range that the device supports.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> hw/virtio/vhost-vdpa.c | 22 +++++++++++++++-------
> 1 file changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
