From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 10:11:48 +0000
Message-ID: <47567964.2030402@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>	
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>	
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>	
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Stephen C. Tweedie wrote:
> So... the interface (a) cannot be used on the Linux VM without at least
> one invasive VM modification, due to the requirement of ptes being
> explicitly unmapped via hypercall;

Also there is the use of VM_FOREIGN 
(http://xenbits.xensource.com/linux-2.6.18-xen.hg?file/b2768401db94/mm/memory.c 
lines 1040--1059), which has been used quite happily in blktap since 
2005 
(http://lists.xensource.com/archives/html/xen-changelog/2005-07/msg00053.html). 
While it may not be a priority to get gntdev into pv-ops Linux, I should 
imagine that blktap would be fairly critical.

> I can't help wondering if this is a hint that now is the time to find a
> better API, which doesn't have the requirement (a) that seems to be
> causing such trouble?  Are other PV guests --- *BSD, Solaris --- going
> to have the same problems with their VM layers if they try to implement
> this API?  Upstream Linux pv_ops certainly will, and it would be good if
> we could avoid tying unprivileged guests to ABIs which cannot hope to be
> merged into pv_ops.

I'm open to suggestions... but I think it always reduces to needing a 
hook that is called on process exit before the PTEs are zapped.

> (Just what is the cost of not having this functionality in blktap,
> anyway?)

If tapdisk dies whilst holding a granted page, the page can never be 
ungranted, so we leak that page.

Regards,

Derek.
