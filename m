From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: include asm/barrier explicitly
Date: Mon, 08 Jul 2013 11:31:45 +0930
Message-ID: <87obaderna.fsf@rustcorp.com.au>
References: <20130707142019.GA2447@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130707142019.GA2447@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> virtio_ring.h uses mb() and friends, make
> it pull in asm/barrier.h itself, not rely
> on other headers to do it.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied.

Thanks,
Rusty.
PS.  I'll squeeze these into this merge window, since they're trivial.
