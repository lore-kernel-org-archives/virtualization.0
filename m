From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 0/6 v3] PCI: Linux kernel SR-IOV support
Date: Wed, 8 Oct 2008 10:32:35 +0800
Message-ID: <D8078B8B3B09934AA9F8F2D5FB3F28CE08A3D24349__28916.2577632398$1223433393$gmane$org@pdsmsx502.ccr.corp.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5EF@pdsmsx502.ccr.corp.intel.com>
	<200809271308.03547.javier@guerrag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200809271308.03547.javier@guerrag.com>
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
To: Javier Guerra Giraldez <javier@guerrag.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, Grant@smtp1.linux-foundation.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, Wilcox <matthew@wil.cx>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Matthew@smtp1.linux-foundation.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sunday, September 28, 2008 2:08 AM, Javier Guerra Giraldez wrote:
>On Saturday 27 September 2008, Zhao, Yu wrote:
>> Greetings,
>>
>> Following patches are intended to support SR-IOV capability in the Linux
>> kernel. With these patches, people can turn a PCI device with the
>> capability into multiple ones from software perspective, which can benefit
>> KVM and achieve other purposes such as QoS, security, etc.
>
>sounds great, i think some Infiniband HBAs have this capability; they even
>suggested using on Xen for faster (no hypervisor intervention) communication
>between DomU's on the same box. (and transparently to out of the box, of
>course)

Thanks. We will also push Xen patches soon. And please feel free to let us know if you have any question when integrating these patches with your products.

>
>does it need an IOMMU (VT-d), or the whole magic is done by the PCI device?

For native Linux, we can use Virtual Function without IOMMU. For KVM, it requires IOMMU so the guest can use VFs.

For Xen HVM, it also requires IOMMU. For Xen PV, it doesn't need IOMMU.

>
>--
>Javier
