From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 3 Dec 2007 17:18:23 +0000
Message-ID: <200712031718.28234.mark.williamson@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475417E7.9070006@cl.cam.ac.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: xen-devel@lists.xensource.com
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> >> It gets better, though. The same hook is used in the version of blktap
> >> in linux-2.6.18-xen (not, as far as I can see, in the sparse tree for
> >> xen-3.1-testing):
> >
> > Oh, I'm thinking more in the direction of killing blktap altogether in
> > favor of a pure userspace implementation on top of gntdev.
>
> I think this would represent good progress, though I wonder if there
> would be a performance penalty due to performing the mapping and
> unmapping in user-space (multiple syscalls per mapping versus a single
> hypercall).

Maybe a change to the gntdev userspace API to allow batching of mapping 
requests?

I'm not aware of a batched mmap interface, which would seem to be the ideal 
solution; but it should be possible to batch this stuff somehow.  Although it 
seems like some kind of really weird ioctl might be needed :-S to do it 
*without* such a batched interface...

blktap in userspace, if any performance problems can be addressed, would seem 
to be a far nicer way of doing things.  And it's less code to merge 
upstream ;-)

Cheers,
Mark

-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
