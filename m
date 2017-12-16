From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Sat, 16 Dec 2017 18:12:35 +0800
Message-ID: <5A34F193.5040700__11469.6515528069$1513419059$gmane$org@intel.com>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<20171215184256.GA27160@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171215184256.GA27160@bombadil.infradead.org>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 12/16/2017 02:42 AM, Matthew Wilcox wrote:
> On Tue, Dec 12, 2017 at 07:55:55PM +0800, Wei Wang wrote:
>> +int xb_preload_and_set_bit(struct xb *xb, unsigned long bit, gfp_t gfp);
> I'm struggling to understand when one would use this.  The xb_ API
> requires you to handle your own locking.  But specifying GFP flags
> here implies you can sleep.  So ... um ... there's no locking?

In the regular use cases, people would do xb_preload() before taking the 
lock, and the xb_set/clear within the lock.

In the virtio-balloon usage, we have a large number of bits to set with 
the balloon_lock being held (we're not unlocking for each bit), so we 
used the above wrapper to do preload and set within the balloon_lock, 
and passed in GFP_NOWAIT to avoid sleeping. Probably we can change to 
put this wrapper implementation to virtio-balloon, since it would not be 
useful for the regular cases.


Best,
Wei
