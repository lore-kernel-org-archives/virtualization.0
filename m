From: corbet@lwn.net (Jonathan Corbet)
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Mon, 07 Apr 2008 11:54:34 -0600
Message-ID: <12555.1207590874__10527.012931607$1207714677$gmane$org@vena.lwn.net>
References: <200804052202.09157.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: Your message of "Sat, 05 Apr 2008 22:02:08 +1000."
	<200804052202.09157.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hey, Rusty,

> For virtualization, we've developed virtio_ring for efficient communication.
> This would also work well for userspace-kernel communication, particularly
> for things like the tun device.  By using the same ABI, we can join guests
> to the host kernel trivially.

I'm *sure* you meant to document that somewhat non-trivial proposed new
kernel API as soon as you got a moment.  But, since I went to the
trouble of reverse engineering it, I decided not to wait and to make a
little unreliable guide of my own.  For those who are curious about how
vringfd() is meant to work (or about how badly I misunderstood it), the
info is at:

	http://lwn.net/SubscriberLink/276856/8c927025c53ad7ce/

Hopefully it will be helpful,

jon
