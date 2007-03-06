From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 11:31:37 +0100
Message-ID: <20070306103137.GB7478@elte.hu>
References: <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org> <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de> <45ED3A8D.9090906@argo.co.il> <45ED4117.40701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934013AbXCFKb4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45ED4117.40701@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Avi Kivity <avi@argo.co.il>, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Gerd Hoffmann <kraxel@suse.de> wrote:

> Thanks.  That is actually the point I want make: although it is 
> *possible* to do that via VMI ROM, doing that using paravirt_ops is 
> *better* (no matter whenever the hypervisor is xen or kvm). [...]

but paravirt_ops is not an ABI ... nor will it ever become one. So the 
fact remains: the extra ABIs towards external hypervisors are quite an 
issue.

> [...] The very same discussion a couple months ago came to exactly 
> that conclusion.

uhm, that discussion mostly only involved people interested in external 
hypervisors, not those poor souls who have to fix up the mess in the end 
within Linux ;-) [ I am very sure all foxes would come to the happy 
conclusion that there is no need for any stinkin' lock on the barn ;-) ]

	Ingo
