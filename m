From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] virtio_pci: use shared interrupts for virtqueues
Date: Fri, 3 Feb 2017 10:52:19 +0100
Message-ID: <20170203095219.GA28483@lst.de>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
	<1485504997-17584-3-git-send-email-hch@lst.de>
	<da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2@redhat.com>
	<20170203082606.GB26800@lst.de>
	<12332f9d-2cf8-d761-032e-a5a89863fd09@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <12332f9d-2cf8-d761-032e-a5a89863fd09@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, pbonzini@redhat.com, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 03, 2017 at 05:47:41PM +0800, Jason Wang wrote:
>> No, we need to allocate the array larger in that case as want proper
>> names for the interrupts.
>
> Consider the case of !per_vq_vectors, the size of msix_names is 2, but 
> snprintf can do out of bound accessing here. (We name the msix shared by 
> virtqueues with something like "%s-virtqueues" before the patch).

Yes, that's what I meant above - we need to allocate a large array
starting with this patch.  I'll fix it up for the next version.
