From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio-net: add missing virtqueue kick when
	flushing packets
Date: Fri, 13 Apr 2018 11:27:12 -0400 (EDT)
Message-ID: <20180413.112712.74483562688980325.davem__10003.7083066583$1523633144$gmane$org@davemloft.net>
References: <1523602705-5155-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1523602705-5155-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: daniel@iogearbox.net, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, ktaka@nii.ac.jp
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Apr 2018 14:58:25 +0800

> We tends to batch submitting packets during XDP_TX. This requires to
> kick virtqueue after a batch, we tried to do it through
> xdp_do_flush_map() which only makes sense for devmap not XDP_TX. So
> explicitly kick the virtqueue in this case.
> 
> Reported-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
> Tested-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
