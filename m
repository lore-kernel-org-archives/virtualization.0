Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC9C4363A
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 15:21:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFE82491B
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VxbGTR1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFE82491B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83780879CD;
	Tue, 13 Oct 2020 15:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOtqHYu-J-fx; Tue, 13 Oct 2020 15:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2CE086F82;
	Tue, 13 Oct 2020 15:21:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85DCCC0052;
	Tue, 13 Oct 2020 15:21:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54470C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 15:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3A1DB87484
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 15:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BMgwV1Jsoa9V
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 15:21:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A04AB87483
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=5RL4Y+hsa8aijqpStulF+xXzWubzL8B4yk2Fwjc3puo=; b=VxbGTR1MRa0lyYvCn2XYCQoIUA
 SYkNUtyIZATMjcJrN5/uV+8SspHQCzZaGETmNyW9Pg+rywr4yDiFJw3LzLQevPdiSJZ+SMb+G2cGD
 B1gqrapcFGTbo+lqOmRhbheXXtxBQDozkaojPadl9V6ZWrop+MucS6hywmlGtnF7D/VvYyEOIqUKT
 ho3u3BD80oYa/KynV49mV2fXVSXA4JqGQvnzlv9av/u6nnCDHDeT8MTgvU4jHl3MYhXrOIoXSAU6s
 m3jKdUquoJ0e/C/aiW/v8uY4P4iFejWiO6QX0C+TYmWYcAVl6u87JbhqgpocQ40T6Keyqn/J/nFhs
 EBo52dMQ==;
Received: from [2601:1c0:6280:3f0::507c]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSM7E-0002Rr-P6; Tue, 13 Oct 2020 15:21:29 +0000
Subject: Re: [External] Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Mike Rapoport <rppt@kernel.org>
References: <20201010103854.66746-1-songmuchun@bytedance.com>
 <CAM_iQpUQXctR8UBNRP6td9dWTA705tP5fWKj4yZe9gOPTn_8oQ@mail.gmail.com>
 <CAMZfGtUhVx_iYY3bJZRY5s1PG0N1mCsYGS9Oku8cTqPiMDze-g@mail.gmail.com>
 <CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com>
 <CAMZfGtXVKER_GM-wwqxrUshDzcEg9FkS3x_BaMTVyeqdYPGSkw@mail.gmail.com>
 <9262ea44-fc3a-0b30-54dd-526e16df85d1@gmail.com>
 <CAMZfGtVF6OjNuJFUExRMY1k-EaDS744=nKy6_a2cYdrJRncTgQ@mail.gmail.com>
 <20201013080906.GD4251@kernel.org>
 <e059f4b1-e51b-0277-e96b-c178d0cf4fd7@infradead.org>
 <20201013151215.GG4251@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3aa9ff1a-e04f-517c-5ebb-2c27804c143a@infradead.org>
Date: Tue, 13 Oct 2020 08:21:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013151215.GG4251@kernel.org>
Content-Language: en-US
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
 Pablo Neira Ayuso <pablo@netfilter.org>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <songmuchun@bytedance.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 10/13/20 8:12 AM, Mike Rapoport wrote:
> On Tue, Oct 13, 2020 at 07:43:59AM -0700, Randy Dunlap wrote:
>> On 10/13/20 1:09 AM, Mike Rapoport wrote:
>>> On Mon, Oct 12, 2020 at 05:53:01PM +0800, Muchun Song wrote:
>>>> On Mon, Oct 12, 2020 at 5:24 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>>>
>>>>> On 10/12/20 10:39 AM, Muchun Song wrote:
>>>>>> On Mon, Oct 12, 2020 at 3:42 PM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>> We are not complaining about TCP using too much memory, but how do
>>>> we know that TCP uses a lot of memory. When I firstly face this problem,
>>>> I do not know who uses the 25GB memory and it is not shown in the /proc/meminfo.
>>>> If we can know the amount memory of the socket buffer via /proc/meminfo, we
>>>> may not need to spend a lot of time troubleshooting this problem. Not everyone
>>>> knows that a lot of memory may be used here. But I believe many people
>>>> should know /proc/meminfo to confirm memory users.
>>>
>>> If I undestand correctly, the problem you are trying to solve is to
>>> simplify troubleshooting of memory usage for people who may not be aware
>>> that networking stack can be a large memory consumer.
>>>
>>> For that a paragraph in 'man 5 proc' maybe a good start:
>>>
>>> >From ddbcf38576d1a2b0e36fe25a27350d566759b664 Mon Sep 17 00:00:00 2001
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>> Date: Tue, 13 Oct 2020 11:07:35 +0300
>>> Subject: [PATCH] proc.5: meminfo: add not anout network stack memory
>>>  consumption
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>  man5/proc.5 | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/man5/proc.5 b/man5/proc.5
>>> index ed309380b..8414676f1 100644
>>> --- a/man5/proc.5
>>> +++ b/man5/proc.5
>>> @@ -3478,6 +3478,14 @@ Except as noted below,
>>>  all of the fields have been present since at least Linux 2.6.0.
>>>  Some fields are displayed only if the kernel was configured
>>>  with various options; those dependencies are noted in the list.
>>> +.IP
>>> +Note that significant part of memory allocated by the network stack
>>> +is not accounted in the file.
>>> +The memory consumption of the network stack can be queried
>>> +using
>>> +.IR /proc/net/sockstat
>>> +or
>>> +.BR ss (8)
>>>  .RS
>>>  .TP
>>>  .IR MemTotal " %lu"
>>
>> Hi Mike,
>>
>> Could you tell us what units those values are in?
>> or is that already explained somewhere else?
> 
> It is described a few lines above and anyway, "MemTotal" is a part of
> the diff context ;-)

with no units AFAICT.

But I was unclear. I wasn't referring to /proc/meminfo, but instead
to /proc/net/sockstat and its units:

sockets: used 1224
TCP: inuse 11 orphan 1 tw 1 alloc 26 mem 3
UDP: inuse 4 mem 2
UDPLITE: inuse 0
RAW: inuse 0
FRAG: inuse 0 memory 0

E.g., for TCP and UDP, are those socket counts or some unit of memory?
If units of memory, what unit size?

thanks.
-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
