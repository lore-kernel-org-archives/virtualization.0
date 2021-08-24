Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54735C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 10:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC5061265
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 10:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFC5061265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B080F40365;
	Tue, 24 Aug 2021 10:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id admMJ69O5gVQ; Tue, 24 Aug 2021 10:05:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98153400BA;
	Tue, 24 Aug 2021 10:05:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79D83C0010;
	Tue, 24 Aug 2021 10:05:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34672C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 214C440365
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kd2dNvAloei4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5837400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629799528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=acXZTsv+ZGRCIMsgyzotp4JqHaREWpj8Vd1U498dQK8=;
 b=WjwNCwr8K1nqqWbWHHfhLtIeigItP/QyG3TKHyE30g8rkYtAsT7TA4Pz1EjX0fu5hD7gVU
 9DxL3zj+8FiH/fU56jx6UCJnQ5sajvGAk18Nw1aqRmbYOJ9ZEsTmCSG4mnVbWQB1yOOdcI
 7ODbpDYzyiYu9hJnsRx/FC+TuYQQN+Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-G6kCMem7PSeihRHatcgP9w-1; Tue, 24 Aug 2021 06:05:27 -0400
X-MC-Unique: G6kCMem7PSeihRHatcgP9w-1
Received: by mail-ej1-f72.google.com with SMTP id
 o7-20020a170906288700b005bb05cb6e25so6876610ejd.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 03:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=acXZTsv+ZGRCIMsgyzotp4JqHaREWpj8Vd1U498dQK8=;
 b=NoeRcA8gyBix3iroy7RuA09EE4e/fRhktFCOHasYyBqqAyke4Sr9M3m+xuBJlcj4GA
 gU/aWByeEJAMzd5VRJwos4+adfEETvturP2l4+ElwkDjQjYIc1sFd24GfReIKlpL+kom
 8KM8iNlquE1OekMapsG845l1HM6NoVRtgBubacKc/RZlvU78AVw+oJhES14IHYdI6bBJ
 r37IoXb5nOe2rb5i8iQdMCKFmwTSxQMbQEvBAS8LGklmLc68nK75fih36QfKoXBnfl4I
 MnosqyDyADCybRXIc2PbykvC/A49FUPQDAVcjhaFW7tOy7MkCcBjRBv13gO5NbRBvBZu
 5Ajw==
X-Gm-Message-State: AOAM532SltVxMcnRMxZklxHIDxf1aplQYmFRIkZJRZgkoDBeM/dFcCKr
 Dlx0cWbiQKzGI2q+a52FloHfcT8qSWbCDkHdlD3cfn8uKACP4t0+qX59Z9uOBfNqpSifFhbNMwQ
 0+pKIZt4zpygnEZVfU9ZnHSSh/ZsTlwCgSgqVlYtVTQ==
X-Received: by 2002:a05:6402:5206:: with SMTP id
 s6mr42111202edd.151.1629799526228; 
 Tue, 24 Aug 2021 03:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI44Z4judGCzN7R2zpOlFSwZBSbEmkd/UBfNZmHvvZCXJIff7B6uB+tsb4YfaMzeFQo6RVNA==
X-Received: by 2002:a05:6402:5206:: with SMTP id
 s6mr42111185edd.151.1629799526106; 
 Tue, 24 Aug 2021 03:05:26 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id k21sm8853122ejj.55.2021.08.24.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 03:05:25 -0700 (PDT)
Date: Tue, 24 Aug 2021 12:05:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210824100523.yn5hgiycz2ysdnvm@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <3f3fc268-10fc-1917-32c2-dc0e7737dc48@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <3f3fc268-10fc-1917-32c2-dc0e7737dc48@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

Hi Arseny,

On Mon, Aug 23, 2021 at 09:41:16PM +0300, Arseny Krasnov wrote:
>Hello, please ping :)
>

Sorry, I was off last week.
I left some minor comments in the patches.

Let's wait a bit for other comments before next version, also on the 
spec, then I think you can send the next version without RFC tag.
The target should be the net-next tree, since this is a new feature.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
