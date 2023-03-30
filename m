Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A5EC6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 08:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E174660E03;
	Thu, 30 Mar 2023 08:19:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E174660E03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P7Lxxplv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcp6lKOnf72j; Thu, 30 Mar 2023 08:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82256615DB;
	Thu, 30 Mar 2023 08:19:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82256615DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6071BC0036;
	Thu, 30 Mar 2023 08:19:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C374C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78A31615DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:19:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78A31615DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AqqZbxZE5RyV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CBDF60E03
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CBDF60E03
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680164350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j6eqKpHQyukUldknWnkYJ906zqmkvEYnde83ajid2aw=;
 b=P7Lxxplv9MPtSpcYNKPhFpoQX5w2PRfKFgaPcMNEjK/gVGJWb4lIVJooPp5lMD3dVsLtyO
 LrCb4VZSyrFwjZ1PAKteMLy6Ey9oM26tpvKazWb+hyhJkF39xTnbvZy1GnMGYCiBIFtcn5
 ehckkFf4awKfaASN3/d3tObIA8/Qi5A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-F4d-fGVkP_yAeO3gmi1nww-1; Thu, 30 Mar 2023 04:19:07 -0400
X-MC-Unique: F4d-fGVkP_yAeO3gmi1nww-1
Received: by mail-qv1-f69.google.com with SMTP id
 f3-20020a0cc303000000b005c9966620daso7805403qvi.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 01:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680164347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6eqKpHQyukUldknWnkYJ906zqmkvEYnde83ajid2aw=;
 b=xELMDzI4DiaCA6wyP9ICD5R2PMtdVTJPNg0miiKofZ77WsSgm+x9DRDzEoDax3XiYu
 RLWOPoWSIhXbAExuYEZJV1HW88zvczipMuCBRKIsJvZKan3EGWjw6tc3aqrd9So8u9qw
 hfF0SwJ7mdtXerJG/wE91K5faLD5Fu2D+2wwxYHjy5wVYYHUply1VtppILmoRLwCwN/z
 X4+BLL9jn5E/jOR6N6VUNbKyekF7/0kZD/7dw/YNcq7Sf5G7QJJbvEPMh3vZQRO3fe4v
 ndZfbXGOPB+SlW37GAJLoGaFg+3RCflXauIbgqRRSrZ2gLTzNMRoKWs/OZWmB/P29+qv
 ox3g==
X-Gm-Message-State: AO0yUKXgDBgqxBQSkD/omwMJ6gDuB7eQro53j6hM9qtapCtWlkJLokKE
 1ZpuG0iiCCE4mk1+vrL6nQ6pCtLVt9nzhzbInCoBRunI0zSXiiYjdzK4kS5Ra+fPPukTBS6VM7t
 hgFlVm0Rg1ZJhvQVuBxzh6U4k4bFOdTNuQDWvrw87Mw==
X-Received: by 2002:ac8:5852:0:b0:3dd:f4cd:9457 with SMTP id
 h18-20020ac85852000000b003ddf4cd9457mr33846458qth.10.1680164347092; 
 Thu, 30 Mar 2023 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ZSR8zCgeepFuAa6Qdv4Dz8GV22rVmnZtGEo7xGCKbU5A+Z7X8US2CvtEhcqENxoJDdCpmFg==
X-Received: by 2002:ac8:5852:0:b0:3dd:f4cd:9457 with SMTP id
 h18-20020ac85852000000b003ddf4cd9457mr33846439qth.10.1680164346857; 
 Thu, 30 Mar 2023 01:19:06 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 r14-20020ac867ce000000b003c034837d8fsm16827815qtp.33.2023.03.30.01.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 01:19:06 -0700 (PDT)
Date: Thu, 30 Mar 2023 10:19:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>, Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [RFC PATCH v2 2/3] vsock/vmci: convert VMCI error code to -ENOMEM
Message-ID: <wzkkagpfxfi7nioixpcmz4uscxojilwhuj4joslwevkm25m6h7@z4yl33oe7wqu>
References: <60abc0da-0412-6e25-eeb0-8e32e3ec21e7@sberdevices.ru>
 <94d33849-d3c1-7468-72df-f87f897bafd2@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <94d33849-d3c1-7468-72df-f87f897bafd2@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
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

On Thu, Mar 30, 2023 at 10:07:36AM +0300, Arseniy Krasnov wrote:
>This adds conversion of VMCI specific error code to general -ENOMEM. It
>is needed, because af_vsock.c passes error value returned from transport
>to the user.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport.c | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 36eb16a40745..45de3e75597f 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1831,10 +1831,17 @@ static ssize_t vmci_transport_stream_dequeue(
> 	size_t len,
> 	int flags)
> {
>+	int err;

Please, use the same type returned by the function.

>+
> 	if (flags & MSG_PEEK)
>-		return vmci_qpair_peekv(vmci_trans(vsk)->qpair, msg, len, 0);
>+		err = vmci_qpair_peekv(vmci_trans(vsk)->qpair, msg, len, 0);
> 	else
>-		return vmci_qpair_dequev(vmci_trans(vsk)->qpair, msg, len, 0);
>+		err = vmci_qpair_dequev(vmci_trans(vsk)->qpair, msg, len, 0);
>+
>+	if (err < 0)
>+		err = -ENOMEM;
>+
>+	return err;
> }
>
> static ssize_t vmci_transport_stream_enqueue(
>@@ -1842,7 +1849,13 @@ static ssize_t vmci_transport_stream_enqueue(
> 	struct msghdr *msg,
> 	size_t len)
> {
>-	return vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
>+	int err;

Ditto.

>+
>+	err = vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
>+	if (err < 0)
>+		err = -ENOMEM;
>+
>+	return err;
> }

@Vishnu: should we backport the change for
vmci_transport_stream_enqueue() to stable branches?

In this case I would split this patch and I would send the
vmci_transport_stream_enqueue() change to the net branch including:

Fixes: c43170b7e157 ("vsock: return errors other than -ENOMEM to socket")

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
