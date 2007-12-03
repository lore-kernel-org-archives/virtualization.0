From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 3 Dec 2007 19:08:08 +0000
Message-ID: <200712031908.11079.mark.williamson@cl.cam.ac.uk>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: dgm36@cam.ac.uk
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, 'Gerd Hoffmann' <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Hi Mark,
>
> > Maybe a change to the gntdev userspace API to allow batching
> > of mapping requests?
>
> Something along the lines of the following?

Just like that :-D

When you said "multiple syscalls per mapping" I assumed you meant that we'd 
lose the batching you get by doing a mulicall.  If it's just a couple of 
syscalls (plus, presumably a couple of hypercalls) per batch of mappings, my 
gut says it's probably not going to hurt block performance.  My guts have 
been wrong in (many!) ways before of course...

I guess the overhead *could* be reduced even more by just having a magic ioctl 
that did all the mmap-ing stuff in one operation, but that'd probably be 
really gross if it wasn't necessary!  And I doubt it'd make upstream very 
happy...

We'll also be eliminating the overheads involved in having a blktap ring for 
talking to userspace and having to move requests between that ring and the 
real block ring, so there's some definite wins in overheads as well.

Cheers,
Mark

-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
