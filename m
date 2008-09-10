From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 2/4 v2] PCI: support ARI capability
Date: Wed, 10 Sep 2008 15:35:06 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110181CAB3__29723.3004043393$1221032261$gmane$org@pdsmsx414.ccr.corp.intel.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6E@pdsmsx414.ccr.corp.intel.com>
	<20080901152734.GC16796@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080901152734.GC16796@ldl.fc.hp.com>
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

On Monday, September 01, 2008 11:28 PM, Alex Chiang wrote:
>* Zhao, Yu <yu.zhao@intel.com>:
>> Support Alternative Routing-ID Interpretation (ARI), which increases the
>number of functions that can be supported by a PCIe endpoint. ARI is required
>by SR-IOV.
>>
>> PCI-SIG ARI specification can be found at
>http://www.pcisig.com/specifications/pciexpress/specifications/ECN-alt-rid-
>interpretation-070604.pdf
>>
>> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
>> Signed-off-by: Eddie Dong <eddie.dong@intel.com>
>>
>> ---
>>  drivers/pci/Kconfig      |    7 ++++
>>  drivers/pci/Makefile     |    2 +
>>  drivers/pci/ari.c        |   71
>++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.h        |    8 +++++
>>  drivers/pci/probe.c      |    3 ++
>>  include/linux/pci.h      |   25 ++++++++++++++++
>>  include/linux/pci_regs.h |   14 +++++++++
>>  7 files changed, 130 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/pci/ari.c
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index e1ca425..f43cc46 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -50,3 +50,10 @@ config HT_IRQ
>>  	   This allows native hypertransport devices to use interrupts.
>>
>>  	   If unsure say Y.
>> +
>> +config PCI_ARI
>> +	bool "PCI ARI support"
>> +	depends on PCI
>> +	default n
>> +	help
>> +	  This enables PCI Alternative Routing-ID Interpretation.
>
>This Kconfig help text is a little weak. Why not include the text
>you've already written here:
>
>	Support Alternative Routing-ID Interpretation (ARI), which
>	increases the number of functions that can be supported by a PCIe
>	endpoint. ARI is required by SR-IOV.
>
>In the Kconfig text, you might want to expand the SR-IOV acronym
>too.

Thanks. Will do in next version.

>
>Thanks.
>
>/ac
