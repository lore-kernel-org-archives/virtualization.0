From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_ring: Update weak barriers to use dma_wmb/rmb
Date: Fri, 10 Apr 2015 12:47:01 +0930
Message-ID: <871tjs1xle.fsf__17516.0831925043$1428712319$gmane$org@rustcorp.com.au>
References: <20150408004742.2112.25484.stgit@ahduyck-vm-fedora22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150408004742.2112.25484.stgit@ahduyck-vm-fedora22>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.h.duyck@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Alexander Duyck <alexander.h.duyck@redhat.com> writes:
> This change makes it so that instead of using smp_wmb/rmb which varies
> depending on the kernel configuration we can can use dma_wmb/rmb which for
> most architectures should be equal to or slightly more strict than
> smp_wmb/rmb.
>
> The advantage to this is that these barriers are available to uniprocessor
> builds as well so the performance should improve under such a
> configuration.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>

This seems OK to me, since it's really as much a cleanup as anything,
but like you I do wonder if there benefit on ARM in practice.

Applied, thanks.

Cheers,
Rusty.
