From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 2/3] virtio: use dev_to_virtio wrapper in virtio
Date: Wed, 05 Dec 2012 20:59:44 +0800
Message-ID: <50BF4540.4050601@cn.fujitsu.com>
References: <1354691009-25966-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1354691009-25966-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<20121205111606.GB10045@redhat.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121205111606.GB10045@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/05/2012 07:16 PM, Michael S. Tsirkin wrote:
> On Wed, Dec 05, 2012 at 03:03:28PM +0800, Wanlong Gao wrote:
>> Use dev_to_virtio wrapper in virtio to make code clearly.
>>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>> ---
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 25fa1a6..30fc3c9 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -79,7 +79,7 @@ struct virtio_device {
>>  	void *priv;
>>  };
>>  
>> -#define dev_to_virtio(dev) container_of(dev, struct virtio_device, dev)
>> +#define dev_to_virtio(_dev) container_of(_dev, struct virtio_device, dev)
>>  int register_virtio_device(struct virtio_device *dev);
>>  void unregister_virtio_device(struct virtio_device *dev);
> 
> 
> More importantly this would fix dev_to_virtio since ATM
> 
> dev_to_virtio(_d) resolves to
>  container_of(_d, struct virtio_device, _d)
> 
> which is not what was intended.

Yes, you are right, I not mentioned.

> 
> However, I think this shows that using a macro here
> is a mistake. Could you code this up with a static inline
> function instead please?

Sure.

Thanks,
Wanlong Gao

> 
>>  
>> -- 
>> 1.8.0
> 
