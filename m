From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] vhost: only return early if ret indicates an error
	or no iovecs have been processed
Date: Tue, 19 Feb 2019 16:40:45 +0000
Message-ID: <4145121c-83b8-e4a4-6c95-ee0151ac70c0__46191.183295899$1550594491$gmane$org@canonical.com>
References: <20190219135713.10426-1-colin.king@canonical.com>
	<20190219113510-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190219113510-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 19/02/2019 16:35, Michael S. Tsirkin wrote:
> On Tue, Feb 19, 2019 at 01:57:13PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the loop that calls log_write_hva on each iovec is never
>> executed because of an incorrect error check on the return from the
>> call to translate_desc.  The check should be checking for a -ve error
>> return and because it makes no sense to iterate over zero items, the
>> checks should also check for zero too.
>>
>> Detected by CoverityScan, CID#1476969 ("Logically dead code")
>>
>> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Jason posted a similar patch recently.
> 
> Are you happy with that one?

Sure, ignore mine, I was late to the party.

> 
>> ---
>>  drivers/vhost/vhost.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 24a129fcdd61..a9a1709a859a 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1788,7 +1788,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
>>  
>>  	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
>>  			     len, iov, 64, VHOST_ACCESS_WO);
>> -	if (ret)
>> +	if (ret <= 0)
>>  		return ret;
>>  
>>  	for (i = 0; i < ret; i++) {
>> -- 
>> 2.20.1
