From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 00/12] VMCI for Linux upstreaming
Date: Tue, 30 Oct 2012 09:18:07 -0700
Message-ID: <20121030161807.GA9709@dtor-ws.eng.vmware.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030021938.GC1920@kroah.com>
	<20121030040744.GB32055@dtor-ws.eng.vmware.com>
	<20121030154801.GC14167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030154801.GC14167@kroah.com>
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

On Tue, Oct 30, 2012 at 08:48:01AM -0700, Greg KH wrote:
> On Mon, Oct 29, 2012 at 09:07:44PM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > On Mon, Oct 29, 2012 at 07:19:38PM -0700, Greg KH wrote:
> > > On Mon, Oct 29, 2012 at 06:03:28PM -0700, George Zhang wrote:
> > > >  drivers/misc/Kconfig                      |    1
> > > >  drivers/misc/Makefile                     |    2
> > > >  drivers/misc/vmw_vmci/Kconfig             |   16
> > > >  drivers/misc/vmw_vmci/Makefile            |   43
> > > 
> > > Meta comment here, why drivers/misc/?  The other hypervisor
> > > infrastructures all have their own directory under drivers/  Should we
> > > be moving everything to drivers/hyperv/ somehow?
> > 
> > drivers/hyperv is not the best name for obvious reasons...
> 
> Sorry, yes :)

:)

> 
> > I think that even if we had a special directory for vmci having network
> > drivers in Dave's realm and pvscsi in James's is best option, so the new
> > directory would contain vmci and the balloon driver (vsock will go into
> > net/).  Given that balloon is already in drivers/misc it looked like
> > obvious place for VMCI as well.
> 
> I agree that the individual drivers should go in the subsystem area,
> it's this "hypervisor bus core" type code that I'm questioning.  Right
> now every hypervisor is putting that logic in a different place in the
> kernel, having some consistency here would be nice.

Hmm, I wonder if miscellaneous and core hypervisor drivers should end
up in drivers/platform:

	drivers/platform/hyperv
	drivers/platform/olpc
	drivers/platform/vmware
	drivers/platform/xen
	drivers/platform/x86

But really we'd like to get VMCI into mainline first and move to a new
place later if such a better place is found.

Thanks,
Dmitry
