From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V3 0/5] Hi:
Date: Fri, 4 Jan 2019 16:41:24 -0500
Message-ID: <20190104163516-mutt-send-email-mst__7111.64512108571$1546637967$gmane$org@kernel.org>
References: <20181229124656.3900-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181229124656.3900-1-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling.


I think it's a reasonable approach.
However I need to look at whether and which mmu notifiers are invoked before
writeback. Do you know?

> Test shows about 24% improvement on TX PPS. It should benefit other
> cases as well.
> 
> Changes from V2:
> - fix buggy range overlapping check
> - tear down MMU notifier during vhost ioctl to make sure invalidation
>   request can read metadata userspace address and vq size without
>   holding vq mutex.
> Changes from V1:
> - instead of pinning pages, use MMU notifier to invalidate vmaps and
>   remap duing metadata prefetch
> - fix build warning on MIPS
> 
> Jason Wang (5):
>   vhost: generalize adding used elem
>   vhost: fine grain userspace memory accessors
>   vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
>   vhost: introduce helpers to get the size of metadata area
>   vhost: access vq metadata through kernel virtual address
> 
>  drivers/vhost/net.c   |   4 +-
>  drivers/vhost/vhost.c | 416 +++++++++++++++++++++++++++++++++++++-----
>  drivers/vhost/vhost.h |  15 +-
>  3 files changed, 384 insertions(+), 51 deletions(-)
> 
> -- 
> 2.17.1
