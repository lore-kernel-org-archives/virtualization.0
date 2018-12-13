From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
	vmap()
Date: Thu, 13 Dec 2018 15:12:29 -0500
Message-ID: <20181213144116-mutt-send-email-mst__20234.3795718209$1544731867$gmane$org@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181213101022.12475-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
> Hi:
> 
> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling.
> 
> Test shows about 24% improvement on TX PPS. It should benefit other
> cases as well.
> 
> Please review

I think the idea of speeding up userspace access is a good one.
However I think that moving all checks to start is way too aggressive.
Instead, let's batch things up but let's not keep them
around forever.
Here are some ideas:


1. Disable preemption, process a small number of small packets
   directly in an atomic context. This should cut latency
   down significantly, the tricky part is to only do it
   on a light load and disable this
   for the streaming case otherwise it's unfair.
   This might fail, if it does just bounce things out to
   a thread.

2. Switch to unsafe_put_user/unsafe_get_user,
   and batch up multiple accesses.

3. Allow adding a fixup point manually,
   such that multiple independent get_user accesses
   can get a single fixup (will allow better compiler
   optimizations).





> Jason Wang (3):
>   vhost: generalize adding used elem
>   vhost: fine grain userspace memory accessors
>   vhost: access vq metadata through kernel virtual address
> 
>  drivers/vhost/vhost.c | 281 ++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  11 ++
>  2 files changed, 266 insertions(+), 26 deletions(-)
> 
> -- 
> 2.17.1
