From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
 entry.S
Date: Wed, 08 Aug 2007 22:21:11 -0700
Message-ID: <46BAA447.9010504__242.127668070857$1186637082$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
	<p738x8mrv4m.fsf@bingen.suse.de>
	<Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0708080924590.7236@gandalf.stny.rr.com>
	<20070808133001.GD14419@one.firstfloor.org>
	<Pine.LNX.4.58.0708080936070.7516@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.58.0708080936070.7516@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, Andi Kleen <andi@firstfloor.org>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Steven Rostedt wrote:
> 	/*
> 	 * x86 arch doesn't have an easy way to find out where
> 	 * gs is located. So we need to read the MSR. But first
> 	 * we need to save off the rcx, rax and rdx.
>   
Why don't you store it in gs?  movq %gs:my_gs_base, %rax?

    J
