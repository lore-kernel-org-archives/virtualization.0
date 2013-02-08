From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/8] virtio: new API for addition of buffers,
	scatterlist changes
Date: Fri, 08 Feb 2013 07:35:44 +0100
Message-ID: <51149CC0.4080702__44560.4275948883$1360305384$gmane$org@redhat.com>
References: <1360239752-2470-1-git-send-email-pbonzini@redhat.com>
	<8738x7ih5o.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8738x7ih5o.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Il 08/02/2013 05:05, Rusty Russell ha scritto:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> The virtqueue_add_buf function has two limitations:
>>
>> 1) it requires the caller to provide all the buffers in a single call;
>>
>> 2) it does not support chained scatterlists: the buffers must be
>> provided as an array of struct scatterlist.
>>
>> Because of these limitations, virtio-scsi has to copy each request into
>> a scatterlist internal to the driver.  It cannot just use the one that
>> was prepared by the upper SCSI layers.
> 
> Hi Paulo,
> 
>         Note that you've defined your problem in terms of your solution
> here.  For clarity:

Good catch. :)

> The problem: we want to prepend and append to a scatterlist.  We can't
>         append, because the chained scatterlist implementation requires
>         an element to be appended to join two scatterlists together.
> 
> The solution: fix scatterlists by introducing struct sg_ring:
>         struct sg_ring {
>                 struct list_head ring;
>         	unsigned int nents;
>         	unsigned int orig_nents; /* do we want to replace sg_table? */
>                 struct scatterlist *sg;
>         };
> 
> The workaround: make virtio accept multiple scatterlists for a single
>         buffer.
> 
> There's nothing wrong with your workaround, but if other subsystems have
> the same problem we do, perhaps we should consider a broader solution?

Do they?  Given the resistance you have had on the topic, perhaps they
don't (though I agree that chained scatterlist are horrible).

But I'll add a note on this to the commit message and why the workaround
is IMHO acceptable.

Paolo
