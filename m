Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA1C4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 10:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44B5341464;
	Mon,  6 Nov 2023 10:51:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44B5341464
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7SZV9ko
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bdc4OEXIGfhe; Mon,  6 Nov 2023 10:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 633BB41465;
	Mon,  6 Nov 2023 10:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 633BB41465
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42978C0039;
	Mon,  6 Nov 2023 10:51:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEC1AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A6DE815CD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:51:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A6DE815CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7SZV9ko
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgDqm1VX_QeP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:51:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AD5181431
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AD5181431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699267860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGKHksPd501hQHA9eLNxN+ry44710hoCv07MExLKHVs=;
 b=K7SZV9kodhdBY8ckM+q65szu6/goZmsDaV105VszGF9Y0Kk4svpsovA5hgwy3nxStxDLoB
 5DPUdN08eT+7IF8yQxSZ7th2BlC2OnYfrSxz6QBc6Hxi2VimDXF54Vhjf7axmHLsaWtE4w
 8K/7UWnCwWrUIjoR7qPz1vbC/SB6dkg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-tZ-cqKBaMPecl5shQ6fswQ-1; Mon, 06 Nov 2023 05:50:52 -0500
X-MC-Unique: tZ-cqKBaMPecl5shQ6fswQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7788fb069abso656689385a.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 02:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267852; x=1699872652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGKHksPd501hQHA9eLNxN+ry44710hoCv07MExLKHVs=;
 b=vWbLBUwm4OgE3wG0AqGeK/oNs0qfho8t7q0HzyC9iXAM/7zRVZ5guuYiZRxrdXlwwg
 SQr0ALWidNERssPSofOjo2o7+MM/GLD+Ch7WWJeYXcZ6GGAeYb1SWmvvyk7eQvLD3Gjm
 USnzDzfUNBzVUlgEyFcDgY9puO+kh8sLLHpJ1+LjvaxCUbqsdnBQb3KrE1cSmzHw9fqE
 xDkGnKgR3dKxkwY0pPltVNAeVrtfZr5JqBdg0/kjNCLdpmNw9Kq8Xi1xd89h7jdgzSok
 lxnjypDZfHoRAtc7UnqhNAyBvXHGAlWxb0wiqpMGD9WGLS7jKxy/Vy0ZbSbvRXJetoGj
 UZ8g==
X-Gm-Message-State: AOJu0Ywb2ugT0+bSYJ9zlTz5JBlOX7zfBSs3AjdH//iZeo060wwPYw05
 OAJkmrcmRlKEvyqFIKH3DfrBqWcgEyLtphjEQO5s+s9LhDZkKE/7yBQFHiy4+lCekhlEvstJwYz
 OIAmlWAcAUvIuA6Z2HwWHz1tGvLfn0PkNLqVTNqQE1w==
X-Received: by 2002:a05:620a:4891:b0:774:21d8:b0bb with SMTP id
 ea17-20020a05620a489100b0077421d8b0bbmr12492222qkb.24.1699267852274; 
 Mon, 06 Nov 2023 02:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0WMQS53FSstaaqoM5HU6Y+QSQp08ZUPiU8X5BKecLqp2Qc+R6PUnmsWzejkhzBiVviTEyQ==
X-Received: by 2002:a05:620a:4891:b0:774:21d8:b0bb with SMTP id
 ea17-20020a05620a489100b0077421d8b0bbmr12492204qkb.24.1699267852003; 
 Mon, 06 Nov 2023 02:50:52 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a05620a125a00b0077892023fc5sm3168522qkl.120.2023.11.06.02.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 02:50:51 -0800 (PST)
Date: Mon, 6 Nov 2023 11:50:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Subject: Re: [PATCH net 0/4] vsock: fix server prevents clients from
 reconnecting
Message-ID: <arbypnxtolin6jhz5wqguh4mnqlejtorgx5gvicwbuqdivjpds@lvitwxxfgy2g>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20231103175551.41025-1-f.storniolo95@gmail.com>
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

On Fri, Nov 03, 2023 at 06:55:47PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This patch series introduce fix and tests for the following vsock bug:
>If the same remote peer, using the same port, tries to connect
>to a server on a listening port more than once, the server will
>reject the connection, causing a "connection reset by peer"
>error on the remote peer. This is due to the presence of a
>dangling socket from a previous connection in both the connected
>and bound socket lists.
>The inconsistency of the above lists only occurs when the remote
>peer disconnects and the server remains active.
>This bug does not occur when the server socket is closed.
>
>More details on the first patch changelog.
>The remaining patches are refactoring and test.

Thanks for the fix and the test!

I only left a small comment in patch 2 which I don't think justifies a
v2 by itself though. If for some other reason you have to send a v2,
then maybe I would fix it.

I reviewed the series and ran the tests. Everything seems to be fine.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
