From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 0/2] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 10 Apr 2018 10:50:43 -0400 (EDT)
Message-ID: <20180410.105043.1798364865868187298.davem__26917.4061403193$1523371730$gmane$org@davemloft.net>
References: <20180410052630.11270-1-stefanha@redhat.com>
	<8642c057-e49d-d95d-19e5-6d304f20064e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8642c057-e49d-d95d-19e5-6d304f20064e@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Apr 2018 14:40:10 +0800

> On 2018年04月10日 13:26, Stefan Hajnoczi wrote:
>> v2:
>>   * Rewrote the conditional to make the vq access check clearer [Linus]
>>   * Added Patch 2 to make the return type consistent and harder to misuse
>>   * [Linus]
>>
>> The first patch fixes the vhost virtqueue access check which was
>> recently
>> broken.  The second patch replaces the int return type with bool to
>> prevent
>> future bugs.
>>
>> Stefan Hajnoczi (2):
>>    vhost: fix vhost_vq_access_ok() log check
>>    vhost: return bool from *_access_ok() functions
>>
>>   drivers/vhost/vhost.h |  4 +--
>>   drivers/vhost/vhost.c | 70
>>   ++++++++++++++++++++++++++-------------------------
>>   2 files changed, 38 insertions(+), 36 deletions(-)
>>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

This sereis doesn't apply cleanly to the net tree, please respin
and add the appropriate Acks and Fixes: tags that Michael and Jason
have provided.

Thank you.
