From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH v13 0/5] Virtio-balloon Enhancement
Date: Wed, 16 Aug 2017 17:33:20 +0800
Message-ID: <59941160.9050403@intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
	<20170816055704.GB21088@shay3t003839711.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170816055704.GB21088@shay3t003839711.china.huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Tao <taozhe1@huawei.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/16/2017 01:57 PM, Adam Tao wrote:
> On Thu, Aug 03, 2017 at 02:38:14PM +0800, Wei Wang wrote:
>> This patch series enhances the existing virtio-balloon with the following
>> new features:
>> 1) fast ballooning: transfer ballooned pages between the guest and host in
>> chunks using sgs, instead of one by one; and
>> 2) free_page_vq: a new virtqueue to report guest free pages to the host.
>>
> Hi wei,
> The reason we add the new vq for the migration feature is based on
> what(original design based on inflate and deflate vq)?
> I am wondering if we add new feature in the future do we still need to add new type
> of vq?
> Do we need to add one command queue for the common purpose(including
> different type of requests except the in/deflate ones)?
> Thanks
> Adam

Hi Adam,

The the free_page_vq is added to report free pages to the hypervisor.
Neither inflate nor deflate vq was for this purpose.

Based on the current implementation, a vq dedicated to one usage (i.e. 
report
free pages) is better, since mixing with other usages, e.g. a command vq to
handle multiple commands at the same time, would have some issues (e.g. one
being delayed by another due to some resource control), and it also 
results in
more complex interfaces between the driver and device.

For future usages which are still unknown at present, I think we can discuss
them case by case in the future.

Best,
Wei
