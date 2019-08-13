From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Date: Tue, 13 Aug 2019 09:41:05 -0700
Message-ID: <20190813164105.GD22640@infradead.org>
References: <20190809054851.20118-1-jasowang@redhat.com>
	<20190810134948-mutt-send-email-mst@kernel.org>
	<360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
	<20190812054429-mutt-send-email-mst@kernel.org>
	<20190812130252.GE24457@ziepe.ca>
	<9a9641fe-b48f-f32a-eecc-af9c2f4fbe0e@redhat.com>
	<20190813115707.GC29508@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190813115707.GC29508@ziepe.ca>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 13, 2019 at 08:57:07AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 13, 2019 at 04:31:07PM +0800, Jason Wang wrote:
> 
> > What kind of issues do you see? Spinlock is to synchronize GUP with MMU
> > notifier in this series.
> 
> A GUP that can't sleep can't pagefault which makes it a really weird
> pattern

get_user_pages/get_user_pages_fast must not be called under a spinlock.
We have the somewhat misnamed __get_user_page_fast that just does a
lookup for existing pages and never faults for a few places that need
to do that lookup from contexts where we can't sleep.
