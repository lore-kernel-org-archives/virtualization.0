From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix potential interrupts during alternative patching
 [was	Re: [RFC] Avoid PIT SMP lockups]
Date: Thu, 19 Oct 2006 01:49:33 -0700
Message-ID: <45373C1D.9080808@goop.org>
References: <1160170736.6140.31.camel@localhost.localdomain>	<453404F6.5040202@vmware.com>	<200610170121.51492.caglar@pardus.org.tr>	<200610171505.53576.caglar@pardus.org.tr> <453730B7.3040906@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030315AbWJSIq6@vger.kernel.org>
In-Reply-To: <453730B7.3040906@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: caglar@pardus.org.tr, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> So this patch is an obvious bugfix - please apply, and to stable as 
> well. I'm not sure when this broke, but taking interrupts in the 
> middle of self modifying code is not a pretty sight.

I had actually seen this when I built the Xen paravirt kernel with SMP 
on, but I assumed it was something in the pv_ops tree rather than 
mainline...

    J
