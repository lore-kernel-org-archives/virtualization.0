From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Thu, 24 Jun 2010 06:30:30 +0100
Message-ID: <AANLkTim6CH_NruBFqK6fIkMkKpAuCIef50mHfldMtNH9__45855.246394831$1277357485$gmane$org@mail.gmail.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<4C2286BE.40808@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C2286BE.40808@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 23, 2010 at 11:12 PM, Anthony Liguori <anthony@codemonkey.ws> w=
rote:
> Shouldn't it be possible to just drop the lock before invoking
> virtqueue_kick() and reacquire it afterwards? =A0There's nothing in that
> virtqueue_kick() path that the lock is protecting AFAICT.

No, that would lead to a race condition because vq->num_added is
modified by both virtqueue_add_buf_gfp() and virtqueue_kick().
Without a lock held during virtqueue_kick() another vcpu could add
bufs while vq->num_added is used and cleared by virtqueue_kick():

void virtqueue_kick(struct virtqueue *_vq, spinlock_t *lock)
{
        struct vring_virtqueue *vq =3D to_vvq(_vq);
        START_USE(vq);
        /* Descriptors and available array need to be set before we expose =
the
         * new available array entries. */
        virtio_wmb();

        vq->vring.avail->idx +=3D vq->num_added;
        vq->num_added =3D 0;

        /* Need to update avail index before checking if we should notify */
        virtio_mb();

        if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY)) {
                /* Release lock while doing the kick because the guest shou=
ld
                 * not exit with the lock held. */
                if (lock)
                        spin_unlock(lock);

                /* Prod other side to tell it about changes. */
                vq->notify(&vq->vq);

                if (lock)
                        spin_lock(lock);
        }

        END_USE(vq);
}

Stefan
