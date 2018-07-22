From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/9] TX used ring batched updating for vhost
Date: Sun, 22 Jul 2018 09:44:12 -0700 (PDT)
Message-ID: <20180722.094412.532906090262121741.davem__16931.8085573197$1532277733$gmane$org@davemloft.net>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
	<20180722173622-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180722173622-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 22 Jul 2018 17:37:05 +0300

> On Fri, Jul 20, 2018 at 08:15:12AM +0800, Jason Wang wrote:
>> Hi:
>> 
>> This series implement batch updating of used ring for TX. This help to
>> reduce the cache contention on used ring. The idea is first split
>> datacopy path from zerocopy, and do only batching for datacopy. This
>> is because zercopy had already supported its own batching.
>> 
>> TX PPS was increased 25.8% and Netperf TCP does not show obvious
>> differences.
>> 
>> The split of datapath will also be helpful for future implementation
>> like in order completion.
>> 
>> Please review.
>> 
>> Thanks
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I'm very happy with the split, the mixed data path became hard to
> maintain.

Thanks for reviewing.

Series applied, thanks everyone.
