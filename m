From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 08:37:54 -0700
Message-ID: <1157125074.28577.94.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122479.28577.64.camel@localhost.localdomain>
	 <1157124580.21733.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751649AbWIAPiM@vger.kernel.org>
In-Reply-To: <1157124580.21733.10.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 17:29 +0200, Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 07:54 -0700, Dave Hansen wrote:
> > Are all of the un/likely()s in here really needed?
> 
> Well, no un/likely is really needed. But they do help the compiler to
> generate better code. It IS unlikely that a page is discarded.

I know what they're _for_. ;)

I seem to recall people being poked in the past for sprinkling too many
of these things around their code.  I just wanted to make sure that
there was some tangible reason for doing it, other than speculative
performance optimization.

-- Dave
