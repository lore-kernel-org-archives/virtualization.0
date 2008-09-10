From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 3/4 v2] PCI: support SR-IOV capability
Date: Wed, 10 Sep 2008 15:59:35 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110181CB1A__26281.9174015478$1221033897$gmane$org@pdsmsx414.ccr.corp.intel.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6F@pdsmsx414.ccr.corp.intel.com>
	<20080901164104.GG16796@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080901164104.GG16796@ldl.fc.hp.com>
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

On Tuesday, September 02, 2008 12:41 AM, Alex Chiang wrote:
>* Zhao, Yu <yu.zhao@intel.com>:
>> Support SR-IOV capability. By default, this feature is not enabled and the
>SR-IOV device behaves as traditional PCI device. After it's enabled, each
>Virtual Function's PCI configuration space can be accessed using its own Bus,
>Device and Function Number (Routing ID). Each Virtual Function also has PCI
>Memory Space, which is used to map its own register set.
>>
>> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
>> Signed-off-by: Eddie Dong <eddie.dong@intel.com>
>>
>> ---
>>  drivers/pci/Kconfig      |   10 +
>>  drivers/pci/Makefile     |    2 +
>>  drivers/pci/iov.c        |  555
>++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c        |   14 +-
>>  drivers/pci/pci.h        |   44 ++++
>>  drivers/pci/probe.c      |    5 +
>>  include/linux/pci.h      |   28 +++
>>  include/linux/pci_regs.h |   20 ++
>>  8 files changed, 677 insertions(+), 1 deletions(-)
>>  create mode 100644 drivers/pci/iov.c
>>
>
>So, what happens if another hotplug driver is already loaded?
>
>I don't know the SR-IOV spec well enough to know if you are
>allowed to have SR-IOV + some other form of hotplug, like ACPI or
>native PCIe.
>
>Today, pci_hp_register will return -EBUSY.
>
>If SR-IOV really doesn't have anything to do with hotplug, then
>it may be a candidate for directly calling pci_create_slot(). In
>that case, 'param' should not be a property of a hotplug slot,
>but of a generic PCI slot.

That's correct, SR-IOV really doesn't have anything to do with hotplug. I was just reusing hotplug sysfs as the control interface. Will remove this in next work, and create SR-IOV own sysfs entries under /sys/bus/pci/devices/.../iov/...

Thanks.

>
>Thanks.
>
>/ac
