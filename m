From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH net-next v6 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Mon, 23 Jul 2018 20:43:03 +0800
Message-ID: <CAMDZJNVPi8DMScyF2KW0mLAYe0p8uUVVY55Oo9Hk6SJJTMZYKg__19864.4877913923$1532349716$gmane$org@mail.gmail.com>
References: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1532196242-2998-4-git-send-email-xiangxia.m.yue@gmail.com>
	<c520c142-ef36-7918-7135-51258c17bd83@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c520c142-ef36-7918-7135-51258c17bd83@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: makita.toshiaki@lab.ntt.co.jp
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 23, 2018 at 5:58 PM Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
>
> On 2018/07/22 3:04, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > Factor out generic busy polling logic and will be
> > used for in tx path in the next patch. And with the patch,
> > qemu can set differently the busyloop_timeout for rx queue.
> >
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > ---
> ...
> > +static void vhost_net_busy_poll_vq_check(struct vhost_net *net,
> > +                                      struct vhost_virtqueue *rvq,
> > +                                      struct vhost_virtqueue *tvq,
> > +                                      bool rx)
> > +{
> > +     struct socket *sock = rvq->private_data;
> > +
> > +     if (rx) {
> > +             if (!vhost_vq_avail_empty(&net->dev, tvq)) {
> > +                     vhost_poll_queue(&tvq->poll);
> > +             } else if (unlikely(vhost_enable_notify(&net->dev, tvq))) {
> > +                     vhost_disable_notify(&net->dev, tvq);
> > +                     vhost_poll_queue(&tvq->poll);
> > +             }
> > +     } else if ((sock && sk_has_rx_data(sock->sk)) &&
> > +                 !vhost_vq_avail_empty(&net->dev, rvq)) {
> > +             vhost_poll_queue(&rvq->poll);
>
> Now we wait for vq_avail for rx as well, I think you cannot skip
> vhost_enable_notify() on tx. Probably you might want to do:
I think vhost_enable_notify is needed.

> } else if (sock && sk_has_rx_data(sock->sk)) {
>         if (!vhost_vq_avail_empty(&net->dev, rvq)) {
>                 vhost_poll_queue(&rvq->poll);
>         } else if (unlikely(vhost_enable_notify(&net->dev, rvq))) {
>                 vhost_disable_notify(&net->dev, rvq);
>                 vhost_poll_queue(&rvq->poll);
>         }
> }
As Jason review as before, we only want rx kick when packet is pending at
socket but we're out of available buffers. So we just enable notify,
but not poll it ?

        } else if ((sock && sk_has_rx_data(sock->sk)) &&
                    !vhost_vq_avail_empty(&net->dev, rvq)) {
                vhost_poll_queue(&rvq->poll);
        else {
                vhost_enable_notify(&net->dev, rvq);
        }
> Also it's better to care vhost_net_disable_vq()/vhost_net_enable_vq() on tx?
I cant find why it is better, if necessary, we can do it.
> --
> Toshiaki Makita
>
