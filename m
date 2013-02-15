From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: Define virtio-mmio registers as LE
Date: Fri, 15 Feb 2013 14:27:47 +1030
Message-ID: <87ehgijkjo.fsf@rustcorp.com.au>
References: <87wqubkalj.fsf@rustcorp.com.au>
	<1360839247-9131-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1360839247-9131-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:
> To solve the never-ending confusions between hosts and guests
> of different endianess, define all virtio-mmio registers as LE.
>
> This change should be safe at this stage, because no known
> working mixed-endian system exists so there is virtually no
> risk of breaking compatibility.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Applied.  We could also move device configuration space to LE, if we
wanted.  It's a bigger change to the Linux implementation, since we now
need accessors for each width, but it might be a good idea.  OTOH,
getting such a change into qemu might be harder...

Cheers,
Rusty.
