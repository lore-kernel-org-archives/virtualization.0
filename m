From: "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
Subject: Re: [SR-IOV driver example 0/3 resend] introduction
Date: Tue, 2 Dec 2008 19:12:18 -0800
Message-ID: <9929d2390812021912ua5ddeafo3ae4a5759ffc4c4e__6428.15488758988$1228321838$gmane$org@mail.gmail.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081202092741.GA1859@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081202092741.GA1859@yzhao12-linux.sh.intel.com>
Content-Disposition: inline
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, gregory.v.rose@intel.com, netdev@vger.kernel.org, "greg@kroah.com" <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 2, 2008 at 1:27 AM, Yu Zhao <yu.zhao@intel.com> wrote:
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
> [SR-IOV driver example 0/3 resend] introduction
> [SR-IOV driver example 1/3 resend] PF driver: hardware specific operations
> [SR-IOV driver example 2/3 resend] PF driver: integrate with SR-IOV core
> [SR-IOV driver example 3/3 resend] VF driver: an independent PCI NIC driver
> --
>

First of all, we (e1000-devel) do support the SR-IOV API.

With that said, NAK on the driver changes.  We were not involved in
these changes and are currently working on a version of the drivers
that will make them acceptable for kernel inclusion.

-- 
Cheers,
Jeff
