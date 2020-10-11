Return-Path: <SRS0=TNKP=DS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6BC43467
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 18:39:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7987A207FB
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omOg9nng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7987A207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09ACC87280;
	Sun, 11 Oct 2020 18:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SckHv0rkpaXB; Sun, 11 Oct 2020 18:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7866E87150;
	Sun, 11 Oct 2020 18:39:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C3BC0052;
	Sun, 11 Oct 2020 18:39:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50ED8C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 18:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3785B84CEB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 18:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VgrK_780l7Fc
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 18:39:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AD0BD84C4E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 18:39:14 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id q9so15408979iow.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ihDBvmS0ut4DSKeE1V92ZLXhV60yzQeKm7MqEH3UbkE=;
 b=omOg9nngjeH2F9Dbb/TM0VIWCX3UYpHtX8QXXKU6Wi49Z7HBxoh8JJj0LrEs6V21k+
 IDFr+Xql22OeBgc7PX013oOTHyG9DTA2sG9CSgHvHnB9jsA58+YS0h7p91sSzydfrlN9
 1RZg0onwhTMveQ1nYGOEpbpcfcowZoubULaRr9Q2fJ4t7bFGKDA9nAFjNnsyvFl151K9
 q9wsmMGQoFNeUcKJ37tVf5HEUTY1JmYRc29u+gu6eT7BvYCiSBC12GxBgiIvtnSF8sOr
 JxSb58k1ZrKUUBSJmZDLdEWidS8VzAeUftUUbacInWRnlXcz3yxhcwzbam9z9Ks1E/rG
 M+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ihDBvmS0ut4DSKeE1V92ZLXhV60yzQeKm7MqEH3UbkE=;
 b=JDH6X+edd8r2ogQLiicHiLTdn3jOZ2DZjk6Xsdqak5LNTpU4iFqA9BtwHH688lh/Fy
 MwAAjY7o/zMmyXiZ+YVulQdbsYsKE598cGerSCIFB8yAVzFs3Z5T1cJzk/3gS29vXAdj
 j+NRf14l5kC31t8nBHB+HoUeXIalxXWJIAzpqhOY5g+7427H6PhIkWDuV9vqSNetOX12
 MwNkdT5Z05pmfidDZbZcMO3G74nWNucCyAfaULwKUwm5Y33uKPct9ohbEDYrfoL82yxH
 cvQc+uOwZCS/VASbiuw73jARBLhttcLX3Na8ROCCdIIcTGiuzSskc7XR92BV2kAZD9Ze
 NPXQ==
X-Gm-Message-State: AOAM530150Y9WhzxtcnAqNXLf/RIQtmWTSLFHsxakgAKpAig13DUdB12
 Ry/neKPEpoUj0IvBJYqURM2JEu6tXxk1lUIbY5I=
X-Google-Smtp-Source: ABdhPJxTF0j2v/9fJi8BunRtQlxMSiClZGK5c3sE9XRmWV7VBvPIX40VOP59eN5kOLWvuAg4icWlgLsDpVCM1/QHaos=
X-Received: by 2002:a02:94cd:: with SMTP id x71mr16450243jah.124.1602441553813; 
 Sun, 11 Oct 2020 11:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201010103854.66746-1-songmuchun@bytedance.com>
In-Reply-To: <20201010103854.66746-1-songmuchun@bytedance.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 11 Oct 2020 11:39:02 -0700
Message-ID: <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
Subject: Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Muchun Song <songmuchun@bytedance.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Neil Brown <neilb@suse.de>, Alexei Starovoitov <ast@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Eric Dumazet <edumazet@google.com>,
 Christian Brauner <christian.brauner@ubuntu.com>, walken@google.com,
 will@kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 dave@stgolabs.net, Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, rafael@kernel.org, decui@microsoft.com,
 Peter Zijlstra <peterz@infradead.org>, samitolvanen@google.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Paolo Abeni <pabeni@redhat.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, shakeelb@google.com,
 Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Sat, Oct 10, 2020 at 3:39 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The amount of memory allocated to sockets buffer can become significant.
> However, we do not display the amount of memory consumed by sockets
> buffer. In this case, knowing where the memory is consumed by the kernel

We do it via `ss -m`. Is it not sufficient? And if not, why not adding it there
rather than /proc/meminfo?

>  static inline void __skb_frag_unref(skb_frag_t *frag)
>  {
> -       put_page(skb_frag_page(frag));
> +       struct page *page = skb_frag_page(frag);
> +
> +       if (put_page_testzero(page)) {
> +               dec_sock_node_page_state(page);
> +               __put_page(page);
> +       }
>  }

You mix socket page frag with skb frag at least, not sure this is exactly
what you want, because clearly skb page frags are frequently used
by network drivers rather than sockets.

Also, which one matches this dec_sock_node_page_state()? Clearly
not skb_fill_page_desc() or __skb_frag_ref().

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
