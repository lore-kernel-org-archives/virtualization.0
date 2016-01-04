From: Yang Zhang <yang.zhang.wz@gmail.com>
Subject: Re: [PATCH RFC] vhost: basic device IOTLB support
Date: Mon, 4 Jan 2016 09:39:37 +0800
Message-ID: <5689CD59.6030900__19240.0252599784$1451922736$gmane$org@gmail.com>
References: <1451546025-15955-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451546025-15955-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 2015/12/31 15:13, Jason Wang wrote:
> This patch tries to implement an device IOTLB for vhost. This could be
> used with for co-operation with userspace(qemu) implementation of
> iommu for a secure DMA environment in guest.
>
> The idea is simple. When vhost meets an IOTLB miss, it will request
> the assistance of userspace to do the translation, this is done
> through:
>
> - Fill the translation request in a preset userspace address (This
>    address is set through ioctl VHOST_SET_IOTLB_REQUEST_ENTRY).
> - Notify userspace through eventfd (This eventfd was set through ioctl
>    VHOST_SET_IOTLB_FD).
>
> When userspace finishes the translation, it will update the vhost
> IOTLB through VHOST_UPDATE_IOTLB ioctl. Userspace is also in charge of
> snooping the IOTLB invalidation of IOMMU IOTLB and use
> VHOST_UPDATE_IOTLB to invalidate the possible entry in vhost.

Is there any performance data shows the difference with IOTLB 
supporting? I doubt we may see performance decrease since the flush code 
path is longer than before.

-- 
best regards
yang
