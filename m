From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Fri, 2 Mar 2018 17:07:58 +0100
Message-ID: <20180302170758.332600d6__19416.5150671781$1520006797$gmane$org@redhat.com>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
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

On Fri,  2 Mar 2018 17:29:14 +0800
Jason Wang <jasowang@redhat.com> wrote:

> XDP_REDIRECT support for mergeable buffer was removed since commit
> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
> case"). This is because we don't reserve enough tailroom for struct
> skb_shared_info which breaks XDP assumption. So this patch fixes this
> by reserving enough tailroom and using fixed size of rx buffer.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - do not add duplicated tracepoint when redirection fails

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I gave it a quick spin on my testlab, and cpumap seems to
work/not-crash now (if I managed to turn back config to
receive_mergeable() correctly ;-)).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
