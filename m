Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC51C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 08:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F12826AA;
	Fri, 27 Jan 2023 08:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31F12826AA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUzwUmn2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJyCs9dxooeA; Fri, 27 Jan 2023 08:19:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FE5582566;
	Fri, 27 Jan 2023 08:19:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FE5582566
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00509C007E;
	Fri, 27 Jan 2023 08:19:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E737DC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B366D4176E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:19:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B366D4176E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUzwUmn2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8suR7IAikeb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:19:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA72E403AC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA72E403AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674807574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXfiZZetQqbi14d70Q9u+6V0Ixs67udoBCY1/+PVet8=;
 b=AUzwUmn2lRsZa1VDFq76iqM6PyRCe7TxQ9VYZhprOFriswFiQRFMy6F1Aetc8SAMRbH89b
 B+LoLdPR/lLPwpg62WR6fwd9tGxo1R6Yy2huUXHUydcqqeW40n2VeuNNO5qEN/PmKlKf43
 N1IFmnQSc0YLD7I6WnyPmQVbGNPbwgU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-gWfdq5waNl6sMZOiq3cXHg-1; Fri, 27 Jan 2023 03:19:32 -0500
X-MC-Unique: gWfdq5waNl6sMZOiq3cXHg-1
Received: by mail-vk1-f199.google.com with SMTP id
 v190-20020a1f2fc7000000b003e1db6f41deso1673908vkv.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 00:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXfiZZetQqbi14d70Q9u+6V0Ixs67udoBCY1/+PVet8=;
 b=n/BPYRdqD+laPMHxkFzz272aHw/kBMGIHsSEklchxa+smymZtJhu6XiwFLzyFbONtm
 CE0st8W8OgZdoa+CCUhPEM0qK6wDpGErdBEOIVWvVNu9BUARd9yluKN7zQAerD1dqn8k
 kTTNSEewHNcUSlJJj0tydUi8tz/nzIcS+P35Oj0gNkuX1d91u9fYnXvCL9kYtcbo9268
 eSIR0opxU2jaI21lyNDjVKRSPyR5crPkf40etACAZHwjTJEarhT6S0ZzFYZPPYaoqOf0
 23LY+eQWa4T3SNeO48bvYCpojRGiTKE/AeBzinw3G1dmBRNwiwu5ZzNMedguIGMkhEtI
 YZUA==
X-Gm-Message-State: AO0yUKXoN81Zh9D2YL1Sh7K6FtXZ6SMShlYFD9DVypTjrLZNsiCsrtQB
 IhMMc6BvQ+qXcirrqq1mOydhKuKDBWLC/EGYWfY5xJzKZhY921CZJWJy7+3J4t8QZNANRY1ye3q
 P4DSV/5CoJ3ApACFi4TyBg53snFSCb8GzrgoqKZ3w7A==
X-Received: by 2002:a1f:2ccd:0:b0:3b8:7586:c194 with SMTP id
 s196-20020a1f2ccd000000b003b87586c194mr2334875vks.3.1674807572330; 
 Fri, 27 Jan 2023 00:19:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8Wc4OoB+LOFJqQ4iS00UuEdhQhclYGMSUuPr4eiyJbnbW7Trc5XIZqA0yh/DrCh1g7rmzsOQ==
X-Received: by 2002:a1f:2ccd:0:b0:3b8:7586:c194 with SMTP id
 s196-20020a1f2ccd000000b003b87586c194mr2334872vks.3.1674807572100; 
 Fri, 27 Jan 2023 00:19:32 -0800 (PST)
Received: from redhat.com ([37.19.199.113]) by smtp.gmail.com with ESMTPSA id
 4-20020a056122084400b003a31fd43853sm259702vkk.3.2023.01.27.00.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 00:19:31 -0800 (PST)
Date: Fri, 27 Jan 2023 03:19:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
Message-ID: <20230127031904-mutt-send-email-mst@kernel.org>
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
 <20221219023900-mutt-send-email-mst@kernel.org>
 <62621671437948@mail.yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <62621671437948@mail.yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
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

On Mon, Dec 19, 2022 at 11:24:26AM +0300, Andrey Smetanin wrote:
> Sorry for the delay.
> I will send update on this week after some tests.
> 19.12.2022, 10:39, "Michael S. Tsirkin" <mst@redhat.com>:

Do you still plan to send something? Dropping this for now.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
