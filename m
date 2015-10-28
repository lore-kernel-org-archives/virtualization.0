From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 00:09:54 -0700
Message-ID: <CALCETrVGggDO94DdAMUsA0KyJnvqLXT4mWcc18VRBft+DsUN4g__49439.0761982233$1446016237$gmane$org@mail.gmail.com>
References: <cover.1446014204.git.luto@kernel.org>
	<1446015204.3405.186.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1446015204.3405.186.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 27, 2015 at 11:53 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2015-10-27 at 23:38 -0700, Andy Lutomirski wrote:
>>
>> Changes from v2:
>>  - Fix really embarrassing bug.  This version actually works.
>
> So embarrassing you didn't want to tell us what it was? ...

Shhh, it's a secret!

I somehow managed to test-boot a different kernel than I thought I was booting.

>
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -292,7 +292,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
>
> -               if (vring_mapping_error(vq, vq->vring.desc[head].addr))
> +               if (vring_mapping_error(vq, addr))
>                         goto unmap_release;
>
>                 vq->vring.desc[head].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
>
> That wasn't going to be the reason for Christian's failure, was it?
>

Not obviously, but it's possible.  Now that I'm staring at it, I have
some more big-endian issues, so there'll be a v4.  I'll also play with
Michael's thing.  Expect a long delay, though -- my flight's about to
leave.

The readme notwithstanding, virtme (https://github.com/amluto/virtme)
actually has s390x support, so I can try to debug when I get home.
I'm not about to try doing this on a laptop :)

--Andy
