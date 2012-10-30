From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH 05/12] VMCI: event handling implementation.
Date: Tue, 30 Oct 2012 08:50:12 -0700
Message-ID: <20121030155012.GE14167@kroah.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010420.17788.59187.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030022446.GF1920@kroah.com>
	<20121030045821.GD32055@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030045821.GD32055@dtor-ws.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2012 at 09:58:21PM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 29, 2012 at 07:24:46PM -0700, Greg KH wrote:
> > On Mon, Oct 29, 2012 at 06:04:27PM -0700, George Zhang wrote:
> > > +/*
> > > + * Releases the given VMCISubscription.
> > > + * Fires the destroy event if the reference count has gone to zero.
> > > + */
> > > +static void event_release(struct vmci_subscription *entry)
> > > +{
> > > +	kref_put(&entry->kref, event_signal_destroy);
> > > +}
> > 
> > Same question as before with the kref_put() call, what is handling the
> > locking here?  It looks like a race to me.
> 
> The reference is taken only if event is on the list (which managed by
> RCU and a mutex), so it is not possible to go from 0->1 for that
> refcount.

Ok, as long as you have audited this.

greg k-h
