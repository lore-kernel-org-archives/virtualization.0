From: nitesh narayan lal <niteshnarayanlalleo@gmail.com>
Subject: virtio performance analysis
Date: Thu, 2 May 2013 09:13:29 +0530
Message-ID: <CAAtA1-aB_EQruG8ta=xjt8LO-522_5=YbKCL_33exXG2n5vutw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,
I am currently working on the virtio performance analysis in PowerPC .
I was looking at the virtio front-end code and had done tracing by
adding WARN_ON condition in skb_recv_done(),xmit_skb_done(
) and virtqueue_kick().
What I had seen is virtqueue_kick() internally it calls iowrite16()
which will cause an exit to QEMU, now either I send a packets from
Guest or receive a packets to guest sart_xmit() will be called and
inside start_xmit there is a call to virtqueue_kick() causing Guest
exit. Also for every packet or ack sent from Guest there is an
exception received while sending or receiving the next packet/ack.
Due to all of the above factors mentioned their will be an increase in
signal, EXTINT and guest exits  and hence it will effect the CPU
performance.
This is what my analysis is so far, it would be great if I could get
some help on this such that whether it seems appropriate or not ?
Regards
Nitesh Narayan Lal
