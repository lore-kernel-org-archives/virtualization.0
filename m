From: Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net-next V2] tun: introduce tx skb ring
Date: Wed, 15 Jun 2016 07:55:27 -0400
Message-ID: <5761422F.3010303__797.371418639337$1466419401$gmane$org@mojatatu.com>
References: <1465979897-4445-1-git-send-email-jasowang@redhat.com>
	<5761418F.2050407@mojatatu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5761418F.2050407@mojatatu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
Cc: eric.dumazet@gmail.com, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 16-06-15 07:52 AM, Jamal Hadi Salim wrote:
> On 16-06-15 04:38 AM, Jason Wang wrote:
>> We used to queue tx packets in sk_receive_queue, this is less
>> efficient since it requires spinlocks to synchronize between producer

> 
> So this is more exercising the skb array improvements. For tun
> it would be useful to see general performance numbers on user/kernel
> crossing (i.e tun read/write).
> If you have the cycles can you run such tests?
> 

Ignore my message - you are running pktgen from a VM towards the host.
So the numbers you posted are what i was interested in.
Thanks for the good work.

cheers,
jamal
