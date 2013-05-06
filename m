From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio performance analysis
Date: Mon, 6 May 2013 13:19:36 +0300
Message-ID: <20130506101936.GA16906@redhat.com>
References: <CAAtA1-aB_EQruG8ta=xjt8LO-522_5=YbKCL_33exXG2n5vutw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAtA1-aB_EQruG8ta=xjt8LO-522_5=YbKCL_33exXG2n5vutw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: nitesh narayan lal <niteshnarayanlalleo@gmail.com>, agraf@suse.de
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 02, 2013 at 09:13:29AM +0530, nitesh narayan lal wrote:
> Hi,
> I am currently working on the virtio performance analysis in PowerPC .

That's nice.

> I was looking at the virtio front-end code and had done tracing by
> adding WARN_ON condition in skb_recv_done(),xmit_skb_done(
> ) and virtqueue_kick().

That's a bit heavy-handed. Why not just use ftrace?

> What I had seen is virtqueue_kick() internally it calls iowrite16()
> which will cause an exit to QEMU,

You probably should be looking at vhost-net and not
userspace virtio-net if you are interested in performance.

> now either I send a packets from
> Guest or receive a packets to guest sart_xmit() will be called and
> inside start_xmit there is a call to virtqueue_kick() causing Guest
> exit. Also for every packet or ack sent from Guest there is an
> exception received while sending or receiving the next packet/ack.

Not exactly, we can buffer many events in
case guest and host are running in parallel.
See vring_need_event and its uses.

> Due to all of the above factors mentioned their will be an increase in
> signal, EXTINT and guest exits

Increase as compared to what?

>  and hence it will effect the CPU
> performance.
> This is what my analysis is so far, it would be great if I could get
> some help on this such that whether it seems appropriate or not ?
> Regards
> Nitesh Narayan Lal
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
