From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
	vmap()
Date: Thu, 13 Dec 2018 10:27:09 -0500
Message-ID: <20181213102315-mutt-send-email-mst__37423.4924711802$1544714737$gmane$org@kernel.org>
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

Userspace accesses through remapping tricks and next time there's a need
for a new barrier we are left to figure it out by ourselves.  I don't
like the idea I have to say.  As a first step, why don't we switch to
unsafe_put_user/unsafe_get_user etc?
That would be more of an apples to apples comparison, would it not?


> Test shows about 24% improvement on TX PPS. It should benefit other
> cases as well.
> 
> Please review
> 
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
