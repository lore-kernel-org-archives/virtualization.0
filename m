From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 0/5] Extend virtio-balloon for fast (de)inflating &
	fast live migration
Date: Fri, 14 Apr 2017 10:28:32 +0800
Message-ID: <58F033D0.7080101__6223.72024595297$1492136818$gmane$org@intel.com>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<20170413204411.GJ784@bombadil.infradead.org>
	<20170414044515-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170414044515-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 04/14/2017 09:50 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 13, 2017 at 01:44:11PM -0700, Matthew Wilcox wrote:
>> On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
>>> 2) transfer the guest unused pages to the host so that they
>>> can be skipped to migrate in live migration.
>> I don't understand this second bit.  You leave the pages on the free list,
>> and tell the host they're free.  What's preventing somebody else from
>> allocating them and using them for something?  Is the guest semi-frozen
>> at this point with just enough of it running to ask the balloon driver
>> to do things?
> There's missing documentation here.
>
> The way things actually work is host sends to guest
> a request for unused pages and then write-protects all memory.
>
> So guest isn't frozen but any changes will be detected by host.
>

Probably it's better to say " transfer the info about the guest unused pages
to the host so that the host gets a chance to skip the transfer of the 
unused
pages during live migration".

Best,
Wei
