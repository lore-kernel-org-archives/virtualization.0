From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V6 0/2] Improve virtio-blk performance
Date: Wed, 08 Aug 2012 14:24:22 +0800
Message-ID: <50220616.6060508@redhat.com>
References: <1344329235-17449-1-git-send-email-asias@redhat.com>
	<20120807091630.GB2651@lst.de> <5021D87C.4050400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5021D87C.4050400@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/08/2012 11:09 AM, Asias He wrote:
> On 08/07/2012 05:16 PM, Christoph Hellwig wrote:
>> On Tue, Aug 07, 2012 at 04:47:13PM +0800, Asias He wrote:
>>> 1) Ramdisk device
>>>       With bio-based IO path, sequential read/write, random read/write
>>>       IOPS boost         : 28%, 24%, 21%, 16%
>>>       Latency improvement: 32%, 17%, 21%, 16%
>>> 2) Fusion IO device
>>>       With bio-based IO path, sequential read/write, random read/write
>>>       IOPS boost         : 11%, 11%, 13%, 10%
>>>       Latency improvement: 10%, 10%, 12%, 10%
>>
>> Do you also have numbers for normal SAS/SATA disks?  The changelog should
>> have a reall good explanation of why this is optional, and numbers are a
>> very important part of that.

Yes. I posted the numbers on normal SATA disks a few days ago in the 
thread with Sasha. Will add that data and explanation of why optional to 
the changelog

-- 
Asias
