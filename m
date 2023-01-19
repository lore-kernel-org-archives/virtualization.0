Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CC2C004D4
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 21:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14218418C3;
	Thu, 19 Jan 2023 21:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14218418C3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mdQ7CD0w;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0BJ5w/p0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JsEnE3y3h_hr; Thu, 19 Jan 2023 21:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5717D41C66;
	Thu, 19 Jan 2023 21:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5717D41C66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 175F0C0033;
	Thu, 19 Jan 2023 21:18:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30706C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 21:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04087405B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 21:18:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04087405B5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=mdQ7CD0w; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=0BJ5w/p0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBsPYntkPIFH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 21:18:56 +0000 (UTC)
X-Greylist: delayed 00:06:19 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DABDB405A7
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DABDB405A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 21:18:55 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1674162752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRUXLP0p0WQ+Qd4xVEuRKMl25ggID9YoYcEY3DCIiik=;
 b=mdQ7CD0wRJvfaZDOr0f82Dc4967iwC75I1+s5lDCu1fHHwtrp+IBba8UPSoQ/va3j4Qar2
 ATGu2nZLLKa0vJ8CheBHLvt0I89xHSG06ZUusQKDPY104va7qqUjwYfiuIUukk+LaqO7Gu
 N+aHnCbtSnW+e8Smx0L+A2DiKy1AOSyLQ5QGRIN4vgJHVE1sRkt9jT/0k9LahiDV7T+AiK
 jKmIL8dmtVDNgeoMh+UAXcZ37mv49o4hNCz9KdPCGAyDUP9ZfpqnymsWZ0f3dG4LxhFiyw
 RTndkgdz2BKS/FhRmtxFB9hP9YbenuT2IOAVALIMh4inh4bZRqxisS45FivGfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1674162752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRUXLP0p0WQ+Qd4xVEuRKMl25ggID9YoYcEY3DCIiik=;
 b=0BJ5w/p0x778LsQ1MznxzGrIdB3OE1QGABAUfN3vpOmJUgdDINUgQsr9tLqZGxSzWuC+ct
 ivl26is4VR39BBBw==
To: Igor Mammedov <imammedo@redhat.com>, "Srivatsa S. Bhat"
 <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] x86/hotplug: Do not put offline vCPUs in mwait idle
 state
In-Reply-To: <20230116155526.05d37ff9@imammedo.users.ipa.redhat.com>
References: <20230116060134.80259-1-srivatsa@csail.mit.edu>
 <20230116155526.05d37ff9@imammedo.users.ipa.redhat.com>
Date: Thu, 19 Jan 2023 22:12:31 +0100
Message-ID: <87bkmui5z4.ffs@tglx>
MIME-Version: 1.0
Cc: x86@kernel.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, ganb@vmware.com, ankitja@vmware.com,
 namit@vmware.com, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>,
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

On Mon, Jan 16 2023 at 15:55, Igor Mammedov wrote:
> "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
>> Fix this by preventing the use of mwait idle state in the vCPU offline
>> play_dead() path for any hypervisor, even if mwait support is
>> available.
>
> if mwait is enabled, it's very likely guest to have cpuidle
> enabled and using the same mwait as well. So exiting early from
>  mwait_play_dead(), might just punt workflow down:
>   native_play_dead()
>         ...
>         mwait_play_dead();
>         if (cpuidle_play_dead())   <- possible mwait here                                              
>                 hlt_play_dead(); 
>
> and it will end up in mwait again and only if that fails
> it will go HLT route and maybe transition to VMM.

Good point.

> Instead of workaround on guest side,
> shouldn't hypervisor force VMEXIT on being uplugged vCPU when it's
> actually hot-unplugging vCPU? (ex: QEMU kicks vCPU out from guest
> context when it is removing vCPU, among other things)

For a pure guest side CPU unplug operation:

    guest$ echo 0 >/sys/devices/system/cpu/cpu$N/online

the hypervisor is not involved at all. The vCPU is not removed in that
case.

So to ensure that this ends up in HLT something like the below is
required.

Note, the removal of the comment after mwait_play_dead() is intentional
because the comment is completely bogus. Not having MWAIT is not a
failure. But that wants to be a seperate patch.

Thanks,

        tglx
---        
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72715d9..3f1f20f71ec5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1833,7 +1833,10 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();	/* Only returns on failure */
+	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
+		hlt_play_dead();
+
+	mwait_play_dead();
 	if (cpuidle_play_dead())
 		hlt_play_dead();
 }


  
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
