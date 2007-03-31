From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 4/6] Convert PDA into the percpu section
Date: Sat, 31 Mar 2007 04:35:58 +0200
Message-ID: <200703310435.59298.ak@suse.de>
References: <20070331020042.003398870@goop.org> <20070331020055.075978807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933322AbXCaCgI@vger.kernel.org>
In-Reply-To: <20070331020055.075978807@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 31 March 2007 04:00, Jeremy Fitzhardinge wrote:
> Currently x86 (similar to x84-64) has a special per-cpu structure
> called "i386_pda" which can be easily and efficiently referenced via
> the %fs register.  An ELF section is more flexible than a structure,
> allowing any piece of code to use this area.  Indeed, such a section
> already exists: the per-cpu area.

Hmm, I'm a little reluctant. This moves i386 more away from x86-64
again. If we ever merge them it would mean more work. Do you really need it?



-Andi
