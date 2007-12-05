From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 11:03:39 +0100
Message-ID: <4756777B.6090405@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>	
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>	
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>	
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1196771999.10809.18.camel@sisko.scot.redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Stephen C. Tweedie wrote:
> I can't help wondering if this is a hint that now is the time to find a
> better API, which doesn't have the requirement (a) that seems to be
> causing such trouble?  Are other PV guests --- *BSD, Solaris --- going
> to have the same problems with their VM layers if they try to implement
> this API?

Well, it isn't that easy unfortunaly.  We have to separate two things here:

  (a) the grant table hypercall API (linux kernel <-> xen).
  (b) the grant table device (userspace interface).

The hypercall API *is* heavily used, block and network drivers are using
it for example.  It works quite well as long as the drivers are living
in kernel space, thus the grants are also mapped in kernel space only.
It isn't very hard to control map and unmap then.

The problems start when the gntdev comes into play which wants allow
userspace applications map grant references.  At this point the whole VM
subsystem becomes involved.  And the requirement of the hypercall API to
 do any pte manipulation using grant table hypercalls becomes a real
burden.  The linux VM design simply doesn't allow that.

Consequently the current gntdev implementation tries to get the job done
by bypassing the VM (and hooking into it).  It establishes mappings by
doing the page table manipulations itself in the fops->mmap function.
It tears down mappings using the hook discussed earlier.

gntdev doesn't even try to handle forking.  I wouldn't be surprised if
that is a great way to kill Domain-0.  The xen hypervisor will most
likely not be amused to find a pte refering to a granted (but foreign)
page which wasn't established using the grant table interface.  Pinning
the pgd of the child process will most likely fail and make the kernel
BUG().

cheers,
  Gerd
