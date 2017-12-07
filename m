From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v18 05/10] xbitmap: add more operations
Date: Thu, 07 Dec 2017 20:01:24 +0800
Message-ID: <5A292D94.5000700__39090.2395164177$1512647970$gmane$org@intel.com>
References: <201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>	<5A210C96.8050208@intel.com>	<201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>	<286AC319A985734F985F78AFA26841F739376DA1@shsmsx102.ccr.corp.intel.com>	<20171201172519.GA27192@bombadil.infradead.org>
	<201712031050.IAC64520.QVLFFOOJOSFtHM@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201712031050.IAC64520.QVLFFOOJOSFtHM@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, nilal@redhat.com, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 12/03/2017 09:50 AM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>> On Fri, Dec 01, 2017 at 03:09:08PM +0000, Wang, Wei W wrote:
>>> On Friday, December 1, 2017 9:02 PM, Tetsuo Handa wrote:
>>>> If start == end is legal,
>>>>
>>>>     for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
>>>>
>>>> makes this loop do nothing because 10 < 10 is false.
>>> How about "start <= end "?
>> Don't ask Tetsuo for his opinion, write some userspace code that uses it.
>>
> Please be sure to prepare for "end == -1UL" case, for "start < end" will become
> true when "start = (start | (IDA_BITMAP_BITS - 1)) + 1" made "start == 0" due to
> overflow.

I think there is one more corner case with this API: searching for bit 
"1" from [0, ULONG_MAX] while no bit is set in the range, there appear 
to be no possible value that we can return (returning "end + 1" will be 
"ULONG_MAX + 1", which is 0)
I plan to make the "end" be exclusive of the searching, that is, [start, 
end), and return "end" if no such bit is found.

For cases like [16, 16), returning 16 doesn't mean bit 16 is 1 or 0, it 
simply means there is no bits to search in the given range, since 16 is 
exclusive.

Please let me know if you have a different thought.

Best,
Wei
