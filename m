From: Alok Kataria <akataria@vmware.com>
Subject: Re: SCSI driver for VMware's virtual HBA - V6.
Date: Wed, 28 Oct 2009 13:28:40 -0700
Message-ID: <1256761720.22354.74.camel@ank32.eng.vmware.com>
References: <1254336812.19921.23.camel@ank32.eng.vmware.com>
	 <20091002004725.GP3958@sequoia.sous-sol.org>
	 <1254789028.15233.54.camel@ank32.eng.vmware.com>
	 <20091013053726.GE17547@sequoia.sous-sol.org>
	 <1255470665.12792.105.camel@ank32.eng.vmware.com>
	 <20091013234127.GA9024@sequoia.sous-sol.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20091013234127.GA9024@sequoia.sous-sol.org>
Sender: linux-scsi-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Randy Dunlap <randy.dunlap@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, Bart Van Assche <bvanassche@acm.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, Roland Dreier <rdreier@cisco.com>, LKML <linux-kernel@vger.kernel.org>, "Chetan.Loke@Emulex.Com" <Chetan.Loke@Emulex.Com>, Brian King <brking@linux.vnet.ibm.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Robert Love <robert.w.love@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Walker <dwalker@fifo99.com>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "virtualization@lists.linux-foundataion.org" <virtualization@lists.linux-foundataion.org>
List-Id: virtualization@lists.linuxfoundation.org


On Tue, 2009-10-13 at 16:41 -0700, Chris Wright wrote: 
> * Alok Kataria (akataria@vmware.com) wrote:
> > SCSI driver for VMware's virtual HBA.
> > 
> > From: Alok N Kataria <akataria@vmware.com>
> > 
> > This is a driver for VMware's paravirtualized SCSI device,
> > which should improve disk performance for guests running
> > under control of VMware hypervisors that support such devices.
> > 
> > Signed-off-by: Alok N Kataria <akataria@vmware.com>
> 
> Looks in good shape to me.
> 
> Reviewed-by: Chris Wright <chrisw@sous-sol.org>

<ping>

This seems to have slipped through the cracks, maybe all the conferences
last week managed to take our attention off this :-).

I just checked the SCSI tree and don't see this merged in any of those
trees yet, though I don't think there is anything else that's pending on
for the driver merge. Some feedback about when this can be merged will
be really helpful.

Thanks,
Alok

