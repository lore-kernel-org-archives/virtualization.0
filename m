From: Greg Edwards <gedwards@ddn.com>
Subject: Re: [PATCH] vhost/scsi: increase VHOST_SCSI_PREALLOC_PROT_SGLS to 2048
Date: Wed, 22 Aug 2018 11:25:06 -0600
Message-ID: <20180822172506.GA992@psuche>
References: <20180808192955.1115-1-gedwards@ddn.com>
	<20180808233807-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180808233807-mutt-send-email-mst@kernel.org>
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
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 08, 2018 at 11:42:22PM +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 08, 2018 at 01:29:55PM -0600, Greg Edwards wrote:
>> The current value of VHOST_SCSI_PREALLOC_PROT_SGLS is too small to
>> accommodate larger I/Os, e.g. 16-32 MiB, when the VIRTIO_SCSI_F_T10_PI
>> feature bit is negotiated and the backing store supports T10 PI.
>>
>> vhost-scsi rejects the command with errors like:
>>
>> [   59.581317] vhost_scsi_calc_sgls: requested sgl_count: 1820 exceeds pre-allocated max_sgls: 512
>>
>> Signed-off-by: Greg Edwards <gedwards@ddn.com>
>> ---
>>  drivers/vhost/scsi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 17fcd3b2e686..8c32cf58d6fa 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -56,7 +56,7 @@
>>  #define VHOST_SCSI_DEFAULT_TAGS 256
>>  #define VHOST_SCSI_PREALLOC_SGLS 2048
>>  #define VHOST_SCSI_PREALLOC_UPAGES 2048
>> -#define VHOST_SCSI_PREALLOC_PROT_SGLS 512
>> +#define VHOST_SCSI_PREALLOC_PROT_SGLS 2048
>>
>>  struct vhost_scsi_inflight {
>>  	/* Wait for the flush operation to finish */
>
> I guess it's ok since PREALLOC_SGLS is already 2K ... or
> am I missing something. Paolo, any input on this?

Ignore this patch.  I believe I've identified the root cause [1], and
will send out a new patch once I've done some more testing.

Greg

  [1] https://www.spinics.net/lists/linux-scsi/msg122825.html
