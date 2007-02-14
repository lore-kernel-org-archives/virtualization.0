From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [patch 05/21] Xen-paravirt: paravirt_ops: allocate a fixmap slot
Date: Wed, 14 Feb 2007 09:43:49 +0100
Message-ID: <45D2CBC5.90809@suse.de>
References: <20070213221729.772002682@goop.org>	<20070213221829.845132535@goop.org>	<45D2649D.4080508@vmware.com> <45D26797.5090600@goop.org> <45D27534.1070608@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751022AbXBNIoN@vger.kernel.org>
In-Reply-To: <45D27534.1070608@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Hecht <dhecht@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> Right.  But that is only because Xen decides to allocate the page from 
> the (machine) physical space, rather than from the pseudo-physical 
> space.  My question is: why doesn't Xen allocate shared_info from the 
> pseudo-physical space?

Historical reasons ...

> If it had, then this page wouldn't need to be 
> treated specially.  I'm not sure, but I seem to remember on 64-bit 
> Xen/XenLinux allocated shared_info from pseudo-physical space already...

Yep, the ia64 port which came later handles some things differently,
specifically some "magic" pages are allocated more clever ;)

Changing that for x86 would break existing guests though.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
