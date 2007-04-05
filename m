From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped location
 with COMPAT_VDSO
Date: Wed, 04 Apr 2007 23:46:29 -0700
Message-ID: <46149B45.2070502@goop.org>
References: <20070405063152.9227D180064@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945958AbXDEGrE@vger.kernel.org>
In-Reply-To: <20070405063152.9227D180064@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland McGrath <roland@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Jan Beulich <JBeulich@novell.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Roland McGrath wrote:
> The patch looks nice and clean.  However, it does not relocate the symbol
> table(s) values.  I thought that was done in an earlier version of this I
> saw, but I might be misremembering.  Though not fatal, this is a regression
> from the previous CONFIG_COMPAT_VDSO behavior.  It will show up in things
> like __kernel_* name display in backtraces.

Hm, OK.  It does, but I wasn't sure if it would matter.  It should be
fairly simple to fix up.

>   If with your other patch
> CONFIG_COMPAT_VDSO will become other than a rarely-used compatibility
> option, then this should be fixed.  Note that with your second patch this
> will also break the symbol values in the randomly-located vma vdso;
> non-ancient glibc doesn't care if the vdso isn't mapped where its phdrs
> say, but everything does still care that the symbol tables in an ELF file
> use addresses matching the phdrs in the same file.
>   

I did the second patch because I could, and to see if it would provoke
some comment.  But effectively removing a kernel config option seems
like a good idea to me.

    J
