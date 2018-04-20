From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Date: Fri, 20 Apr 2018 17:12:21 +0300
Message-ID: <20180420165302-mutt-send-email-mst__12486.768133431$1524233451$gmane$org@kernel.org>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
	<30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
	<20180419212911-mutt-send-email-mst@kernel.org>
	<060e2b5f-2e93-c53f-387b-5baaa33e87cd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <060e2b5f-2e93-c53f-387b-5baaa33e87cd@redhat.com>
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

On Fri, Apr 20, 2018 at 11:52:47AM +0800, Jason Wang wrote:
> > The biggest issue is that you let userspace poke at the
> > device which is also allowed by the IOMMU to poke at
> > kernel memory (needed for kernel driver to work).
> 
> I don't quite get. The userspace driver could be built on top of VFIO for
> sure. So kernel memory were perfectly isolated in this case.

VFIO does what it can but it mostly just has the IOMMU to play with.
So don't overestimate what it can do - it assumes a high level
of spec compliance for protections to work. For example,
ATS is enabled by default if device has it, and that
treats translated requests are trusted. FLS is assumed to reset
the device for when VFIO is unbound from the device. etc.


> > 
> > Yes, maybe if device is not buggy it's all fine, but
> > it's better if we do not have to trust the device
> > otherwise the security picture becomes more murky.
> > 
> > I suggested attaching a PASID to (some) queues - see my old post "using
> > PASIDs to enable a safe variant of direct ring access".
> > 
> > Then using IOMMU with VFIO to limit access through queue to corrent
> > ranges of memory.
> 
> Well userspace driver could benefit from this too. And we can even go
> further by using nested IO page tables to share IOVA address space between
> devices and a VM.
> 
> Thanks

Yes I suggested this separately.

-- 
MST
