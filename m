From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v23 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Wed, 24 Jan 2018 13:47:47 +0800
Message-ID: <5A681E03.1030007__10995.7258952365$1516772638$gmane$org@intel.com>
References: <1516762227-36346-1-git-send-email-wei.w.wang@intel.com>
	<1516762227-36346-3-git-send-email-wei.w.wang@intel.com>
	<20180124064923-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180124064923-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/24/2018 01:01 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 24, 2018 at 10:50:27AM +0800, Wei Wang wrote:
> This will not DTRT in all cases. It's quite possible
> that host does not need the kick when ring is half full but
> does need it later when ring is full.
> You can kick at ring half full as optimization but you absolutely
> still must kick on ring full. Something like:
>
> if (vq->num_free == virtqueue_get_vring_size(vq) / 2 ||
> 	vq->num_free <= 2)

Right. Would "if (vq->num_free < virtqueue_get_vring_size(vq) / 2" be 
better?


Best,
Wei
