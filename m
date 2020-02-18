From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/2] virtio-blk: fix hw_queue stopped on arbitrary error
Date: Tue, 18 Feb 2020 10:21:18 +0800
Message-ID: <CACVXFVNiADTW_vLVc1bUSa0CoViLbVzoMnSJW4=sx=MCE-xUPw@mail.gmail.com>
References: <20200213123728.61216-1-pasic@linux.ibm.com> <20200213123728.61216-2-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200213123728.61216-2-pasic@linux.ibm.com>
Sender: linux-block-owner@vger.kernel.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 8:38 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> Since nobody else is going to restart our hw_queue for us, the
> blk_mq_start_stopped_hw_queues() is in virtblk_done() is not sufficient
> necessarily sufficient to ensure that the queue will get started again.
> In case of global resource outage (-ENOMEM because mapping failure,
> because of swiotlb full) our virtqueue may be empty and we can get
> stuck with a stopped hw_queue.
>
> Let us not stop the queue on arbitrary errors, but only on -EONSPC which
> indicates a full virtqueue, where the hw_queue is guaranteed to get
> started by virtblk_done() before when it makes sense to carry on
> submitting requests. Let us also remove a stale comment.

The generic solution may be to stop queue only when there is any
in-flight request
not completed.

Checking -ENOMEM may not be enough, given -EIO can be returned from
virtqueue_add()
too in case of dma map failure.

Thanks,
