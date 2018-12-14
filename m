From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Fri, 14 Dec 2018 15:49:51 +0800
Message-ID: <5C13609F.4090406__43062.4662935317$1544773700$gmane$org@huawei.com>
References: <5C10D4FB.6070009@huawei.com>
	<20181212103138-mutt-send-email-mst@kernel.org>
	<5C11CD14.3040809@huawei.com>
	<20181213154923.GN23318@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213154923.GN23318@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2018/12/13 23:49, Stefan Hajnoczi wrote:
> On Thu, Dec 13, 2018 at 11:08:04AM +0800, jiangyiwen wrote:
>> On 2018/12/12 23:37, Michael S. Tsirkin wrote:
>>> On Wed, Dec 12, 2018 at 05:29:31PM +0800, jiangyiwen wrote:
>>>> When vhost support VIRTIO_VSOCK_F_MRG_RXBUF feature,
>>>> it will merge big packet into rx vq.
>>>>
>>>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>>>
>>> I feel this approach jumps into making interface changes for
>>> optimizations too quickly. For example, what prevents us
>>> from taking a big buffer, prepending each chunk
>>> with the header and writing it out without
>>> host/guest interface changes?
>>>
>>> This should allow optimizations such as vhost_add_used_n
>>> batching.
>>>
>>> I realize a header in each packet does have a cost,
>>> but it also has advantages such as improved robustness,
>>> I'd like to see more of an apples to apples comparison
>>> of the performance gain from skipping them.
>>>
>>>
>>
>> Hi Michael,
>>
>> I don't fully understand what you mean, do you want to
>> see a performance comparison that before performance and
>> only use batching?
>>
>> In my opinion, guest don't fill big buffer in rx vq because
>> the balance performance and guest memory pressure, add
>> mergeable feature can improve big packets performance,
>> as for small packets, I try to find out the reason, may be
>> the fluctuation of test results, or in mergeable mode, when
>> Host send a 4k packet to Guest, we should call vhost_get_vq_desc()
>> twice in host(hdr + 4k data), and in guest we also should call
>> virtqueue_get_buf() twice.
> 
> I like the idea of making optimizations in small steps and measuring the
> effect of each step.  This way we'll know which aspect caused the
> differences in benchmark results.
> 
> Stefan
> 

Yes, now I also focus on other project, but I will use some
extra time to measure it.

Thanks,
Yiwen.
