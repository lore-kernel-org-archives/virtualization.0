From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v7 kernel 2/5] virtio-balloon:
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Thu, 09 Mar 2017 15:12:47 +0800
Message-ID: <58C1006F.6080206__13303.3552360304$1489043497$gmane$org@intel.com>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-3-git-send-email-wei.w.wang@intel.com>
	<20170308060131-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170308060131-mutt-send-email-mst@kernel.org>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Amit Shah <amit.shah@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liang Li <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/08/2017 12:01 PM, Michael S. Tsirkin wrote:
> On Fri, Mar 03, 2017 at 01:40:27PM +0800, Wei Wang wrote:
>> From: Liang Li <liang.z.li@intel.com>
>>
>> Add a new feature bit, VIRTIO_BALLOON_F_CHUNK_TRANSFER. Please check
>> the implementation patch commit for details about this feature.
>
> better squash into next patch.

OK, will do.

Best,
Wei
