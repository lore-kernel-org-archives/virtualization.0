From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Sun, 24 Mar 2013 16:27:15 -0700
Message-ID: <514F8BD3.8010306@zytor.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130324201910.GA31631@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/24/2013 01:19 PM, Michael S. Tsirkin wrote:
>>  struct virtio_pci_cap {
>>  	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
>> @@ -150,7 +153,9 @@ struct virtio_pci_common_cfg {
>>  	__le16 queue_size;	/* read-write, power of 2. */
>>  	__le16 queue_msix_vector;/* read-write */
>>  	__le16 queue_enable;	/* read-write */
>> -	__le16 queue_notify;	/* read-only */
>> +	__le16 unused2;
>> +	__le32 queue_notify_val;/* read-only */
>> +	__le32 queue_notify_off;/* read-only */
>>  	__le64 queue_desc;	/* read-write */
>>  	__le64 queue_avail;	/* read-write */
>>  	__le64 queue_used;	/* read-write */
> 
> So how exactly do the offsets mesh with the dual capability?  For IO we
> want to use the same address and get queue from the data, for memory we
> want a per queue address ...
> 

How about having a readonly field which is "address increment per trigger"?

The guest would be required to always write the queue number as the
data, however, the host would not be required to interpret it if the
address increment is nonzero?

	-hpa
