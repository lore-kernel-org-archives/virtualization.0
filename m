From: Linhaifeng <haifeng.lin@huawei.com>
Subject: Re: virtio-net: why not always to set avail->flags to
	VRING_AVAIL_F_NO_INTERRUPT
Date: Thu, 4 Jun 2015 10:35:19 +0800
Message-ID: <556FB967.6010103__26229.1340077811$1433385360$gmane$org@huawei.com>
References: <556E9F87.7030202@huawei.com> <87k2vkuvg8.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k2vkuvg8.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 2015/6/4 9:13, Rusty Russell wrote:
> Linhaifeng <haifeng.lin@huawei.com> writes:
>> Hi,
>>
>> I'm a newbie and have a question about vring_new_virtqueue function.
>>
>> Why we set avail->flags to VRING_AVAIL_F_NO_INTERRUPT when no callbacks?
>> I think we should set avail->flags to VRING_AVAIL_F_NO_INTERRUPT even if no callbacks.
> 
> Hi Linhaifeng,
> 
>         Not sure I understand your question, but I'll try to answer.
> 
> We don't set VRING_AVAIL_F_NO_INTERRUPT if there's a callback because we
> want that callback called.  Otherwise callback will never be used.
> 
> Cheers,
> Rusty.
> 
> 

Hi Rusty,

Thank you for your response.

I mean should we set VRING_AVAIL_F_NO_INTERRUPT when virtqueue is initialized whether there is callback or not?
As it would be set in function virtqueue_disable_cb and virtqueue_enable_cb_prepare later.

Regards,
Haifeng
