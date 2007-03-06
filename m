From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 11:23:19 +0100
Message-ID: <45ED4117.40701@suse.de>
References: <20070305120631.GA14105@elte.hu> <1173101297.26165.39.camel@localhost.localdomain> <1173142644.4644.6.camel@localhost.localdomain> <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org> <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de> <45ED3A8D.9090906@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933220AbXCFKXM@vger.kernel.org>
In-Reply-To: <45ED3A8D.9090906@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@argo.co.il>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Gerd Hoffmann wrote:
>> Oh, and btw:  What was the reason why kvm paravirtualization doesn't use
>> the vmi interface?
>>
>>   
> 
> There actually was proof of concept code to do just that (by Anthony
> Liguori).  For Linux, I feel paravirt_ops is superior as we can extend
> it if something is missing.

Thanks.  That is actually the point I want make: although it is
*possible* to do that via VMI ROM, doing that using paravirt_ops is
*better* (no matter whenever the hypervisor is xen or kvm).  Thats why
we actually have it.  The very same discussion a couple months ago came
to  exactly that conclusion.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
