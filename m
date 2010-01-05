From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH v2] virtio-blk physical block size
Date: Tue, 05 Jan 2010 14:58:43 +0200
Message-ID: <4B433783.6090400__31719.5162679583$1262696368$gmane$org@redhat.com>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
	<20100104083035.GA7461@lst.de>
	<201001052326.33216.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001052326.33216.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/05/2010 02:56 PM, Rusty Russell wrote:
>
>> Those should be the same for any sane interface.  They are for classical
>> disk devices with larger block sizes (MO, s390 dasd) and also for the
>> now appearing 4k sector scsi disks.  But in the ide world people are
>> concerned about dos/window legacy compatiblity so they came up with a
>> nasty hack:
>>
>>   - there is a physical block size as used by the disk internally
>>     (4k initially)
>>   - all the interfaces to the operating system still happen in the
>>     traditional 512 byte blocks to not break any existing assumptions
>>   - to make sure modern operating systems can optimize for the larger
>>     physical sectors the disks expose this size, too.
>>   - even worse disks can also have alignment hacks for the traditional
>>     DOS partitions tables, so that the 512 byte block zero might even
>>     have an offset into the first larger physical block.  This is also
>>     exposed in the ATA identify information.
>>
>> All in all I don't think this mess is a good idea to replicate in
>> virtio.  Virtio by defintion requires virtualization aware guests, so we
>> should just follow the SCSI way of larger real block sizes here.
>>      
> Yes.  The current VIRTIO_BLK_F_BLK_SIZE says "please use this block size".
> We haven't actually specified what happens if the guest doesn't, but the
> spec says "must", and the Linux implementation does so AFAICT.
>
> If we want a "soft" size, we could add that as a separate feature.
>    

No - I agree with Christoph, there's no reason to use a 512/4096 
monstrosity with virtio.

-- 
error compiling committee.c: too many arguments to function
