Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D56EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 11:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC28B40146;
	Tue, 14 Dec 2021 11:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAUrPmTzmyEl; Tue, 14 Dec 2021 11:12:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB542400E4;
	Tue, 14 Dec 2021 11:12:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A74A0C0038;
	Tue, 14 Dec 2021 11:12:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8ABDC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 11:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79DFE60B57
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 11:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tS9fsoKvkTwv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 11:12:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8DCC60B41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639480347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhEBJGXZFfGYUz+W85L5SMxf6iwehQCfNTkjovdJG5M=;
 b=CocbHTwEjEP9aiWJ5/mX2mDYD5vC2YZf/U3EaxCJh+rzE9/+aJfbRQ0uPPtJb6lbsF07wT
 CEsge+NJVbuvsixkcGGYQ1hkQUNC+tJQ9Pka20bgH6AcK6q1G+y78i7+pLNr3XGOkrg2HK
 ra5ZG2v4sySG6pRduwdBMqux88I6a8A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-al8--b-aPx-GBtRE5F-eEw-1; Tue, 14 Dec 2021 06:12:26 -0500
X-MC-Unique: al8--b-aPx-GBtRE5F-eEw-1
Received: by mail-wr1-f70.google.com with SMTP id
 f5-20020a5d4dc5000000b001a0b1481734so1748752wru.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NhEBJGXZFfGYUz+W85L5SMxf6iwehQCfNTkjovdJG5M=;
 b=QCxqmYUhtNCcMLNjfJZ+pZIWKClxj7BVzKmWasxGcbxTZv3QjxHeT4IQTu7bNKkgPy
 GT55iO/Km/qNJGWfru+5tiBYziCnhMhqIlxswhOIabitS8hGWB9M+2C8yMtftl2pCi5x
 OZLQH6tnwZ8xKKewa0Zo9iN7o47IhpJFzgEiVOQcC02GyG3M1Oj/EozNIqyzaK8cvWH8
 Jmivwyl5qx/oR2Mtvo52ozKSQTV6Umjm600VFCGOlxJLi5nRmZJJjsLPaaDRu3P2js7T
 TVTQ9Co8jRURJZlwiV179XVzEeU/EcMbwrO+8ALx2XNvvf6WqzP1u9zQg2cFZYWoJN+s
 xQIQ==
X-Gm-Message-State: AOAM533tdKzHaKsOr3UmxtpMfvLeJaXEhN76EvP3fXVoJ2bLNbW3GMOs
 WbVslne5BFOouzh93J0uaGkNlnvj1nOaWycTl7fuwQyYIMg5nMUByzoFRvJOTND2Mg/Tv8cIr4K
 BwzA4NeiJHMGGHM3wDYuNcGp5qLhGstfzhM582apu2w==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr4970173wrz.286.1639480344916; 
 Tue, 14 Dec 2021 03:12:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFYBnaaLlG5u868auQajpx3Q+vEL9m2bZT4jvzWvMdYLS7h21aWLOaz+1MyPC1CpQbjd1ozw==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr4970128wrz.286.1639480344544; 
 Tue, 14 Dec 2021 03:12:24 -0800 (PST)
Received: from steredhat (host-87-21-203-138.retail.telecomitalia.it.
 [87.21.203.138])
 by smtp.gmail.com with ESMTPSA id m3sm13625927wrv.95.2021.12.14.03.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 03:12:24 -0800 (PST)
Date: Tue, 14 Dec 2021 12:12:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
Message-ID: <20211214111221.c3giy22fjh25jux2@steredhat>
References: <20211213144258.179984-1-elic@nvidia.com>
 <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
 <20211214094235.6uzzxigykd76o6uq@steredhat>
 <20211214095303.GA94217@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20211214095303.GA94217@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 virtualization-owner@lists.linux-foundation.org
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

On Tue, Dec 14, 2021 at 11:53:03AM +0200, Eli Cohen wrote:
>On Tue, Dec 14, 2021 at 10:42:35AM +0100, Stefano Garzarella wrote:
>> Hi Eli,
>> I don't know what's wrong, but I've only received replies through the
>> virtualization@lists.linux-foundation.org mailing list.
>>
>> Even in the archive I can't find your original series.
>>
>> Adding virtualization-owner@lists.linux-foundation.org to double check
>> what's going wrong.
>
>OK, let me know if you want me to send you the patches. I am going to
>send a new series and can put you on CC.

I'll look at the new series.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
