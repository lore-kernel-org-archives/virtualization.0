From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 4/6] Rename the parainstructions symbols to be
	consistent with the others
Date: Wed, 04 Apr 2007 12:03:17 +1000
Message-ID: <1175652197.12230.563.camel@localhost.localdomain>
References: <20070404010655.400913479@goop.org>
	 <20070404011453.598418421@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966276AbXDDCEE@vger.kernel.org>
In-Reply-To: <20070404011453.598418421@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-04-03 at 18:06 -0700, Jeremy Fitzhardinge wrote:
> plain text document attachment (fix-parainstructions-name.patch)
> The other symbols used to delineate the alt-instructions sections have
> the form __foo/__foo_end.  Rename parainstructions to match.

OK, I guess this is an area where the kernel has its own standard.

(__start_<secname> and __stop_<secname> are the symbols automatically
inserted by ld if the section name is straight alpha-numeric.  It's
actually pretty cool for code where you want section boundaries without
writing a linker script).

Cheers,
Rusty.
