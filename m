From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 1/4 v2] PCI: introduce new base functions
Date: Wed, 10 Sep 2008 16:17:18 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110181CB4E__39550.6706358448$1221034872$gmane$org@pdsmsx414.ccr.corp.intel.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6D@pdsmsx414.ccr.corp.intel.com>
	<20080901161534.GF16796@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080901161534.GF16796@ldl.fc.hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Chiang <achiang@hp.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday, September 02, 2008 12:16 AM, Alex Chiang wrote:
>* Zhao, Yu <yu.zhao@intel.com>:
>> Some basic changes to allocation bus range, MMIO resource for SR-IOV device.
>
>This following comment is a bit confusing:
>> And add new sysfs entry to hotplug core to pass parameter to a
>> slot, which will be used by SR-IOV code.
>
>I was reading this patch, expecting to see a change to the
>hotplug core _API_ taking a param, not just a new sysfs entry.
>
>I would suggest rewording this part of the changelog as:
>
>	Add new sysfs file 'param' to /sys/bus/pci/slots/.../
>	which allows the user to pass a parameter to a slot. This
>	parameter will be used by the SR-IOV code.
>
>More about this new 'param' file below.
>
>>
>
>Please break the 80-column "rule" and make this all one line, to
>help with greppability.
>
>I know the prior version had it broken across two lines too, but
>we can improve it now. :)

Sure, will do this in next version :-)

>
>> +			continue;
>> +		}
>> +		child->is_added = 1;
>> +		retval = device_create_file(&child->dev,
>> +					    &dev_attr_cpuaffinity);
>> +		if (retval)
>> +			dev_err(&dev->dev, "Error creating cpuaffinity"
>> +					   " file, continuing...\n");
>
>This one too, please.
>
>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>> index e1098c3..f6f2a59 100644
>> --- a/drivers/pci/proc.c
>> +++ b/drivers/pci/proc.c
>> @@ -352,15 +352,16 @@ static int show_device(struct seq_file *m, void *v)
>>  			dev->vendor,
>>  			dev->device,
>>  			dev->irq);
>> -	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve
>compatibility */
>> -	for (i=0; i<7; i++) {
>> +
>> +	/* only print standard and ROM resources to preserve compatibility */
>> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>
>Why not:
>
>	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
>
>Looks like the tradeoff is explicit mention of PCI_ROM_RESOURCE
>vs using a non-standard C idiom (personally, I'm not a huge fan
>of <= in a for loop, but ymmv).
>
>Again, this is a minor nit, feel free to ignore.

It can be PCI_BRIDGE_RESOURCES, because there may be some non-standard resources following PCI_ROM_RESOURCE and before PCI_BRIDGE_RESOURCES.

For example, a standard PCI device has following resources:
	0 - 5   BARs
	6       ROM
	7 - 10  Bridge

After SR-IOV is enabled, it becomes
	0 - 5   standard BARs
	6       Rom
     7 - 12  SR-IOV BARs
	13 - 16 Bridge

>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index c0e1400..687be00 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -76,7 +76,29 @@ enum pci_mmap_state {
>>  #define PCI_DMA_FROMDEVICE	2
>>  #define PCI_DMA_NONE		3
>>
>> -#define DEVICE_COUNT_RESOURCE	12
>> +/*
>> + *  For PCI devices, the region numbers are assigned this way:
>> + */
>> +enum {
>> +	/* 0-5	standard PCI regions */
>> +	PCI_STD_RESOURCE,
>> +
>> +	/* expansion ROM */
>> +	PCI_ROM_RESOURCE = 6,
>> +
>> +	/* address space assigned to buses behind the bridge */
>> +#ifndef PCI_BRIDGE_NUM_RES
>> +#define PCI_BRIDGE_NUM_RES 4
>> +#endif
>> +	PCI_BRIDGE_RESOURCES,
>> +	PCI_BRIDGE_RES_END = PCI_BRIDGE_RESOURCES + PCI_BRIDGE_NUM_RES - 1,
>> +
>> +	/* total resources associated with a PCI device */
>> +	PCI_NUM_RESOURCES,
>> +
>> +	/* preserve this for compatibility */
>> +	DEVICE_COUNT_RESOURCE
>> +};
>
>Ouch, this enum makes my head hurt a little. Care to put in a
>comment for PCI_BRIDGE_RES_END, saying that it has a value of 10?

Same as above, the PCI_BRIDGE_RES_END varies when some features is enabled or disabled.

Thank you very much for carefully reviewing these patches. I'd like to invite you to review next version again if it's convenient for you.

>
>Thanks,
>
>/ac
