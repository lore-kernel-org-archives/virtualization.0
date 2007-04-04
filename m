From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack	pagetable
 entries
Date: Wed, 04 Apr 2007 16:39:45 -0700
Message-ID: <46143741.3020408@goop.org>
References: <20070402055652.610711908@goop.org>	 <200704041347.42822.ak@suse.de> <4613C828.2030604@goop.org>	 <200704041756.35016.ak@suse.de> <1175727549.12230.583.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752854AbXDDXkO@vger.kernel.org>
In-Reply-To: <1175727549.12230.583.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> You'll still have the damage inflicted on gcc's optimizer, though.

Well, I could remove the clobbers for PVOP_CALL[0-2] and add the
appropriate push/pops, and put similar push/pop wrappers around all the
called functions.  But it doesn't make it any prettier.

    J
