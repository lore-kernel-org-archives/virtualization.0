From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 15 Sep 2006 13:50:55 -0400
Message-ID: <200609151352_MC3-1-CB54-526A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain;
	 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751281AbWIORyU@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
List-Id: virtualization@lists.linuxfoundation.org

In-Reply-To: <1158309400.23993.9.camel@localhost>

On Fri, 15 Sep 2006 10:36:39 +0200, Martin Schwidefsky wrote:

> I wonder which trick you use, since there is only one page table one
> i386 I can only imagine that you are tracking all page tables of the
> guest.

AMD K8 with the SVM feature has host and guest page tables and
address-space identifiers for the guests so their global TLB flushes
can be limited to their own address space...

-- 
Chuck
