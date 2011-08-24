From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 081/117] Staging: hv: vmbus: Introduce a lock to protect
	the ext field in hv_device
Date: Wed, 24 Aug 2011 14:29:43 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B270A@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-81-git-send-email-kys@microsoft.com>
	<20110823230816.GN9641@kroah.com>
	<6E21E5352C11B742B20C142EB499E048081B238B@TK5EX14MBXC126.redmond.corp.microsoft.com>
	<20110824025827.GB30779@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110824025827.GB30779@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, August 23, 2011 10:58 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 081/117] Staging: hv: vmbus: Introduce a lock to protect the
> ext field in hv_device
> 
> On Wed, Aug 24, 2011 at 12:55:12AM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Tuesday, August 23, 2011 7:08 PM
> > > To: KY Srinivasan
> > > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> > > Subject: Re: [PATCH 081/117] Staging: hv: vmbus: Introduce a lock to protect
> the
> > > ext field in hv_device
> > >
> > > On Fri, Jul 15, 2011 at 10:47:09AM -0700, K. Y. Srinivasan wrote:
> > > > The current mechanism for handling references in broken.
> > > > Introduce a lock to protect the ext field in hv_device.
> > >
> > > Why would that lock ever be needed?  How can things change to this
> > > pointer in different ways like you are thinking it could?  Doesn't the
> > > reference counting in the device itself handle this properly?
> >
> > This is to deal with a potential race condition between the driver being
> > unloaded and incoming traffic from the VMBUS side. The ext pointer is
> > device specific (either pointing to a storage or a network device) and what
> > we are protecting is the pointer being set to NULL from the unload side when
> > we might have a racing access from the interrupt side (on the incoming vmbus
> > traffic).
> 
> I still don't think this is needed at all, the drivers should not have
> to worry about this.  Something is wrong with the design if it is, as no
> other bus needs something like this, right?

This notion of reference counting has been in this code ever since I have been
working on this code; it just that I fixed some obvious holes/race conditions in the
logic to manage the reference counting. Firstly, this is not mandated by the vmbus and is 
used to support the protocol between the guest and host for storage, networking etc.
At least in the case of both block and networking, the client side driver code (running in the guest)
Initiates book keeping messages to the host that is not known to upper level code in Linux. So for
Instance, even though SCSI layer knows exactly what I/O's are pending and takes care of reference
counting the structures, it does not know about messages that have been sent by the lower level
storvsc driver code. If a racing unload were to happen, we could potentially dereference a NULL
ext pointer from the incoming packet processing context. The cases where this can happen are even
more prevalent on the networking side.

Regards,

K. Y
