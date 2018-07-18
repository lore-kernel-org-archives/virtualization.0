From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V2 0/8] Packed virtqueue support for vhost
Date: Wed, 18 Jul 2018 13:09:52 +0900 (KST)
Message-ID: <20180718.130952.1583275621144007884.davem@davemloft.net>
References: <20180716113720-mutt-send-email-mst@kernel.org>
	<33f4643f-f226-0389-1f4f-607c289db94e@redhat.com>
	<20180716154102-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180716154102-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 16 Jul 2018 15:49:04 +0300

> I'm not sure I understand this approach. Packed ring is just an
> optimization.  What value is there in merging it if it does not help
> speed?

So it seems that both Tiwei's and Jason's packed patch sets are kind
of in limbo due to this discussion.

If I understand Jason correctly, he's trying to say that although this
work doesn't show improvements by itself, however it paves the way
such that optimizaations done in the future will be more visible.

I kind of can see Michael's viewpoint too, in that we should put this
stuff in later when it does actually show some difference.

Therefore, I'll mark both patch sets as "deferred" for now.

Let me know if I should do something else.

Thanks!
