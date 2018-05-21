From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 0/4] Fix several issues of virtio-net mergeable XDP
Date: Mon, 21 May 2018 18:04:32 +0300
Message-ID: <20180521180405-mutt-send-email-mst__7568.87211832709$1526914984$gmane$org@kernel.org>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 21, 2018 at 04:35:02PM +0800, Jason Wang wrote:
> Hi:
> 
> Please review the patches that tries to fix sevreal issues of
> virtio-net mergeable XDP.
> 
> Thanks

I think we should do 3/4 differently.
The rest looks good, and probably needed on stable.

Thanks!

> Jason Wang (4):
>   virtio-net: correctly redirect linearized packet
>   virtio-net: correctly transmit XDP buff after linearizing
>   virtio-net: reset num_buf to 1 after linearizing packet
>   virito-net: fix leaking page for gso packet during mergeable XDP
> 
>  drivers/net/virtio_net.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
