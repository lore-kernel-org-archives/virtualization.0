Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F21C433FE
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 08:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DDC482A56;
	Thu, 17 Feb 2022 08:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXRMC8YW-2Mf; Thu, 17 Feb 2022 08:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 410738284B;
	Thu, 17 Feb 2022 08:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C973C0011;
	Thu, 17 Feb 2022 08:34:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9B99C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 08:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0DA0409C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 08:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wn_7Smq4REqo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 08:34:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E32FE40995
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 08:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645086863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hhpl+rzufZ4HpgJzL8RSu4UiBBIjnQJwZAboaAQxVZk=;
 b=JLPKoBNMBZ04PZs36ZPLUmTI04olUKV6Tuam1EgUgH7D9uuVnwcut8N06csD+w8sy4uDF3
 TRiL7Xvuz6NlhezHI/Qcl9ucBBSxa02i7r3OYiqlkDnFKplU6pZ2/QA7irp2+lEbThcghm
 yXz+0qxg64Jr+EN4GUFPupxysXtobMQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-IGHeEJSePvCEv_RTxGxRNA-1; Thu, 17 Feb 2022 03:34:19 -0500
X-MC-Unique: IGHeEJSePvCEv_RTxGxRNA-1
Received: by mail-ed1-f69.google.com with SMTP id
 k5-20020a508ac5000000b00408dec8390aso3065873edk.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 00:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hhpl+rzufZ4HpgJzL8RSu4UiBBIjnQJwZAboaAQxVZk=;
 b=Hu22SJLaLj8azE+5Q4qGzoI7dUsH9FnWNU3ybiP99uCXTlopBEPsBeph/7tIIwt2ay
 U6VbQpveEwdfWCQWKbEAz+hIXifn8oMhISaVXTIaqYyLIuOEZVC+5TkFWrNW3RXm6qbD
 yn9SMaKK/+peYC8Xgh1KPfbNuppuDWMLXknd+RF3sEyHj6pnE8T9Ywz38E5Y7eOD++mi
 1JjOt0e3YtEU3atpgHZ3z2Ol0CVVmxlr2SXndBKVWVb1hhQsVYI2nypWDQuwI3zEuwq0
 JdRTnUrtjzDqF1m8KCHt54zFzKpeoDhdPjbQRpdjzz6eSv8x6YQlnVL1gVVsquLcvGAy
 NZ7g==
X-Gm-Message-State: AOAM5326hYRLEcUZnAj3MGRWyC1sMgzteRwXknoz1yI8o/0OsdSEFeia
 O7Fy9gT8YYztPumTzKtdxWXM6PYgghqtvQtsGAkFtwHl6vFXnYli13DwguGmy6QO2JQG7mqpE/S
 Dc2Qbnn/nm0Ld6MM+SX1A5akYg7b4Gtp38BxZEfodhw==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id
 n23-20020a1709062bd700b006cdf89dc828mr1535792ejg.232.1645086858353; 
 Thu, 17 Feb 2022 00:34:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWeBziOjg1wr7D46Vg3PrFPzezNZQTlS0tbQ74/7RcIcGsZSR6aR8D0exZ1cCEkVQvZNAJMQ==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id
 n23-20020a1709062bd700b006cdf89dc828mr1535783ejg.232.1645086858124; 
 Thu, 17 Feb 2022 00:34:18 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id b4sm926960ejv.108.2022.02.17.00.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 00:34:17 -0800 (PST)
Date: Thu, 17 Feb 2022 09:34:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH] vsock: remove vsock from connected table when connect is
 interrupted by a signal
Message-ID: <20220217083411.rjb2em2vf6hcgo64@sgarzare-redhat>
References: <20220216143222.1614690-1-sforshee@digitalocean.com>
 <20220216161122.eacdfgljg2c6yeby@sgarzare-redhat>
 <20220216201459.5a5b58e9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20220216201459.5a5b58e9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 16, 2022 at 08:14:59PM -0800, Jakub Kicinski wrote:
>On Wed, 16 Feb 2022 17:11:22 +0100 Stefano Garzarella wrote:
>> On Wed, Feb 16, 2022 at 08:32:22AM -0600, Seth Forshee wrote:
>> >vsock_connect() expects that the socket could already be in the
>> >TCP_ESTABLISHED state when the connecting task wakes up with a signal
>> >pending. If this happens the socket will be in the connected table, and
>> >it is not removed when the socket state is reset. In this situation it's
>> >common for the process to retry connect(), and if the connection is
>> >successful the socket will be added to the connected table a second
>> >time, corrupting the list.
>> >
>> >Prevent this by calling vsock_remove_connected() if a signal is received
>> >while waiting for a connection. This is harmless if the socket is not in
>> >the connected table, and if it is in the table then removing it will
>> >prevent list corruption from a double add.
>> >
>> >Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 1 +
>> > 1 file changed, 1 insertion(+)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 3235261f138d..38baeb189d4e 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1401,6 +1401,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>> > 			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>> > 			sock->state = SS_UNCONNECTED;
>> > 			vsock_transport_cancel_pkt(vsk);
>> >+			vsock_remove_connected(vsk);
>> > 			goto out_wait;
>> > 		} else if (timeout == 0) {
>> > 			err = -ETIMEDOUT;
>>
>> Thanks for this fix! The patch LGTM:
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>>
>> @Dave, @Jakub, since we need this also in stable branches, I was going
>> to suggest adding a Fixes tag, but I'm a little confused: the issue
>> seems to have always been there, so from commit d021c344051a ("VSOCK:
>> Introduce VM Sockets"), but to use vsock_remove_connected() as we are
>> using in this patch, we really need commit d5afa82c977e ("vsock: correct
>> removal of socket from the list").
>>
>> Commit d5afa82c977e was introduces in v5.3 and it was backported in
>> v4.19 and v4.14, but not in v4.9.
>> So if we want to backport this patch also for v4.9, I think we need
>> commit d5afa82c977e as well.
>
>The fixes tag sounds good. Dunno what's the best way to handle this
>case. We can add a mention of the dependency to the patch description.
>Personally I'd keep things simple, add the Fixes tag and keep an eye
>on the backports, if 4.9 doesn't get it - email Greg and explain.
>

Okay, I'll keep an eye on this patch for 4.9.

@Seth, can you send a v2 mentioning the dependency with commit 
d5afa82c977e ("vsock: correct removal of socket from the list") and 
adding the following fixes tag?

     Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
