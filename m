From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/test: fix up after API change
Date: Tue, 9 Jun 2020 13:56:26 +0800
Message-ID: <8ca24e37-d319-fbf7-0114-ddf7eb110781@redhat.com>
References: <20200608124254.727184-1-mst@redhat.com>
 <e747a953-3135-fef9-b098-fca11755d6e4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e747a953-3135-fef9-b098-fca11755d6e4@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/9 下午1:53, Jason Wang wrote:
>
> On 2020/6/8 下午8:42, Michael S. Tsirkin wrote:
>> Pass a flag to request kernel thread use.
>>
>> Fixes: 01fcb1cbc88e ("vhost: allow device that does not depend on 
>> vhost worker")
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   drivers/vhost/test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
>> index f55cb584b84a..12304eb8da15 100644
>> --- a/drivers/vhost/test.c
>> +++ b/drivers/vhost/test.c
>> @@ -122,7 +122,7 @@ static int vhost_test_open(struct inode *inode, 
>> struct file *f)
>>       vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
>>       n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
>>       vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
>> -               VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
>> +               VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
>>         f->private_data = n;
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Just to confirm, have you queued the doorbell mapping patches already? 
> Or you expect I squash this into v2 of doorbell mapping series?


Ok, I saw the patches in your linux-next branch.

Thanks


>
> Thanks
>
