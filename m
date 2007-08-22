From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Fix lazy mode vmalloc synchronization for paravirt
Date: Tue, 21 Aug 2007 23:52:21 -0700
Message-ID: <46CBDD25.5050909@vmware.com>
References: <46CB91BC.2010808@vmware.com> <46CBD78C.3020804@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757386AbXHVG5i@vger.kernel.org>
In-Reply-To: <46CBD78C.3020804@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> No, under Xen the kernel/hypervisor PMD is not shared between processes,
> so this is still used when PAE is enabled.
>   

Ahh, yes.  So this was a lucky catch for us.  Non-PAE kernels seem to be 
increasing in value at antique sales.

Zach
