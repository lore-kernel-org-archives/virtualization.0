From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Thu, 14 Dec 2017 04:37:01 -0800
Message-ID: <20171214123701.GA30288__4188.40096467665$1513255032$gmane$org@bombadil.infradead.org>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
	<5A311C5E.7000304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A311C5E.7000304@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 13, 2017 at 08:26:06PM +0800, Wei Wang wrote:
> On 12/12/2017 09:20 PM, Tetsuo Handa wrote:
> > Can you eliminate exception path and fold all xbitmap patches into one, and
> > post only one xbitmap patch without virtio-baloon changes? If exception path
> > is valuable, you can add exception path after minimum version is merged.
> > This series is too difficult for me to close corner cases.
> 
> That exception path is claimed to save memory, and I don't have a strong
> reason to remove that part.
> Matthew, could we get your feedback on this?

Sure.  This code is derived from the IDA code in lib/idr.c.  Eventually,
I intend to reunite them.  For IDA, it clearly makes sense; the first 62
entries result in allocating no memory at all, which is going to be 99%
of users.  After that, we allocate 128 bytes which will serve the first
1024 users.

The xbitmap, as used by Wei's patches here is going to be used somewhat
differently from that.  I understand why Tetsuo wants the exceptional
path removed; I'm not sure the gains will be as important.  But if we're
going to rebuild the IDA on top of the xbitmap, we need to keep them.

I really want to pay more attention to this, but I need to focus on
getting the XArray finished.
