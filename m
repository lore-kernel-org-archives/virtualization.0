Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595E9C83F2E
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 15:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF1FA834F5;
	Thu, 31 Aug 2023 15:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF1FA834F5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PlZo130G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C6U9Oz0mw6C1; Thu, 31 Aug 2023 15:01:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 64A6F83449;
	Thu, 31 Aug 2023 15:00:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64A6F83449
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3646FC0071;
	Thu, 31 Aug 2023 15:00:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCB49C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEA9960BD6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:00:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEA9960BD6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PlZo130G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPFLk2_oqbUN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:00:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A4A560B3B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A4A560B3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693494055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vgwa1dB9SPLXrOuebcpc/xedsvZ9jq5rbgcVN4pe9yQ=;
 b=PlZo130GRPz4BlJtUoeXaBxANh6YnYyyHcqSRKL5zbr+lTeKBuF3WfyIGHvwzasPC0xErn
 Aw2hf4TZvuEtuxclp/S9/zbLYq4eAyWSQ41WuiY+4zh4rTD8eA2/xmcdeXzJCsw/t0zh3s
 VZmavZq/uqUt8HS4AzVOX1yQ7aZ+KaM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-H3nSU9m9NJezf2D8WNSADQ-1; Thu, 31 Aug 2023 11:00:53 -0400
X-MC-Unique: H3nSU9m9NJezf2D8WNSADQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355cf318so68005866b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693494052; x=1694098852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgwa1dB9SPLXrOuebcpc/xedsvZ9jq5rbgcVN4pe9yQ=;
 b=PHoZJq8asL4HW6DlxNApkdfdCpWPIawn0/mtkOHE82UYNvKsdh7indH+6DH02fNPRE
 hjrGuAyZ1N4N8XWYIBDPy3hbPt0x/DQgcBluJDw5E4QUg/nNuNIhCMhpQ/IDIuBgY0MP
 d2ScgKQPDu32Il4zsGyt+szJRw/NEqUYz+J8xwGAS1+CkfaQZflRkzGYBwICspOe95sd
 OAtgnvad+K+rzbvmux9RzCh9tx+LGGggXwoYltnqXneqsjrnEhM7Em6GeeE++xvpfyZi
 3bFqikCEtLD9d2UKdUZ65XbDLT62l8AP9ANqHUVH8ii5OyFQwHyCLYcEDzyMwUcBEoyl
 B2+w==
X-Gm-Message-State: AOJu0YxJs5Oeu0xKIupj7toOPt+9hpdLZ4PnDeYK6xBGH4GXrJrgrehb
 bTuz8OgjAnr98fbZbVWiHfN5R6ys52SGKkYH8MYQ45iQssCQ9Gc+HUn7O595quUtG1ZE4bpIur4
 DrRSkaBWurq1o5fBPx7b1lwlW9oSDYS5YrHTQFkSD7Q==
X-Received: by 2002:a17:906:5a6f:b0:9a3:c4f4:12dc with SMTP id
 my47-20020a1709065a6f00b009a3c4f412dcmr4524803ejc.7.1693494052173; 
 Thu, 31 Aug 2023 08:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEItJP1c9NKLWMSDU2Fjxe2iKrYoxUCLRWz4/6JWjMqNieHJ8iRQusTIkf8kXERSXMOfiazaw==
X-Received: by 2002:a17:906:5a6f:b0:9a3:c4f4:12dc with SMTP id
 my47-20020a1709065a6f00b009a3c4f412dcmr4524784ejc.7.1693494051830; 
 Thu, 31 Aug 2023 08:00:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 rs10-20020a170907036a00b00992b510089asm855137ejb.84.2023.08.31.08.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 08:00:51 -0700 (PDT)
Date: Thu, 31 Aug 2023 17:00:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [RFC PATCH v2 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <gqhfmvel7kkglvaco5lnjiggfj57j7ie5erp6vjvfmm5ifwsw5@o2tzqsnvoc7x>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
 <20230826175900.3693844-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230826175900.3693844-2-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
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

On Sat, Aug 26, 2023 at 08:58:59PM +0300, Arseniy Krasnov wrote:
>POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 020cf17ab7e4..013b65241b65 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			err = total_written;
> 	}
> out:
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = sk_stream_error(sk, msg->msg_flags, err);
>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
