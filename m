From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 12/12] VMCI: Some header and config files.
Date: Mon, 26 Nov 2012 16:45:58 -0800
Message-ID: <1733473.DLmiAWnRYk@dtor-d630.eng.vmware.com>
References: <20121107183624.9658.78903.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121127002357.GA27683@core.coreip.homeip.net>
	<20121127003239.GA32298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121127003239.GA32298@kroah.com>
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
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday, November 26, 2012 04:32:39 PM Greg KH wrote:
> On Mon, Nov 26, 2012 at 04:23:57PM -0800, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > For some reason it still didn't go through to our corporate mail server
> > but I see it on LKML.
> 
> Good.
> 
> > On Mon, Nov 26, 2012 at 04:03:04PM -0800, Greg KH wrote:
> > > On Wed, Nov 07, 2012 at 10:43:03AM -0800, George Zhang wrote:
> > > > +static inline struct vmci_handle VMCI_MAKE_HANDLE(vmci_id cid,
> > > > vmci_id rid) +{
> > > > +	struct vmci_handle h;
> > > > +	h.context = cid;
> > > > +	h.resource = rid;
> > > > +	return h;
> > > > +}
> > > 
> > > You return a structure on the stack that just went away?  Yeah, I know
> > > it's an inline, but come on, that's not ok.
> > 
> > This is certainly OK even if it is not inline, we return the _value_,
> > not the pointer to the stacki memory. And yes, the structure is 64 bit
> > value so it is returned in registers.
> 
> Even on a 32bit processor? 

I thought it would, but it looks like it won't. Maybe we'll just switch it
to a macro with C99 style initializators to keep the same semantic but
avoid the question.

> Also, you already have another function that
> does this same thing, so having 2 functions in the same patch seems odd,
> right?

Yes, you can say that it is probably a bit excessive.

OK, now that we are on the same page we'll go and fix the issues.

Thanks,
Dmitry
