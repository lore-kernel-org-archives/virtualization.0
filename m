From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5 of 5] virtio: expose added descriptors immediately
Date: Mon, 14 Nov 2011 11:13:57 +1030
Message-ID: <87lirjpm7m.fsf@rustcorp.com.au>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<f3831c1617c86a51d875.1320306173@localhost6.localdomain6>
	<20111113210256.GA31621@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111113210256.GA31621@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Christoph Hellwig <hch@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 13 Nov 2011 23:03:14 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Nov 03, 2011 at 06:12:53PM +1030, Rusty Russell wrote:
> > A virtio driver does virtqueue_add_buf() multiple times before finally
> > calling virtqueue_kick(); previously we only exposed the added buffers
> > in the virtqueue_kick() call.  This means we don't need a memory
> > barrier in virtqueue_add_buf(), but it reduces concurrency as the
> > device (ie. host) can't see the buffers until the kick.
> > 
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> In the past I played with a patch like this, but I didn't see a
> performance gain either way. Do you see any gain?

No, but I haven't run it on real hardware.  lguest may see a win with
this in theory, since the virtqueue processing is fully async, so I'll
run some tests.

> I'm a bit concerned that with this patch, a buggy driver that
> adds more than 2^16 descriptors without a kick
> would seem to work sometimes. Let's add WARN_ON(vq->num_added > (1 << 16))?

Hmm, I guess it could wait for the add to fail before doing a kick, but
noone does that at the moment, so I've added a slight variant:

	WARN_ON(vq->num_added > vq->vring.num);

Thanks,
Rusty.
