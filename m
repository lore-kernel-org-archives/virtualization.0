From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Thu, 01 Dec 2011 13:12:25 +1030
Message-ID: <87wrahrp0u.fsf@rustcorp.com.au>
References: <1322559196-11139-1-git-send-email-levinsasha928@gmail.com>
	<20111129125622.GB19157@redhat.com>
	<1322573688.4395.11.camel@lappy>
	<20111129135406.GB30966@redhat.com> <1322576464.7003.6.camel@lappy>
	<20111129145451.GD30966@redhat.com>
	<4ED4F30F.8000603@redhat.com> <1322669511.3985.8.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1322669511.3985.8.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>, Avi Kivity <avi@redhat.com>
Cc: markmc@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 30 Nov 2011 18:11:51 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> On Tue, 2011-11-29 at 16:58 +0200, Avi Kivity wrote:
> > On 11/29/2011 04:54 PM, Michael S. Tsirkin wrote:
> > > > 
> > > > Which is actually strange, weren't indirect buffers introduced to make
> > > > the performance *better*? From what I see it's pretty much the
> > > > same/worse for virtio-blk.
> > >
> > > I know they were introduced to allow adding very large bufs.
> > > See 9fa29b9df32ba4db055f3977933cd0c1b8fe67cd
> > > Mark, you wrote the patch, could you tell us which workloads
> > > benefit the most from indirect bufs?
> > >
> > 
> > Indirects are really for block devices with many spindles, since there
> > the limiting factor is the number of requests in flight.  Network
> > interfaces are limited by bandwidth, it's better to increase the ring
> > size and use direct buffers there (so the ring size more or less
> > corresponds to the buffer size).
> > 
> 
> I did some testing of indirect descriptors under different workloads.

MST and I discussed getting clever with dynamic limits ages ago, but it
was down low on the TODO list.  Thanks for diving into this...

AFAICT, if the ring never fills, direct is optimal.  When the ring
fills, indirect is optimal (we're better to queue now than later).

Why not something simple, like a threshold which drops every time we
fill the ring?

struct vring_virtqueue
{
...
        int indirect_thresh;
...
}

virtqueue_add_buf_gfp()
{
...

        if (vq->indirect &&
            (vq->vring.num - vq->num_free) + out + in > vq->indirect_thresh)
                return indirect()
...

	if (vq->num_free < out + in) {
                if (vq->indirect && vq->indirect_thresh > 0)
                        vq->indirect_thresh--;
        
...
}

Too dumb?

Cheers,
Rusty.
