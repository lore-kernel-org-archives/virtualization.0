From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Avoid race condition with uninitialized requests
Date: Mon, 22 Sep 2014 08:17:25 -0600
Message-ID: <54202F75.8080401@kernel.dk>
References: <1411031071-40390-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1411031071-40390-2-git-send-email-dahi@linux.vnet.ibm.com>
	<54202EF8.4080909@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54202EF8.4080909@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, tom.leiming@gmail.com
Cc: kvm@vger.kernel.org, mst@redhat.com, ppinatti@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2014-09-22 08:15, Christian Borntraeger wrote:
> On 09/18/2014 11:04 AM, David Hildenbrand wrote:
>> This patch should fix the bug reported in https://lkml.org/lkml/2014/9/11/249.
>>
>> We have to initialize at least the atomic_flags and the cmd_flags when
>> allocating storage for the requests.
>>
>> Otherwise blk_mq_timeout_check() might dereference uninitialized pointers when
>> racing with the creation of a request.
>>
>> Also move the reset of cmd_flags for the initializing code to the point where a
>> request is freed. So we will never end up with pending flush request indicators
>> that might trigger dereferences of invalid pointers in blk_mq_timeout_check().
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
> Can you please add
> Reported-by: Paulo De Rezende Pinatti <ppinatti@linux.vnet.ibm.com>
> Tested-by: Paulo De Rezende Pinatti <ppinatti@linux.vnet.ibm.com>
>
> as Paulo did the testing work?
>
> We thing this patch is fine and should go upstream.

I might have to pick'n rebase the series, in which case I'll add it. But 
I already queued it up last week, so if I don't, then I can't easily add 
it. I wish the git notes wasn't such a horrible and unusable hack, so we 
had a chance to annotate commits without having to rewrite history...

-- 
Jens Axboe
