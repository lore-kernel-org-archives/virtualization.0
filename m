Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F5DC25B4E
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 13:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 871A5414F8;
	Fri, 20 Jan 2023 13:55:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 871A5414F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdlaOfpm-Po4; Fri, 20 Jan 2023 13:55:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07F9C411AB;
	Fri, 20 Jan 2023 13:55:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07F9C411AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2AA1C0032;
	Fri, 20 Jan 2023 13:55:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6E97C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC0D8414F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:55:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC0D8414F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uv3h2pFnmw2r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:55:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E138C411AB
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E138C411AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:55:28 +0000 (UTC)
Received: from [198.134.98.50] (helo=srivatsab3MD6R.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pIrrV-00Fo3V-LQ;
 Fri, 20 Jan 2023 08:55:21 -0500
Subject: Re: [PATCH v2] x86/hotplug: Do not put offline vCPUs in mwait idle
 state
To: Thomas Gleixner <tglx@linutronix.de>, Igor Mammedov <imammedo@redhat.com>
References: <20230116060134.80259-1-srivatsa@csail.mit.edu>
 <20230116155526.05d37ff9@imammedo.users.ipa.redhat.com> <87bkmui5z4.ffs@tglx>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <ecb9a22e-fd6e-67f0-d916-ad16033fc13c@csail.mit.edu>
Date: Fri, 20 Jan 2023 05:55:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87bkmui5z4.ffs@tglx>
Content-Language: en-US
Cc: x86@kernel.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, ganb@vmware.com, ankitja@vmware.com,
 namit@vmware.com, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, bordoloih@vmware.com,
 xen-devel@lists.xenproject.org, Wyes Karny <wyes.karny@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, keerthanak@vmware.com,
 Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 amakhalov@vmware.com, linux-kernel@vger.kernel.org,
 Lewis Caroll <lewis.carroll@amd.com>, blamoreaux@vmware.com
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


Hi Igor and Thomas,

Thank you for your review!

On 1/19/23 1:12 PM, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 15:55, Igor Mammedov wrote:
>> "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
>>> Fix this by preventing the use of mwait idle state in the vCPU offline
>>> play_dead() path for any hypervisor, even if mwait support is
>>> available.
>>
>> if mwait is enabled, it's very likely guest to have cpuidle
>> enabled and using the same mwait as well. So exiting early from
>>  mwait_play_dead(), might just punt workflow down:
>>   native_play_dead()
>>         ...
>>         mwait_play_dead();
>>         if (cpuidle_play_dead())   <- possible mwait here                                              
>>                 hlt_play_dead(); 
>>
>> and it will end up in mwait again and only if that fails
>> it will go HLT route and maybe transition to VMM.
> 
> Good point.
> 
>> Instead of workaround on guest side,
>> shouldn't hypervisor force VMEXIT on being uplugged vCPU when it's
>> actually hot-unplugging vCPU? (ex: QEMU kicks vCPU out from guest
>> context when it is removing vCPU, among other things)
> 
> For a pure guest side CPU unplug operation:
> 
>     guest$ echo 0 >/sys/devices/system/cpu/cpu$N/online
> 
> the hypervisor is not involved at all. The vCPU is not removed in that
> case.
> 

Agreed, and this is indeed the scenario I was targeting with this patch,
as opposed to vCPU removal from the host side. I'll add this clarification
to the commit message.

> So to ensure that this ends up in HLT something like the below is
> required.
> 
> Note, the removal of the comment after mwait_play_dead() is intentional
> because the comment is completely bogus. Not having MWAIT is not a
> failure. But that wants to be a seperate patch.
> 

Sounds good, will do and post a new version.

Thank you!

Regards,
Srivatsa
VMware Photon OS


> Thanks,
> 
>         tglx
> ---        
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 55cad72715d9..3f1f20f71ec5 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1833,7 +1833,10 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> -	mwait_play_dead();	/* Only returns on failure */
> +	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
> +		hlt_play_dead();
> +
> +	mwait_play_dead();
>  	if (cpuidle_play_dead())
>  		hlt_play_dead();
>  }
> 
> 
>   
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
