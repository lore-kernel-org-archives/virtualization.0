Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F256EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 08:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F74240182;
	Tue, 15 Mar 2022 08:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FriKrS67h9xz; Tue, 15 Mar 2022 08:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5E5C40201;
	Tue, 15 Mar 2022 08:43:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98C53C001A;
	Tue, 15 Mar 2022 08:43:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50E9BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D7F884184
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jHBS7DfS7BOF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:43:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97C6284167
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647333787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ws46Mm4AeMY5ZL6XjAXUl4ERDO6VAVFfSe3QGONNiyc=;
 b=PcIqAYJIYZi7TRxVA3vdf3dfFNqwwozFMsvd+oIB+CuAJQAPcLa+hdvA4jpoavLbelQOmC
 jzVPZalrIf/4y7Ql6Vzx6newUxkpYtZvAOeUwjjEkoAgcVtR4JjLwH3JqTzYs9wyTGbERX
 KlXPbYP9QcNcYrdiseDA6gLA5bgBmDc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-FZwSLefvPnuLT36fogbb-w-1; Tue, 15 Mar 2022 04:43:06 -0400
X-MC-Unique: FZwSLefvPnuLT36fogbb-w-1
Received: by mail-qt1-f200.google.com with SMTP id
 h11-20020ac87d4b000000b002e1c9a3ae51so5820754qtb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 01:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ws46Mm4AeMY5ZL6XjAXUl4ERDO6VAVFfSe3QGONNiyc=;
 b=ErZtRQJx21heQ+5oBNtZ3yTHc3q69IJWOCWAHF4IQtZthIIiLdKKyYgjB/lp440D5N
 MNyWGFfJeo7B8pdhpHvBGKlbJoSt/ulMy95KLffoqHiPXWGqRqrcuSLlb8grZAsKjAx5
 jmqh+vwpMqKpNPF6pPUPp8WPsK15Mqyx7WP1o2F8xB316aRuX+OjCvSt19/d7BnI3sWU
 5dgOHPRm/yAi4vVXCWqYNc3FHZCDzonW4xmOoc/wFwD+pQOelpz/p34+CENiSwGhTwb0
 JuYghXgCA6zaGFqWwX4x2CGSOVirnwhJyZQ/ghpTPxscpMyx4MA6PJPO6vRR82lnJHnb
 J/6w==
X-Gm-Message-State: AOAM532BeYu6MWXnSTBxRS0R9UgnhgNnCafV9fGf6oWpUITPuytnqGpr
 jL5aIYQyTnH1O0zBurJlDbOqhDEt2XRi2eLgbrR8kaNQiEoaRCWfNeUxc0zRnk80SYq76bEl5lv
 pvchzpj1ckIldJzf5jBMjkCDevcK0FEfgDDnt26GLkQ==
X-Received: by 2002:a05:6214:411e:b0:435:7ef8:bfef with SMTP id
 kc30-20020a056214411e00b004357ef8bfefmr20319584qvb.1.1647333786241; 
 Tue, 15 Mar 2022 01:43:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3oHkYwl/EHW6+VU5/edFtgukOuNs5P/czgeVeppYp8cc7Uf17rwKyNVm6Cb0TeigCA4dttw==
X-Received: by 2002:a05:6214:411e:b0:435:7ef8:bfef with SMTP id
 kc30-20020a056214411e00b004357ef8bfefmr20319574qvb.1.1647333786022; 
 Tue, 15 Mar 2022 01:43:06 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 a15-20020ac85b8f000000b002e1c6a303f9sm7149201qta.95.2022.03.15.01.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 01:43:05 -0700 (PDT)
Date: Tue, 15 Mar 2022 09:42:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/3] af_vsock: add two new tests for SOCK_SEQPACKET
Message-ID: <20220315084257.lbrbsilpndswv3zy@sgarzare-redhat>
References: <1bb5ce91-da53-7de9-49ba-f49f76f45512@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1bb5ce91-da53-7de9-49ba-f49f76f45512@sberdevices.ru>
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

Hi Arseniy,

On Fri, Mar 11, 2022 at 10:52:36AM +0000, Krasnov Arseniy Vladimirovich wrote:
>This adds two tests: for receive timeout and reading to invalid
>buffer provided by user. I forgot to put both patches to main
>patchset.
>
>Arseniy Krasnov(2):
>
>af_vsock: SOCK_SEQPACKET receive timeout test
>af_vsock: SOCK_SEQPACKET broken buffer test
>
>tools/testing/vsock/vsock_test.c | 170 +++++++++++++++++++++++++++++++++++++++
>1 file changed, 170 insertions(+)

Thank you for these tests!

I left a few comments and I'm not sure about the 'broken buffer test' 
behavior.

About the series, it sounds like something is wrong with your setup, 
usually the cover letter is "patch" 0. In this case I would have 
expected:

     [0/2] af_vsock: add two new tests for SOCK_SEQPACKET
     [1/2] af_vsock: SOCK_SEQPACKET receive timeout test
     [2/2] af_vsock: SOCK_SEQPACKET broken buffer test

Are you using `git send-email` or `git publish`?


When you will remove the RFC, please add `net-next` label:
[PATCH net-next 0/2], etc..

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
