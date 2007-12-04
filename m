From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 04 Dec 2007 12:39:59 +0000
Message-ID: <1196771999.10809.18.camel@sisko.scot.redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>
	<475541A8.7030100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475541A8.7030100@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Stephen Tweedie <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On Tue, 2007-12-04 at 13:01 +0100, Gerd Hoffmann wrote:

> >> Who uses the gntdev device right now?
> > 
> > Good question! I'm aware of it being used in a few research projects,
> > and it seems to work for them (though I think it is mostly used with the
> > linux-2.6.18-xen kernel). Anyone else?
> 
> So it effectively got no real-world testing yet ...

So... the interface (a) cannot be used on the Linux VM without at least
one invasive VM modification, due to the requirement of ptes being
explicitly unmapped via hypercall; and (b) isn't used significantly in
real life yet.

I can't help wondering if this is a hint that now is the time to find a
better API, which doesn't have the requirement (a) that seems to be
causing such trouble?  Are other PV guests --- *BSD, Solaris --- going
to have the same problems with their VM layers if they try to implement
this API?  Upstream Linux pv_ops certainly will, and it would be good if
we could avoid tying unprivileged guests to ABIs which cannot hope to be
merged into pv_ops.

(Just what is the cost of not having this functionality in blktap,
anyway?)

--Stephen
