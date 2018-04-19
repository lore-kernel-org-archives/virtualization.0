From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_ring: switch to dma_XX barriers for rpmsg
Date: Thu, 19 Apr 2018 19:48:24 +0200
Message-ID: <524fb400-2325-f60b-7e03-15be01888afc__3089.04822818494$1524160007$gmane$org@redhat.com>
References: <1524159181-351878-1-git-send-email-mst@redhat.com>
	<5047d08c-9f9e-2902-d425-1fac849ce5b4@redhat.com>
	<20180419204017-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180419204017-mutt-send-email-mst@kernel.org>
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On 19/04/2018 19:46, Michael S. Tsirkin wrote:
>> This should be okay, but I wonder if there should be a virtio_wmb(...)
>> or an "if (weak_barriers) wmb()" before the "writel" in vm_notify
>> (drivers/virtio/virtio_mmio.c).
>>
>> Thanks,
>>
>> Paolo
> That one uses weak barriers AFAIK.
> 
> IIUC you mean rproc_virtio_notify.
> 
> I suspect it works because specific kick callbacks have a barrier internally.

Yes, that one.  At least keystone_rproc_kick doesn't seem to have a barrier.

Paolo
