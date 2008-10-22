From: Yu Zhao <yu.zhao@uniscape.net>
Subject: Re: [PATCH 9/16 v6] PCI: add boot option to align MMIO resources
Date: Wed, 22 Oct 2008 22:52:43 +0800
Message-ID: <48FF3E3B.3050006__36187.1763402179$1224687473$gmane$org@uniscape.net>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084324.GI3773@yzhao12-linux.sh.intel.com>
	<200810220834.07222.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200810220834.07222.bjorn.helgaas@hp.com>
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
> On Wednesday 22 October 2008 02:43:24 am Yu Zhao wrote:
>> This patch adds boot option to align MMIO resource for a device.
>> The alignment is a bigger value between the PAGE_SIZE and the
>> resource size.
> 
> It looks like this forces alignment on PAGE_SIZE, not "a bigger
> value between the PAGE_SIZE and the resource size."  Can you
> clarify the changelog to specify exactly what alignment this
> option forces?

I guess following would explain your question.

>>  int pci_resource_alignment(struct pci_dev *dev, int resno)
>>  {
>> -	resource_size_t align;
>> +	resource_size_t align, bios_align;
>>  	struct resource *res = dev->resource + resno;
>>  
>> +	bios_align = pcibios_resource_alignment(dev, resno);
>> +
>>  	align = resource_alignment(res);
>>  	if (align)
>> -		return align;
>> +		return align > bios_align ? align : bios_align;
>>  
>>  	dev_err(&dev->dev, "alignment: invalid resource #%d\n", resno);
>>  	return 0;
