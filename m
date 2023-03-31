Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA64C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 096AC4219D;
	Fri, 31 Mar 2023 07:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 096AC4219D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ce5FqbD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVnIhtbgLz51; Fri, 31 Mar 2023 07:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BAF742099;
	Fri, 31 Mar 2023 07:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BAF742099
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2502BC0036;
	Fri, 31 Mar 2023 07:15:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39024C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13F4E40578
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13F4E40578
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ce5FqbD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2TnDlvLjOKah
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:15:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EC77400F3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EC77400F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680246909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWMFK/padud2qL2Yu5nuVXmsRK2hLBvg6h75c5M7KFw=;
 b=ce5FqbD973OR0uuL9me7U+UlE7kjD9jWV0CFfgp99sQd2jvtcqvTNNrCYmbnWJ0t8TUHJ3
 xmrBvRGEvO13hjF7wIiWYpoRdcHLcSI/hpm21HSENmuhBZ30in5dEejTCaSgW0OM1bRRl6
 77lkcXdlS07F/lmygAW7Z8TMiXzjWeU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-AyKaYg0XOo26ZIvDu7wDOA-1; Fri, 31 Mar 2023 03:15:07 -0400
X-MC-Unique: AyKaYg0XOo26ZIvDu7wDOA-1
Received: by mail-ed1-f72.google.com with SMTP id
 x35-20020a50baa6000000b005021d1b1e9eso30751223ede.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 00:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680246906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWMFK/padud2qL2Yu5nuVXmsRK2hLBvg6h75c5M7KFw=;
 b=Alcydo2UhqscaRdAbgS6EkK/LQPwVqBh7aYhwjzTuf81uViGKk5stBwVxPkbW7eZ0m
 JIKXR4gpTfqzSSfQtJmSe19d8fd0eJSTC0k/D6T52NCVSK9issVBGZZSfM+sN+IIvXVe
 M6/mUx2q0xhAQSiQoypQl1gsXeT6wp0jOOWRfhuqw4VxqJhr4If9fsjuXWQq+oLSx1hD
 a0xD7z/Bya9mT0OSO0j6k3s0yylQgxIU1p2/Mho5Q7JlZuVSXlWfykixzq7KvcWTt4oN
 L3wJQ3LSxKxd/7MEkOyV6aXdiOFfBqeEhcK7QM6aQ6KWh6UBwRX4jCe2dpFAQDu6nQ9D
 WLnw==
X-Gm-Message-State: AAQBX9ccxisX/wjAmkUuXDHjZPGaVWKSBoILFu5fpqViI+TFOCch++QN
 mjdVUfQJvBEEqueFAKo198Jb33d2cYvOfAKWCeU/idje+GjZ1Y0pZsyER+Jk3Cnh8p4EIGjczNt
 ymFDEAeY9spk+nIpFCTDMcJkUwXCLToTbuPdBBVKufg==
X-Received: by 2002:a17:907:6d83:b0:947:6ce9:705d with SMTP id
 sb3-20020a1709076d8300b009476ce9705dmr5436212ejc.55.1680246906173; 
 Fri, 31 Mar 2023 00:15:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350aZwogAdOwSVJvzr6Pjwq+TBHVkVowx29697Nam/rYpQ8g3Ha6PzoB/NgF8lkggQuyLgeScSw==
X-Received: by 2002:a17:907:6d83:b0:947:6ce9:705d with SMTP id
 sb3-20020a1709076d8300b009476ce9705dmr5436179ejc.55.1680246905861; 
 Fri, 31 Mar 2023 00:15:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 v13-20020a170906b00d00b009373f1b5c4esm649065ejy.161.2023.03.31.00.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 00:15:05 -0700 (PDT)
Date: Fri, 31 Mar 2023 09:15:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/4] vsock/vmci: convert VMCI error code to
 -ENOMEM on send
Message-ID: <rrapkoibcd6p33pmai2egr6isphvbx7rlu6hfj74gsmuih5p2o@kdilyljzs5bm>
References: <dead4842-333a-015e-028b-302151336ff9@sberdevices.ru>
 <a0915a9d-ba41-5a90-0e16-40c2315f0445@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <a0915a9d-ba41-5a90-0e16-40c2315f0445@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Thu, Mar 30, 2023 at 11:12:44PM +0300, Arseniy Krasnov wrote:
>This adds conversion of VMCI specific error code to general -ENOMEM. It
>is needed, because af_vsock.c passes error value returned from transport
>to the user, which does not expect to get VMCI_ERROR_* values.
>
>Fixes: c43170b7e157 ("vsock: return errors other than -ENOMEM to socket")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

The patch LGTM, but I suggest to extract this patch from the series and
send it directly to the net tree, while other patches can be sent to
net-next.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
