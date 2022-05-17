Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26528C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 16:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AADA7419DA;
	Tue, 17 May 2022 16:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id udtKYsX75BJg; Tue, 17 May 2022 16:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09E7B419C9;
	Tue, 17 May 2022 16:48:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A8FC0039;
	Tue, 17 May 2022 16:48:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E518BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E171783E58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gu3CQAEDMnlK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:48:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp1.osuosl.org (Postfix) with ESMTP id 405AC83DF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:48:16 +0000 (UTC)
Received: from c-24-16-96-21.hsd1.wa.comcast.net ([24.16.96.21]
 helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1nr0Md-000E5Y-3n; Tue, 17 May 2022 12:48:03 -0400
Subject: Re: [PATCH v3] arm64: paravirt: Use RCU read locks to guard
 stolen_time
To: Will Deacon <will@kernel.org>
References: <20220513174654.362169-1-quic_eberman@quicinc.com>
 <c24e405e-b5f9-d2f7-a629-1ee1beab3681@csail.mit.edu>
 <20220517085418.GA3169@willie-the-truck>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <1dc10835-e302-8ae7-c256-efb0c420f35a@csail.mit.edu>
Date: Tue, 17 May 2022 09:48:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220517085418.GA3169@willie-the-truck>
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>,
 Murali Nalajala <quic_mnalajal@quicinc.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Alexey Makhalov <amakhalov@vmware.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 linux-arm-kernel@lists.infradead.org
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

On 5/17/22 1:54 AM, Will Deacon wrote:
> On Fri, May 13, 2022 at 04:32:53PM -0700, Srivatsa S. Bhat wrote:
>> On 5/13/22 10:46 AM, Elliot Berman wrote:
>>> From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>>>

[...]

>>>  static int stolen_time_cpu_down_prepare(unsigned int cpu)
>>>  {
>>> +	struct pvclock_vcpu_stolen_time *kaddr = NULL;
>>>  	struct pv_time_stolen_time_region *reg;
>>>  
>>>  	reg = this_cpu_ptr(&stolen_time_region);
>>>  	if (!reg->kaddr)
>>>  		return 0;
>>>  
>>> -	memunmap(reg->kaddr);
>>> -	memset(reg, 0, sizeof(*reg));
>>> +	kaddr = rcu_replace_pointer(reg->kaddr, NULL, true);
>>> +	synchronize_rcu();
>>> +	memunmap(kaddr);
>>>  
>>
>> The original code used to memset the stolen time region, but this
>> patch seems to drop it. Was that change intentional?
> 
> 'struct pv_time_stolen_time_region' only has one field ('kaddr'), which
> we're now clearing with rcu_replace_pointer() so the memset doesn't make
> sense.
> 

Ah right, never mind :)

Thank you!

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
