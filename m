From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Wed, 27 Apr 2011 02:45:50 -0400
Message-ID: <20110427064550.GA597@infradead.org>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <20110426232843.GA31184@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 27, 2011 at 01:54:02AM +0000, KY Srinivasan wrote:
> I would prefer that we go through the  review process. What is the process for
> this review? Is there a time window for people to respond. I am hoping I will be able
> to address all the review comments well in advance of the  next closing of the tree,
> with the hope of taking the vmbus driver out of staging this go around (hope springs
> eternal in the human breast ...)! 

It would be useful if you'd send one driver at a time to the list as the
full source to review.

Did we make any progress on the naming discussion?  In my opinion hv is
a far to generic name for your drivers.  Why not call it mshv dor the
driver directory and prefixes?

As far as the core code is concerned, can you explain the use of the
dev_add, dev_rm and cleanup methods and how they relate to the
normal probe/remove/shutdown methods?

As far as the storage drivers are concerned I still have issues with the
architecture.  I haven't seen any good explanation why you want to  have
the blkvsc and storvsc drivers different from each other.  They both
speak the same vmbus-level protocol and tunnel scsi commands over it.
Why would you sometimes expose this SCSI protocol as a SCSI LLDD and
sometimes as a block driver?  What decides that a device is exported
in a way to that blkvsc is bound to them vs storvsc?  How do they look
like on the windows side?  From my understanding of the windows driver
models both the recent storport model and the older scsiport model are
more or less talking scsi to the driver anyway, so what is the
difference between the two for a Windows guest?

Also pleae get rid of struct storvsc_driver_object, it's just a very
strange way to store file-scope variables, and useless indirection
for the I/O submission handler.
