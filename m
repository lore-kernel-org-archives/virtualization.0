Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C66C433EF
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 15:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33693425E0;
	Fri, 20 May 2022 15:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_ewu8BEWObU; Fri, 20 May 2022 15:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 68899425C6;
	Fri, 20 May 2022 15:41:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44748C0039;
	Fri, 20 May 2022 15:41:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA005C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 951AB82884
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3x-NDsmG89UN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:41:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp1.osuosl.org (Postfix) with ESMTP id 725D88276E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:41:30 +0000 (UTC)
Received: from [77.23.249.31] (helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1ns4kk-000Jtb-1u; Fri, 20 May 2022 11:41:22 -0400
To: Shreenidhi Shedi <yesshedi@gmail.com>, amakhalov@vmware.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com
References: <20220520140954.597725-1-sshedi@vmware.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] x86/vmware: use unsigned integer for shifting
Message-ID: <a38ef828-dbfa-59c0-475d-e16c44267e6b@csail.mit.edu>
Date: Fri, 20 May 2022 17:41:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220520140954.597725-1-sshedi@vmware.com>
Content-Language: en-US
Cc: pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Shreenidhi Shedi <sshedi@vmware.com>,
 virtualization@lists.linux-foundation.org
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

On 5/20/22 7:09 AM, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> From: Shreenidhi Shedi <sshedi@vmware.com>
> 
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.
> 
> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..cd809c5b17f0 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpu.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
> +#include <linux/bits.h>
>  #include <asm/div64.h>
>  #include <asm/x86_init.h>
>  #include <asm/hypervisor.h>
> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> +		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC))


This patch has clearly not been tested, and not even compiled! (It is
missing a semicolon at the end of the return statement).

Please take your time to revise and test your patch based on the
review feedback; there is no hurry! :)

(Also, while at it, the double From: at the beginning of the patch
needs to be fixed too).

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
