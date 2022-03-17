Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E703C4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 08:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A995E84359;
	Thu, 17 Mar 2022 08:49:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-TVrsbowYyx; Thu, 17 Mar 2022 08:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E4B481450;
	Thu, 17 Mar 2022 08:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F85EC0012;
	Thu, 17 Mar 2022 08:49:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7F22C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D7D540487
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H1i59cb_idZj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:49:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6940A4000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647506948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gz/W/pn91Pd0cp+FBSUWrFfqAy7FqwqHAAG9hudoc3k=;
 b=eISSKLK8qX9wW9FtaYNMLuj6nnnMb/4AEkKTzPb8Qg6sShy7zaL4LLm0EcEroZkdgT3QVH
 f9hxztUtpO3GoWSvK9matt6QrbpxHysLN7ZFzb9g1pViJMjq2omd78LJWr4jCGtUb/ys6a
 +MKEGZzmbL5GZ720KhxnhPIqY2QSQ/M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-57dCw5uKPs6UilQAqil0KA-1; Thu, 17 Mar 2022 04:49:07 -0400
X-MC-Unique: 57dCw5uKPs6UilQAqil0KA-1
Received: by mail-qv1-f72.google.com with SMTP id
 dj3-20020a056214090300b004354a9c60aaso3562301qvb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 01:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gz/W/pn91Pd0cp+FBSUWrFfqAy7FqwqHAAG9hudoc3k=;
 b=k2j0fVmvZUJ+69n2boaNh8bi7S545hhW3UN/GxYiPpq2au0/xTTiKEvXdtj39g4W5Z
 0XxPUxN1LB7E+3Uw2YgiQprzSudlKIq5H3Gt4OumJJ+rOHo4GRp4YVL1M7Vi82R9bAV7
 nTDAv7xAJJ5nmfZs/ZvdtEYGiEiPHre4y+8ifPVogVETwahiMvDGJ463OmzvuVeWeH3U
 y03evo9qULF8IpVAs68Do0uKBsped3BiRRo7qqOu2R6TuXzV2PHk6i5lJt1Srk++0bf7
 1n9IBNZkVkQzhW1oQlBcTEOeiTN7y9vOYe2Im7PCCQI75Y90o5NCI0ey3fU5ed+7Q+up
 35rQ==
X-Gm-Message-State: AOAM530UuPdmwgbly35uqhucf6mCSa00x7Lv9OrpzKYZM4vKDN0Z1ga8
 MJxU/jqycrI4rY7AZnl56630pHIy0xUGm0NP48v1bcXcIiaQy3AxQVDV2YlfOgTdEg5PI2aWub0
 ZlVsXDRpVClcY5vbM7ti6/oqKq3GIfBvzAH4Bfe4g+Q==
X-Received: by 2002:a05:6214:20ac:b0:435:bc08:3fee with SMTP id
 12-20020a05621420ac00b00435bc083feemr2637722qvd.62.1647506946709; 
 Thu, 17 Mar 2022 01:49:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfxE61qldB187jrMNs+6ZiPIrvfd4dvExZrtE1N5vj69apnHkdN+sVPDMzutJ+kVJuhUJMSA==
X-Received: by 2002:a05:6214:20ac:b0:435:bc08:3fee with SMTP id
 12-20020a05621420ac00b00435bc083feemr2637709qvd.62.1647506946520; 
 Thu, 17 Mar 2022 01:49:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-42-202-12.retail.telecomitalia.it.
 [79.42.202.12]) by smtp.gmail.com with ESMTPSA id
 s64-20020a375e43000000b0067b0e68092csm2249499qkb.91.2022.03.17.01.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 01:49:05 -0700 (PDT)
Date: Thu, 17 Mar 2022 09:49:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v4 1/2] af_vsock: SOCK_SEQPACKET receive timeout
 test
Message-ID: <20220317084900.e5nxahx4ize2wfcj@sgarzare-redhat>
References: <97d6d8c6-f7b2-1b03-a3d9-f312c33134ec@sberdevices.ru>
 <3cf108a3-e57f-abf8-e82f-6d6e80c4a37a@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <3cf108a3-e57f-abf8-e82f-6d6e80c4a37a@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Thu, Mar 17, 2022 at 08:31:49AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Test for receive timeout check: connection is established,
>receiver sets timeout, but sender does nothing. Receiver's
>'read()' call must return EAGAIN.
>
>Signed-off-by: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
>---
> v3 -> v4:
> 1) Fix stupid bug about invalid 'if()' line.
>
> tools/testing/vsock/vsock_test.c | 84 ++++++++++++++++++++++++++++++++
> 1 file changed, 84 insertions(+)

Everything is okay now, tests pass and the patch looks good to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
