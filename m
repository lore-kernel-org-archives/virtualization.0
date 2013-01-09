From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 07/12] VMCI: queue pairs implementation.
Date: Tue, 08 Jan 2013 16:28:51 -0800
Message-ID: <2526541.2xuuOB7vZK@dtor-d630.eng.vmware.com>
References: <20130108234751.2698.66606.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20130108235444.2698.24076.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20130109001539.GA24989@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130109001539.GA24989@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: pv-drivers@vmware.com
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Greg,

On Tuesday, January 08, 2013 04:15:39 PM Greg KH wrote:
> On Tue, Jan 08, 2013 at 03:54:54PM -0800, George Zhang wrote:
> 
> > +/* Guest device port I/O. */
> > +struct PPNSet {
> > +	u64 num_produce_pages;
> > +	u64 num_consume_pages;
> > +	u32 *produce_ppns;
> > +	u32 *consume_ppns;
> > +	bool initialized;
> > +};
> 
> I know this is a private structure to the driver, so it's not that big
> of a deal at all, but the naming for this is a bit odd (mixed case.)
> 
> Not a show stopper at all, but if you had run checkpatch.pl on it, it
> would have warned you about this.

Surprisingly it does not:

[dtor@dtor-ws vmci]$ ./scripts/checkpatch.pl -f  
drivers/misc/vmw_vmci/vmci_queue_pair.h 
total: 0 errors, 0 warnings, 191 lines checked

drivers/misc/vmw_vmci/vmci_queue_pair.h has no obvious style problems and is 
ready for submission.

Also silent on the patch itself...

We'll send a followup patch anyway.

Thanks,
Dmitry
