From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: SCSI driver for VMware's virtual HBA - V5.
Date: Tue, 13 Oct 2009 14:35:57 +0000
Message-ID: <1255444557.2855.95.camel__22088.1071211354$1255445253$gmane$org@localhost.localdomain>
References: <1254336812.19921.23.camel@ank32.eng.vmware.com>
	<20091002004725.GP3958@sequoia.sous-sol.org>
	<1254789028.15233.54.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254789028.15233.54.camel@ank32.eng.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, Bart Van Assche <bvanassche@acm.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, Roland Dreier <rdreier@cisco.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, "Chetan.Loke@Emulex.Com" <Chetan.Loke@Emulex.Com>, Daniel Walker <dwalker@fifo99.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Robert Love <robert.w.love@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2009-10-05 at 17:30 -0700, Alok Kataria wrote:
> > Were you still planning on renaming the driver to something less generic
> > (like vmw_pvscsi)?
> 
> 
> Yep, below is a patch with the rename, the driver is now called
> vmw_pvscsi. Do let me know if you have any other comments. Thanks.

I'm still curious to know what the 'p' in the name stands for.  Surely
this is a fully virtual driver, not a paravirtual one?

James
