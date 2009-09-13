From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Sun, 13 Sep 2009 08:46:10 +0300
Message-ID: <20090913054610.GA4446__17307.9134583988$1252821047$gmane$org@redhat.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<20090908201428.GA12420@redhat.com>
	<C85CEDA13AB1CF4D9D597824A86D2B9006AECB9C1D@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <C85CEDA13AB1CF4D9D597824A86D2B9006AECB9C1D@PDSMSX501.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Xin, Xiaohui" <xiaohui.xin@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "s.hetze@linux-ag.com" <s.hetze@linux-ag.com>, avi@redhat.com, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

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
