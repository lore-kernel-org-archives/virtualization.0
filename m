From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Date: Thu, 19 Apr 2018 21:40:23 +0300
Message-ID: <20180419212911-mutt-send-email-mst__32994.9858286001$1524163124$gmane$org@kernel.org>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
	<30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiao.w.wang@intel.com, ddutile@redhat.com, jianfeng.tan@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 10, 2018 at 03:25:45PM +0800, Jason Wang wrote:
> > > > One problem is that, different virtio ring compatible devices
> > > > may have different device interfaces. That is to say, we will
> > > > need different drivers in QEMU. It could be troublesome. And
> > > > that's what this patch trying to fix. The idea behind this
> > > > patch is very simple: mdev is a standard way to emulate device
> > > > in kernel.
> > > So you just move the abstraction layer from qemu to kernel, and you still
> > > need different drivers in kernel for different device interfaces of
> > > accelerators. This looks even more complex than leaving it in qemu. As you
> > > said, another idea is to implement userspace vhost backend for accelerators
> > > which seems easier and could co-work with other parts of qemu without
> > > inventing new type of messages.
> > I'm not quite sure. Do you think it's acceptable to
> > add various vendor specific hardware drivers in QEMU?
> > 
> 
> I don't object but we need to figure out the advantages of doing it in qemu
> too.
> 
> Thanks

To be frank kernel is exactly where device drivers belong.  DPDK did
move them to userspace but that's merely a requirement for data path.
*If* you can have them in kernel that is best:
- update kernel and there's no need to rebuild userspace
- apps can be written in any language no need to maintain multiple
  libraries or add wrappers
- security concerns are much smaller (ok people are trying to
  raise the bar with IOMMUs and such, but it's already pretty
  good even without)

The biggest issue is that you let userspace poke at the
device which is also allowed by the IOMMU to poke at
kernel memory (needed for kernel driver to work).

Yes, maybe if device is not buggy it's all fine, but
it's better if we do not have to trust the device
otherwise the security picture becomes more murky.

I suggested attaching a PASID to (some) queues - see my old post "using
PASIDs to enable a safe variant of direct ring access".

Then using IOMMU with VFIO to limit access through queue to corrent
ranges of memory.


-- 
MST
