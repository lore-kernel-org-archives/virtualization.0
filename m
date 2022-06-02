Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91E4C43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 13:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C0EE40B15;
	Thu,  2 Jun 2022 13:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rvRb3OwuDxP; Thu,  2 Jun 2022 13:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17999400D2;
	Thu,  2 Jun 2022 13:02:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF8D1C0039;
	Thu,  2 Jun 2022 13:02:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63B8EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BA16405F3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6DOpFaXSXgXh
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 13:02:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D29D400D2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 13:02:03 +0000 (UTC)
Received: from [77.23.249.31] (helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1nwkSd-000aHy-Hc; Thu, 02 Jun 2022 09:01:59 -0400
Subject: Re: [PATCH v4] x86/vmware: use BIT() macro for shifting
To: Shreenidhi Shedi <yesshedi@gmail.com>, amakhalov@vmware.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com
References: <20220601101820.535031-1-sshedi@vmware.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <f62fcdee-7d38-6bef-f60a-2b7ca3deba47@csail.mit.edu>
Date: Thu, 2 Jun 2022 15:01:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220601101820.535031-1-sshedi@vmware.com>
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

On 6/1/22 3:18 AM, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <sshedi@vmware.com>
> 
> Using BIT() macro improves readability & it uses unsigned long for
> shifting which is an added advantage.
> 
> Kernel builds with -fno-strict-overflow CFLAG hence shifting a signed
> integer by 31 bits is not an issue in this case.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---

Looks good to me.

Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

>  arch/x86/kernel/cpu/vmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f4..02039ec35 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -476,8 +476,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> +		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
>  }
> 
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> --
> 2.36.1
>  
Regards,
Srivatsa
VMware Photon OS
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
