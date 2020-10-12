Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3283C43467
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 22:12:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6428C21BE5
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 22:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfJwjbcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6428C21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C8FC2274FC;
	Mon, 12 Oct 2020 22:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xlgb0rW8RKKx; Mon, 12 Oct 2020 22:12:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2D84C20348;
	Mon, 12 Oct 2020 22:12:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE92BC0052;
	Mon, 12 Oct 2020 22:12:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD1C4C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 22:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AB09A20461
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 22:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZdnjRhRTtjR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 22:12:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 5439220348
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 22:12:46 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id 67so19341777iob.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6GZ3bPMspww2V+Ym0Qh7X9pkgI/IU9Jbpf7mzdOQus0=;
 b=bfJwjbcd5PfSUcnm5iNF1BFJezZAWaVv8f4NLYg36c21R35nOTPcbZgGSeAP/BN0YC
 lArmVDHnZ5+zDU4S/jy3q0/lyq09lQDp6In3uxoRVf9QoEhNVCbeiBmEhgiAO4kHrK9B
 Hq7VkFhxWsNwnniQIXjcTgqlMxhRpcwPgURREjSvx7Dig8vrhb+HCgy+t8JOknv+TuVK
 SodLcbqfh2IHcOVQgsCI818lRf3F8KtPBlaBu5QgIDdgNJy8y66xgSpWB+1KJX5j86Gr
 jqyxILPzfhjLTUnkww//qeHeGNTskcutRLhjmBzZq5YXYW7gvwoYKQoL3WOILki0xJ0v
 VmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6GZ3bPMspww2V+Ym0Qh7X9pkgI/IU9Jbpf7mzdOQus0=;
 b=o0ae/j0eyI3j52NkQrN2HshtANcY8xPqKAZki0S0v9pME/2CkWOJCYER5sVY/zLuYw
 Vzyhl/oehLTxcDmf9xvzyKTJo6EuyEy9M83g/ZN2io68Kekz+dHXQ3DiMeNT6rg6E2Ro
 aFXqfc5XKdpj3a5s81fU4L3ouXunGZrgAP3HkQR1ceS7YkM4m+3dujoXmzJRbPotm8rK
 G4hirJL8rvTR0amRfEtj1G0CoTABIXe0ZMvCNHUIbO5Bj4R9Z+6T2Nzbx4zPx3GX9Fdz
 s2h/FdNR8vSg5W0H7GEqiYNVOBix1KD24w53I5HeGOhmdYJYxzzIMSWuASm6qYqEdBQR
 bdew==
X-Gm-Message-State: AOAM531p0/3afbj8JmRIbDoqXU4t2Du7/XtJIy6Spec2H2cybB+8/Tj1
 fVdRS+CnhaLA5gLJZOrCBshXqv52HHkT2tUlhIA=
X-Google-Smtp-Source: ABdhPJyFc4ostSbxsypN1wGndFqR3BXYLSDhPoPs1FLqkP0180PUNcs1Rg52RMqlZV96tqBaaMtbT66MdYmI0R8n1vU=
X-Received: by 2002:a05:6638:159:: with SMTP id
 y25mr21753172jao.131.1602540765537; 
 Mon, 12 Oct 2020 15:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
In-Reply-To: <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 12 Oct 2020 15:12:34 -0700
Message-ID: <CAM_iQpUgy7MDka8A44U=pLGDOwqn8YhXMp8rgs8LCJBHb5DXYA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Muchun Song <songmuchun@bytedance.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Neil Brown <neilb@suse.de>, Alexei Starovoitov <ast@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Eric Dumazet <edumazet@google.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Michel Lespinasse <walken@google.com>, Will Deacon <will@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, dave@stgolabs.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Eric Dumazet <eric.dumazet@gmail.com>, rafael@kernel.org,
 Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Paolo Abeni <pabeni@redhat.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Shakeel Butt <shakeelb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, chenqiwu@xiaomi.com,
 Martin KaFai Lau <kafai@fb.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 christophe.leroy@c-s.fr, Willem de Bruijn <willemb@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
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

On Mon, Oct 12, 2020 at 2:53 AM Muchun Song <songmuchun@bytedance.com> wrote:
> We are not complaining about TCP using too much memory, but how do
> we know that TCP uses a lot of memory. When I firstly face this problem,
> I do not know who uses the 25GB memory and it is not shown in the /proc/meminfo.
> If we can know the amount memory of the socket buffer via /proc/meminfo, we
> may not need to spend a lot of time troubleshooting this problem. Not everyone
> knows that a lot of memory may be used here. But I believe many people
> should know /proc/meminfo to confirm memory users.

Well, I'd bet networking people know `ss -m` better than /proc/meminfo,
generally speaking.

The practice here is that if you want some networking-specific counters,
add it to where networking people know better, that is, `ss -m` or /proc/net/...

Or maybe the problem you described is not specific to networking at all,
there must be some other places where pages are allocated but not charged.
If so, adding a general mm counter in /proc/meminfo makes sense, but
it won't be specific to networking.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
