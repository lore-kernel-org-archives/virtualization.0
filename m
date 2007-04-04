From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable
 entries
Date: Wed, 04 Apr 2007 08:45:44 -0700
Message-ID: <4613C828.2030604@goop.org>
References: <20070402055652.610711908@goop.org> <200704020812.18320.ak@suse.de> <46136F25.7030907@goop.org> <200704041347.42822.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933620AbXDDPqD@vger.kernel.org>
In-Reply-To: <200704041347.42822.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Why is there a difference for null syscall? I had assumed we patched all the 
> fast path cases relevant there. Do you have an idea where it comes from?

Sure.  There's indirect calls for things like sti/cli/iret.  It goes
back to native speed when you patch the real instructions inline.

    J
