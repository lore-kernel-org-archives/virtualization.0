From: "Xin, Xiaohui" <xiaohui.xin@intel.com>
Subject: RE: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 14 Sep 2009 13:57:06 +0800
Message-ID: <C85CEDA13AB1CF4D9D597824A86D2B9006AECB9FE7__37045.8218422302$1252907906$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<20090908201428.GA12420@redhat.com>
	<C85CEDA13AB1CF4D9D597824A86D2B9006AECB9C1D@PDSMSX501.ccr.corp.intel.com>
	<20090913054610.GA4446@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090913054610.GA4446@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "s.hetze@linux-ag.com" <s.hetze@linux-ag.com>, "avi@redhat.com" <avi@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>The irqfd/ioeventfd patches are part of Avi's kvm.git tree:
>git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git
>
>I expect them to be merged by 2.6.32-rc1 - right, Avi?

Michael,

I think I have the kernel patch for kvm_irqfd and kvm_ioeventfd, but missed the qemu side patch for irqfd and ioeventfd.

I met the compile error when I compiled virtio-pci.c file in qemu-kvm like this:

/root/work/vmdq/vhost/qemu-kvm/hw/virtio-pci.c:384: error: `KVM_IRQFD` undeclared (first use in this function)
/root/work/vmdq/vhost/qemu-kvm/hw/virtio-pci.c:400: error: `KVM_IOEVENTFD` undeclared (first use in this function)

Which qemu tree or patch do you use for kvm_irqfd and kvm_ioeventfd?

Thanks
Xiaohui

-----Original Message-----
From: Michael S. Tsirkin [mailto:mst@redhat.com] 
Sent: Sunday, September 13, 2009 1:46 PM
To: Xin, Xiaohui
Cc: Ira W. Snyder; netdev@vger.kernel.org; virtualization@lists.linux-foundation.org; kvm@vger.kernel.org; linux-kernel@vger.kernel.org; mingo@elte.hu; linux-mm@kvack.org; akpm@linux-foundation.org; hpa@zytor.com; gregory.haskins@gmail.com; Rusty Russell; s.hetze@linux-ag.com; avi@redhat.com
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server

On Fri, Sep 11, 2009 at 11:17:33PM +0800, Xin, Xiaohui wrote:
> Michael,
> We are very interested in your patch and want to have a try with it.
> I have collected your 3 patches in kernel side and 4 patches in queue side.
> The patches are listed here:
> 
> PATCHv5-1-3-mm-export-use_mm-unuse_mm-to-modules.patch
> PATCHv5-2-3-mm-reduce-atomic-use-on-use_mm-fast-path.patch
> PATCHv5-3-3-vhost_net-a-kernel-level-virtio-server.patch
> 
> PATCHv3-1-4-qemu-kvm-move-virtio-pci[1].o-to-near-pci.o.patch
> PATCHv3-2-4-virtio-move-features-to-an-inline-function.patch
> PATCHv3-3-4-qemu-kvm-vhost-net-implementation.patch
> PATCHv3-4-4-qemu-kvm-add-compat-eventfd.patch
> 
> I applied the kernel patches on v2.6.31-rc4 and the qemu patches on latest kvm qemu.
> But seems there are some patches are needed at least irqfd and ioeventfd patches on
> current qemu. I cannot create a kvm guest with "-net nic,model=virtio,vhost=vethX".
> 
> May you kindly advice us the patch lists all exactly to make it work?
> Thanks a lot. :-)
> 
> Thanks
> Xiaohui


The irqfd/ioeventfd patches are part of Avi's kvm.git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git

I expect them to be merged by 2.6.32-rc1 - right, Avi?

-- 
MST
