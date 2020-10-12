Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66029C433DF
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 09:24:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BBF2080D
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 09:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKFHU+ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BBF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2D349204F3;
	Mon, 12 Oct 2020 09:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oX7lgbQ6zwd; Mon, 12 Oct 2020 09:24:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 68E8422640;
	Mon, 12 Oct 2020 09:24:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB63C0051;
	Mon, 12 Oct 2020 09:24:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE7ADC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 09:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AD73185FD4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 09:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qzncZ9btzl6e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 09:24:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 150D0860EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 09:24:11 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id n15so18331149wrq.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DMVGRL2h5VknQLtG+XBcBI/2PJssThsIUXIEgYmYsSU=;
 b=uKFHU+okcDjb6Fb/zP+lA9f+wlJxiFRf7FlqX2XxTyuTAKieQcr+4zEW7fj4A8Nodv
 UF+rwE5tD2Honok8Btx3sX6sPae46NxFjByl9kbbCK6ESCFKenq7EwhoEVom6Bihw8o8
 JwSALjaIOzE1qYYNL5Z5adiyP5tSNlQubxoSXrK/Q/orJAeILuAmOveunVcy+BUGzlKh
 GiyXc7DjBg3xpg2bF/WuWixArQ5fEkUFuXU6lyRn3lcpiitXWoGX4CX48uXPPd3VpwYe
 HPOJndvhcauDFtUV5/TmvJEWQsDs07mw7cLnIx/vGlrqjxN8HNJwzQgzNPlmNJICIUK+
 Nd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DMVGRL2h5VknQLtG+XBcBI/2PJssThsIUXIEgYmYsSU=;
 b=kzWknbbed7bJ1wtKdGOyG49ssQ2s0Q5FdzqdIK6xTMkqyuD/KIESXK1PZXGuI5pAqK
 BVczxOxzNCrf0FwSKYNc7WLL9HU3K1Rz+M+1c28KViTjZwLzzNdlQN8l6G8BzuJKiLxJ
 GmVbHpHqoKvGcd+EQOxV4hxbhEOOvg8NawhPVi6nDQdkrbBJKLnajWP180HKMVSJp8WT
 WSblkJ2dXTlFpUtoM2vFHZuv3EkiYEAT+yB/u6xFYInjic/SXRyBzUXc/HHRi3vGxlPt
 zldI9LvJzeGzVLwhwO5shLLhrZmjLuQ3Ffk+garKLXRh1oV8vh6x9rLTCWzuxe3gYKFt
 hzgw==
X-Gm-Message-State: AOAM532irhYa/BimpRQIbxH6n5DeIMw0/fFWc5fmmmn/PYtvLaRLXth5
 iVF0kFh2WhCRMW/5zmRFKnM=
X-Google-Smtp-Source: ABdhPJxWeGiqNCh1RC5V9AJmojzSnIkqs8imzlEXRVq0FqWUz6cdLVCww51FepImaJs0WTrh5TtGDQ==
X-Received: by 2002:adf:9f4c:: with SMTP id f12mr16937624wrg.108.1602494649624; 
 Mon, 12 Oct 2020 02:24:09 -0700 (PDT)
Received: from [192.168.8.147] ([37.167.93.109])
 by smtp.gmail.com with ESMTPSA id c16sm25066726wrx.31.2020.10.12.02.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 02:24:08 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Muchun Song <songmuchun@bytedance.com>, Eric Dumazet <edumazet@google.com>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
Date: Mon, 12 Oct 2020 11:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
Content-Language: en-US
Cc: Miaohe Lin <linmiaohe@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@suse.com>, rafael@kernel.org, Neil Brown <neilb@suse.de>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMC8xMi8yMCAxMDozOSBBTSwgTXVjaHVuIFNvbmcgd3JvdGU6Cj4gT24gTW9uLCBPY3Qg
MTIsIDIwMjAgYXQgMzo0MiBQTSBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+IHdy
b3RlOgo+Pgo+PiBPbiBNb24sIE9jdCAxMiwgMjAyMCBhdCA2OjIyIEFNIE11Y2h1biBTb25nIDxz
b25nbXVjaHVuQGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+Pj4KPj4+IE9uIE1vbiwgT2N0IDEyLCAy
MDIwIGF0IDI6MzkgQU0gQ29uZyBXYW5nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5jb20+IHdyb3Rl
Ogo+Pj4+Cj4+Pj4gT24gU2F0LCBPY3QgMTAsIDIwMjAgYXQgMzozOSBBTSBNdWNodW4gU29uZyA8
c29uZ211Y2h1bkBieXRlZGFuY2UuY29tPiB3cm90ZToKPj4+Pj4KPj4+Pj4gVGhlIGFtb3VudCBv
ZiBtZW1vcnkgYWxsb2NhdGVkIHRvIHNvY2tldHMgYnVmZmVyIGNhbiBiZWNvbWUgc2lnbmlmaWNh
bnQuCj4+Pj4+IEhvd2V2ZXIsIHdlIGRvIG5vdCBkaXNwbGF5IHRoZSBhbW91bnQgb2YgbWVtb3J5
IGNvbnN1bWVkIGJ5IHNvY2tldHMKPj4+Pj4gYnVmZmVyLiBJbiB0aGlzIGNhc2UsIGtub3dpbmcg
d2hlcmUgdGhlIG1lbW9yeSBpcyBjb25zdW1lZCBieSB0aGUga2VybmVsCj4+Pj4KPj4+PiBXZSBk
byBpdCB2aWEgYHNzIC1tYC4gSXMgaXQgbm90IHN1ZmZpY2llbnQ/IEFuZCBpZiBub3QsIHdoeSBu
b3QgYWRkaW5nIGl0IHRoZXJlCj4+Pj4gcmF0aGVyIHRoYW4gL3Byb2MvbWVtaW5mbz8KPj4+Cj4+
PiBJZiB0aGUgc3lzdGVtIGhhcyBsaXR0bGUgZnJlZSBtZW1vcnksIHdlIGNhbiBrbm93IHdoZXJl
IHRoZSBtZW1vcnkgaXMgdmlhCj4+PiAvcHJvYy9tZW1pbmZvLiBJZiBhIGxvdCBvZiBtZW1vcnkg
aXMgY29uc3VtZWQgYnkgc29ja2V0IGJ1ZmZlciwgd2UgY2Fubm90Cj4+PiBrbm93IGl0IHdoZW4g
dGhlIFNvY2sgaXMgbm90IHNob3duIGluIHRoZSAvcHJvYy9tZW1pbmZvLiBJZiB0aGUgdW5hd2Fy
ZSB1c2VyCj4+PiBjYW4ndCB0aGluayBvZiB0aGUgc29ja2V0IGJ1ZmZlciwgbmF0dXJhbGx5IHRo
ZXkgd2lsbCBub3QgYHNzIC1tYC4gVGhlCj4+PiBlbmQgcmVzdWx0Cj4+PiBpcyB0aGF0IHdlIHN0
aWxsIGRvbuKAmXQga25vdyB3aGVyZSB0aGUgbWVtb3J5IGlzIGNvbnN1bWVkLiBBbmQgd2UgYWRk
IHRoZQo+Pj4gU29jayB0byB0aGUgL3Byb2MvbWVtaW5mbyBqdXN0IGxpa2UgdGhlIG1lbWNnIGRv
ZXMoJ3NvY2snIGl0ZW0gaW4gdGhlIGNncm91cAo+Pj4gdjIgbWVtb3J5LnN0YXQpLiBTbyBJIHRo
aW5rIHRoYXQgYWRkaW5nIHRvIC9wcm9jL21lbWluZm8gaXMgc3VmZmljaWVudC4KPj4+Cj4+Pj4K
Pj4+Pj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3NrYl9mcmFnX3VucmVmKHNrYl9mcmFnX3QgKmZy
YWcpCj4+Pj4+ICB7Cj4+Pj4+IC0gICAgICAgcHV0X3BhZ2Uoc2tiX2ZyYWdfcGFnZShmcmFnKSk7
Cj4+Pj4+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBza2JfZnJhZ19wYWdlKGZyYWcpOwo+
Pj4+PiArCj4+Pj4+ICsgICAgICAgaWYgKHB1dF9wYWdlX3Rlc3R6ZXJvKHBhZ2UpKSB7Cj4+Pj4+
ICsgICAgICAgICAgICAgICBkZWNfc29ja19ub2RlX3BhZ2Vfc3RhdGUocGFnZSk7Cj4+Pj4+ICsg
ICAgICAgICAgICAgICBfX3B1dF9wYWdlKHBhZ2UpOwo+Pj4+PiArICAgICAgIH0KPj4+Pj4gIH0K
Pj4+Pgo+Pj4+IFlvdSBtaXggc29ja2V0IHBhZ2UgZnJhZyB3aXRoIHNrYiBmcmFnIGF0IGxlYXN0
LCBub3Qgc3VyZSB0aGlzIGlzIGV4YWN0bHkKPj4+PiB3aGF0IHlvdSB3YW50LCBiZWNhdXNlIGNs
ZWFybHkgc2tiIHBhZ2UgZnJhZ3MgYXJlIGZyZXF1ZW50bHkgdXNlZAo+Pj4+IGJ5IG5ldHdvcmsg
ZHJpdmVycyByYXRoZXIgdGhhbiBzb2NrZXRzLgo+Pj4+Cj4+Pj4gQWxzbywgd2hpY2ggb25lIG1h
dGNoZXMgdGhpcyBkZWNfc29ja19ub2RlX3BhZ2Vfc3RhdGUoKT8gQ2xlYXJseQo+Pj4+IG5vdCBz
a2JfZmlsbF9wYWdlX2Rlc2MoKSBvciBfX3NrYl9mcmFnX3JlZigpLgo+Pj4KPj4+IFllYWgsIHdl
IGNhbGwgaW5jX3NvY2tfbm9kZV9wYWdlX3N0YXRlKCkgaW4gdGhlIHNrYl9wYWdlX2ZyYWdfcmVm
aWxsKCkuCj4+PiBTbyBpZiBzb21lb25lIGdldHMgdGhlIHBhZ2UgcmV0dXJuZWQgYnkgc2tiX3Bh
Z2VfZnJhZ19yZWZpbGwoKSwgaXQgbXVzdAo+Pj4gcHV0IHRoZSBwYWdlIHZpYSBfX3NrYl9mcmFn
X3VucmVmKCkvc2tiX2ZyYWdfdW5yZWYoKS4gV2UgdXNlIFBHX3ByaXZhdGUKPj4+IHRvIGluZGlj
YXRlIHRoYXQgd2UgbmVlZCB0byBkZWMgdGhlIG5vZGUgcGFnZSBzdGF0ZSB3aGVuIHRoZSByZWZj
b3VudCBvZgo+Pj4gcGFnZSByZWFjaGVzIHplcm8uCj4+Pgo+Pgo+PiBQYWdlcyBjYW4gYmUgdHJh
bnNmZXJyZWQgZnJvbSBwaXBlIHRvIHNvY2tldCwgc29ja2V0IHRvIHBpcGUgKHNwbGljZSgpCj4+
IGFuZCB6ZXJvY29weSBmcmllbmRzLi4uKQo+Pgo+PiAgSWYgeW91IHdhbnQgdG8gdHJhY2sgVENQ
IG1lbW9yeSBhbGxvY2F0aW9ucywgeW91IGFsd2F5cyBjYW4gbG9vayBhdAo+PiAvcHJvYy9uZXQv
c29ja3N0YXQsCj4+IHdpdGhvdXQgYWRkaW5nIHlldCBhbm90aGVyIGV4cGVuc2l2ZSBtZW1vcnkg
YWNjb3VudGluZy4KPiAKPiBUaGUgJ21lbScgaXRlbSBpbiB0aGUgL3Byb2MvbmV0L3NvY2tzdGF0
IGRvZXMgbm90IHJlcHJlc2VudCByZWFsCj4gbWVtb3J5IHVzYWdlLiBUaGlzIGlzIGp1c3QgdGhl
IHRvdGFsIGFtb3VudCBvZiBjaGFyZ2VkIG1lbW9yeS4KPiAKPiBGb3IgZXhhbXBsZSwgaWYgYSB0
YXNrIHNlbmRzIGEgMTAtYnl0ZSBtZXNzYWdlLCBpdCBvbmx5IGNoYXJnZXMgb25lCj4gcGFnZSB0
byBtZW1jZy4gQnV0IHRoZSBzeXN0ZW0gbWF5IGFsbG9jYXRlIDggcGFnZXMuIFRoZXJlZm9yZSwg
aXQKPiBkb2VzIG5vdCB0cnVseSByZWZsZWN0IHRoZSBtZW1vcnkgYWxsb2NhdGVkIGJ5IHRoZSBh
Ym92ZSBtZW1vcnkKPiBhbGxvY2F0aW9uIHBhdGguIFdlIGNhbiBzZWUgdGhlIGRpZmZlcmVuY2Ug
dmlhIHRoZSBmb2xsb3dpbmcgbWVzc2FnZS4KPiAKPiBjYXQgL3Byb2MvbmV0L3NvY2tzdGF0Cj4g
ICBzb2NrZXRzOiB1c2VkIDY5OAo+ICAgVENQOiBpbnVzZSA3MCBvcnBoYW4gMCB0dyA2MTcgYWxs
b2MgMTM0IG1lbSAxMwo+ICAgVURQOiBpbnVzZSA5MCBtZW0gNAo+ICAgVURQTElURTogaW51c2Ug
MAo+ICAgUkFXOiBpbnVzZSAxCj4gICBGUkFHOiBpbnVzZSAwIG1lbW9yeSAwCj4gCj4gY2F0IC9w
cm9jL21lbWluZm8gfCBncmVwIFNvY2sKPiAgIFNvY2s6ICAgICAgICAgICAgICAxMzY2NCBrQgo+
IAo+IFRoZSAvcHJvYy9uZXQvc29ja3N0YXQgb25seSBzaG93cyB1cyB0aGF0IHRoZXJlIGFyZSAx
Nyo0IGtCIFRDUAo+IG1lbW9yeSBhbGxvY2F0aW9ucy4gQnV0IGFwcGx5IHRoaXMgcGF0Y2gsIHdl
IGNhbiBzZWUgdGhhdCB3ZSB0cnVseQo+IGFsbG9jYXRlIDEzNjY0IGtCKE1heSBiZSBncmVhdGVy
IHRoYW4gdGhpcyB2YWx1ZSBiZWNhdXNlIG9mIHBlci1jcHUKPiBzdGF0IGNhY2hlKS4gT2YgY291
cnNlIHRoZSBsb2FkIG9mIHRoZSBleGFtcGxlIGhlcmUgaXMgbm90IGhpZ2guIEluCj4gc29tZSBo
aWdoIGxvYWQgY2FzZXMsIEkgYmVsaWV2ZSB0aGUgZGlmZmVyZW5jZSBoZXJlIHdpbGwgYmUgZXZl
bgo+IGdyZWF0ZXIuCj4gCgpUaGlzIGlzIGdyZWF0LCBidXQgeW91IGhhdmUgbm90IGFkZHJlc3Nl
ZCBteSBmZWVkYmFjay4KClRDUCBtZW1vcnkgYWxsb2NhdGlvbnMgYXJlIGJvdW5kZWQgYnkgL3By
b2Mvc3lzL25ldC9pcHY0L3RjcF9tZW0KCkZhY3QgdGhhdCB0aGUgbWVtb3J5IGlzIGZvcndhcmQg
YWxsb2NhdGVkIG9yIG5vdCBpcyBhIGRldGFpbC4KCklmIHlvdSB0aGluayB3ZSBtdXN0IHByZS1h
bGxvY2F0ZSBtZW1vcnksIGluc3RlYWQgb2YgZm9yd2FyZCBhbGxvY2F0aW9ucywKeW91ciBwYXRj
aCBkb2VzIG5vdCBhZGRyZXNzIHRoaXMuIEFkZGluZyBvbmUgbGluZSBwZXIgY29uc3VtZXIgaW4g
L3Byb2MvbWVtaW5mbyBsb29rcwp3cm9uZyB0byBtZS4KCklmIHlvdSBkbyBub3Qgd2FudCA5LjM3
ICUgb2YgcGh5c2ljYWwgbWVtb3J5IGJlaW5nIHBvc3NpYmx5IHVzZWQgYnkgVENQLApqdXN0IGNo
YW5nZSAvcHJvYy9zeXMvbmV0L2lwdjQvdGNwX21lbSBhY2NvcmRpbmdseSA/CgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
