From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 9 Aug 2007 10:37:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708091032300.32067__3963.67295547879$1186673999$gmane$org@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081200.13669.ak@suse.de> <46BAB9DD.5030400@goop.org>
	<200708091626.09316.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708091626.09316.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, mingo@elte.hu, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--
On Thu, 9 Aug 2007, Andi Kleen wrote:
>
> > This has to match the normal C calling convention though, doesn't it?
>
> Native cli/sti/save/restore_flags are all only assembly and can be easily
> (in fact more easily than in C) written as pure assembler functions. Then
> you can use whatever calling convention you want.

I agree.
Should we make a paravirt_ops_asm.S file that can implement these native
funcions, and so we can get rid of the C functions only doing asm?

>
> While some paravirt implementations may have more complicated implementations
> i guess it's still a reasonable requirement to make them simple enough
> in pure assembler. If not they can use a trampoline, but that's hopefully
> not needed.

It works for lguest64.  I'm sure it should be no problem with other HVs.

-- Steve
