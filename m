From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 2/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Tue, 22 Jan 2013 09:33:07 +0800
Message-ID: <50FDEC53.2060506@redhat.com>
References: <1358755528-31421-1-git-send-email-asias@redhat.com>
	<1358755528-31421-3-git-send-email-asias@redhat.com>
	<20130121185713.GA28429@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130121185713.GA28429@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/22/2013 02:57 AM, Marcelo Tosatti wrote:
> On Mon, Jan 21, 2013 at 04:05:27PM +0800, Asias He wrote:
>> We can get all the pages in one time instead of calling
>> gup N times.
>>
>> Signed-off-by: Asias He <asias@redhat.com>
>> ---
>>  drivers/vhost/tcm_vhost.c | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
>> index ca35c16..59be442 100644
>> --- a/drivers/vhost/tcm_vhost.c
>> +++ b/drivers/vhost/tcm_vhost.c
>> @@ -430,37 +430,45 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
>>   * Returns the number of scatterlist entries used or -errno on error.
>>   */
>>  static int vhost_scsi_map_to_sgl(struct scatterlist *sgl,
>> -	unsigned int sgl_count, void __user *ptr, size_t len, int write)
>> +	unsigned int sgl_count, struct iovec *iov, int write)
>>  {
>>  	struct scatterlist *sg = sgl;
>>  	unsigned int npages = 0;
>> +	void __user *ptr = iov->iov_base;
>> +	size_t len = iov->iov_len;
>>  	int ret;
>> +	unsigned int pages_nr, offset, nbytes;
>> +	struct page **pages;
>> +
>> +	pages_nr = iov_num_pages(iov);
>> +	pages = kmalloc(pages_nr * sizeof(struct page *), GFP_ATOMIC);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	ret = get_user_pages_fast((unsigned long)ptr, pages_nr, write, pages);
>> +	if (ret != pages_nr)
>> +		goto err;
> 
> 1. Why GFP_ATOMIC? get_user_pages_fast can sleep, so this path must not
> be atomic (if it is, should use __get_user_pages_fast).
> 
> GFP_ATOMIC should be avoided.
> 
> 2. Should drop reference to pages whose refcount has been increased,
> if ret > 0 && ret != pages_nr (see last phrase of get_user_pages_fast
> commentary).

Thanks Marcelo. V2 is on the way.

-- 
Asias
