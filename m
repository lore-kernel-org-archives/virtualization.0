From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 6/8 v4] PCI: support the SR-IOV capability
Date: Wed, 15 Oct 2008 10:04:31 +0800
Message-ID: <48F54FAF.7060204__14717.8232939497$1224036609$gmane$org@intel.com>
References: <20081014103424.GA1704@yzhao12-linux.sh.intel.com>
	<20081014105928.GF1734@yzhao12-linux.sh.intel.com>
	<20081014123002.GA15064@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081014123002.GA15064@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

Matthew Wilcox wrote:
> On Tue, Oct 14, 2008 at 06:59:28PM +0800, Yu Zhao wrote:
>> +++ b/include/linux/pci.h
>> @@ -87,6 +87,12 @@ enum {
>>       /* #6: expansion ROM */
>>       PCI_ROM_RESOURCE,
>>
>> +     /* device specific resources */
>> +#ifdef CONFIG_PCI_IOV
>> +     PCI_IOV_RESOURCES,
>> +     PCI_IOV_RESOURCES_END = PCI_IOV_RESOURCES + PCI_IOV_NUM_BAR - 1,
>> +#endif
>> +
>>       /* address space assigned to buses behind the bridge */
>>  #ifndef PCI_BRIDGE_RES_NUM
>>  #define PCI_BRIDGE_RES_NUM 4
> 
> Why expand the number of resources in struct pci_dev instead of putting
> the new resources in struct pci_iov?

Yes, it's supposed to be in the 'struct pci_iov', and the resources used 
to be there in early version. But later I found all resource related 
functions such as pci_assign_resource, pdev_sort_resources, 
pbus_size_mem, etc. assume the resources are bundled with 'struct 
pci_dev' and address them using their indexes. Encapsulating resources 
into 'pci_iov' will impact all these functions. And I think we can 
postpone the change of these functions until the PCIM comes out, if the 
IOV is the only one who uses non-standard resources.

> 
> --
> Matthew Wilcox                          Intel Open Source Technology Centre
> "Bill, look, we understand that you're interested in selling us this
> operating system, but compare it to ours.  We can't possibly take such
> a retrograde step."
