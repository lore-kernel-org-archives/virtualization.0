From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small
	buffer
Date: Thu, 1 Mar 2018 10:15:53 +0100
Message-ID: <20180301101553.55c4c6bd@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
	<1519874345-10235-3-git-send-email-jasowang@redhat.com>
	<20180301090206.04e13a71@redhat.com>
	<dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
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

On Thu, 1 Mar 2018 16:49:24 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > 2. This can easily cause out-of-order packets.  
> 
> I may miss something, but it looks to me packets were still delivered
> in order? Or you mean the packets that was dropped by cpumap?

No. Packets can now travel two code paths to the egress device. (1) XDP
native via ndp_xdp_xmit via direct delivery into a lockfree/dedicated
TX queue, (2) via normal network stack which can involve being queue in
a qdisc.  Do you see the possibility of the reorder now?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
