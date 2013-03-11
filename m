From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Opposite return values in vringh_notify_enable_kern() and
	virtqueue_enable_cb().
Date: Mon, 11 Mar 2013 09:55:58 +0100
Message-ID: <CAJK669Zkn0HL0AQVO3=C=ChsFHy5xD0hDNKPSrKOFLivu3AODA@mail.gmail.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Erwan YVIN <Erwan.Yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

The two similar functions in vringh and virtqueue for turning on
interrupts has opposite return values if there are buffers available
in the ring. I think it would be better if these two functions aligned
the use of return values. Maybe it's just me, but I got the logic
for re-scheduling NAPI wrong due to this.

/**
 * vringh_notify_enable_kern - we want to know if something changes.
 * @vrh: the vring.
 *
 * This always enables notifications, but returns true if there are
 * now more buffers available in the vring.
 */
bool vringh_notify_enable_kern(struct vringh *vrh)

/**
 * virtqueue_enable_cb - restart callbacks after disable_cb.
 * @vq: the struct virtqueue we're talking about.
 *
 * This re-enables callbacks; it returns "false" if there are pending
 * buffers in the queue, ....
 */
bool virtqueue_enable_cb(struct virtqueue *_vq)

Regards.
Sjur
