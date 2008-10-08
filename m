From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 2/6 v3] PCI: add new general functions
Date: Wed, 8 Oct 2008 11:25:00 +0800
Message-ID: <D8078B8B3B09934AA9F8F2D5FB3F28CE08A3D2442C__46570.8191426986$1223436496$gmane$org@pdsmsx502.ccr.corp.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F2@pdsmsx502.ccr.corp.intel.com>
	<200810020921.32335.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200810020921.32335.jbarnes@virtuousgeek.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Alex@smtp1.linux-foundation.org, Grant Grundler <grundler@parisc-linux.org>, Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, October 03, 2008 12:22 AM, Jesse Barnes wrote:
>On Saturday, September 27, 2008 1:27 am Zhao, Yu wrote:
>> Centralize capability related functions into several new functions and put
>> PCI resource definitions into an enum.
>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index f99160d..f2feebc 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>
>The sysfs changes look fine, they should be submitted separately.

Will do.

>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 259eaff..400d3b3 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -356,25 +356,10 @@ pci_find_parent_resource(const struct pci_dev *dev,
>> struct resource *res) static void
>>  pci_restore_bars(struct pci_dev *dev)
>>  {
>> -       int i, numres;
>> -
>> -       switch (dev->hdr_type) {
>> -       case PCI_HEADER_TYPE_NORMAL:
>> -               numres = 6;
>> -               break;
>> -       case PCI_HEADER_TYPE_BRIDGE:
>> -               numres = 2;
>> -               break;
>> -       case PCI_HEADER_TYPE_CARDBUS:
>> -               numres = 1;
>> -               break;
>> -       default:
>> -               /* Should never get here, but just in case... */
>> -               return;
>> -       }
>> +       int i;
>>
>> -       for (i = 0; i < numres; i ++)
>> -               pci_update_resource(dev, &dev->resource[i], i);
>> +       for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
>> +               pci_update_resource(dev, i);
>>  }
>
>This confused me for a minute until I saw that the new pci_update_resource
>ignores invalid BAR numbers.  Not sure if that's clearer than the current
>code...

When device has its own specific BARs, we have to add more 'case' statement in this function and may mass this function up. Simply ignoring the unused resources in pci_update_resource looks concise to me. Anyway, I can use keep the old structure if you feel the change brought more confusion than concision.

>
>> +/**
>> + * pci_resource_bar - get position of the BAR associated with a resource
>> + * @dev: the PCI device
>> + * @resno: the resource number
>> + * @type: the BAR type to be filled in
>> + *
>> + * Returns BAR position in config space, or 0 if the BAR is invalid.
>> + */
>> +int pci_resource_bar(struct pci_dev *dev, int resno, enum pci_bar_type
>> *type) +{
>> +       if (resno < PCI_ROM_RESOURCE) {
>> +               *type = pci_bar_unknown;
>> +               return PCI_BASE_ADDRESS_0 + 4 * resno;
>> +       } else if (resno == PCI_ROM_RESOURCE) {
>> +               *type = pci_bar_rom;
>> +               return dev->rom_base_reg;
>> +       }
>> +
>> +       dev_err(&dev->dev, "BAR: invalid resource #%d\n", resno);
>> +       return 0;
>> +}
>
>It looks like this will spew an error even under normal circumstances since
>pci_restore_bars gets called at resume time, right?  You could make this into

It won't print the message unless there is something wrong with the system. pci_update_resource is only called when the resource # is less than PCI_BRIDGE_RESOURCES and it will ignore unused resource. So when pci_resource_bar gets involved, all resource # shouldn't big than PCI_ROM_RESOURCE (PCI_BRIDGE_RESOURCE = PCI_ROM_RESOURCE + 1)

>a debug message or just get rid of it.  Also now that I look at this, I don't
>think it'll provide equivalent functionality to the old restore_bars code,
>won't a cardbus bridge end up getting pci_update_resource called on invalid
>BARs?

The cardbus uses 1 BAR resource plus 4 (max) bridge resources. The pci_update_resource is only called when restoring the BAR resource. It won't be called to update the bridge resources for the reason I mentioned above.

>
>> +static void pci_init_capabilities(struct pci_dev *dev)
>> +{
>> +       /* MSI/MSI-X list */
>> +       pci_msi_init_pci_dev(dev);
>> +
>> +       /* Power Management */
>> +       pci_pm_init(dev);
>> +
>> +       /* Vital Product Data */
>> +       pci_vpd_pci22_init(dev);
>> +}
>> +
>
>These capabilities changes look good, care to separate them out?

Will do.

>
>Let's see if we can whittle down this patchset by extracting and applying all
>the various cleanups; that should make the core bits easier to review.

Thanks for the careful reviewing and the comments. I'll send the updated version soon according to all the comments I've got.

>
>Thanks,
>--
>Jesse Barnes, Intel Open Source Technology Center
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
