From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 05/12] VMCI: event handling implementation.
Date: Tue, 30 Oct 2012 08:59:39 -0700
Message-ID: <2950075.FZEQUln4vx@dtor-d630.eng.vmware.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030050152.GE32055@dtor-ws.eng.vmware.com>
	<20121030155041.GF14167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121030155041.GF14167@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday, October 30, 2012 08:50:41 AM Greg KH wrote:
> On Mon, Oct 29, 2012 at 10:01:52PM -0700, Dmitry Torokhov wrote:
> > On Mon, Oct 29, 2012 at 07:26:05PM -0700, Greg KH wrote:
> > > On Mon, Oct 29, 2012 at 06:04:27PM -0700, George Zhang wrote:
> > > > +static void event_signal_destroy(struct kref *kref)
> > > > +{
> > > > +	struct vmci_subscription *entry =
> > > > +			container_of(kref, struct vmci_subscription, kref);
> > > > +
> > > > +	complete(&entry->done);
> > > > +}
> > > 
> > > Didn't you just leak memory here?  What frees the structure up?
> > 
> > event_unregister_subscription() waits for that completion and frees the
> > structure. We want event_unregister_subscription() to wait until all
> > fired callbacks completed before unregister is complete.
> 
> So all calls to this can just sit and spin waiting for others to clean
> up?  Odd, but ok.

Not all as there is logically only one owner of the subscription so
naturally it waits until all notification callbacks are done.

Frankly we have a change that gets rid of delayed ecvent callbacks
and so the refcounting is no longer needed at all.

Thanks,
Dmitry
