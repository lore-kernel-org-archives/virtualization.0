From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: How to get a sense of VM pressure
Date: Sat, 26 Jul 2008 20:14:12 -0700
Message-ID: <1217128452.23502.4.camel@nimitz>
References: <488A1398.7020004@goop.org>
	 <200807261425.26318.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757540AbYG0DO2@vger.kernel.org>
In-Reply-To: <200807261425.26318.nickpiggin@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2008-07-26 at 14:25 +1000, Nick Piggin wrote:
> Google I think and maybe IBM (can't remember) is using the proc pagemap
> interfaces to help with this. Probably it is super secret code that can't
> be released though -- but it gives you somewhere to look.

Nobody at IBM that I know. :)  I have other nefarious purposes for it,
but not for memory pressure.

-- Dave
