From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: SCSI driver for VMware's virtual HBA - V5.
Date: Tue, 13 Oct 2009 09:45:30 -0700
Message-ID: <4AD4AEAA.2080209__44488.0006173209$1255453825$gmane$org@goop.org>
References: <1254336812.19921.23.camel@ank32.eng.vmware.com>	<20091002004725.GP3958@sequoia.sous-sol.org>	<1254789028.15233.54.camel@ank32.eng.vmware.com>
	<1255444557.2855.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1255444557.2855.95.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, Bart Van Assche <bvanassche@acm.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, Roland Dreier <rdreier@cisco.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, "Chetan.Loke@Emulex.Com" <Chetan.Loke@Emulex.Com>, Daniel Walker <dwalker@fifo99.com>, akataria@vmware.com, Robert Love <robert.w.love@intel.com>, Rolf Eike Beer <eike-kernel@sf-tec.de>
List-Id: virtualization@lists.linuxfoundation.org

On 10/13/09 07:35, James Bottomley wrote:
>> Yep, below is a patch with the rename, the driver is now called
>> vmw_pvscsi. Do let me know if you have any other comments. Thanks.
>>     
> I'm still curious to know what the 'p' in the name stands for.  Surely
> this is a fully virtual driver, not a paravirtual one?
>   

I would assume that "pv" does stand for paravirtual.  The terminology is
a bit screwy: "fully virtualized" means that the device looks like a
real hardware device that is being emulated.  "Paravirtualized" means
that it is a completely virtual device which isn't an emulation of
anything; the guests know this this and talk to it accordingly.

    J
