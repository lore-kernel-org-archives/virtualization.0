From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH v2, part3 07/11] PCI, xen-pcifront: use new PCI
	interfaces to simplify implementation
Date: Mon, 10 Jun 2013 12:58:01 -0400
Message-ID: <20130610165801.GA24823@phenom.dumpdata.com>
References: <1368719459-24800-1-git-send-email-jiang.liu@huawei.com>
	<1368719459-24800-8-git-send-email-jiang.liu@huawei.com>
	<20130607145024.GA16631@phenom.dumpdata.com>
	<20130607153822.GA24882@phenom.dumpdata.com>
	<51B20F57.7050100@gmail.com>
	<20130607170706.GB3730@phenom.dumpdata.com>
	<51B4B266.5010100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51B4B266.5010100@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>, Myron Stowe <myron.stowe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Rafael J . Wysocki" <rjw@sisk.pl>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 10, 2013 at 12:50:46AM +0800, Jiang Liu wrote:
> On Sat 08 Jun 2013 01:07:06 AM CST, Konrad Rzeszutek Wilk wrote:
> > On Sat, Jun 08, 2013 at 12:50:31AM +0800, Jiang Liu wrote:
> >> On 06/07/2013 11:38 PM, Konrad Rzeszutek Wilk wrote:
> >>> On Fri, Jun 07, 2013 at 10:50:24AM -0400, Konrad Rzeszutek Wilk wrote:
> >>>> On Thu, May 16, 2013 at 11:50:55PM +0800, Jiang Liu wrote:
> >>>>> Use new PCI interfaces to simplify xen-pcifront implementation:
> >>>>> 1) Use pci_create_root_bus() instead of pci_scan_bus_parented()
> >>>>>    because pci_scan_bus_parented() is marked as __deprecated.This
> >>>>>    also gets rid of a duplicated call of pci_bus_start_devices().
> >>>>> 2) Use pci_stop_root_bus() and pci_remove_root_bus() instead of
> >>>>>    open-coded private implementation.
> >>>>> 3) Use pci_set_host_bridge_release() to release data structures
> >>>>>    associated with PCI root buses.
> >>>>> 4) Use pci_bus_get()/pci_bus_put() to manage PCI root bus reference
> >>>>>    count.
> >>>>>
> >>>>> This is also a preparation for coming PCI bus lock enhancement.
> >>>
> >>> With this patch from :
> >>>
> >>>  Merge branch 'pci_lock_v3' of https://github.com/jiangliu/linux into testing
> >>>
> >>>
> >>> it blows up when detaching the device.
> >> Hi Konrad,
> >>    Thanks for testing! According to the log messages, this issue should
> >> be related to pci bus reference counter management. Seems we have done
> >> an extra(unbalanced) release of pci bus device.
> >>    Will investigate it tomorrow!
> >
> > That is quite commendable that you are willing to look over this on
> > the weekend but I am not going to be able to rerun this test until
> > some time in the week. You could enjoy the weekend and just look at
> > this during the week.
> 
> Hi Konrad,
>      We should have root-caused this bug, which is caused by 
> for_each_pci_root_bus().
> Current implementation doesn't support root bus deletion when walking 
> PCI root
> buses by for_each_pci_root_bus(). The reference counter 
> (pci_bus->dev.knode_class.n_ref)
> becomes zero after returning from pci_remove_root_bus(), so it triggers 
> kref warnings
> and double-free of klist_node object when we call 
> pci_get_next_root_bus() to get the
> next PCI root bus.
>      So we will first revert to  list_for_each_entry_safe(bus, temp, 
> &pci_root_buses, node)
> and solve this issue in next version of for_each_pci_root_bus().

That definitly solves the issue. Thanks!

I used pci_lock_v3 of https://github.com/jiangliu/linux and the fix
below.

Is there a new patchset you are going to be posting or a git branch
that I can look over?

Thanks.
