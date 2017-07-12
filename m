From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v11 3/6] virtio-balloon:
	VIRTIO_BALLOON_F_PAGE_CHUNKS
Date: Wed, 12 Jul 2017 21:05:38 +0800
Message-ID: <59661EA2.2040708__4245.46067738465$1499864626$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-4-git-send-email-wei.w.wang@intel.com>
	<20170613200049-mutt-send-email-mst@kernel.org>
	<594240E9.2070705@intel.com>
	<20170628150450.GA1402@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170628150450.GA1402@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, amit.shah@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, dave.hansen@intel.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Matthew,

On 06/28/2017 11:04 PM, Matthew Wilcox wrote:
> On Thu, Jun 15, 2017 at 04:10:17PM +0800, Wei Wang wrote:
>>> So you still have a home-grown bitmap. I'd like to know why
>>> isn't xbitmap suggested for this purpose by Matthew Wilcox
>>> appropriate. Please add a comment explaining the requirements
>>> from the data structure.
>> I didn't find his xbitmap being upstreamed, did you?
> It doesn't have any users in the tree yet.  Can't add code with new users.
> You should be the first!

Glad to be the first person eating your tomato. Taste good :-)
Please have a check how it's cooked in the latest v12 patches. Thanks.

Best,
Wei
