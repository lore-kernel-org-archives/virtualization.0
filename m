From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [bpf-next V2 PATCH 11/14] virtio_net: setup xdp_rxq_info
Date: Tue, 26 Dec 2017 12:20:50 +0100
Message-ID: <20171226122050.3a453cd7__48178.3897187144$1514287174$gmane$org@redhat.com>
References: <151396262289.20006.1429172971820409456.stgit@firesoul>
	<151396275093.20006.9684557344807016870.stgit@firesoul>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <151396275093.20006.9684557344807016870.stgit@firesoul>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Borkmann <borkmann@iogearbox.net>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, brouer@redhat.com, virtualization@lists.linux-foundation.org, dsahern@gmail.com, gospo@broadcom.com, bjorn.topel@intel.com, michael.chan@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 22 Dec 2017 18:12:31 +0100
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> The virtio_net driver doesn't dynamically change the RX-ring queue
> layout and backing pages, but instead reject XDP setup if all the
> conditions for XDP is not meet.  Thus, the xdp_rxq_info also remains
> fairly static.  This allow us to simply add the reg/unreg to
> net_device open/close functions.
> 
> Driver hook points for xdp_rxq_info:
>  * reg  : virtnet_open
>  * unreg: virtnet_close
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  drivers/net/virtio_net.c |   12 +++++++++++-

Found a bug while testing this... I forgot to update receive_mergeable() too.

I'll send a V3

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
