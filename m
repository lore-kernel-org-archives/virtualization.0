From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Mon, 9 Sep 2019 15:18:01 +0800
Message-ID: <bb9ae371-58b7-b7fc-b728-b5c5f55d3a91__44471.623333969$1568013525$gmane$org@redhat.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905135907.GB6011@mellanox.com>
	<7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
	<20190906.151505.1486178691190611604.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190906.151505.1486178691190611604.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2019/9/6 下午9:15, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri, 6 Sep 2019 18:02:35 +0800
>
>> On 2019/9/5 下午9:59, Jason Gunthorpe wrote:
>>> I think you should apply the revert this cycle and rebase the other
>>> patch for next..
>>>
>>> Jason
>> Yes, the plan is to revert in this release cycle.
> Then you should reset patch #1 all by itself targetting 'net'.


Thanks for the reminding. I want the patch to go through Michael's vhost  
tree, that's why I don't put 'net' prefix. For next time, maybe I can  
use "vhost" as a prefix for classification?
