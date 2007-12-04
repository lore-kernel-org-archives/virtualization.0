From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 04 Dec 2007 13:01:44 +0100
Message-ID: <475541A8.7030100@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475520A1.6080909@cl.cam.ac.uk>
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
> Gerd Hoffmann wrote:
>> Oh, for me it isn't robust at all, it crashes on the first munmap
>> syscall.  It is the Fedora 8 kernel.  See attachment.  Didn't try
>> xensource 2.6.18 yet.
> 
> My gut feeling is that something changed in mm between 2.6.18 and
> 2.6.21, but that seems like a cop out so...

Could be.  Cross checking failed thouth, 2.6.18 doesn't boot the machine
in question (intel devel box with ich9).  Doesn't finds the disk.
Probably the ahci driver is too old.

>> Ideas what is wrong?
> 
> Since the bug appears to be in page_remove_rmap, that would tend to
> imply that there is never a corresponding page_add_*_rmap
> (page_add_file_rmap?). My knowledge of the Linux mm code is a bit shaky
> here: should gntdev be doing this? Should we be using install_page (or a
> modified version thereof) to set the PTE?

Don't know, I'm just trying to use it.  I did some mm handling for
device drivers back in my video4linux days, but for that it wasn't
needed to be involved into setting/clearing pte entries.  I just had a
->nopage handler allocate the pages the way I needed it for the
userspace mappings of video dma buffers.

> Also, does a simple program that opens gntdev, maps a grant,
> accesses/writes to the page, and unmaps it (all using the xc_gnttab_*
> functions) work?

Didn't try yet.  The application in question (blkbackd) does this:

  * map blk shared ring
  * see the first request come in (kernel trying to read the
    partition table).
  * map the grants of the request.
  * perform I/O.
  * Try to unmap the grants of the request.  On the first unmap call
    the kernel oopses.

This all without even starting a guest, I'm just using "xm block-attach"
 to create a blkfront device in Dom0.

>> Who uses the gntdev device right now?
> 
> Good question! I'm aware of it being used in a few research projects,
> and it seems to work for them (though I think it is mostly used with the
> linux-2.6.18-xen kernel). Anyone else?

So it effectively got no real-world testing yet ...

cheers,
  Gerd
