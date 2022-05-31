Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C29C433F5
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 12:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A45140961;
	Tue, 31 May 2022 12:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p6ovmjiBaH24; Tue, 31 May 2022 12:52:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EB116408AE;
	Tue, 31 May 2022 12:52:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F06C0039;
	Tue, 31 May 2022 12:52:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B673C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22576408B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bme4BNkoI5CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:52:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9075408AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:52:07 +0000 (UTC)
Received: from ip4d17f91f.dynamic.kabel-deutschland.de ([77.23.249.31]
 helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1nw1Lp-000Lu4-Ri; Tue, 31 May 2022 08:51:58 -0400
To: Peter Zijlstra <peterz@infradead.org>,
 Shreenidhi Shedi <yesshedi@gmail.com>
References: <20220527175737.915284-1-sshedi@vmware.com>
 <YpIpL728ii08D9uK@worktop.programming.kicks-ass.net>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v3] x86/vmware: use unsigned integer for shifting
Message-ID: <5dfc62d1-5778-ed94-3f3e-54e12ee5e4e6@csail.mit.edu>
Date: Tue, 31 May 2022 14:51:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YpIpL728ii08D9uK@worktop.programming.kicks-ass.net>
Content-Language: en-US
Cc: x86@kernel.org, amakhalov@vmware.com, Shreenidhi Shedi <sshedi@vmware.com>,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, tglx@linutronix.de
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

On 5/28/22 6:52 AM, Peter Zijlstra wrote:
> On Fri, May 27, 2022 at 11:27:37PM +0530, Shreenidhi Shedi wrote:
>> From: Shreenidhi Shedi <sshedi@vmware.com>
>>
>> Shifting signed 32-bit value by 31 bits is implementation-defined
>> behaviour. Using unsigned is better option for this.
> 
> The kernel builds with -fno-strict-overflow and as such this behaviour
> is well defined.
>

Ah, I see. Thank you, Peter!
 
>> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
> 
> Nothing broken, therefore nothing fixed.
> 

Agreed.

I think using the BIT() macro still provides a nice readability
improvement. So, Shreenidhi, could you spin a new version of the patch
with the same code changes but with a different commit message about
using the BIT() macro to simplify the code, and also include a
clarification as to why the existing code is correct (which Peter
pointed out), please?

Thank you!

Regards,
Srivatsa
VMware Photon OS
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
