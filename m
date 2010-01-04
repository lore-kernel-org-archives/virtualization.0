From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v2] virtio-blk physical block size
Date: Mon, 04 Jan 2010 09:02:57 +0200
Message-ID: <4B4192A1.3030801__19711.0184505165$1262588649$gmane$org@redhat.com>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001041338.52621.rusty@rustcorp.com.au>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/04/2010 05:08 AM, Rusty Russell wrote:
> On Tue, 29 Dec 2009 03:09:23 am Avi Kivity wrote:
>    
>> This patch adds a physical block size attribute to virtio disks,
>> corresponding to /sys/devices/.../physical_block_size.  It is defined as
>> the request alignment which will not trigger RMW cycles.  This can be
>> important for modern disks which use 4K physical sectors (though they
>> still support 512 logical sectors), and for file-backed disk images (which
>> have both the underlying filesystem block size and their own allocation
>> granularity to consider).
>>
>> Installers use this to align partitions to physical block boundaries.
>>
>> Note the spec already defined blk_size as the performance rather than
>> minimum alignment.  However the driver interpreted this as the logical
>> block size, so I updated the spec to match the driver assuming the driver
>> predates the spec and that this is an error.
>>      
> I thought this was what I was doing, but I have shown over and over that
> I have no idea about block devices.
>
> Our current driver treats BLK_SIZE as the logical and physical size (see
> blk_queue_logical_block_size).
>    

But we want them to be different.

> I have no idea what "logical" vs. "physical" actually means.  Anyone?  Most
> importantly, is it some Linux-internal difference or a real I/O-visible
> distinction?
>    

Yes.

Logical block size is the minimum block size the hardware will allow.  
Try to write less than that, and the hardware will laugh in your face.

Physical block size is the what the logical block size would have been 
is software didn't suck.  In theory they should be the same, but since 
compatibility reaons clamp the logical block size to 512, they have to 
differ.  A disk may have a physical block size of 4096 and emulate 
logical block size of 512 on top of that using read-modify-write.

Or so I understand it.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
