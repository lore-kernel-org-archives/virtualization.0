From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Mon, 06 Aug 2018 17:56:17 +0800
Message-ID: <5B681B41.6070205__25987.2795119465$1533549084$gmane$org@intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
	<1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
	<16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/03/2018 08:11 PM, Tetsuo Handa wrote:
> On 2018/08/03 17:32, Wei Wang wrote:
>> +static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>> +{
>> +	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
>> +	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
>> +	vb->shrinker.batch = 0;
>> +	vb->shrinker.seeks = DEFAULT_SEEKS;
> Why flags field is not set? If vb is allocated by kmalloc(GFP_KERNEL)
> and is nowhere zero-cleared, KASAN would complain it.

Could you point where in the code that would complain it?
I only see two shrinker flags (NUMA_AWARE and MEMCG_AWARE), and they 
seem not related to that.


Best,
Wei
