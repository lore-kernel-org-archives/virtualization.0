From: David Miller <davem@davemloft.net>
Subject: Re: [patch 13/26] Xen-paravirt_ops: Consistently wrap paravirt ops
 callsites to make them patchable
Date: Fri, 16 Mar 2007 02:33:31 -0700 (PDT)
Message-ID: <20070316.023331.59468179.davem@davemloft.net>
References: <20070301232443.195603797@goop.org>
	<20070301232527.956565107@goop.org>
	<20070316092445.GM23174@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932908AbXCPJdf@vger.kernel.org>
In-Reply-To: <20070316092445.GM23174@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@elte.hu
Cc: jeremy@goop.org, ak@muc.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, chrisw@sous-sol.org, zach@vmware.com, rusty@rustcorp.com.au, anthony@codemonkey.ws, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 16 Mar 2007 10:24:45 +0100

> ugh. This is beyond ugly! Why dont we just compile two images, one for 
> Xen and one for native, do two passes to get those two images and 
> 'merge' them into a single vmlinuz (so that we still have a 'single' 
> kernel unit to deal with on the distro side). This way we avoid all this 
> crazy, limited, fragile patchery business...

Perhaps the problem can be dealt with using ELF relocations.

There is another case, discussed yesterday on netdev, where run-time
resolution of ELF relocations would be useful (for
very-very-very-read-only variables) so if it can solve this problem
too it would be nice to have a generic infrastructure for it.
