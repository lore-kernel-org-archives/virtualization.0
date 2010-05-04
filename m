From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 04 May 2010 11:34:38 +0300
Message-ID: <4BDFDC1E.5070500__1552.02895771271$1272962130$gmane$org@redhat.com>
References: <20100218222220.GA14847@redhat.com>
	<201005041408.25069.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201005041408.25069.rusty@rustcorp.com.au>
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
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, Jens Axboe <jens.axboe@oracle.com>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On 05/04/2010 07:38 AM, Rusty Russell wrote:
> On Fri, 19 Feb 2010 08:52:20 am Michael S. Tsirkin wrote:
>    
>> I took a stub at documenting CMD and FLUSH request types in virtio
>> block.  Christoph, could you look over this please?
>>
>> I note that the interface seems full of warts to me,
>> this might be a first step to cleaning them.
>>      
> ISTR Christoph had withdrawn some patches in this area, and was waiting
> for him to resubmit?
>
> I've given up on figuring out the block device.  What seem to me to be sane
> semantics along the lines of memory barriers are foreign to disk people: they
> want (and depend on) flushing everywhere.
>
> For example, tdb transactions do not require a flush, they only require what
> I would call a barrier: that prior data be written out before any future data.
> Surely that would be more efficient in general than a flush!  In fact, TDB
> wants only writes to *that file* (and metadata) written out first; it has no
> ordering issues with other I/O on the same device.
>    

I think that's SCSI ordered tags.

> A generic I/O interface would allow you to specify "this request depends on these
> outstanding requests" and leave it at that.  It might have some sync flush
> command for dumb applications and OSes.  The userspace API might be not be as
> precise and only allow such a barrier against all prior writes on this fd.
>    

Depends on all previous requests, and will commit before all following 
requests.  ie a full barrier.

> ISTR someone mentioning a desire for such an API years ago, so CC'ing the
> usual I/O suspects...
>    

I'd love to see TCQ exposed to user space.

-- 
error compiling committee.c: too many arguments to function
