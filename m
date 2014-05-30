From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] block: virtio_blk: don't hold spin lock during world
	switch
Date: Fri, 30 May 2014 15:40:02 +0930
Message-ID: <877g537q6d.fsf@rustcorp.com.au>
References: <1401418169-3361-1-git-send-email-ming.lei@canonical.com>
	<5387F8B2.1070509@kernel.dk>
	<CACVXFVPoG6_fL_MTRF+616W7UdHpSgjtMLBLeBn4OGR63haw3w@mail.gmail.com>
	<5387FC96.4030508@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5387FC96.4030508@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>
Cc: virtualization@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Jens Axboe <axboe@kernel.dk> writes:
> If Rusty agrees, I'd like to add it for 3.16 with a stable marker.

Really stable?  It improves performance, which is nice.  But every patch
which goes into the kernel fixes a bug, improves clarity, improves
performance or adds a feature.  I've now seen all four cases get CC'd
into stable.

Including some of mine explicitly not marked stable which get swept up
by enthusiastic stable maintainers :(

Is now there *any* patch short of a major rewrite which shouldn't get
cc: stable?

Cheers,
Rusty.
