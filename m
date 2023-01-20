Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84C6C05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 15:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DA3A415AE;
	Fri, 20 Jan 2023 15:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DA3A415AE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MO4uzR93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jt3u58lA-qYd; Fri, 20 Jan 2023 15:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F359415A6;
	Fri, 20 Jan 2023 15:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F359415A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31C03C0032;
	Fri, 20 Jan 2023 15:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0981CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 15:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D892C41CDE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 15:37:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D892C41CDE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MO4uzR93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARzyOPfYDRk4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 15:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC63541CDD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC63541CDD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674229060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf+VUNzHo6930QhHDjlYS5a/9FVCtfkspKq7OQ6oVEY=;
 b=MO4uzR935q98DxhIKd51GMndg7y8YlQU/8Frnu4yLKk+0G9e2c+catA2uyLqfZy76Uloxp
 hMgaRSopBnLZhK+3bRzkD+ShtWvJBvXi3qX/eU+EdA6xHLQ7BH8B5d+z51luiIAkNbXHFb
 1n+i94xnvqwTZnEmXJHq0lHeZqBn1QE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-9LzJVtPsPaW0UXg-_QRimQ-1; Fri, 20 Jan 2023 10:37:39 -0500
X-MC-Unique: 9LzJVtPsPaW0UXg-_QRimQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 xj11-20020a170906db0b00b0077b6ecb23fcso4052133ejb.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 07:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf+VUNzHo6930QhHDjlYS5a/9FVCtfkspKq7OQ6oVEY=;
 b=dBnBT4lpMYZlavEeoNWc69or16wjYz5a935r6Ou27bPAX5nMSGytXCKExejpRt8+Zd
 xlMLs0Y6php8vEk5ALAc5vLQt/gVuBmESZaIYBMpem1GJQJh5N2hwW9jQTTFWYyOWUPo
 mgrgiKPQi2Rbtl8FdOnKv1TZ2ww5iLdzbS1yt7vW8WiyB25DJ+jTLwGQvNq37Y/KWU6I
 oRZ5ASyy8kL/9AOqGPhNezHMGv4vfRQfjTFb8j3LHowDvAslpH0Ok+3UXR2BdxjeTlP6
 3Chlu7ryvVMEEC3o/8SGXerxBTSsVaQjRNv5kA2eFRTnP/18E3QI9NfghjWShjuXX9RQ
 Jkug==
X-Gm-Message-State: AFqh2kqRa9dx+YItZMLREjWlHqwSnJCNEa+AnqN3uRTQicessMu657dB
 RHzFCAqKx8IiJkA6kPQbxC5iFoxr+TuBJORwc5jmKb6/OU/0vS6PfzXQe43AXuJ7SBvC/1GYIKs
 lvCLfBrZPBLKC4ACjUFwUEWwBt+6psoiVHE2c3mYW1g==
X-Received: by 2002:a05:6402:413:b0:498:b9ea:1894 with SMTP id
 q19-20020a056402041300b00498b9ea1894mr14217265edv.15.1674229058215; 
 Fri, 20 Jan 2023 07:37:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9Neac975gd5nkcxdpVzeTBwC+wqA5CjhhwnQrnrtHBQwgyExGpn/wMyvV8tTW0X127YXwMw==
X-Received: by 2002:a05:6402:413:b0:498:b9ea:1894 with SMTP id
 q19-20020a056402041300b00498b9ea1894mr14217220edv.15.1674229057884; 
 Fri, 20 Jan 2023 07:37:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 eg49-20020a05640228b100b00488117821ffsm17591730edb.31.2023.01.20.07.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 07:37:35 -0800 (PST)
Date: Fri, 20 Jan 2023 16:37:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] x86/hotplug: Do not put offline vCPUs in mwait idle
 state
Message-ID: <20230120163734.63e62444@imammedo.users.ipa.redhat.com>
In-Reply-To: <ecb9a22e-fd6e-67f0-d916-ad16033fc13c@csail.mit.edu>
References: <20230116060134.80259-1-srivatsa@csail.mit.edu>
 <20230116155526.05d37ff9@imammedo.users.ipa.redhat.com>
 <87bkmui5z4.ffs@tglx>
 <ecb9a22e-fd6e-67f0-d916-ad16033fc13c@csail.mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>, amakhalov@vmware.com,
 linux-kernel@vger.kernel.org, Lewis Caroll <lewis.carroll@amd.com>,
 blamoreaux@vmware.com
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

On Fri, 20 Jan 2023 05:55:11 -0800
"Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:

> Hi Igor and Thomas,
> 
> Thank you for your review!
> 
> On 1/19/23 1:12 PM, Thomas Gleixner wrote:
> > On Mon, Jan 16 2023 at 15:55, Igor Mammedov wrote:  
> >> "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:  
> >>> Fix this by preventing the use of mwait idle state in the vCPU offline
> >>> play_dead() path for any hypervisor, even if mwait support is
> >>> available.  
> >>
> >> if mwait is enabled, it's very likely guest to have cpuidle
> >> enabled and using the same mwait as well. So exiting early from
> >>  mwait_play_dead(), might just punt workflow down:
> >>   native_play_dead()
> >>         ...
> >>         mwait_play_dead();
> >>         if (cpuidle_play_dead())   <- possible mwait here                                              
> >>                 hlt_play_dead(); 
> >>
> >> and it will end up in mwait again and only if that fails
> >> it will go HLT route and maybe transition to VMM.  
> > 
> > Good point.
> >   
> >> Instead of workaround on guest side,
> >> shouldn't hypervisor force VMEXIT on being uplugged vCPU when it's
> >> actually hot-unplugging vCPU? (ex: QEMU kicks vCPU out from guest
> >> context when it is removing vCPU, among other things)  
> > 
> > For a pure guest side CPU unplug operation:
> > 
> >     guest$ echo 0 >/sys/devices/system/cpu/cpu$N/online
> > 
> > the hypervisor is not involved at all. The vCPU is not removed in that
> > case.
> >   
> 
> Agreed, and this is indeed the scenario I was targeting with this patch,
> as opposed to vCPU removal from the host side. I'll add this clarification
> to the commit message.

commit message explicitly said:
"which prevents the hypervisor from running other vCPUs or workloads on the
corresponding pCPU."

and that implies unplug on hypervisor side as well.
Why? That's because when hypervisor exposes mwait to guest, it has to reserve/pin
a pCPU for each of present vCPUs. And you can safely run other VMs/workloads
on that pCPU only after it's not possible for it to be reused by VM where
it was used originally.

Now consider following worst (and most likely) case without unplug
on hypervisor side:

 1. vm1mwait: pin pCPU2 to vCPU2
 2. vm1mwait: guest$ echo 0 >/sys/devices/system/cpu/cpu2/online
        -> HLT -> VMEXIT
 --
 3. vm2mwait: pin pCPU2 to vCPUx and start VM
 4. vm2mwait: guest OS onlines Vcpu and starts using it incl.
       going into idle=>mwait state
 --
 5. vm1mwait: it still thinks that vCPU is present it can rightfully do:
       guest$ echo 1 >/sys/devices/system/cpu/cpu2/online
 --              
 6.1 best case vm1mwait online fails after timeout
 6.2 worse case: vm2mwait does VMEXIT on vCPUx around time-frame when
     vm1mwait onlines vCPU2, the online may succeed and then vm2mwait's
     vCPUx will be stuck (possibly indefinitely) until for some reason
     VMEXIT happens on vm1mwait's vCPU2 _and_ host decides to schedule
     vCPUx on pCPU2 which would make vm1mwait stuck on vCPU2.
So either way it's expected behavior.

And if there is no intention to unplug vCPU on hypervisor side,
then VMEXIT on play_dead is not really necessary (mwait is better
then HLT), since hypervisor can't safely reuse pCPU elsewhere and
VCPU goes into deep sleep within guest context.

PS:
The only case where making HLT/VMEXIT on play_dead might work out,
would be if new workload weren't pinned to the same pCPU nor
used mwait (i.e. host can migrate it elsewhere and schedule
vCPU2 back on pCPU2).


> > So to ensure that this ends up in HLT something like the below is
> > required.
> > 
> > Note, the removal of the comment after mwait_play_dead() is intentional
> > because the comment is completely bogus. Not having MWAIT is not a
> > failure. But that wants to be a seperate patch.
> >   
> 
> Sounds good, will do and post a new version.
> 
> Thank you!
> 
> Regards,
> Srivatsa
> VMware Photon OS
> 
> 
> > Thanks,
> > 
> >         tglx
> > ---        
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 55cad72715d9..3f1f20f71ec5 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1833,7 +1833,10 @@ void native_play_dead(void)
> >  	play_dead_common();
> >  	tboot_shutdown(TB_SHUTDOWN_WFS);
> >  
> > -	mwait_play_dead();	/* Only returns on failure */
> > +	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
> > +		hlt_play_dead();
> > +
> > +	mwait_play_dead();
> >  	if (cpuidle_play_dead())
> >  		hlt_play_dead();
> >  }
> > 
> > 
> >   
> >   
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
