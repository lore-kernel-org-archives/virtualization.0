From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v16 5/5] virtio-balloon: VIRTIO_BALLOON_F_CTRL_VQ
Date: Thu, 19 Oct 2017 16:07:06 +0800
Message-ID: <59E85D2A.1060407__24836.912242654$1508400353$gmane$org@intel.com>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-6-git-send-email-wei.w.wang@intel.com>
	<20171001060305-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73932025A@shsmsx102.ccr.corp.intel.com>
	<20171010180636-mutt-send-email-mst@kernel.org>
	<59DDB428.4020208@intel.com>
	<20171011161912-mutt-send-email-mst@kernel.org>
	<59DEE790.5040809@intel.com>
	<20171013163503-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171013163503-mutt-send-email-mst@kernel.org>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, mhocko@kernel.or
List-Id: virtualization@lists.linuxfoundation.org

On 10/13/2017 09:38 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 12, 2017 at 11:54:56AM +0800, Wei Wang wrote:
>>> But I think flushing is very fragile. You will easily run into races
>>> if one of the actors gets out of sync and keeps adding data.
>>> I think adding an ID in the free vq stream is a more robust
>>> approach.
>>>
>> Adding ID to the free vq would need the device to distinguish whether it
>> receives an ID or a free page hint,
> Not really.  It's pretty simple: a 64 bit buffer is an ID. A 4K and bigger one
> is a page.

I think we can also use the previous method, free page via in_buf, and 
id via out_buf.

Best,
Wei
