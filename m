From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/9] virtio-blk: use virtqueue_start_buf on req path
Date: Mon, 18 Feb 2013 10:05:26 +0100
Message-ID: <5121EED6.7000307@redhat.com>
References: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
	<1360671815-2135-5-git-send-email-pbonzini@redhat.com>
	<51207AA1.4090408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51207AA1.4090408@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 17/02/2013 07:37, Asias He ha scritto:
>> >  static int __virtblk_add_req(struct virtqueue *vq,
>> > -			     struct virtblk_req *vbr)
>> > +			     struct virtblk_req *vbr,
>> > +			     struct scatterlist *data_sg,
>> > +			     unsigned data_nents)
>> >  {
>> >  	struct scatterlist sg;
>> >  	enum dma_data_direction dir;
>> >  	int ret;
>> >  
>> > +	int type = vbr->out_hdr.type & ~VIRTIO_BLK_T_OUT;
>> >  	unsigned int nents = 2;
>> >  	unsigned int nsg = 2;
>> >  
>> > -	if (vbr->nents) {
>> > +	if (type == VIRTIO_BLK_T_SCSI_CMD) {
>> > +		BUG_ON(use_bio);
> Do we really need the BUG_ON?  Even if with use_bio=1,
> VIRTIO_BLK_T_SCSI_CMD cmd can be fired. See this:

I stand corrected... will send the patch with this removed.

Paolo
