Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E96C433FE
	for <virtualization@archiver.kernel.org>; Wed, 29 Dec 2021 16:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6518060A70;
	Wed, 29 Dec 2021 16:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyudUWTlns7t; Wed, 29 Dec 2021 16:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 162AD607B5;
	Wed, 29 Dec 2021 16:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB448C0071;
	Wed, 29 Dec 2021 16:51:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C3C0C0012;
 Wed, 29 Dec 2021 16:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ABED60881;
 Wed, 29 Dec 2021 16:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yiQnMlcg9meT; Wed, 29 Dec 2021 16:51:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F42B606EB;
 Wed, 29 Dec 2021 16:51:35 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id z3so16238886plg.8;
 Wed, 29 Dec 2021 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eyiokD87yXLE7dKoF/rAesIX6IaZjzEtJI7+LN04FEk=;
 b=jbps2qryj0Z0zQWn+lrBBlSxcDefe6KXi88QIlXKVc6Y7PKqWfUapjY8JxFcaIGigd
 ft7+84WoQ0h4UhL3vyJ1DIBHIIiAm5llGYmfk4nVkAe+3GrrBf97zhKbWsvTPX6JejKF
 1dkXJo0UGl+pIxJTyh0L4R8V7cOazLao67YG1WvcCgMJUT7Zmhf0eicJkPKKBztKsk7v
 D05fKDj1dOQc8zLv828bRzJys90kfBlRY+f583hLSA+S27xtYBrr/t46oqhBNzw2uXBi
 meZ8HORQpYNqIJLSkK446oH4j64Ut5bibHP4XsZdHoPvyO6AnHzKO5rs+vK+c+HbGKip
 7LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eyiokD87yXLE7dKoF/rAesIX6IaZjzEtJI7+LN04FEk=;
 b=NEPqMtwB8XP21Uon3X4N39Lm+6fcv0OuMxw5wJJdReuPrhwlKJ2PRCHhibtb06/zE/
 tEId8AQWmEbt3lAwrswgIUXRztyGCphiBfUjYKuZ+vhXS89Bs5NgKBMlEQV6s8AZTmeB
 i4GEeSuzImPkU2sQTcluIL2VJzWKu5gQcTMD5rMgrvR/7WMi/6Vo8dH4nFkvjcrKf5m1
 INvjK0J3TFgKX8nRfrM4unTE/mh6ccVSCXw5J0SBofcq++EFYbCl6Y/dR0JJOMbPyQEt
 yVF9EDZ7tDQG3Uss0N3cQ5y4ZJiCLao0/Lw7UxIpdhO9u/QG00MDaSbf0qEYCVePEDdn
 /Ufw==
X-Gm-Message-State: AOAM533U240x3LWTUcqg8QAZrvd4LiVwi3n1fWwnKBuEGBwCaT3FGLqC
 8+j1xlt9b4ZM0BHf5uKLWd7AtD7nxhTxPVMfJDY=
X-Google-Smtp-Source: ABdhPJxws7iMiWFQ81pkeV1J6AYDjsQKCDaoIm81c0ZOXt5vTQ/CRD6VrIFy5sdtzv5w8UmX3Hk8KIPfWDSHxOMnNg4=
X-Received: by 2002:a17:902:c443:b0:148:f689:d924 with SMTP id
 m3-20020a170902c44300b00148f689d924mr27252809plm.78.1640796694708; Wed, 29
 Dec 2021 08:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20211229004913.513372-1-kuba@kernel.org>
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Dec 2021 08:51:23 -0800
Message-ID: <CAADnVQLd2y_Cuqrn+cAQzCjpXM_Lub5_X6xEfZdMMC2a2Jq41A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] net: don't include filter.h from net/sock.h
To: Jakub Kicinski <kuba@kernel.org>
Cc: wintera@linux.ibm.com, Andrew Lunn <andrew@lunn.ch>,
 mustafa.ismail@intel.com, Pablo Neira Ayuso <pablo@netfilter.org>,
 ath11k@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, george.mccollister@gmail.com,
 anthony.l.nguyen@intel.com, Ralf Baechle <ralf@linux-mips.org>,
 linux-hams@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 linux-s390 <linux-s390@vger.kernel.org>, pkshih@realtek.com,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-bluetooth@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, coreteam@netfilter.org,
 intel-wired-lan <intel-wired-lan@lists.osuosl.org>, nikolay@nvidia.com,
 linux-wireless <linux-wireless@vger.kernel.org>, habetsm.xilinx@gmail.com,
 Iurii Zaikin <yzaikin@google.com>, vivien.didelot@gmail.com, wg@grandegger.com,
 woojung.huh@microchip.com, johan.hedberg@gmail.com,
 Arnd Bergmann <arnd@arndb.de>, marcel@holtmann.org,
 Jamal Hadi Salim <jhs@mojatatu.com>, linux-can@vger.kernel.org,
 wenjia@linux.ibm.com, Marc Kleine-Budde <mkl@pengutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, luiz.dentz@gmail.com,
 jiri@nvidia.com, Cong Wang <xiyou.wangcong@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com,
 trond.myklebust@hammerspace.com, kvalo@codeaurora.org,
 linux-nfs@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
 linux-decnet-user@lists.sourceforge.net, Florian Westphal <fw@strlen.de>,
 Tariq Toukan <tariqt@nvidia.com>, kgraul@linux.ibm.com, ecree.xilinx@gmail.com,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 netfilter-devel <netfilter-devel@vger.kernel.org>, jreuter@yaina.de,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 olteanv@gmail.com, saeedm@nvidia.com, anna.schumaker@netapp.com,
 Taehee Yoo <ap420073@gmail.com>
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

On Tue, Dec 28, 2021 at 4:49 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> sock.h is pretty heavily used (5k objects rebuilt on x86 after
> it's touched). We can drop the include of filter.h from it and
> add a forward declaration of struct sk_filter instead.
> This decreases the number of rebuilt objects when bpf.h
> is touched from ~5k to ~1k.
>
> There's a lot of missing includes this was masking. Primarily
> in networking tho, this time.
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba@kernel.org/
>  - fix build in bond on ia64
>  - fix build in ip6_fib with randconfig

Nice! Applied. Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
