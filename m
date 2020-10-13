Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E92C43467
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B76120797
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVCqZc0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76120797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 708DB878A1;
	Tue, 13 Oct 2020 06:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXUSkmSQontc; Tue, 13 Oct 2020 06:55:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A0AF87883;
	Tue, 13 Oct 2020 06:55:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65843C0052;
	Tue, 13 Oct 2020 06:55:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78639C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 06:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5505387A5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 06:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AaH5NIBnG8KR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 06:55:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 68AE487A49
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 06:55:34 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id g12so22576572wrp.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 23:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tsRtK+RphjJoix8LNFIUyEqIBIL/eXaIC2bZ4t/CBOQ=;
 b=DVCqZc0KrivZAyxTL0AvxUJIK8ar/eLOwEdWUo/cKCbAoTHgn33/8+mW9OHucS84v6
 0imUvQqQAst6kKaHRL53ucde/VGeMSByqHyllJ/uDQpUysG6+31rPcgj26UxVsnLdPw8
 bfyqYHaZd6F7DTxDh4M9MqsWd1Fqr7QO6Eib0jiaFCXEG3HkYbI14lKYhDar8x0Cdl8s
 pB7FD0Rhk2JUG7jdZ45/x7EknGoQjDpzV2vQ7D5UdDPRn5/rJbsCpCJQU5neobKMaKUQ
 U6QTs0HJiG92p59SleNX/m+xsMzOj0Pb+03mhokRCjuiTEZ/11U7eLxoWvknFy0pXz3f
 EJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tsRtK+RphjJoix8LNFIUyEqIBIL/eXaIC2bZ4t/CBOQ=;
 b=VZpDAYrFVWeosycgLu06IFMEXqmR55a8/jDCfHeal8/WzDnyk4VjpEOY+YWHf8kvEK
 8iOylq02Zw/pBbcmxuEevJ8N4Ph9ojvs+7DWrdXG71g5jHGpcbWPb765oHg1KuXxSCJc
 iYQMn5tqsrS3jzbi3NFc25pXEEe59aH5ZZYa3av4QUsHxx+IBBikTaYjoTcgr3an4xWC
 XBkEQgrMWIF5wMkQQskzhnt11X1/ron4f/6X7IkAywu17EekLPIkrQBXNLkDY9yud87B
 igBRRmzBdogkpC9XekxlC+u6TI20NHTmVUKwo9jOGQRo4AqmvC4C1pKN6f7wQfbfkhrF
 xkAQ==
X-Gm-Message-State: AOAM531quyxr9mw2JH/0uziRhxPdwEWfNt4WMlbH6kyGvJkvhu8tfYrg
 o+DU4rI/hktLwZIWrUwNg24=
X-Google-Smtp-Source: ABdhPJyQXupiGXk53k8bnCs10W8RAjL7Zi7PA+tSuK0vnrjR6U4YpJdR1j2LtYICyCerFkByTf/QBw==
X-Received: by 2002:adf:e412:: with SMTP id g18mr11015720wrm.211.1602572132746; 
 Mon, 12 Oct 2020 23:55:32 -0700 (PDT)
Received: from [192.168.8.147] ([37.171.149.236])
 by smtp.gmail.com with ESMTPSA id f14sm26683540wme.22.2020.10.12.23.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 23:55:32 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Muchun Song <songmuchun@bytedance.com>,
 Eric Dumazet <eric.dumazet@gmail.com>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <93d5ad90-2bd5-07ad-618e-456ed2e6da87@gmail.com>
Date: Tue, 13 Oct 2020 08:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
Content-Language: en-US
Cc: Miaohe Lin <linmiaohe@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@suse.com>, rafael@kernel.org, Neil Brown <neilb@suse.de>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Eric Dumazet <edumazet@google.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Michel Lespinasse <walken@google.com>, Will Deacon <will@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, dave@stgolabs.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Shakeel Butt <shakeelb@google.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Cong Wang <xiyou.wangcong@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, chenqiwu@xiaomi.com,
 Martin KaFai Lau <kafai@fb.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 christophe.leroy@c-s.fr, Willem de Bruijn <willemb@google.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Florian Westphal <fw@strlen.de>, gustavoars@kernel.org,
 Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
 rppt@kernel.org, Linux Kernel Network Developers <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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



On 10/12/20 11:53 AM, Muchun Song wrote:

> We are not complaining about TCP using too much memory, but how do
> we know that TCP uses a lot of memory. When I firstly face this problem,
> I do not know who uses the 25GB memory and it is not shown in the /proc/meminfo.
> If we can know the amount memory of the socket buffer via /proc/meminfo, we
> may not need to spend a lot of time troubleshooting this problem. Not everyone
> knows that a lot of memory may be used here. But I believe many people
> should know /proc/meminfo to confirm memory users.

Adding yet another operations in networking fast path is a high cost to pay
just to add one extra line in /proc/meminfo, while /proc/net/sockstat
is already a good proxy, with per protocol details, instead of a single bucket.

I reiterate that zero copy would make this counter out of sync,
unless special support is added (adding yet another operations ?)

Also your patch does not address gazillions of page allocations from drivers
in RX path.

Here at Google the majority of networking mm usage when hosts are under stress
is in RX path, when out of order queues start to grow in TCP sockets.

Allocations in TX path were greatly reduced and optimally sized with the introduction
of /proc/sys/net/ipv4/tcp_notsent_lowat.

We have gazillions of put_page()/__free_page()/__free_pages()/alloc_page()/... all
over the places, adding yet another tracking of "this page is used by networking stacks"
is going to be quite a big project.

I thought memcg was a better goal in the long run, lets focus on it.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
