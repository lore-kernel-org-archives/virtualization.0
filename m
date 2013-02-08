From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH 0/8] virtio: new API for addition of buffers,
	scatterlist changes
Date: Fri, 08 Feb 2013 14:35:55 +1030
Message-ID: <8738x7ih5o.fsf@rustcorp.com.au>
References: <1360239752-2470-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1360239752-2470-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> The virtqueue_add_buf function has two limitations:
>
> 1) it requires the caller to provide all the buffers in a single call;
>
> 2) it does not support chained scatterlists: the buffers must be
> provided as an array of struct scatterlist.
>
> Because of these limitations, virtio-scsi has to copy each request into
> a scatterlist internal to the driver.  It cannot just use the one that
> was prepared by the upper SCSI layers.

Hi Paulo,

        Note that you've defined your problem in terms of your solution
here.  For clarity:

The problem: we want to prepend and append to a scatterlist.  We can't
        append, because the chained scatterlist implementation requires
        an element to be appended to join two scatterlists together.

The solution: fix scatterlists by introducing struct sg_ring:
        struct sg_ring {
                struct list_head ring;
        	unsigned int nents;
        	unsigned int orig_nents; /* do we want to replace sg_table? */
                struct scatterlist *sg;
        };

The workaround: make virtio accept multiple scatterlists for a single
        buffer.

There's nothing wrong with your workaround, but if other subsystems have
the same problem we do, perhaps we should consider a broader solution?

Cheers,
Rusty.
