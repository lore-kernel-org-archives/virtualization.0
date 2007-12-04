From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 04 Dec 2007 09:40:49 +0000
Message-ID: <475520A1.6080909@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>
	<47546931.2090602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <47546931.2090602@redhat.com>
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
>> On this point I completely agree with you! If anyone has any less
>> radical suggestions, then I'd be delighted to refactor the gntdev code
>> to use them. However, I'm not currently aware of any alternative that
>> maintains robustness to process crashes.
> 
> Oh, for me it isn't robust at all, it crashes on the first munmap
> syscall.  It is the Fedora 8 kernel.  See attachment.  Didn't try
> xensource 2.6.18 yet.

My gut feeling is that something changed in mm between 2.6.18 and 
2.6.21, but that seems like a cop out so...

> Ideas what is wrong?

Since the bug appears to be in page_remove_rmap, that would tend to 
imply that there is never a corresponding page_add_*_rmap 
(page_add_file_rmap?). My knowledge of the Linux mm code is a bit shaky 
here: should gntdev be doing this? Should we be using install_page (or a 
modified version thereof) to set the PTE?

Also, does a simple program that opens gntdev, maps a grant, 
accesses/writes to the page, and unmaps it (all using the xc_gnttab_* 
functions) work?

> Who uses the gntdev device right now?

Good question! I'm aware of it being used in a few research projects, 
and it seems to work for them (though I think it is mostly used with the 
linux-2.6.18-xen kernel). Anyone else?

>> I think this would represent good progress, though I wonder if there
>> would be a performance penalty due to performing the mapping and
>> unmapping in user-space (multiple syscalls per mapping versus a single
>> hypercall).
> 
> I'd expect the hard disk (and how I/O is scheduled) being the
> bottleneck, not the syscall overhead.  Nevertheless I plan to benchmark
> it once I have it up and running.

Great to hear that you're working on this! Let me know if there's any 
other help I can provide with gntdev.

Cheers,

Derek.
