Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9301C4363A
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 21:47:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365E4208D5
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 21:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYImlSuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365E4208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 86D1D86D33;
	Mon, 12 Oct 2020 21:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l35GJLG8lRkM; Mon, 12 Oct 2020 21:47:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EAEFE86BBF;
	Mon, 12 Oct 2020 21:47:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7D76C07FF;
	Mon, 12 Oct 2020 21:47:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D571C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 21:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8DC7886BBF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 21:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jpkj7oueGgCs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 21:47:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ADC4886BBE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 21:47:03 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id k6so19226937ior.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h+F8apYj2Plr5dGtsp4Sn87icM0Gt/ZYiDUCGu5uXTA=;
 b=sYImlSuWHY/0f/jfbP/5+gVgcuqOAtQjUMnXMHXED5umjtE3LPslOSL7etCXMHOofP
 OCpa+2Sz42CDxUNykjUuDhWyt5vFu1VQ2q4mLxaSnkvM0BeJYsRX2yVIf69oRTE9T67o
 HRSY3XMYMW81cX286ZryHP3m3P/6kZ5ItQS7iUkubm19T+mUJGaXaGWyUNZdJtMqQgmL
 zSpO8tHo17YhrEljp7eptvHzAhmOHFf/hJvg/N0IaJaR5HkeDupWi3U14lijEclKn9qq
 MEwXGSOFD9iX8EgjReyyv2j7VDxt6rk3rEUTRz5EOYXiuvy4JelYIs/WB2F89KX73aVI
 Mp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h+F8apYj2Plr5dGtsp4Sn87icM0Gt/ZYiDUCGu5uXTA=;
 b=BSLMcJbPCW9DtYbEwcrvZ8eSD9tMWf0FpVq54v7+enTipYf7TlZ9xzk4cETGfxxIpC
 2fU9qXw7eChJz8el5sN5FbiZdKp1V7wCB5xwBdoUK+I+RozA+6wVMuZI0q78Ml2dOp0M
 luIH73XfTMRi1teO/arQn4jUs/Auzi6LQDIh5NA3X4OD1cKXQyAistoz77Uiyuk/yFmj
 hpMl+bwc4Kk4MzYsOwTMuHCOa17D44nJtZ8K+UYL16KqjZ2JeHt4XpvLwLDxJDWGgfeZ
 72V7IX8oDLCSJfTqbWxkiDAipUvdBkjGx/tfsfIDWXKut3eeXvd+JNbz/f5Kn2Q0MUOF
 5mqw==
X-Gm-Message-State: AOAM530fhsQLyoJSk9n5wAexBem9bbghevtDIzIVj7yiVejxiznb7rLS
 PJZeCAX7GXKW+NDl2etwUdm9odcFe3SUMeghLrE=
X-Google-Smtp-Source: ABdhPJz+y8paHziZjzqkLnzbjCoDFkO2pq2nRDQe31YPP796UzqDxRo9ZdyGommWTE6TqDzyP+Mz9TyqV84szZZPZVw=
X-Received: by 2002:a02:94cd:: with SMTP id x71mr20173978jah.124.1602539222864; 
 Mon, 12 Oct 2020 14:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
In-Reply-To: <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 12 Oct 2020 14:46:51 -0700
Message-ID: <CAM_iQpXLX1xXN02idk-yU1T=AGb9JmGiLkfRGCJOxjCw-OWpfQ@mail.gmail.com>
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
 Daniel Borkmann <daniel@iogearbox.net>, rafael@kernel.org, decui@microsoft.com,
 Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Paolo Abeni <pabeni@redhat.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Shakeel Butt <shakeelb@google.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU3VuLCBPY3QgMTEsIDIwMjAgYXQgOToyMiBQTSBNdWNodW4gU29uZyA8c29uZ211Y2h1bkBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgT2N0IDEyLCAyMDIwIGF0IDI6MzkgQU0g
Q29uZyBXYW5nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFNh
dCwgT2N0IDEwLCAyMDIwIGF0IDM6MzkgQU0gTXVjaHVuIFNvbmcgPHNvbmdtdWNodW5AYnl0ZWRh
bmNlLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IFRoZSBhbW91bnQgb2YgbWVtb3J5IGFsbG9jYXRl
ZCB0byBzb2NrZXRzIGJ1ZmZlciBjYW4gYmVjb21lIHNpZ25pZmljYW50Lgo+ID4gPiBIb3dldmVy
LCB3ZSBkbyBub3QgZGlzcGxheSB0aGUgYW1vdW50IG9mIG1lbW9yeSBjb25zdW1lZCBieSBzb2Nr
ZXRzCj4gPiA+IGJ1ZmZlci4gSW4gdGhpcyBjYXNlLCBrbm93aW5nIHdoZXJlIHRoZSBtZW1vcnkg
aXMgY29uc3VtZWQgYnkgdGhlIGtlcm5lbAo+ID4KPiA+IFdlIGRvIGl0IHZpYSBgc3MgLW1gLiBJ
cyBpdCBub3Qgc3VmZmljaWVudD8gQW5kIGlmIG5vdCwgd2h5IG5vdCBhZGRpbmcgaXQgdGhlcmUK
PiA+IHJhdGhlciB0aGFuIC9wcm9jL21lbWluZm8/Cj4KPiBJZiB0aGUgc3lzdGVtIGhhcyBsaXR0
bGUgZnJlZSBtZW1vcnksIHdlIGNhbiBrbm93IHdoZXJlIHRoZSBtZW1vcnkgaXMgdmlhCj4gL3By
b2MvbWVtaW5mby4gSWYgYSBsb3Qgb2YgbWVtb3J5IGlzIGNvbnN1bWVkIGJ5IHNvY2tldCBidWZm
ZXIsIHdlIGNhbm5vdAo+IGtub3cgaXQgd2hlbiB0aGUgU29jayBpcyBub3Qgc2hvd24gaW4gdGhl
IC9wcm9jL21lbWluZm8uIElmIHRoZSB1bmF3YXJlIHVzZXIKPiBjYW4ndCB0aGluayBvZiB0aGUg
c29ja2V0IGJ1ZmZlciwgbmF0dXJhbGx5IHRoZXkgd2lsbCBub3QgYHNzIC1tYC4gVGhlCj4gZW5k
IHJlc3VsdAoKSW50ZXJlc3RpbmcsIHdlIGFscmVhZHkgaGF2ZSBhIGZldyBjb3VudGVycyByZWxh
dGVkIHRvIHNvY2tldCBidWZmZXJzLAphcmUgeW91IHNheWluZyB0aGVzZSBhcmUgbm90IGFjY291
bnRlZCBpbiAvcHJvYy9tZW1pbmZvIGVpdGhlcj8KSWYgeWVzLCB3aHkgYXJlIHBhZ2UgZnJhZ3Mg
c28gc3BlY2lhbCBoZXJlPyBJZiBub3QsIHRoZXkgYXJlIG1vcmUKaW1wb3J0YW50IHRoYW4gcGFn
ZSBmcmFncywgc28geW91IHByb2JhYmx5IHdhbnQgdG8gZGVhbCB3aXRoIHRoZW0KZmlyc3QuCgoK
PiBpcyB0aGF0IHdlIHN0aWxsIGRvbuKAmXQga25vdyB3aGVyZSB0aGUgbWVtb3J5IGlzIGNvbnN1
bWVkLiBBbmQgd2UgYWRkIHRoZQo+IFNvY2sgdG8gdGhlIC9wcm9jL21lbWluZm8ganVzdCBsaWtl
IHRoZSBtZW1jZyBkb2VzKCdzb2NrJyBpdGVtIGluIHRoZSBjZ3JvdXAKPiB2MiBtZW1vcnkuc3Rh
dCkuIFNvIEkgdGhpbmsgdGhhdCBhZGRpbmcgdG8gL3Byb2MvbWVtaW5mbyBpcyBzdWZmaWNpZW50
LgoKSXQgbG9va3MgbGlrZSBhY3R1YWxseSB0aGUgc29ja2V0IHBhZ2UgZnJhZyBpcyBhbHJlYWR5
IGFjY291bnRlZCwKZm9yIGV4YW1wbGUsIHRoZSB0Y3Bfc2VuZG1zZ19sb2NrZWQoKToKCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNvcHkgPSBtaW5fdChpbnQsIGNvcHksIHBmcmFnLT5zaXplIC0g
cGZyYWctPm9mZnNldCk7CgogICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXNrX3dtZW1fc2No
ZWR1bGUoc2ssIGNvcHkpKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gd2Fp
dF9mb3JfbWVtb3J5OwoKCj4KPiA+Cj4gPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgX19za2JfZnJh
Z191bnJlZihza2JfZnJhZ190ICpmcmFnKQo+ID4gPiAgewo+ID4gPiAtICAgICAgIHB1dF9wYWdl
KHNrYl9mcmFnX3BhZ2UoZnJhZykpOwo+ID4gPiArICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0g
c2tiX2ZyYWdfcGFnZShmcmFnKTsKPiA+ID4gKwo+ID4gPiArICAgICAgIGlmIChwdXRfcGFnZV90
ZXN0emVybyhwYWdlKSkgewo+ID4gPiArICAgICAgICAgICAgICAgZGVjX3NvY2tfbm9kZV9wYWdl
X3N0YXRlKHBhZ2UpOwo+ID4gPiArICAgICAgICAgICAgICAgX19wdXRfcGFnZShwYWdlKTsKPiA+
ID4gKyAgICAgICB9Cj4gPiA+ICB9Cj4gPgo+ID4gWW91IG1peCBzb2NrZXQgcGFnZSBmcmFnIHdp
dGggc2tiIGZyYWcgYXQgbGVhc3QsIG5vdCBzdXJlIHRoaXMgaXMgZXhhY3RseQo+ID4gd2hhdCB5
b3Ugd2FudCwgYmVjYXVzZSBjbGVhcmx5IHNrYiBwYWdlIGZyYWdzIGFyZSBmcmVxdWVudGx5IHVz
ZWQKPiA+IGJ5IG5ldHdvcmsgZHJpdmVycyByYXRoZXIgdGhhbiBzb2NrZXRzLgo+ID4KPiA+IEFs
c28sIHdoaWNoIG9uZSBtYXRjaGVzIHRoaXMgZGVjX3NvY2tfbm9kZV9wYWdlX3N0YXRlKCk/IENs
ZWFybHkKPiA+IG5vdCBza2JfZmlsbF9wYWdlX2Rlc2MoKSBvciBfX3NrYl9mcmFnX3JlZigpLgo+
Cj4gWWVhaCwgd2UgY2FsbCBpbmNfc29ja19ub2RlX3BhZ2Vfc3RhdGUoKSBpbiB0aGUgc2tiX3Bh
Z2VfZnJhZ19yZWZpbGwoKS4KCkhvdyBpcyBza2JfcGFnZV9mcmFnX3JlZmlsbCgpIHBvc3NpYmx5
IHBhaXJlZCB3aXRoIF9fc2tiX2ZyYWdfdW5yZWYoKT8KCj4gU28gaWYgc29tZW9uZSBnZXRzIHRo
ZSBwYWdlIHJldHVybmVkIGJ5IHNrYl9wYWdlX2ZyYWdfcmVmaWxsKCksIGl0IG11c3QKPiBwdXQg
dGhlIHBhZ2UgdmlhIF9fc2tiX2ZyYWdfdW5yZWYoKS9za2JfZnJhZ191bnJlZigpLiBXZSB1c2Ug
UEdfcHJpdmF0ZQo+IHRvIGluZGljYXRlIHRoYXQgd2UgbmVlZCB0byBkZWMgdGhlIG5vZGUgcGFn
ZSBzdGF0ZSB3aGVuIHRoZSByZWZjb3VudCBvZgo+IHBhZ2UgcmVhY2hlcyB6ZXJvLgoKc2tiX3Bh
Z2VfZnJhZ19yZWZpbGwoKSBpcyBjYWxsZWQgb24gZnJhZ3Mgbm90IHdpdGhpbiBhbiBza2IsIGZv
ciBpbnN0YW5jZSwKc2tfcGFnZV9mcmFnX3JlZmlsbCgpIHVzZXMgaXQgZm9yIGEgcGVyLXNvY2tl
dCBvciBwZXItcHJvY2VzcyBwYWdlIGZyYWcuCkJ1dCwgX19za2JfZnJhZ191bnJlZigpIGlzIHNw
ZWNpZmljYWxseSB1c2VkIGZvciBza2IgZnJhZ3MsIHdoaWNoIGFyZQpzdXBwb3NlZCB0byBiZSBm
aWxsZWQgYnkgc2tiX2ZpbGxfcGFnZV9kZXNjKCkgKHBhZ2UgaXMgYWxsb2NhdGVkIGJ5IGRyaXZl
cikuCgpUaGV5IGFyZSBkaWZmZXJlbnQgdGhpbmdzIHlvdSBhcmUgbWl4aW5nIHRoZW0gdXAsIHdo
aWNoIGxvb2tzIGNsZWFybHkKd3Jvbmcgb3IgYXQgbGVhc3QgbWlzbGVhZGluZy4KClRoYW5rcy4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
