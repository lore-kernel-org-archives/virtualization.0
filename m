Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCDFC433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 16:37:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A17E22403
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oScIWqUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A17E22403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BAEE12E337;
	Sat, 10 Oct 2020 16:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qccmKrCVOg5e; Sat, 10 Oct 2020 16:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 46EA62034A;
	Sat, 10 Oct 2020 16:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22B1CC07FF;
	Sat, 10 Oct 2020 16:37:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E8A2C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 16:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 51A47870F4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 16:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5DH3uvi70xGm
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 16:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 79304863CD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=MW24HhFwFfGIeQJGLuezuzELB0g5N7HkPqr7uAX0N+s=; b=oScIWqUOiH3J9pqSo9SHSZaKgg
 G9dV+RYanl2AxUqG2llr4HvArk+ueT9cGvrgm3Qkh1pbG+IkGDLOZQCggUtAarBWTjiPYDDi3cCgr
 mPJs8/BlMEL1ucx0YiembjuXBi3e3ZHa4OKjNzTsc2k28FSD9USstIqnzNE+oE3FZbvKTMcAyAVN4
 bSTZwsZ1o1i8ct8E6eujqe2U0GVTJewEeNhJK3TZDoTObSFTsSah9TUMKEPXLWq2xOQ3eyWYkpXJq
 cFhjzoIoFWn+afqvTSG9cgPUg3q4nZ2r9FrZDQyE2T8sVEl/oUAqes3hG9Lb8NaqyG5zZ2ZX5KyJw
 YPQtQWCQ==;
Received: from [2601:1c0:6280:3f0::507c]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kRHrD-00024R-2j; Sat, 10 Oct 2020 16:36:31 +0000
Subject: Re: [PATCH] mm: proc: add Sock to /proc/meminfo
To: Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 kuba@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
 edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 shakeelb@google.com, will@kernel.org, mhocko@suse.com, guro@fb.com,
 neilb@suse.de, rppt@kernel.org, samitolvanen@google.com,
 kirill.shutemov@linux.intel.com, feng.tang@intel.com, pabeni@redhat.com,
 willemb@google.com, fw@strlen.de, gustavoars@kernel.org,
 pablo@netfilter.org, decui@microsoft.com, jakub@cloudflare.com,
 peterz@infradead.org, christian.brauner@ubuntu.com, ebiederm@xmission.com,
 tglx@linutronix.de, dave@stgolabs.net, walken@google.com, jannh@google.com,
 chenqiwu@xiaomi.com, christophe.leroy@c-s.fr, minchan@kernel.org,
 kafai@fb.com, ast@kernel.org, daniel@iogearbox.net, linmiaohe@huawei.com,
 keescook@chromium.org
References: <20201010103854.66746-1-songmuchun@bytedance.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f6dfa37f-5991-3e96-93b8-737f60128151@infradead.org>
Date: Sat, 10 Oct 2020 09:36:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201010103854.66746-1-songmuchun@bytedance.com>
Content-Language: en-US
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Hi,

On 10/10/20 3:38 AM, Muchun Song wrote:
> The amount of memory allocated to sockets buffer can become significant.
> However, we do not display the amount of memory consumed by sockets
> buffer. In this case, knowing where the memory is consumed by the kernel
> is very difficult. On our server with 500GB RAM, sometimes we can see
> 25GB disappear through /proc/meminfo. After our analysis, we found the
> following memory allocation path which consumes the memory with page_owner
> enabled.
> 
>   849698 times:
>   Page allocated via order 3, mask 0x4052c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP)
>    __alloc_pages_nodemask+0x11d/0x290
>    skb_page_frag_refill+0x68/0xf0
>    sk_page_frag_refill+0x19/0x70
>    tcp_sendmsg_locked+0x2f4/0xd10
>    tcp_sendmsg+0x29/0xa0
>    sock_sendmsg+0x30/0x40
>    sock_write_iter+0x8f/0x100
>    __vfs_write+0x10b/0x190
>    vfs_write+0xb0/0x190
>    ksys_write+0x5a/0xd0
>    do_syscall_64+0x5d/0x110
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/base/node.c      |  2 ++
>  drivers/net/virtio_net.c |  3 +--
>  fs/proc/meminfo.c        |  1 +
>  include/linux/mmzone.h   |  1 +
>  include/linux/skbuff.h   | 43 ++++++++++++++++++++++++++++++++++++++--
>  kernel/exit.c            |  3 +--
>  mm/page_alloc.c          |  7 +++++--
>  mm/vmstat.c              |  1 +
>  net/core/sock.c          |  8 ++++----
>  net/ipv4/tcp.c           |  3 +--
>  net/xfrm/xfrm_state.c    |  3 +--
>  11 files changed, 59 insertions(+), 16 deletions(-)

Thanks for finding that.

Please update Documentation/filesystems/proc.rst "meminfo" section also.

-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
