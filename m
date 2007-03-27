From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Simplify smp_call_function*() by using common implementation
Date: Tue, 27 Mar 2007 15:46:08 -0700
Message-ID: <46099EB0.8000900@goop.org>
References: <46099709.2000304@goop.org> <20070327154357.f9335623.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934237AbXC0WqM@vger.kernel.org>
In-Reply-To: <20070327154357.f9335623.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Stephane Eranian <eranian@hpl.hp.com>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
>                                               func() or <what>??
>       and what does "nearly ready" mean?
>   

Sorry, I forgot to include your doc updates from last time.

"nearly ready" means that its just about to call the function, but
hasn't necessarily done so.

    J
