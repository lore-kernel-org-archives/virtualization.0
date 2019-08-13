From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Date: Tue, 13 Aug 2019 08:57:07 -0300
Message-ID: <20190813115707.GC29508__41446.5270748892$1565697444$gmane$org@ziepe.ca>
References: <20190809054851.20118-1-jasowang@redhat.com>
	<20190810134948-mutt-send-email-mst@kernel.org>
	<360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
	<20190812054429-mutt-send-email-mst@kernel.org>
	<20190812130252.GE24457@ziepe.ca>
	<9a9641fe-b48f-f32a-eecc-af9c2f4fbe0e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9a9641fe-b48f-f32a-eecc-af9c2f4fbe0e@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 13, 2019 at 04:31:07PM +0800, Jason Wang wrote:

> What kind of issues do you see? Spinlock is to synchronize GUP with MMU
> notifier in this series.

A GUP that can't sleep can't pagefault which makes it a really weird
pattern

> Btw, back to the original question. May I know why synchronize_rcu() is not
> suitable? Consider:

We already went over this. You'd need to determine it doesn't somehow
deadlock the mm on reclaim paths. Maybe it is OK, the rcq_gq_wq is
marked WQ_MEM_RECLAIM at least..

I also think Michael was concerned about the latency spikes a long RCU
delay would cause.

Jason
