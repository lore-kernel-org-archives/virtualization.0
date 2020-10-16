Return-Path: <SRS0=Urmt=DX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329C3C43467
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 20:53:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F61216C4
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 20:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia140vyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F61216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37D0788F2F;
	Fri, 16 Oct 2020 20:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F6hHvbP70itb; Fri, 16 Oct 2020 20:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20BE588F1A;
	Fri, 16 Oct 2020 20:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4DB2C07FF;
	Fri, 16 Oct 2020 20:53:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15E38C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 20:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 035FE88577
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 20:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mH5xVhFN7vE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 20:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4AE7E8856B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 20:53:42 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id e7so2158783pfn.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0efe4ZswmOvSV9QicwyqB6fv9os8T/DGdQrXJonnXfU=;
 b=Ia140vybnbMk8phKU5HmNtD4SH9QvW01QBJWsD42VQG/He9IU/Z/GCeuhEAU3fxKJe
 p9om8meCP2zPNgOXjCGO4IKUsxW4bk4S01ptydLJ9m9n5fvufxVIAI2DuHa+RXqXI8Fy
 vLOlAHbA8E6FFXkkWrhT3uU1NUboIG7n+Acik/ORasBZnFd19y+9ne7XBaxYRMN5uAMB
 KDdWJ+/5qmi3ABqkqRdLshmvJQuO1Ey6pn6+Ur3Ib37edjfZS0raMMUIxgW5PWataXnk
 0/T6gDtyRW69km7Jy8SfuqhSzqzK8+yCjF/8wSndOu/3RNevTVZeNf0IhgZxyVSI3vqC
 30Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=0efe4ZswmOvSV9QicwyqB6fv9os8T/DGdQrXJonnXfU=;
 b=AKRymOtPHtXyeZtOvVWRMjbr0rm8hoWkFBlCMCdVAMGF8OA1aFqs+r2vvQdotyPp75
 gCbugpYer7c5w4643UG+BLu9RsZ/F1t1JjTUBtLbjOUocRnBPsCDukKPuGPPB3Of2+HG
 jnlpM63TT96f2/mldAeoRMOkPcwdahw/BET7kKVmmaID8vLV3Owy8Lu9pGB5WD3pGbaw
 nTtrv68tjcyMy7QN9/XfnhVG+cLmhamWpJ7ZNkhAlTxZXWV8LWcbYdI+/6zoW0CZzdkI
 w5KEcEu6ZdFksb5gkkShVrsLOfcpKesYWCVLXydIIDDyBC2GrnH4UaeSjcrBKHNS2a0R
 q2Aw==
X-Gm-Message-State: AOAM530naDy4Ei/Ldl1KfJbv0+VaCr/4pVt0+nu5Qk++8EQKzytWFluq
 iHDJmYcMoI7YfM9NA29nggo=
X-Google-Smtp-Source: ABdhPJycsKD8TliiRJKggZ9pz79tbD3yWTffp+g43TndWMTzi9kZMZURt2MMRpRSeq4spvWtZ8hMCA==
X-Received: by 2002:a63:1f19:: with SMTP id f25mr4755943pgf.232.1602881621736; 
 Fri, 16 Oct 2020 13:53:41 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
 by smtp.gmail.com with ESMTPSA id q13sm3893651pfg.3.2020.10.16.13.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 13:53:40 -0700 (PDT)
Date: Fri, 16 Oct 2020 13:53:36 -0700
From: Minchan Kim <minchan@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
Message-ID: <20201016205336.GE1976566@google.com>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
 <20201013080906.GD4251@kernel.org>
 <8d1558e7-cd09-1f9e-edab-5f22c5bfc342@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d1558e7-cd09-1f9e-edab-5f22c5bfc342@suse.cz>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@suse.com>, rafael@kernel.org, Neil Brown <neilb@suse.de>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Eric Dumazet <edumazet@google.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Michel Lespinasse <walken@google.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Steffen Klassert <steffen.klassert@secunet.com>, dave@stgolabs.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <songmuchun@bytedance.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 virtualization@lists.linux-foundation.org, chenqiwu@xiaomi.com,
 Martin KaFai Lau <kafai@fb.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 christophe.leroy@c-s.fr, Willem de Bruijn <willemb@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Florian Westphal <fw@strlen.de>, gustavoars@kernel.org,
 David Miller <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>,
 Mike Rapoport <rppt@kernel.org>
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

On Fri, Oct 16, 2020 at 05:38:26PM +0200, Vlastimil Babka wrote:
> On 10/13/20 10:09 AM, Mike Rapoport wrote:
> > > We are not complaining about TCP using too much memory, but how do
> > > we know that TCP uses a lot of memory. When I firstly face this problem,
> > > I do not know who uses the 25GB memory and it is not shown in the /proc/meminfo.
> > > If we can know the amount memory of the socket buffer via /proc/meminfo, we
> > > may not need to spend a lot of time troubleshooting this problem. Not everyone
> > > knows that a lot of memory may be used here. But I believe many people
> > > should know /proc/meminfo to confirm memory users.
> > If I undestand correctly, the problem you are trying to solve is to
> > simplify troubleshooting of memory usage for people who may not be aware
> > that networking stack can be a large memory consumer.
> > 
> > For that a paragraph in 'man 5 proc' maybe a good start:
> 
> Yeah. Another major consumer that I've seen at some point was xfs buffers.

As well, there are other various type of memory consumers in embedded world,
depending on the features what they supprted, too. They often tempted to add
the memory consumption into /proc/meminfo or /proc/vmstat, too to get
memory visibility.

> And there might be others, and adding everything to /proc/meminfo is not
> feasible. I have once proposed adding a counter called "Unaccounted:" which
> would at least tell the user easily if a significant portion is occupied by
> memory not explained by the other meminfo counters, and look for trends
> (increase = potential memory leak?). For specific prominent consumers not
> covered by meminfo but that have some kind of internal counters, we could
> document where to look, such as /proc/net/sockstat or maybe create some
> /proc/ or /sys directory with file per consumer so that it's still easy to
> check, but without the overhead of global counters and bloated
> /proc/meminfo?

What have in my mind is to support simple general sysfs infra from MM for
driver/subysstems rather than creating each own memory stat. The API
could support flexible accounting like just global memory consumption and/or
consmption by key(e.g,. pid or each own special) for the detail.

So, they are all shown under /sys/kernel/mm/misc/ with detail as well as
/proc/meminfo with simple line for global.

Furthermore, I'd like to plug the infra into OOM message so once OOM occurs,
we could print each own hidden memory usage from driver side if the driver
believe they could be memory hogger. It would make easier to detect
such kinds of leak or hogging as well as better maintainace.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
