Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380F2C4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 10:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D595D82081;
	Mon,  6 Nov 2023 10:46:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D595D82081
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YfQuIxOo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v0afqp48qoP2; Mon,  6 Nov 2023 10:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EE2D81BC5;
	Mon,  6 Nov 2023 10:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EE2D81BC5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E828C0039;
	Mon,  6 Nov 2023 10:46:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7652C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8AADE41465
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:46:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AADE41465
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YfQuIxOo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id coIV1aqQILAK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:46:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F13541464
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F13541464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699267604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y6QcvY42P7J5f+1XN4Qoz7DTeNEAzvUSzxn7o+ZphKQ=;
 b=YfQuIxOoG/IMMRNoz0IYo7SOaW9ehhvriAYE3+mnXx9T7fFGNFRBp/5BWhYe1f7EFUKvzq
 /X+SuqM5AgA+oAmNL04sA+tkP4TNfWGkXZeOhn/Mj5sO0hh3OkiWlGM3sGvnrbXMmBwum5
 aqZzeDb51bYySX/nrwFb4e/zHGnPSr8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Veuec2M6MP-liaZ5_oWsOA-1; Mon, 06 Nov 2023 05:46:41 -0500
X-MC-Unique: Veuec2M6MP-liaZ5_oWsOA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7789f06778aso795835285a.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 02:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267600; x=1699872400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6QcvY42P7J5f+1XN4Qoz7DTeNEAzvUSzxn7o+ZphKQ=;
 b=BXcQvuAXVe7BCwhsrTAO858WP34VsddsJKhvukBQjl+55oSsuIN6iFVx4gCKnXvKPG
 /Y4Cxx5AENr/HmMRPIxJbo71Ed+pclXC5adWBwhhgIR2+lM7nlujBabLarQWHVL6PbW7
 LXOj1w8i5/dsRdEf8YjEQw0rW8vr8PGgw+nZUFbvhRWg5WE8G+e2Pn/AGRVNXk+3wNfW
 zeiSxpiBeeGjXOAkWFzCB+UAg6IgnojNEAnRpq7tX2JzSZ3xHfksF7YDezMw7RmBUQZ7
 MiqNK42lMZdxuIUFOMWMpHy/WeKRITGEeUIb3tywvbake4tuMWvU504jHChmN96DFWwU
 tLSw==
X-Gm-Message-State: AOJu0YzzCJLKhY/PgbHiigO8UgHxMDh2l8k6QpsRirmwHwImp71CuCce
 CRBbxklZqDkFTnnTZqAa9iufvNDOj4h7CeQtxDdjDLULyrfFW1/ujfw80o4RXAx/SbYoC9IftEb
 5PKAJWunql/+DrxNNGiAdFf7WFDozSKb8btnuTJ0A3g==
X-Received: by 2002:a05:620a:4622:b0:779:cf70:8495 with SMTP id
 br34-20020a05620a462200b00779cf708495mr13042334qkb.22.1699267600581; 
 Mon, 06 Nov 2023 02:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0MTPNegxkHg2EtjSBJdIkcLWvJeBZhkiYCgUyFVAeJU8p43NP4uMhUlLf+FYjn63g6E1jfw==
X-Received: by 2002:a05:620a:4622:b0:779:cf70:8495 with SMTP id
 br34-20020a05620a462200b00779cf708495mr13042320qkb.22.1699267600334; 
 Mon, 06 Nov 2023 02:46:40 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a05622a229200b004181c32dcc3sm3258973qtb.16.2023.11.06.02.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 02:46:39 -0800 (PST)
Date: Mon, 6 Nov 2023 11:46:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Subject: Re: [PATCH net 2/4] test/vsock fix: add missing check on socket
 creation
Message-ID: <dhech4poimv5fphsxpy4oxy5ks5kpki6kzboy6kpnfm65vz3tp@nm6hoicgj5ze>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-3-f.storniolo95@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20231103175551.41025-3-f.storniolo95@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 imbrenda@linux.vnet.ibm.com, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, asias@redhat.com, pabeni@redhat.com,
 luigi.leonardi@outlook.com, davem@davemloft.net
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

On Fri, Nov 03, 2023 at 06:55:49PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>Add check on socket() return value in vsock_listen()
>and vsock_connect()
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

If you need to resend the entire series, maybe you can remove "fix"
from the commit title.

But it's a minor thing, so I would only change it if there's something
else that justifies sending a v2:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 92336721321a..698b0b44a2ee 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -104,6 +104,10 @@ static int vsock_connect(unsigned int cid, unsigned int port, int type)
> 	control_expectln("LISTENING");
>
> 	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>
> 	timeout_begin(TIMEOUT);
> 	do {
>@@ -158,6 +162,10 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 	int old_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>
> 	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
> 		perror("bind");
>-- 
>2.41.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
