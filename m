From: Dan Hecht <dhecht@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Tue, 06 Mar 2007 13:32:23 -0800
Message-ID: <45EDDDE7.9060408@vmware.com>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net> <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu> <20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com> <1173178774.24738.311.camel@localhost.localdomain> <45EDD82F.90204@vmware.com> <20070306222157.GJ22829@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030182AbXCFVcZ@vger.kernel.org>
In-Reply-To: <20070306222157.GJ22829@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: tglx@linutronix.de, Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/06/2007 02:21 PM, Andi Kleen wrote:
>> I believe this was just a quick fix in response to Ingo breaking the VMI 
>> build yesterday by disabling NO_IDLE_HZ on us.  There is no technical 
>> reason why NO_IDLE_HZ=y can't coexist with NO_HZ.
> 
> Well it's nasty that you force NO_IDLE_HZ on all of paravirt ops users.

The only thing NO_IDLE_HZ=y "forces" on other users is some extra code 
(which you are going to get no matter what with CONFIG_PARAVIRT).   It 
doesn't force them to use this code.  It just provides a few extra 
routines that a paravirt_ops backend might want to call back into (I 
think both vmi and xen backends use these routines and that is why it 
became associated with CONFIG_PARAVIRT rather than CONFIG_VMI).
