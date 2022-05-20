Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D92C433EF
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 11:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F51D42550;
	Fri, 20 May 2022 11:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoJE7AvDHh92; Fri, 20 May 2022 11:29:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4AF0424C3;
	Fri, 20 May 2022 11:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 878F6C0039;
	Fri, 20 May 2022 11:29:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1A2DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F32684490
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPIPhJaZdqFO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:29:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB63584488
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:29:42 +0000 (UTC)
Received: from [77.23.249.31] (helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1ns0p7-0005LB-Jg; Fri, 20 May 2022 07:29:37 -0400
To: Borislav Petkov <bp@alien8.de>, Shreenidhi Shedi <yesshedi@gmail.com>
References: <20220520072857.592746-1-sshedi@vmware.com>
 <Yode3m6iia9ZBHsl@zn.tnic>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] x86/vmware: use unsigned integer for shifting
Message-ID: <c3219731-5f7e-80ea-b193-f8c93d7c1bdc@csail.mit.edu>
Date: Fri, 20 May 2022 13:29:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yode3m6iia9ZBHsl@zn.tnic>
Content-Language: en-US
Cc: x86@kernel.org, amakhalov@vmware.com, Shreenidhi Shedi <sshedi@vmware.com>,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
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

Hi Shreenidhi,

Thank you for the patch!

On 5/20/22 2:26 AM, Borislav Petkov wrote:
> On Fri, May 20, 2022 at 12:58:57PM +0530, Shreenidhi Shedi wrote:
>> Shifting signed 32-bit value by 31 bits is implementation-defined
>> behaviour. Using unsigned is better option for this.
>>

Can you also add a "Fixes:" tag with the commit that introduced the
issue? I believe it is 4cca6ea04d31 ("x86/apic: Allow x2apic without
IR on VMware platform").

>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>> ---
>>  arch/x86/kernel/cpu/vmware.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>> index c04b933f48d3..b28f789d3c56 100644
>> --- a/arch/x86/kernel/cpu/vmware.c
>> +++ b/arch/x86/kernel/cpu/vmware.c
>> @@ -476,7 +476,7 @@ static bool __init vmware_legacy_x2apic_available(void)
>>  {
>>  	uint32_t eax, ebx, ecx, edx;
>>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
>> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>> +	return (eax & (1U << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>>  	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> 
> Or you can use the BIT() macro and simplify this expression even more:
> 
>        return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
>                (eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
> 
> 

That's better indeed.

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
