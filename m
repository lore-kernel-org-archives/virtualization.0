From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 09:37:11 +0100
Message-ID: <45ED2837.3020108@suse.de>
References: <20070305120631.GA14105@elte.hu>	<1173101297.26165.39.camel@localhost.localdomain>	<1173142644.4644.6.camel@localhost.localdomain>	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932980AbXCFIhV@vger.kernel.org>
In-Reply-To: <20070306081909.GA9331@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> btw., while we have everyone on the phone and talking ;) Technologically 
> it would save us a whole lot of trouble in Linux if 'external' 
> hypervisors could standardize around a single ABI - such as VMI. Is 
> there any deep reason why Xen couldnt use VMI to talk to Linux? I 
> suspect a range of VMI vectors could be set aside for Xen's dom0 (and 
> other) APIs that have no current VMI equivalent - if there's broad 
> agreement on the current 60+ base VMI vectors that center around basic 
> x86 CPU capabilities - which make up the largest portion of our 
> paravirtualization complexity. Pipe dream?

IIRC there was some proof-of-concept at least for xen guests.

> there are already 5 major hypervisors we are going to support (in 
> alphabetical order):
> 
>  - KVM
>  - lguest
>  - Windows
>  - VMWare
>  - Xen
> 
> the QA matrix is gonna be a _mess_.

I fail to see how xen-via-vmirom instead of xen-via-paravirt_ops reduces
the QA effort.  You still have 5 Hypervisors you have to test against.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
