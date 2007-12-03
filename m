From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 03 Dec 2007 15:16:24 +0100
Message-ID: <47540FB8.8000106@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4754024C.7020905@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Derek Murray wrote:
> I take the blame for that one. I added the hook because, if a process
> were to die whilst holding one or more grants, there were no hooks that
> would make it possible to carry out the grant-unmap. All existing hooks
> on either the device or the VMA were called *after* the PTEs were cleared.

Hmm.  What exactly is the issue here?

This is about *userspace* mappings, right?  As far as I can see from a
quick scan there of the code is an additional kernel space mapping for
the grants and the userspace mapping is optional.  I don't see any
problems with userspace mapping going away without *instant*
notification.  Cleaning up a bit later, called from the
file_ops->release callback maybe, should work ok.

The problem I see with the additional vm_ops callback is that I suspect
you'll have to come up with some *very* good arguments to get it
accepted by the VM (as in "virtual memory") folks and merged mainline.

> It gets better, though. The same hook is used in the version of blktap
> in linux-2.6.18-xen (not, as far as I can see, in the sparse tree for
> xen-3.1-testing):

Oh, I'm thinking more in the direction of killing blktap altogether in
favor of a pure userspace implementation on top of gntdev.

cheers,
  Gerd
