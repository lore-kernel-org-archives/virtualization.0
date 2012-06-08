From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio_blk: unlock vblk->lock during kick
Date: Fri, 8 Jun 2012 16:51:58 +0300
Message-ID: <20120608135158.GA3925@redhat.com>
References: <1338541986-8083-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<20120604111134.GA28673@redhat.com>
	<CAJSP0QWkXeCQKOEMoV6XkNpwbnQczq9Smx85=Tg-73A9fmSyVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJSP0QWkXeCQKOEMoV6XkNpwbnQczq9Smx85=Tg-73A9fmSyVQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: khoa@us.ibm.com, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 06, 2012 at 04:25:55PM +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 4, 2012 at 12:11 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > On Fri, Jun 01, 2012 at 10:13:06AM +0100, Stefan Hajnoczi wrote:
> >> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >> index 774c31d..d674977 100644
> >> --- a/drivers/block/virtio_blk.c
> >> +++ b/drivers/block/virtio_blk.c
> >> @@ -199,8 +199,14 @@ static void do_virtblk_request(struct request_que=
ue *q)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 issued++;
> >> =A0 =A0 =A0 }
> >>
> >> - =A0 =A0 if (issued)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vblk->vq);
> >> + =A0 =A0 if (!issued)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 if (virtqueue_kick_prepare(vblk->vq)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(vblk->disk->queue->queue_loc=
k);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_notify(vblk->vq);
> >
> > If blk_done runs and completes the request at this point,
> > can hot unplug then remove the queue?
> > If yes will we get a use after free?
> =

> This is a difficult question, I haven't been able to decide one way or
> another.  The use-after-free is the
> spin_lock_irq(vblk->disk->queue->queue_lock).
> =

> It still doesn't explain why existing drivers are doing this.  In nbd,
> for example, I can't see anything preventing the same situation in
> drivers/block/nbd.c:do_nbd_request() between wake_up() and
> spin_lock_irq(q->queue_lock).  If the request completes (like in your
> example scenario) then the module remove code path has no way of
> knowing there is still a thread in do_nbd_request().
> =

> Any ideas?
> =

> Stefan

Try posting to a storage-related mailing list and/or lkml.

-- =

MST
