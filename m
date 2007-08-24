From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 23 Aug 2007 23:59:40 -0700
Message-ID: <46CE81DC.90103@vmware.com>
References: <46CE70C8.2030005@vmware.com> <46CE8069.9070404@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760937AbXHXHFQ@vger.kernel.org>
In-Reply-To: <46CE8069.9070404@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Hm.  Doing any kind of lazy-state operation with preemption enabled is
> fundamentally meaningless.  How does it get into a preemptable state
>   

Agree 100%.  It is the lazy mode flush that might happen when preempt is 
enabled, but lazy mode is disabled.  In that case, the code relies on 
per-cpu variables, which is a bad thing to do in preemtible code.  This 
can happen in the current code path.

Thinking slightly deeper about it, it might be the case that there is no 
bug, because the local lazy mode variables are only _modified_ in the 
preemptible state, and guaranteed to be zero in the non-preemtible 
state; but it was not clear to me that this is always the case, and I 
got very nervous about reading per-cpu variables with preempt enabled.  
It would, in any case, fire a BUG_ON in the Xen code, which I did fix.

Do you agree it is better to be safe than sorry in this case?  The kind 
of bugs introduced by getting this wrong are really hard to find, and I 
would rather err on the side of an extra increment and decrement of 
preempt_count that causing a regression.

Zach
