From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for
	mergeable buffer
Date: Thu, 1 Mar 2018 10:10:38 +0100
Message-ID: <20180301101038.4253424d@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  1 Mar 2018 11:19:03 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This series tries to re-enable XDP_REDIRECT for mergeable buffer which
> was removed since commit 7324f5399b06 ("virtio_net: disable
> XDP_REDIRECT in receive_mergeable() case"). Main concerns are:
> 
> - not enough tailroom was reserved which breaks cpumap

To address this at a more fundamental level, I would suggest that we/you
instead extend XDP to know it's buffers "frame" size/end.  (The
assumption use to be, xdp_buff->data_hard_start + PAGE_SIZE, but
ixgbe+virtio_net broke that assumption).

It should actually be fairly easy to implement:
 * Simply extend xdp_buff with a "data_hard_end" pointer.

Now cpumap is more safe... instead of crashing, it can now know/see when
it is safe to create an SKB using build_skb (could fallback to
dev_alloc_skb).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
