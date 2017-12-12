From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH] ptr_ring: add barriers
Date: Tue, 12 Dec 2017 11:58:52 +0530
Message-ID: <93ed1559-74d4-d72f-0969-12bfaf370cc1__29011.2672410489$1513195162$gmane$org@caviumnetworks.com>
References: <1512501990-30029-1-git-send-email-mst@redhat.com>
	<20171211.105308.1899676147655539775.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171211.105308.1899676147655539775.davem@davemloft.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>, mst@redhat.com
Cc: george.cherian@cavium.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

Hi David,

On 12/11/2017 09:23 PM, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Tue, 5 Dec 2017 21:29:37 +0200
> 
>> Users of ptr_ring expect that it's safe to give the
>> data structure a pointer and have it be available
>> to consumers, but that actually requires an smb_wmb
>> or a stronger barrier.
>>
>> In absence of such barriers and on architectures that reorder writes,
>> consumer might read an un=initialized value from an skb pointer stored
>> in the skb array.  This was observed causing crashes.
>>
>> To fix, add memory barriers.  The barrier we use is a wmb, the
>> assumption being that producers do not need to read the value so we do
>> not need to order these reads.
>>
>> Reported-by: George Cherian <george.cherian@cavium.com>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I'm asked for asking for testing feedback and did not get it in a
> reasonable amount of time.
> 
The tests have completed more than 48 hours without any failures.
I won't interrupt the same and run for longer time.
In case of any issue I will report the same.
> So I'm applying this as-is, and queueing it up for -stable.
> 
> Thank you.

Regards,
-George
> 
