From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] virtio-blk: Don't free ida when disk is in use
Date: Fri, 21 Dec 2012 09:57:18 +0800
Message-ID: <50D3C1FE.7000508@redhat.com>
References: <1355946015-25879-1-git-send-email-agraf@suse.de>
	<20121220105417.GA3789@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121220105417.GA3789@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/20/2012 06:54 PM, Michael S. Tsirkin wrote:
> On Wed, Dec 19, 2012 at 08:40:15PM +0100, Alexander Graf wrote:
>> When a file system is mounted on a virtio-blk disk, we then remove it
>> and then reattach it, the reattached disk gets the same disk name and
>> ids as the hot removed one.
>>
>> This leads to very nasty effects - mostly rendering the newly attached
>> device completely unusable.
>>
>> Trying what happens when I do the same thing with a USB device, I saw
>> that the sd node simply doesn't get free'd when a device gets forcefully
>> removed.
>>
>> Imitate the same behavior for vd devices. This way broken vd devices
>> simply are never free'd and newly attached ones keep working just fine.
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>>  drivers/block/virtio_blk.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 0bdde8f..07a18e2 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -889,6 +889,7 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>>  {
>>  	struct virtio_blk *vblk = vdev->priv;
>>  	int index = vblk->index;
>> +	int refc;
>>  
>>  	/* Prevent config work handler from accessing the device. */
>>  	mutex_lock(&vblk->config_lock);
>> @@ -903,11 +904,15 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>>  
>>  	flush_work(&vblk->config_work);
>>  
>> +	refc = atomic_read(&disk_to_dev(vblk->disk)->kobj.kref.refcount);
>>  	put_disk(vblk->disk);
>>  	mempool_destroy(vblk->pool);
>>  	vdev->config->del_vqs(vdev);
>>  	kfree(vblk);
>> -	ida_simple_remove(&vd_index_ida, index);
>> +
>> +	/* Only free device id if we don't have any users */
>> +	if (refc == 1)
>> +		ida_simple_remove(&vd_index_ida, index);
>>  }
>>  
>>  #ifdef CONFIG_PM
> 
> Network devices take the approach of retrying every second.
> Donnu if it makes sense here.


virtnet_remove()? I am not seeing the code there.

We are too late in the remove path in virtblk_remove(). No easy way to
come back to the state before the remove. So, giving user warning (tell
him to close the device) and retrying might be a choice.


>> -- 
>> 1.7.12.4
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 


-- 
Asias
