From: Yu Zhao <yu.zhao@uniscape.net>
Subject: Re: [PATCH 2/16 v6] PCI: define PCI resource names in an 'enum'
Date: Wed, 22 Oct 2008 22:44:24 +0800
Message-ID: <48FF3C48.9060809@uniscape.net>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084041.GB3773@yzhao12-linux.sh.intel.com>
	<200810220824.21356.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200810220824.21356.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Bjorn Helgaas wrote:
> On Wednesday 22 October 2008 02:40:41 am Yu Zhao wrote:
>> This patch moves all definitions of the PCI resource names to an 'enum',
>> and also replaces some hard-coded resource variables with symbol
>> names. This change eases introduction of device specific resources.
> 
> Thanks for removing a bunch of magic numbers from the code.
> 
>>  static void
>>  pci_restore_bars(struct pci_dev *dev)
>>  {
>> -	int i, numres;
>> -
>> -	switch (dev->hdr_type) {
>> -	case PCI_HEADER_TYPE_NORMAL:
>> -		numres = 6;
>> -		break;
>> -	case PCI_HEADER_TYPE_BRIDGE:
>> -		numres = 2;
>> -		break;
>> -	case PCI_HEADER_TYPE_CARDBUS:
>> -		numres = 1;
>> -		break;
>> -	default:
>> -		/* Should never get here, but just in case... */
>> -		return;
>> -	}
>> +	int i;
>>  
>> -	for (i = 0; i < numres; i++)
>> +	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
>>  		pci_update_resource(dev, i);
>>  }
> 
> The behavior of this function used to depend on dev->hdr_type.  Now
> we don't look at hdr_type at all, so we do the same thing for all
> devices.
> 
> For example, for a CardBus device, we used to call pci_update_resource()
> only for BAR 0; now we call it for BARs 0-6.
> 
> Maybe this is safe, but I can't tell from the patch, so I think you
> should explain *why* it's safe in the changelog.

It's safe because pci_update_resource() will ignore unused resources. 
E.g., for a Cardbus, only BAR 0 is used and its 'flags' is set, then 
pci_update_resource() only updates it. BAR 1-6 are ignored since their 
'flags' are 0.

I'll put more explanation in the changelog.

Thanks,
Yu
