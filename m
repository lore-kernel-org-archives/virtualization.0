From: john cooper <john.cooper@redhat.com>
Subject: Re: [PATCH 1/2] Add 'serial' attribute to virtio-blk devices
Date: Mon, 21 Jun 2010 01:51:57 -0400
Message-ID: <4C1EFDFD.5050907__39440.6182961122$1277100735$gmane$org@redhat.com>
References: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
	<201006211122.38156.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201006211122.38156.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: john.cooper@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Sat, 19 Jun 2010 04:08:02 am Ryan Harper wrote:
>> Create a new attribute for virtio-blk devices that will fetch the serial number
>> of the block device.  This attribute can be used by udev to create disk/by-id
>> symlinks for devices that don't have a UUID (filesystem) associated with them.
>>
>> ATA_IDENTIFY strings are special in that they can be up to 20 chars long
>> and aren't required to be NULL-terminated.  The buffer is also zero-padded
>> meaning that if the serial is 19 chars or less that we get a NULL terminated
>> string.  When copying this value into a string buffer, we must be careful to
>> copy up to the NULL (if it present) and only 20 if it is longer and not to
>> attempt to NULL terminate; this isn't needed.
>>
>> Signed-off-by: Ryan Harper <ryanh@us.ibm.com>
>> Signed-off-by: john cooper <john.cooper@redhat.com>
>> ---
>>  drivers/block/virtio_blk.c |   32 ++++++++++++++++++++++++++++++++
>>  1 files changed, 32 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 258bc2a..f1ef26f 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -281,6 +281,31 @@ static int index_to_minor(int index)
>>  	return index << PART_BITS;
>>  }
>>  
>> +/* Copy serial number from *s to *d.  Copy operation terminates on either
>> + * encountering a nul in *s or after n bytes have been copied, whichever
>> + * occurs first.  *d is not forcibly nul terminated.  Return # of bytes copied.
>> + */
>> +static inline int serial_sysfs(char *d, char *s, int n)
>> +{
>> +	char *di = d;
>> +
>> +	while (*s && n--)
>> +		*d++ = *s++;
>> +	return d - di;
>> +}
>> +
>> +static ssize_t virtblk_serial_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct gendisk *disk = dev_to_disk(dev);
>> +	char id_str[VIRTIO_BLK_ID_BYTES];
>> +
>> +	if (IS_ERR(virtblk_get_id(disk, id_str)))
>> +		return 0;
> 
> 0?  Really?  That doesn't seem very informative.

Propagating a prospective error from virtblk_get_id() should
be possible.  Unsure if doing so is more useful from the
user's perspective compared to just a nul id string.

>> +	return serial_sysfs(buf, id_str, min(VIRTIO_BLK_ID_BYTES, PAGE_SIZE));
> 
> How about something like this:
> 
> 	BUILD_BUG_ON(PAGE_SIZE < VIRTIO_BLK_ID_BYTES + 1);

Agreed, that's a better wrench in the gearworks.
Note padding buf[] by 1 isn't necessary as indicated
below.

> 	/* id_str is not necessarily nul-terminated! */
> 	buf[VIRTIO_BLK_ID_BYTES] = '\0';
> 	return virtblk_get_id(disk, buf);

The /sys file is rendered according to the length
returned from this function and the trailing nul
is not interpreted in this context.  In fact if a
nul is added and included in the byte count of the
string it will appear in the /sys file.

Thanks,

-john


-- 
john.cooper@redhat.com
