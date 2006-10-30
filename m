From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Mon, 30 Oct 2006 15:24:55 -0800
Message-ID: <454689C7.6030009@vmware.com>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com> <200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com> <20061030225016.GA95732@muc.de> <45468620.5060805@vmware.com> <20061030231251.GB98768@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161463AbWJ3XY5@vger.kernel.org>
In-Reply-To: <20061030231251.GB98768@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> That is the one that can panic, for now.  Fixing the paravirtualized 
>> case is easy, but we can't assume paravirtualization just yet.
>>     
>
> Hmm, this means standard vmware boot is not reliable unless that magic option
> is set?   That doesn't sound good.  
>   

It doesn't happen often, but it is a possibility that the kernel 
calibrates the delay wrong because of timing glitches caused by CPU 
migration, paging, or other phenomena which are supposed to be 
transparent to the kernel (but cause temporal lapse).  In that case, the 
kernel may not make enough progress in a spin delay loop to properly 
reach the number of microseconds required for N number of timer ticks to 
occur.  In theory this can happen on a real machine, as SMM mode could 
be active, doing USB device emulation or something that takes a while 
during the lpj calibration and throwing the computation off.

By changing the parameters (N ticks at K Hz in T seconds), it is easy to 
create an unstable measurement that can achieve high failure rates, 
although in practice the Linux parameters appear to be reasonable enough 
that it is not a major problem.

Zach
