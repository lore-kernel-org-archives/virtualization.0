Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7194C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 14:17:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CBF2311D
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 14:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CBF2311D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BC468688F;
	Wed,  5 Aug 2020 14:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6b1qh7yhBNkZ; Wed,  5 Aug 2020 14:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2A04861F0;
	Wed,  5 Aug 2020 14:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA189C0050;
	Wed,  5 Aug 2020 14:17:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B795C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 675E587B69
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1BUGvR1d0wb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:17:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 311498707A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:17:10 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A4C6FB619;
 Wed,  5 Aug 2020 14:17:24 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To: peterz@infradead.org, Marco Elver <elver@google.com>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net>
 <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <b4d46726-d343-f347-c044-06c6e815076a@suse.com>
Date: Wed, 5 Aug 2020 16:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805141237.GS2674@hirez.programming.kicks-ass.net>
Content-Language: en-US
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, yu-cheng.yu@intel.com, tony.luck@intel.com,
 dave.hansen@linux.intel.com, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 virtualization@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, tglx@linutronix.de, x86@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 05.08.20 16:12, peterz@infradead.org wrote:
> On Wed, Aug 05, 2020 at 03:59:40PM +0200, Marco Elver wrote:
>> On Wed, Aug 05, 2020 at 03:42PM +0200, peterz@infradead.org wrote:
> 
>>> Shouldn't we __always_inline those? They're going to be really small.
>>
>> I can send a v2, and you can choose. For reference, though:
>>
>> 	ffffffff86271ee0 <arch_local_save_flags>:
>> 	ffffffff86271ee0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>> 	ffffffff86271ee5:       48 83 3d 43 87 e4 01    cmpq   $0x0,0x1e48743(%rip)        # ffffffff880ba630 <pv_ops+0x120>
>> 	ffffffff86271eec:       00
>> 	ffffffff86271eed:       74 0d                   je     ffffffff86271efc <arch_local_save_flags+0x1c>
>> 	ffffffff86271eef:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>> 	ffffffff86271ef4:       ff 14 25 30 a6 0b 88    callq  *0xffffffff880ba630
>> 	ffffffff86271efb:       c3                      retq
>> 	ffffffff86271efc:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>> 	ffffffff86271f01:       0f 0b                   ud2
> 
>> 	ffffffff86271a90 <arch_local_irq_restore>:
>> 	ffffffff86271a90:       53                      push   %rbx
>> 	ffffffff86271a91:       48 89 fb                mov    %rdi,%rbx
>> 	ffffffff86271a94:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>> 	ffffffff86271a99:       48 83 3d 97 8b e4 01    cmpq   $0x0,0x1e48b97(%rip)        # ffffffff880ba638 <pv_ops+0x128>
>> 	ffffffff86271aa0:       00
>> 	ffffffff86271aa1:       74 11                   je     ffffffff86271ab4 <arch_local_irq_restore+0x24>
>> 	ffffffff86271aa3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>> 	ffffffff86271aa8:       48 89 df                mov    %rbx,%rdi
>> 	ffffffff86271aab:       ff 14 25 38 a6 0b 88    callq  *0xffffffff880ba638
>> 	ffffffff86271ab2:       5b                      pop    %rbx
>> 	ffffffff86271ab3:       c3                      retq
>> 	ffffffff86271ab4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>> 	ffffffff86271ab9:       0f 0b                   ud2
> 
> 
> Blergh, that's abysmall. In part I suspect because you have
> CONFIG_PARAVIRT_DEBUG, let me try and untangle that PV macro maze.
> 

Probably. I have found the following in my kernel:

fffffff81540a5f <arch_local_save_flags>:
ffffffff81540a5f:   ff 14 25 40 a4 23 82    callq  *0xffffffff8223a440
ffffffff81540a66:   c3                      retq


Juergen
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
