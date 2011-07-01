From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/40] Staging: hv: Driver cleanup
Date: Fri, 1 Jul 2011 04:21:36 -0400
Message-ID: <20110701082136.GE28322@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <20110630193346.GA22707@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480816C36D@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480816C36D@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 30, 2011 at 11:28:27PM +0000, KY Srinivasan wrote:
> > On Wed, Jun 29, 2011 at 07:38:21AM -0700, K. Y. Srinivasan wrote:
> > > Further cleanup of the hv drivers:
> > >
> > > 	1) Cleanup the reference counting mess for both stor and net devices.
> > 
> > I really don't understand the need for reference counting on the storage
> > side, especially now that you only have a SCSI driver.  The SCSI
> > midlayer does proper counting on it's objects (Scsi_Host, scsi_device,
> > scsi_cmnd), so you'll get that for free given that SCSI drivers just
> > piggyback on the midlayer lifetime rules.
> 
> The reference counting allows us to properly deal with messages coming back from the host
> to the guest with a racing remove of the device. I am told these messages could potentially be
> not a response to a message sent from the guest.

To deal with that the scsi subsystem has a two stage teardown for the
SCSI host.  First you call scsi_remove_host, at which point no new I/O
to it can be started.  After that you can wait for all outstanding
messages, and finally you do a scsi_host_put to drop the long-term
reference to it, and eventually free it.
