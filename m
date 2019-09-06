From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Fri, 06 Sep 2019 15:15:05 +0200 (CEST)
Message-ID: <20190906.151505.1486178691190611604.davem__11662.615490944$1567775722$gmane$org@davemloft.net>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905135907.GB6011@mellanox.com>
	<7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Sep 2019 18:02:35 +0800

> On 2019/9/5 下午9:59, Jason Gunthorpe wrote:
>> I think you should apply the revert this cycle and rebase the other
>> patch for next..
>>
>> Jason
> 
> Yes, the plan is to revert in this release cycle.

Then you should reset patch #1 all by itself targetting 'net'.
