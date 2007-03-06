From: Avi Kivity <avi@argo.co.il>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 11:55:25 +0200
Message-ID: <45ED3A8D.9090906@argo.co.il>
References: <20070305120631.GA14105@elte.hu> <1173101297.26165.39.camel@localhost.localdomain> <1173142644.4644.6.camel@localhost.localdomain> <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org> <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030344AbXCFJ6G@vger.kernel.org>
In-Reply-To: <45ED3121.8090308@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Oh, and btw:  What was the reason why kvm paravirtualization doesn't use
> the vmi interface?
>
>   

There actually was proof of concept code to do just that (by Anthony 
Liguori).  For Linux, I feel paravirt_ops is superior as we can extend 
it if something is missing.  If VMI is adopted by non-Linux guests, we 
may support it as a quick way to add paravirt support for those guests.

-- 
error compiling committee.c: too many arguments to function
