Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65627C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 08:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECB8061212;
	Fri, 27 Jan 2023 08:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECB8061212
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WQojwCH0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yemYQWwHTMyQ; Fri, 27 Jan 2023 08:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7DFF3611B2;
	Fri, 27 Jan 2023 08:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DFF3611B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53AA7C0032;
	Fri, 27 Jan 2023 08:16:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7EDAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7480F8283D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7480F8283D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WQojwCH0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8OSHoguh7aZG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:16:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC69A8282C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC69A8282C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674807370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWjslA7V36Tnq5X4Dk1DPZb0FqrAbkUAfwliGUEUMn0=;
 b=WQojwCH0MZQHZag3tZfs7suDahMJ8uNYS1MyF8cXP+gSrgKGN+bsn5rWFqJ9kcoa+Tlp20
 wcx9FQFrbE1fl2ph/ol6ZUEnJjLqLWYIpn3sET3VA87LpjiShrDeti+wCeBNTsLXSNZw9e
 v0WfoU+yD4iv3ir/8s34MEROEzyo/7U=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-u7EbOnuWPKGUAqkBUdAK3g-1; Fri, 27 Jan 2023 03:16:08 -0500
X-MC-Unique: u7EbOnuWPKGUAqkBUdAK3g-1
Received: by mail-vk1-f199.google.com with SMTP id
 x22-20020a1f3116000000b003c67dc01d12so1665002vkx.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 00:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWjslA7V36Tnq5X4Dk1DPZb0FqrAbkUAfwliGUEUMn0=;
 b=BwSzsKxmrdFU/a5naDv2fVfVtgQ0ktn+hqzs7YEnXZk5VzqBiKnP4PW92c0SUKbYyR
 JiydjNBb0DSYROUvX7y0gjxNaqFsPw3KEHZW5DdAc3EZIfY356/jUyKk/pJM+LPok8+P
 IWXPHr3EfPCtGDZoH2aFOnRXIHJTtCcaweng9fxfahTC0LolyzylPTNgsdYy7PH/KMsz
 6JDQ63goyCYwt4RXhBcXADSEsjVJ+LIXKewze+Klcl2pCFTH+mqOUeqMHWb95gAxjZy4
 xB56JYH5+WR9IT6z0TrPQKSY+UjVYFyfYdwjS1gZeA33HGU9QmQzBG8Zsb5KBbFuwFlX
 5zrQ==
X-Gm-Message-State: AO0yUKUdGU4PT7hRO5tBO6auCSkg5iau6y3X/KnmUiTR4ryChp2hohF+
 D/Oo7JIYYsx2o6osKhMOWCLsUOGSQuLjvC2h9/NrC1P0JwxvXVYFt3vrbBdec96KMSzE22btM8c
 Lxre7NcprcSs7NHynvRRjf1Zs7AGqwywxEIsIafSj/Q==
X-Received: by 2002:a67:e195:0:b0:3ce:e81e:323f with SMTP id
 e21-20020a67e195000000b003cee81e323fmr2643117vsl.18.1674807367945; 
 Fri, 27 Jan 2023 00:16:07 -0800 (PST)
X-Google-Smtp-Source: AK7set83wBPz4cZHvtA1Pjgz6tb6cyQS95YMCY1akLKhXcmwLtPZvU+PfA3wqagGAeJWgt5/MrBtFA==
X-Received: by 2002:a67:e195:0:b0:3ce:e81e:323f with SMTP id
 e21-20020a67e195000000b003cee81e323fmr2643112vsl.18.1674807367727; 
 Fri, 27 Jan 2023 00:16:07 -0800 (PST)
Received: from redhat.com ([37.19.199.113]) by smtp.gmail.com with ESMTPSA id
 s3-20020a05610201c300b003ef3aba306csm47720vsq.23.2023.01.27.00.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 00:16:07 -0800 (PST)
Date: Fri, 27 Jan 2023 03:16:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
Message-ID: <20230127031524-mutt-send-email-mst@kernel.org>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Did you say you are going to post v4 of this?
I'm dropping this from review for now.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
