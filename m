From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH 08/12] VMCI: resource object implementation.
Date: Tue, 30 Oct 2012 08:51:59 -0700
Message-ID: <20121030155159.GG14167@kroah.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010453.17788.90295.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030022905.GH1920@kroah.com>
	<20121030052016.GF32055@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030052016.GF32055@dtor-ws.eng.vmware.com>
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

On Mon, Oct 29, 2012 at 10:20:16PM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 29, 2012 at 07:29:05PM -0700, Greg KH wrote:
> > On Mon, Oct 29, 2012 at 06:04:58PM -0700, George Zhang wrote:
> > > +static struct vmci_resource *vmci_resource_lookup(struct vmci_handle handle)
> > > +{
> > > +	struct vmci_resource *r, *resource = NULL;
> > > +	struct hlist_node *node;
> > > +	unsigned int idx = vmci_resource_hash(handle);
> > > +
> > > +	BUG_ON(VMCI_HANDLE_EQUAL(handle, VMCI_INVALID_HANDLE));
> > 
> > You just crashed a machine, with no chance for recovery.  Not a good
> > idea.  Never a good idea.  Customers just lost data, and now they are
> > mad.  Make sure you at least print out your email address so they know
> > who to blame :)
> > 
> > Seriously, never BUG() in a driver, warn, sure, but this just looks like
> > a debugging assert().  Please remove all of these, they are sprinkled
> > all over the driver code here, I'm only responding to one of them here.
> > 
> > Even better yet, properly handle the error and keep on going, that's
> > what the rest of the kernel does.  Or should :)
> 
> For public APIs it certainly makes sense to check and handle erroneous input;

It's not "public", it's an in-kernel api.  See the static up there?  :)

> internally it often makes sense to simply enforce invariants, because if
> we managed to get into that state that we consider impossible we can't really
> trust anything.

Then error out, don't crash the box.  Again, this really looks like an
ASSERT() you are trying to catch, which you know how well we like those
in kernel code...

> FWIW:
> [dtor@dtor-ws kernel]$ grep -r BUG_ON . | wc -l
> 11269

I'm not saying that those are acceptable either, I just don't want to
add any more to the kernel.

greg k-h
