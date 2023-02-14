Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5BCC61DA4
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 17:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B505940B86;
	Tue, 14 Feb 2023 17:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B505940B86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u65k-_TxeXom; Tue, 14 Feb 2023 17:10:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5696140B6E;
	Tue, 14 Feb 2023 17:10:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5696140B6E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBC7C0032;
	Tue, 14 Feb 2023 17:10:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF74C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 17:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA07C81A23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 17:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA07C81A23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gDJeXJTLcQY7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 17:10:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1178181E55
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1178181E55
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 17:10:08 +0000 (UTC)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140]
 helo=srivatsab3MD6R.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pRyod-003ROd-5s;
 Tue, 14 Feb 2023 12:10:03 -0500
Subject: Re: [PATCH] x86/hotplug: Remove incorrect comment about
 mwait_play_dead()
To: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
 peterz@infradead.org, hpa@zytor.com
References: <20230128003751.141317-1-srivatsa@csail.mit.edu>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <e6792ea0-d210-a31d-b7da-8525e1315505@csail.mit.edu>
Date: Tue, 14 Feb 2023 09:09:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230128003751.141317-1-srivatsa@csail.mit.edu>
Content-Language: en-US
Cc: kvm@vger.kernel.org, pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, ganb@vmware.com, ankitja@vmware.com,
 namit@vmware.com, amakhalov@vmware.com, rafael.j.wysocki@intel.com,
 bordoloih@vmware.com, xen-devel@lists.xenproject.org, wyes.karny@amd.com,
 thomas.lendacky@amd.com, paulmck@kernel.org, keerthanak@vmware.com,
 bp@alien8.de, jgross@suse.com, seanjc@google.com, linux-kernel@vger.kernel.org,
 lewis.carroll@amd.com, imammedo@redhat.com, blamoreaux@vmware.com
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

On 1/27/23 4:37 PM, Srivatsa S. Bhat wrote:
> From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
> 
> The comment that says mwait_play_dead() returns only on failure is a
> bit misleading because mwait_play_dead() could actually return for
> valid reasons (such as mwait not being supported by the platform) that
> do not indicate a failure of the CPU offline operation. So, remove the
> comment.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>


Gentle ping for review. Thank you!

Regards,
Srivatsa

> ---
>  arch/x86/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 55cad72715d9..9013bb28255a 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1833,7 +1833,7 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> -	mwait_play_dead();	/* Only returns on failure */
> +	mwait_play_dead();
>  	if (cpuidle_play_dead())
>  		hlt_play_dead();
>  }
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
