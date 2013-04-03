From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2 V3] virtio-spec: dynamic network offloads configuration
Date: Wed, 03 Apr 2013 11:50:19 +1030
Message-ID: <87ehes5s18.fsf@rustcorp.com.au>
References: <1364902740-24948-1-git-send-email-dmitry@daynix.com>
	<1364902740-24948-2-git-send-email-dmitry@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364902740-24948-2-git-send-email-dmitry@daynix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Fleytman <dmitry@daynix.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Ronen Hod <rhod@redhat.com>, Dmitry Fleytman <dfleytma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Dmitry Fleytman <dmitry@daynix.com> writes:
> From: Dmitry Fleytman <dfleytma@redhat.com>
>
> Virtio-net driver currently negotiates network offloads
> on startup via features mechanism and have no ability to
> change offloads state later.
> This patch introduced a new control command that allows
> to configure device network offloads state dynamically.
> The patch also introduces a new feature flag
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
>
> Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>

(BTW, I like to be CC'd on these things directly, so I don't miss them)

The idea is fine.

But I dislike the duplication of constants: let's just use the feature
bits directly:

#define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
#define VIRTIO_NET_F_GUEST_TSO4	7	/* Guest can handle TSOv4 in. */
#define VIRTIO_NET_F_GUEST_TSO6	8	/* Guest can handle TSOv6 in. */
#define VIRTIO_NET_F_GUEST_ECN	9	/* Guest can handle TSO[6] w/ ECN in. */
#define VIRTIO_NET_F_GUEST_UFO	10	/* Guest can handle UFO in. */

You want this, because you have to test against them anyway before
trying to re-enable them.

And secondly, it'll be much clearer if you don't say "change" but
"disable and re-enable", which is what's actually allowed.

Thanks,
Rusty.
