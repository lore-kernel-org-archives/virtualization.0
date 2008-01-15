From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] fix bug in virtio-rng
Date: Tue, 15 Jan 2008 11:02:00 +1100
Message-ID: <200801151102.00640.rusty@rustcorp.com.au>
References: <200801141831.35481.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801141831.35481.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 15 January 2008 04:31:35 Christian Borntraeger wrote:
> Rusty,
>
> I have seen an oops triggered by the following bug statement in
> virtio-rng:
>
> if (vq->vq_ops->add_buf(vq, &sg, 0, 1, &random_data) != 0)
> 	BUG();
>
> The problem is that we never called get_buf for complete buffers.
>
> The fix is simple: We have to free the buffer on interrupt to
> avoid a virtqueue "overflow".

Thanks, applied.

Rusty.
