Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F31C433DF
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 14:44:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9F42488C
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0rBuENa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9F42488C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6412886C31;
	Tue, 13 Oct 2020 14:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4PWNrc8tdnNX; Tue, 13 Oct 2020 14:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25CE586C20;
	Tue, 13 Oct 2020 14:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B61EC07FF;
	Tue, 13 Oct 2020 14:44:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 626B6C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 14:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5060086C20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 14:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MpYJpXYFOZCL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 14:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1144786C08
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=gKRE5e5JfpskUWXmYMgE/etrXSbKNWpPiTlTnQ/1/ws=; b=R0rBuENacNrEsc1Bdj2P9Tk79p
 QQX4a1UYYI0zagRHF/Vz1dpEwOhrRrNLQyDN+LcRY8fHQZ/+ax5c/c1pEK3uVi0IOR0GWbr+SLsqs
 nxsSI+xrio4qTmdQ/2PrywhF3xqIvfl1AmXrgGijj7/QChZ+UD7kkAvbSJF3c+1ChWRn4P2M03bgz
 4oiTsAKgm/bG2XdBJZcFXYPjyF3nN/1y2XgcBfYbInHolOpjDY49FThLQg2loIxiinaPU518L8EYs
 wNXoXr6IiYfGJ4UrRsCihWloD1uIIJNneCgVhy3lJKxJhK6pLc0Na/uxOVrwhg6bVHPCCp9ExRCvx
 v9OFBAjg==;
Received: from [2601:1c0:6280:3f0::507c]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSLXE-0006p7-QB; Tue, 13 Oct 2020 14:44:17 +0000
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Mike Rapoport <rppt@kernel.org>, Muchun Song <songmuchun@bytedance.com>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
 <20201013080906.GD4251@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e059f4b1-e51b-0277-e96b-c178d0cf4fd7@infradead.org>
Date: Tue, 13 Oct 2020 07:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013080906.GD4251@kernel.org>
Content-Language: en-US
Cc: Miaohe Lin <linmiaohe@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Michal Hocko <mhocko@suse.com>, rafael@kernel.org, Neil Brown <neilb@suse.de>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Eric Dumazet <edumazet@google.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Michel Lespinasse <walken@google.com>, Will Deacon <will@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, dave@stgolabs.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Shakeel Butt <shakeelb@google.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Cong Wang <xiyou.wangcong@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, chenqiwu@xiaomi.com,
 Martin KaFai Lau <kafai@fb.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 christophe.leroy@c-s.fr, Willem de Bruijn <willemb@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg KH <gregkh@linuxfoundation.org>, Florian Westphal <fw@strlen.de>,
 gustavoars@kernel.org, Roman Gushchin <guro@fb.com>,
 Minchan Kim <minchan@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
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

T24gMTAvMTMvMjAgMTowOSBBTSwgTWlrZSBSYXBvcG9ydCB3cm90ZToKPiBPbiBNb24sIE9jdCAx
MiwgMjAyMCBhdCAwNTo1MzowMVBNICswODAwLCBNdWNodW4gU29uZyB3cm90ZToKPj4gT24gTW9u
LCBPY3QgMTIsIDIwMjAgYXQgNToyNCBQTSBFcmljIER1bWF6ZXQgPGVyaWMuZHVtYXpldEBnbWFp
bC5jb20+IHdyb3RlOgo+Pj4KPj4+IE9uIDEwLzEyLzIwIDEwOjM5IEFNLCBNdWNodW4gU29uZyB3
cm90ZToKPj4+PiBPbiBNb24sIE9jdCAxMiwgMjAyMCBhdCAzOjQyIFBNIEVyaWMgRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIE1vbiwgT2N0IDEyLCAy
MDIwIGF0IDY6MjIgQU0gTXVjaHVuIFNvbmcgPHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbT4gd3Jv
dGU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gTW9uLCBPY3QgMTIsIDIwMjAgYXQgMjozOSBBTSBDb25nIFdh
bmcgPHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiBT
YXQsIE9jdCAxMCwgMjAyMCBhdCAzOjM5IEFNIE11Y2h1biBTb25nIDxzb25nbXVjaHVuQGJ5dGVk
YW5jZS5jb20+IHdyb3RlOgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGUgYW1vdW50IG9mIG1lbW9yeSBh
bGxvY2F0ZWQgdG8gc29ja2V0cyBidWZmZXIgY2FuIGJlY29tZSBzaWduaWZpY2FudC4KPj4+Pj4+
Pj4gSG93ZXZlciwgd2UgZG8gbm90IGRpc3BsYXkgdGhlIGFtb3VudCBvZiBtZW1vcnkgY29uc3Vt
ZWQgYnkgc29ja2V0cwo+Pj4+Pj4+PiBidWZmZXIuIEluIHRoaXMgY2FzZSwga25vd2luZyB3aGVy
ZSB0aGUgbWVtb3J5IGlzIGNvbnN1bWVkIGJ5IHRoZSBrZXJuZWwKPj4+Pj4+Pgo+Pj4+Pj4+IFdl
IGRvIGl0IHZpYSBgc3MgLW1gLiBJcyBpdCBub3Qgc3VmZmljaWVudD8gQW5kIGlmIG5vdCwgd2h5
IG5vdCBhZGRpbmcgaXQgdGhlcmUKPj4+Pj4+PiByYXRoZXIgdGhhbiAvcHJvYy9tZW1pbmZvPwo+
Pj4+Pj4KPj4+Pj4+IElmIHRoZSBzeXN0ZW0gaGFzIGxpdHRsZSBmcmVlIG1lbW9yeSwgd2UgY2Fu
IGtub3cgd2hlcmUgdGhlIG1lbW9yeSBpcyB2aWEKPj4+Pj4+IC9wcm9jL21lbWluZm8uIElmIGEg
bG90IG9mIG1lbW9yeSBpcyBjb25zdW1lZCBieSBzb2NrZXQgYnVmZmVyLCB3ZSBjYW5ub3QKPj4+
Pj4+IGtub3cgaXQgd2hlbiB0aGUgU29jayBpcyBub3Qgc2hvd24gaW4gdGhlIC9wcm9jL21lbWlu
Zm8uIElmIHRoZSB1bmF3YXJlIHVzZXIKPj4+Pj4+IGNhbid0IHRoaW5rIG9mIHRoZSBzb2NrZXQg
YnVmZmVyLCBuYXR1cmFsbHkgdGhleSB3aWxsIG5vdCBgc3MgLW1gLiBUaGUKPj4+Pj4+IGVuZCBy
ZXN1bHQKPj4+Pj4+IGlzIHRoYXQgd2Ugc3RpbGwgZG9u4oCZdCBrbm93IHdoZXJlIHRoZSBtZW1v
cnkgaXMgY29uc3VtZWQuIEFuZCB3ZSBhZGQgdGhlCj4+Pj4+PiBTb2NrIHRvIHRoZSAvcHJvYy9t
ZW1pbmZvIGp1c3QgbGlrZSB0aGUgbWVtY2cgZG9lcygnc29jaycgaXRlbSBpbiB0aGUgY2dyb3Vw
Cj4+Pj4+PiB2MiBtZW1vcnkuc3RhdCkuIFNvIEkgdGhpbmsgdGhhdCBhZGRpbmcgdG8gL3Byb2Mv
bWVtaW5mbyBpcyBzdWZmaWNpZW50Lgo+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+PiAgc3RhdGljIGlu
bGluZSB2b2lkIF9fc2tiX2ZyYWdfdW5yZWYoc2tiX2ZyYWdfdCAqZnJhZykKPj4+Pj4+Pj4gIHsK
Pj4+Pj4+Pj4gLSAgICAgICBwdXRfcGFnZShza2JfZnJhZ19wYWdlKGZyYWcpKTsKPj4+Pj4+Pj4g
KyAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHNrYl9mcmFnX3BhZ2UoZnJhZyk7Cj4+Pj4+Pj4+
ICsKPj4+Pj4+Pj4gKyAgICAgICBpZiAocHV0X3BhZ2VfdGVzdHplcm8ocGFnZSkpIHsKPj4+Pj4+
Pj4gKyAgICAgICAgICAgICAgIGRlY19zb2NrX25vZGVfcGFnZV9zdGF0ZShwYWdlKTsKPj4+Pj4+
Pj4gKyAgICAgICAgICAgICAgIF9fcHV0X3BhZ2UocGFnZSk7Cj4+Pj4+Pj4+ICsgICAgICAgfQo+
Pj4+Pj4+PiAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gWW91IG1peCBzb2NrZXQgcGFnZSBmcmFnIHdpdGgg
c2tiIGZyYWcgYXQgbGVhc3QsIG5vdCBzdXJlIHRoaXMgaXMgZXhhY3RseQo+Pj4+Pj4+IHdoYXQg
eW91IHdhbnQsIGJlY2F1c2UgY2xlYXJseSBza2IgcGFnZSBmcmFncyBhcmUgZnJlcXVlbnRseSB1
c2VkCj4+Pj4+Pj4gYnkgbmV0d29yayBkcml2ZXJzIHJhdGhlciB0aGFuIHNvY2tldHMuCj4+Pj4+
Pj4KPj4+Pj4+PiBBbHNvLCB3aGljaCBvbmUgbWF0Y2hlcyB0aGlzIGRlY19zb2NrX25vZGVfcGFn
ZV9zdGF0ZSgpPyBDbGVhcmx5Cj4+Pj4+Pj4gbm90IHNrYl9maWxsX3BhZ2VfZGVzYygpIG9yIF9f
c2tiX2ZyYWdfcmVmKCkuCj4+Pj4+Pgo+Pj4+Pj4gWWVhaCwgd2UgY2FsbCBpbmNfc29ja19ub2Rl
X3BhZ2Vfc3RhdGUoKSBpbiB0aGUgc2tiX3BhZ2VfZnJhZ19yZWZpbGwoKS4KPj4+Pj4+IFNvIGlm
IHNvbWVvbmUgZ2V0cyB0aGUgcGFnZSByZXR1cm5lZCBieSBza2JfcGFnZV9mcmFnX3JlZmlsbCgp
LCBpdCBtdXN0Cj4+Pj4+PiBwdXQgdGhlIHBhZ2UgdmlhIF9fc2tiX2ZyYWdfdW5yZWYoKS9za2Jf
ZnJhZ191bnJlZigpLiBXZSB1c2UgUEdfcHJpdmF0ZQo+Pj4+Pj4gdG8gaW5kaWNhdGUgdGhhdCB3
ZSBuZWVkIHRvIGRlYyB0aGUgbm9kZSBwYWdlIHN0YXRlIHdoZW4gdGhlIHJlZmNvdW50IG9mCj4+
Pj4+PiBwYWdlIHJlYWNoZXMgemVyby4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFBhZ2VzIGNhbiBiZSB0
cmFuc2ZlcnJlZCBmcm9tIHBpcGUgdG8gc29ja2V0LCBzb2NrZXQgdG8gcGlwZSAoc3BsaWNlKCkK
Pj4+Pj4gYW5kIHplcm9jb3B5IGZyaWVuZHMuLi4pCj4+Pj4+Cj4+Pj4+ICBJZiB5b3Ugd2FudCB0
byB0cmFjayBUQ1AgbWVtb3J5IGFsbG9jYXRpb25zLCB5b3UgYWx3YXlzIGNhbiBsb29rIGF0Cj4+
Pj4+IC9wcm9jL25ldC9zb2Nrc3RhdCwKPj4+Pj4gd2l0aG91dCBhZGRpbmcgeWV0IGFub3RoZXIg
ZXhwZW5zaXZlIG1lbW9yeSBhY2NvdW50aW5nLgo+Pj4+Cj4+Pj4gVGhlICdtZW0nIGl0ZW0gaW4g
dGhlIC9wcm9jL25ldC9zb2Nrc3RhdCBkb2VzIG5vdCByZXByZXNlbnQgcmVhbAo+Pj4+IG1lbW9y
eSB1c2FnZS4gVGhpcyBpcyBqdXN0IHRoZSB0b3RhbCBhbW91bnQgb2YgY2hhcmdlZCBtZW1vcnku
Cj4+Pj4KPj4+PiBGb3IgZXhhbXBsZSwgaWYgYSB0YXNrIHNlbmRzIGEgMTAtYnl0ZSBtZXNzYWdl
LCBpdCBvbmx5IGNoYXJnZXMgb25lCj4+Pj4gcGFnZSB0byBtZW1jZy4gQnV0IHRoZSBzeXN0ZW0g
bWF5IGFsbG9jYXRlIDggcGFnZXMuIFRoZXJlZm9yZSwgaXQKPj4+PiBkb2VzIG5vdCB0cnVseSBy
ZWZsZWN0IHRoZSBtZW1vcnkgYWxsb2NhdGVkIGJ5IHRoZSBhYm92ZSBtZW1vcnkKPj4+PiBhbGxv
Y2F0aW9uIHBhdGguIFdlIGNhbiBzZWUgdGhlIGRpZmZlcmVuY2UgdmlhIHRoZSBmb2xsb3dpbmcg
bWVzc2FnZS4KPj4+Pgo+Pj4+IGNhdCAvcHJvYy9uZXQvc29ja3N0YXQKPj4+PiAgIHNvY2tldHM6
IHVzZWQgNjk4Cj4+Pj4gICBUQ1A6IGludXNlIDcwIG9ycGhhbiAwIHR3IDYxNyBhbGxvYyAxMzQg
bWVtIDEzCj4+Pj4gICBVRFA6IGludXNlIDkwIG1lbSA0Cj4+Pj4gICBVRFBMSVRFOiBpbnVzZSAw
Cj4+Pj4gICBSQVc6IGludXNlIDEKPj4+PiAgIEZSQUc6IGludXNlIDAgbWVtb3J5IDAKPj4+Pgo+
Pj4+IGNhdCAvcHJvYy9tZW1pbmZvIHwgZ3JlcCBTb2NrCj4+Pj4gICBTb2NrOiAgICAgICAgICAg
ICAgMTM2NjQga0IKPj4+Pgo+Pj4+IFRoZSAvcHJvYy9uZXQvc29ja3N0YXQgb25seSBzaG93cyB1
cyB0aGF0IHRoZXJlIGFyZSAxNyo0IGtCIFRDUAo+Pj4+IG1lbW9yeSBhbGxvY2F0aW9ucy4gQnV0
IGFwcGx5IHRoaXMgcGF0Y2gsIHdlIGNhbiBzZWUgdGhhdCB3ZSB0cnVseQo+Pj4+IGFsbG9jYXRl
IDEzNjY0IGtCKE1heSBiZSBncmVhdGVyIHRoYW4gdGhpcyB2YWx1ZSBiZWNhdXNlIG9mIHBlci1j
cHUKPj4+PiBzdGF0IGNhY2hlKS4gT2YgY291cnNlIHRoZSBsb2FkIG9mIHRoZSBleGFtcGxlIGhl
cmUgaXMgbm90IGhpZ2guIEluCj4+Pj4gc29tZSBoaWdoIGxvYWQgY2FzZXMsIEkgYmVsaWV2ZSB0
aGUgZGlmZmVyZW5jZSBoZXJlIHdpbGwgYmUgZXZlbgo+Pj4+IGdyZWF0ZXIuCj4+Pj4KPj4+Cj4+
PiBUaGlzIGlzIGdyZWF0LCBidXQgeW91IGhhdmUgbm90IGFkZHJlc3NlZCBteSBmZWVkYmFjay4K
Pj4+Cj4+PiBUQ1AgbWVtb3J5IGFsbG9jYXRpb25zIGFyZSBib3VuZGVkIGJ5IC9wcm9jL3N5cy9u
ZXQvaXB2NC90Y3BfbWVtCj4+Pgo+Pj4gRmFjdCB0aGF0IHRoZSBtZW1vcnkgaXMgZm9yd2FyZCBh
bGxvY2F0ZWQgb3Igbm90IGlzIGEgZGV0YWlsLgo+Pj4KPj4+IElmIHlvdSB0aGluayB3ZSBtdXN0
IHByZS1hbGxvY2F0ZSBtZW1vcnksIGluc3RlYWQgb2YgZm9yd2FyZCBhbGxvY2F0aW9ucywKPj4+
IHlvdXIgcGF0Y2ggZG9lcyBub3QgYWRkcmVzcyB0aGlzLiBBZGRpbmcgb25lIGxpbmUgcGVyIGNv
bnN1bWVyIGluIC9wcm9jL21lbWluZm8gbG9va3MKPj4+IHdyb25nIHRvIG1lLgo+Pgo+PiBJIHRo
aW5rIHRoYXQgdGhlIGNvbnN1bWVyIHdoaWNoIGNvbnN1bWVzIGEgbG90IG9mIG1lbW9yeSBzaG91
bGQgYmUgYWRkZWQKPj4gdG8gdGhlIC9wcm9jL21lbWluZm8uIFRoaXMgY2FuIGhlbHAgdXMga25v
dyB0aGUgdXNlciBvZiBsYXJnZSBtZW1vcnkuCj4+Cj4+Pgo+Pj4gSWYgeW91IGRvIG5vdCB3YW50
IDkuMzcgJSBvZiBwaHlzaWNhbCBtZW1vcnkgYmVpbmcgcG9zc2libHkgdXNlZCBieSBUQ1AsCj4+
PiBqdXN0IGNoYW5nZSAvcHJvYy9zeXMvbmV0L2lwdjQvdGNwX21lbSBhY2NvcmRpbmdseSA/Cj4+
Cj4+IFdlIGFyZSBub3QgY29tcGxhaW5pbmcgYWJvdXQgVENQIHVzaW5nIHRvbyBtdWNoIG1lbW9y
eSwgYnV0IGhvdyBkbwo+PiB3ZSBrbm93IHRoYXQgVENQIHVzZXMgYSBsb3Qgb2YgbWVtb3J5LiBX
aGVuIEkgZmlyc3RseSBmYWNlIHRoaXMgcHJvYmxlbSwKPj4gSSBkbyBub3Qga25vdyB3aG8gdXNl
cyB0aGUgMjVHQiBtZW1vcnkgYW5kIGl0IGlzIG5vdCBzaG93biBpbiB0aGUgL3Byb2MvbWVtaW5m
by4KPj4gSWYgd2UgY2FuIGtub3cgdGhlIGFtb3VudCBtZW1vcnkgb2YgdGhlIHNvY2tldCBidWZm
ZXIgdmlhIC9wcm9jL21lbWluZm8sIHdlCj4+IG1heSBub3QgbmVlZCB0byBzcGVuZCBhIGxvdCBv
ZiB0aW1lIHRyb3VibGVzaG9vdGluZyB0aGlzIHByb2JsZW0uIE5vdCBldmVyeW9uZQo+PiBrbm93
cyB0aGF0IGEgbG90IG9mIG1lbW9yeSBtYXkgYmUgdXNlZCBoZXJlLiBCdXQgSSBiZWxpZXZlIG1h
bnkgcGVvcGxlCj4+IHNob3VsZCBrbm93IC9wcm9jL21lbWluZm8gdG8gY29uZmlybSBtZW1vcnkg
dXNlcnMuCj4gCj4gSWYgSSB1bmRlc3RhbmQgY29ycmVjdGx5LCB0aGUgcHJvYmxlbSB5b3UgYXJl
IHRyeWluZyB0byBzb2x2ZSBpcyB0bwo+IHNpbXBsaWZ5IHRyb3VibGVzaG9vdGluZyBvZiBtZW1v
cnkgdXNhZ2UgZm9yIHBlb3BsZSB3aG8gbWF5IG5vdCBiZSBhd2FyZQo+IHRoYXQgbmV0d29ya2lu
ZyBzdGFjayBjYW4gYmUgYSBsYXJnZSBtZW1vcnkgY29uc3VtZXIuCj4gCj4gRm9yIHRoYXQgYSBw
YXJhZ3JhcGggaW4gJ21hbiA1IHByb2MnIG1heWJlIGEgZ29vZCBzdGFydDoKPiAKPj5Gcm9tIGRk
YmNmMzg1NzZkMWEyYjBlMzZmZTI1YTI3MzUwZDU2Njc1OWI2NjQgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxCj4gRnJvbTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+IERhdGU6
IFR1ZSwgMTMgT2N0IDIwMjAgMTE6MDc6MzUgKzAzMDAKPiBTdWJqZWN0OiBbUEFUQ0hdIHByb2Mu
NTogbWVtaW5mbzogYWRkIG5vdCBhbm91dCBuZXR3b3JrIHN0YWNrIG1lbW9yeQo+ICBjb25zdW1w
dGlvbgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNv
bT4KPiAtLS0KPiAgbWFuNS9wcm9jLjUgfCA4ICsrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvbWFuNS9wcm9jLjUgYi9tYW41L3Byb2Mu
NQo+IGluZGV4IGVkMzA5MzgwYi4uODQxNDY3NmYxIDEwMDY0NAo+IC0tLSBhL21hbjUvcHJvYy41
Cj4gKysrIGIvbWFuNS9wcm9jLjUKPiBAQCAtMzQ3OCw2ICszNDc4LDE0IEBAIEV4Y2VwdCBhcyBu
b3RlZCBiZWxvdywKPiAgYWxsIG9mIHRoZSBmaWVsZHMgaGF2ZSBiZWVuIHByZXNlbnQgc2luY2Ug
YXQgbGVhc3QgTGludXggMi42LjAuCj4gIFNvbWUgZmllbGRzIGFyZSBkaXNwbGF5ZWQgb25seSBp
ZiB0aGUga2VybmVsIHdhcyBjb25maWd1cmVkCj4gIHdpdGggdmFyaW91cyBvcHRpb25zOyB0aG9z
ZSBkZXBlbmRlbmNpZXMgYXJlIG5vdGVkIGluIHRoZSBsaXN0Lgo+ICsuSVAKPiArTm90ZSB0aGF0
IHNpZ25pZmljYW50IHBhcnQgb2YgbWVtb3J5IGFsbG9jYXRlZCBieSB0aGUgbmV0d29yayBzdGFj
awo+ICtpcyBub3QgYWNjb3VudGVkIGluIHRoZSBmaWxlLgo+ICtUaGUgbWVtb3J5IGNvbnN1bXB0
aW9uIG9mIHRoZSBuZXR3b3JrIHN0YWNrIGNhbiBiZSBxdWVyaWVkCj4gK3VzaW5nCj4gKy5JUiAv
cHJvYy9uZXQvc29ja3N0YXQKPiArb3IKPiArLkJSIHNzICg4KQo+ICAuUlMKPiAgLlRQCj4gIC5J
UiBNZW1Ub3RhbCAiICVsdSIKCkhpIE1pa2UsCgpDb3VsZCB5b3UgdGVsbCB1cyB3aGF0IHVuaXRz
IHRob3NlIHZhbHVlcyBhcmUgaW4/Cm9yIGlzIHRoYXQgYWxyZWFkeSBleHBsYWluZWQgc29tZXdo
ZXJlIGVsc2U/Cgp0aGFua3MuCi0tIAp+UmFuZHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
