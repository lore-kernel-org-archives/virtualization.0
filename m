From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC PATCH v2, part3 07/11] PCI,
	xen-pcifront: use new PCI interfaces to simplify implementation
Date: Fri, 07 Jun 2013 23:17:56 +0800
Message-ID: <51B1F9A4.7090608@gmail.com>
References: <1368719459-24800-1-git-send-email-jiang.liu@huawei.com>
	<1368719459-24800-8-git-send-email-jiang.liu@huawei.com>
	<20130607145024.GA16631@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130607145024.GA16631@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>, Myron Stowe <myron.stowe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Rafael J . Wysocki" <rjw@sisk.pl>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri 07 Jun 2013 10:50:24 PM CST, Konrad Rzeszutek Wilk wrote:
> On Thu, May 16, 2013 at 11:50:55PM +0800, Jiang Liu wrote:
>> Use new PCI interfaces to simplify xen-pcifront implementation:
>> 1) Use pci_create_root_bus() instead of pci_scan_bus_parented()
>>    because pci_scan_bus_parented() is marked as __deprecated.This
>>    also gets rid of a duplicated call of pci_bus_start_devices().
>> 2) Use pci_stop_root_bus() and pci_remove_root_bus() instead of
>>    open-coded private implementation.
>> 3) Use pci_set_host_bridge_release() to release data structures
>>    associated with PCI root buses.
>> 4) Use pci_bus_get()/pci_bus_put() to manage PCI root bus reference
>>    count.
>>
>> This is also a preparation for coming PCI bus lock enhancement.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
>> Cc: xen-devel@lists.xensource.com
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/pci/xen-pcifront.c | 81 ++++++++++++++++++++++------------------------
>>  1 file changed, 39 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
>> index 816cf94..6aa2c0f 100644
>> --- a/drivers/pci/xen-pcifront.c
>> +++ b/drivers/pci/xen-pcifront.c
......
>> @@ -480,12 +490,14 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>>  		goto err_out;
>>  	}
>>
>> -	bus_entry->bus = b;
>> +	pci_set_host_bridge_release(to_pci_host_bridge(b->bridge),
>> +				    pcifront_release_sd, sd);
>>
>> -	list_add(&bus_entry->list, &pdev->root_buses);
>> -
>> -	/* pci_scan_bus_parented skips devices which do not have a have
>> -	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
>> +	/*
>> +	 * Every PCI physical device should have function 0, but that's not
>> +	 * true for xen.
>
> That is incorrect. There are two types of backends - one of them will
> start at zero, but the other might not.
Hi Konrad,
      Forgive my poor knowledge about Xen:(, so I will skip this change.
Regards!
Gerry
