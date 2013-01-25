From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH V7 1/3] virtio-net: fix the set affinity bug when CPU
	IDs are not consecutive
Date: Fri, 25 Jan 2013 17:16:14 +0800
Message-ID: <51024D5E.6000409__39216.940655797$1359105431$gmane$org@cn.fujitsu.com>
References: <1359102981-3401-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<510249C6.2000105@redhat.com> <51024AC7.9030109@cn.fujitsu.com>
	<51024C3A.6080200@redhat.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51024C3A.6080200@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Dumazet <erdnetdev@gmail.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


>>>>  
>>>> -	for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> -		int cpu = set ? i : -1;
>>>> -		virtqueue_set_affinity(vi->rq[i].vq, cpu);
>>>> -		virtqueue_set_affinity(vi->sq[i].vq, cpu);
>>>> -	}
>>>> +	if (set) {
>>>> +		i = 0;
>>>> +		for_each_online_cpu(cpu) {
>>>> +			virtqueue_set_affinity(vi->rq[i].vq, cpu);
>>>> +			virtqueue_set_affinity(vi->sq[i].vq, cpu);
>>>> +			*per_cpu_ptr(vi->vq_index, cpu) = i;
>>>> +			i++;
>>>> +		}
>>>>  
>>>> -	if (set)
>>>>  		vi->affinity_hint_set = true;
>>>> -	else
>>>> +	} else {
>>>> +		for(i = 0; i < vi->max_queue_pairs; i++) {
>>>> +			virtqueue_set_affinity(vi->rq[i].vq, -1);
>>>> +			virtqueue_set_affinity(vi->sq[i].vq, -1);
>>>> +		}
>>>> +
>>>> +		i = 0;
>>>> +		for_each_online_cpu(cpu)
>>>> +			*per_cpu_ptr(vi->vq_index, cpu) =
>>>> +				++i % vi->curr_queue_pairs;
>>>> +
>>>>  		vi->affinity_hint_set = false;
>>>> +	}
>>>>  }
>>> Sorry, looks like the issue of v6 still exists, we need set per-cpu
>>> index unconditionally here (and also in 2/3), the cpus != queues check
>>> may bypass this setting.
>> This fixed in 2/3, when cpus != queues, it will go into virtnet_clean_affinity(in 2/3),
>> then vq index is set in virtnet_clean_affinity. Am I missing something?
> 
> Ah, so 2/3 looks fine. I suggest to fix this in 1/3 since it's not good
> to introduce a bug in patch 1 and fix it in patch 2, and this can also
> confuse the bisect.
> 

Make sense, will move the fix from 2/3 to 1/3.

Thanks,
Wanlong Gao
