From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Sat, 22 Nov 2008 15:03:59 +0800
Message-ID: <4927AEDF.4070808__30322.6005555645$1227337603$gmane$org@intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081121205746.GA3639@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081121205746.GA3639@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> On Sat, Nov 22, 2008 at 02:36:05AM +0800, Yu Zhao wrote:
>> Greetings,
>>
>> Following patches are intended to support SR-IOV capability in the
>> Linux kernel. With these patches, people can turn a PCI device with
>> the capability into multiple ones from software perspective, which
>> will benefit KVM and achieve other purposes such as QoS, security,
>> and etc.
>>
>> The Physical Function and Virtual Function drivers using the SR-IOV
>> APIs will come soon!
> 
> Thanks for respining these patches, but I think we really need to see a
> driver using this in order to get an idea of how it will be used.

Yes, the PF driver patch and the VF driver for Intel 82576 NIC will be 
available next week. Both PF/VF drivers are testing versions. The PF 
driver patch is based on the lasted kernel IGB driver 
(drivers/net/igb/), and uses SR-IOV v7 API. The VF driver is a totally 
new NIC driver, it looks like other normal PCI NIC drivers.

> Also, the Xen and KVM people need to agree on the userspace interface
> here, perhaps also getting some libvirt involvement as well, as they are
> going to be the ones having to use this all the time.

I'll keep KVM/Xen people updated on the user level interface and let 
them comment based on a real usage model of the Intel 82576 NIC after 
PF/VF drivers are available.

Regards,
Yu
