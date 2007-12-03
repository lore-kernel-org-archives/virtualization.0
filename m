From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 03 Dec 2007 14:51:19 +0000
Message-ID: <475417E7.9070006@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>
	<47540FB8.8000106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <47540FB8.8000106@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Derek Murray wrote:
>> I take the blame for that one. I added the hook because, if a process
>> were to die whilst holding one or more grants, there were no hooks that
>> would make it possible to carry out the grant-unmap. All existing hooks
>> on either the device or the VMA were called *after* the PTEs were cleared.
> 
> Hmm.  What exactly is the issue here?
> 
> This is about *userspace* mappings, right?  As far as I can see from a
> quick scan there of the code is an additional kernel space mapping for
> the grants and the userspace mapping is optional.  I don't see any
> problems with userspace mapping going away without *instant*
> notification.  Cleaning up a bit later, called from the
> file_ops->release callback maybe, should work ok.

If we let Linux zap the page tables before we unmap the grant reference, 
then it is not possible to unmap the grant reference. The 
unmap_grant_ref hypercall ultimately calls destroy_grant_pte_mapping in 
xen/arch/x86/mm.c, which ensures that the PTE does in fact point to the 
granted frame. Note also the comment further up in that file (in 
put_page_from_l1e):

     /*
      * Check if this is a mapping that was established via a grant 
reference.
      * If it was then we should not be here: we require that such 
mappings are
      * explicitly destroyed via the grant-table interface.
      *
      * The upshot of this is that the guest can end up with active 
grants that
      * it cannot destroy (because it no longer has a PTE to present to the
      * grant-table interface). This can lead to subtle hard-to-catch bugs,
      * hence a special grant PTE flag can be enabled to catch the bug 
early.
      *
      * (Note that the undestroyable active grants are not a security 
hole in
      * Xen. All active grants can safely be cleaned up when the domain 
dies.)
      */

Effectively, there is a debug option that sets a bit in PTEs that map 
granted pages, and this can be used to force a domain_crash in the event 
that a VM tries to zap the entries normally. The normal behaviour is to 
silently accept the zap operation, and leak granted pages until the 
grantee domain is killed.

> The problem I see with the additional vm_ops callback is that I suspect
> you'll have to come up with some *very* good arguments to get it
> accepted by the VM (as in "virtual memory") folks and merged mainline.

On this point I completely agree with you! If anyone has any less 
radical suggestions, then I'd be delighted to refactor the gntdev code 
to use them. However, I'm not currently aware of any alternative that 
maintains robustness to process crashes.

>> It gets better, though. The same hook is used in the version of blktap
>> in linux-2.6.18-xen (not, as far as I can see, in the sparse tree for
>> xen-3.1-testing):
> 
> Oh, I'm thinking more in the direction of killing blktap altogether in
> favor of a pure userspace implementation on top of gntdev.

I think this would represent good progress, though I wonder if there 
would be a performance penalty due to performing the mapping and 
unmapping in user-space (multiple syscalls per mapping versus a single 
hypercall).

Cheers,

Derek Murray.
