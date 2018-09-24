From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] vhost/scsi: truncate T10 PI iov_iter to prot_bytes
Date: Mon, 24 Sep 2018 11:09:51 +0200
Message-ID: <32695e5b-96cc-e37b-b624-2c70a96aa39e@redhat.com>
References: <20180822192153.24217-1-gedwards@ddn.com>
	<20180921174912.GA19193@psuche>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180921174912.GA19193@psuche>
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
To: Greg Edwards <gedwards@ddn.com>, virtualization@lists.linux-foundation.org
Cc: Mike Christie <mchristi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 21/09/2018 19:49, Greg Edwards wrote:
> On Wed, Aug 22, 2018 at 01:21:53PM -0600, Greg Edwards wrote:
>> Commands with protection information included were not truncating the
>> protection iov_iter to the number of protection bytes in the command.
>> This resulted in vhost_scsi mis-calculating the size of the protection
>> SGL in vhost_scsi_calc_sgls(), and including both the protection and
>> data SG entries in the protection SGL.
>>
>> Fixes: 09b13fa8c1a1 ("vhost/scsi: Add ANY_LAYOUT support in vhost_scsi_handle_vq")
>> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> 
> 
> Any thoughts on this patch?
> 
> 
>> ---
>>  drivers/vhost/scsi.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 76f8d649147b..cbe0ea26c1ff 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -964,7 +964,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>>  				prot_bytes = vhost32_to_cpu(vq, v_req_pi.pi_bytesin);
>>  			}
>>  			/*
>> -			 * Set prot_iter to data_iter, and advance past any
>> +			 * Set prot_iter to data_iter and truncate it to
>> +			 * prot_bytes, and advance data_iter past any
>>  			 * preceeding prot_bytes that may be present.
>>  			 *
>>  			 * Also fix up the exp_data_len to reflect only the
>> @@ -973,6 +974,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>>  			if (prot_bytes) {
>>  				exp_data_len -= prot_bytes;
>>  				prot_iter = data_iter;
>> +				iov_iter_truncate(&prot_iter, prot_bytes);
>>  				iov_iter_advance(&data_iter, prot_bytes);
>>  			}
>>  			tag = vhost64_to_cpu(vq, v_req_pi.tag);
>> --
>> 2.17.1

Fixes: 09b13fa8c1a1093e9458549ac8bb203a7c65c62a
Cc: stable@vger.kernel.org
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
