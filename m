From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Date: Fri, 22 Nov 2019 14:08:27 +0100
Message-ID: <20191122140827.0ead345c.pasic@linux.ibm.com>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191119080420-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Thanks Michael!

Actually I also hoped to start a discussion on virtio with encrypted
memory.

I assume the AMD folks have the most experience with this, and I very
much like to understand how do they master the challenges we are all
facing.

My understanding of IO in the context of AMD SEV is that the user
is responsible for choosing the swiotlb command line parameter of the
guest kernel so, that the guest never runs out of swiotlb. And that
not doing so may have fatal consequences with regards to the guest. [1]

The swiotlb being a guest global resource, to choose such a size, one
would fist need to know the maximal swiotlb footprint of each device,
and then apply some heuristics regarding fragmentation.

Honestly, if somebody asked me how to calculate the max swiotlb
footprint of the most common virtio devices, I would feel very
uncomfortable.

But maybe I got it all wrong. @Tom can you help me understand how this
works?

In any case, we s390 protected virtualization folks are concerned about
the things laid out above. The goal of this patch is to make the swiotlb
full condition less grave, but it is by no means a full solution.

I would like to work on improving on this situation. Obviously we have
done some thinking about what can be done, but I would very much like to
collect the opinions, of the people in the community that AFAICT face
same problem. One of the ideas is to try to prevent it from happening by
making swiotlb sizing dynamic. Another idea is to make the system deal
with the failures gracefully. Both ideas come with a bag of problems of
their own (AFAICT).

According to my research the people I need to talk to are Tom (AMD), and
Ram and Thiago (Power) and of course the respective maintainers. Have I
missed anybody?

Regards,
Halil

--

[1] https://github.com/AMDESE/AMDSEV#faq-4

On Tue, 19 Nov 2019 08:04:29 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Will be in the next pull request.
> 
> On Tue, Nov 19, 2019 at 12:10:22PM +0100, Halil Pasic wrote:
> > ping
> > 
> > On Thu, 14 Nov 2019 13:46:46 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> > > Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
> > > virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
> > > a very realistic scenario for guests with encrypted memory, as swiotlb
> > > may run out of space, depending on it's size and the I/O load.
> > > 
> > > The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
> > > error, despite the fact that swiotlb full is in absence of bugs a
> > > recoverable condition.
> > > 
> > > Let us change the return code to -ENOMEM, and make the block layer
> > > recover form these failures when virtio-blk encounters the condition
> > > described above.
> > > 
> > > Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > > ---
> > > 
[..]
