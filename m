From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci RFC 00/11] VMCI for Linux
Date: Mon, 4 Jun 2012 15:57:57 -0700
Message-ID: <20120604225757.GC7041__23823.8845406615$1338877085$gmane$org@kroah.com>
References: <20120515235024.GB1758@kroah.com>
	<552579991.43606.1338564781979.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <552579991.43606.1338564781979.JavaMail.root@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy King <acking@vmware.com>
Cc: dtor@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dsouders@vmware.com, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>, akpm@linux-foundation.org, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 01, 2012 at 08:33:02AM -0700, Andy King wrote:
> Greg,
> 
> Thanks so much for the comments and apologies for the delayed response.
> 
> > Don't we have something like this already for KVM and maybe Xen?
> > virtio?  Can't you use that code instead of a new block of code that
> > is only used by vmware users?  It has virtual pci devices which
> > should give you what you want/need here, right?
> >
> > If not, why doesn't that work for you?  Would it be easier to just
> > extend it?
> 
> The VMCI virtual device for which this driver is intended has been
> around a lot longer than this submission might suggest.  The virtual
> hardware was released in a product before Rusty sent his RFC and
> quite a bit before it made it to mainline; there was, regrettably,
> no virtio then.
> 
> As such, it was designed to be its own transport, and it's something
> that is now very much fixed at the hardware level (enhancements
> not withstanding), and which we have to support all the way back.

What "hardware" are you refering to here?

> In addition to that, our hypervisor endpoints are written using
> the existing device backend; virtio doesn't currently make a lot of
> sense for them, and would require a lot of additional work.
> 
> All of this is unfortunate.  While I agree that virtio is certainly
> the right approach, and we need to avoid this proliferation, I think
> at this point we'd really like to try and upstream this in its current
> form.  There's certainly the possibility going forwards that we could
> add a glue layer, such that other clients could use virtio if they're
> willing to write their own hypervisor endpoints.
> 
> Does that sound reasonable?

Not really, why should we take an interface that is tied to something
that you are saying isn't something we should be using?  Don't you also
have control over the hypervisor side of things in order to properly
design this type of thing?

thanks,

greg k-h
