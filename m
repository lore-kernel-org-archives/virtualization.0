From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2] virtio_blk: unlock vblk->lock during kick
Date: Fri, 1 Jun 2012 08:58:05 +0100
Message-ID: <CAJSP0QWw1N_93OHehGK3MqVP-DPVUwbOsf2nJmgJosvY-9wDyA@mail.gmail.com>
References: <1338383963-17910-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<4FC84734.3070808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FC84734.3070808@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: khoa@us.ibm.com, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 1, 2012 at 5:38 AM, Asias He <asias@redhat.com> wrote:
> On 05/30/2012 09:19 PM, Stefan Hajnoczi wrote:
> Could you use vblk->disk->queue->queue_lock to reference the lock so that
> this patch will work on top of this one:
>
> =A0 virtio-blk: Use block layer provided spinlock

Absolutely.  I'll rebased on top of your patches and resend.

> BTW. Why the function name is changed to virtqueue_notify() from
> virtqueue_kick_notify()? Seems Rusty renamed it. I think the latter name =
is
> better because it is more consistent and easier to remember.
>
> =A0 virtqueue_kick()
> =A0 virtqueue_kick_prepare()
> =A0 virtqueue_kick_notify()
>
> I believe you used virtqueue_kick_notify() in your original patch.
> See:
> =A0 http://www.spinics.net/lists/linux-virtualization/msg14616.html

You are right, it was renamed upstream.  I liked to old name better
too but am happy to use what's there now.

Stefan
