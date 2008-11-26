From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [SR-IOV driver example 0/3] introduction
Date: Wed, 26 Nov 2008 15:14:48 -0500
Message-ID: <492DAE38.3050809__42494.4029692144$1227730657$gmane$org@garzik.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081126140303.GA13641@yzhao12-linux.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>
Cc: xen-devel@lists.xensource.com, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

Yu Zhao wrote:
> SR-IOV drivers of Intel 82576 NIC are available. There are two parts
> of the drivers: Physical Function driver and Virtual Function driver.
> The PF driver is based on the IGB driver and is used to control PF to
> allocate hardware specific resources and interface with the SR-IOV core.
> The VF driver is a new NIC driver that is same as the traditional PCI
> device driver. It works in both the host and the guest (Xen and KVM)
> environment.
> 
> These two drivers are testing versions and they are *only* intended to
> show how to use SR-IOV API.
> 
> Intel 82576 NIC specification can be found at:
> http://download.intel.com/design/network/datashts/82576_Datasheet_v2p1.pdf
> 
> [SR-IOV driver example 1/3] PF driver: allocate hardware specific resource
> [SR-IOV driver example 2/3] PF driver: integrate with SR-IOV core
> [SR-IOV driver example 3/3] VF driver tar ball

Please copy netdev@vger.kernel.org on all network-related patches.  This 
is where the network developers live, and all patches on this list are 
automatically archived for review and handling at 
http://patchwork.ozlabs.org/project/netdev/list/

	Jeff
