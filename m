From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Mon, 11 Mar 2019 11:14:13 -0700 (PDT)
Message-ID: <20190311.111413.1140896328197448401.davem__36913.1559202046$1552328064$gmane$org@davemloft.net>
References: <20190308141220.GA21082@infradead.org>
	<56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
	<20190311095405-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190311095405-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 11 Mar 2019 09:59:28 -0400

> On Mon, Mar 11, 2019 at 03:13:17PM +0800, Jason Wang wrote:
>> 
>> On 2019/3/8 下午10:12, Christoph Hellwig wrote:
>> > On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
>> > > This series tries to access virtqueue metadata through kernel virtual
>> > > address instead of copy_user() friends since they had too much
>> > > overheads like checks, spec barriers or even hardware feature
>> > > toggling. This is done through setup kernel address through vmap() and
>> > > resigter MMU notifier for invalidation.
>> > > 
>> > > Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
>> > > obvious improvement.
>> > How is this going to work for CPUs with virtually tagged caches?
>> 
>> 
>> Anything different that you worry?
> 
> If caches have virtual tags then kernel and userspace view of memory
> might not be automatically in sync if they access memory
> through different virtual addresses. You need to do things like
> flush_cache_page, probably multiple times.

"flush_dcache_page()"
