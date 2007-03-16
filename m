From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 17:31:21 +0100
Message-ID: <20070316163118.GA12999@elte.hu>
References: <45FA054F.6020107@vmware.com> <m17itho10v.fsf@ebiederm.dsl.xmission.com> <45FAC4EF.4060305@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933648AbXCPQbr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45FAC4EF.4060305@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Zachary Amsden <zach@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > The practical question here is if we already have all of the 
> > relocation logic for the VDSO why do we need to add more?
> 
> The kernel doesn't normally ever relocate the vdso; [...]

that's what is the case right now, but much of the intention behind the 
vma based vDSO is to enable per-process randomized vdso locations, and 
various distributions do that. So the 'modern' vDSO concept is very much 
relocatable.

	Ingo
