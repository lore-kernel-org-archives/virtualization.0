From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Thu, 28 Oct 2010 11:27:31 +0200
Message-ID: <4CC94203.1080207@redhat.com>
References: <4CAC9CD1.2050601@collabora.co.uk> <4CB1D79A.6070805@redhat.com>	<4CBD739A.2010500@collabora.co.uk> <4CBD7560.6080207@redhat.com> <4CC8226F.5080807@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CC8226F.5080807@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: linux-kernel@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

  On 10/27/2010 03:00 PM, Ian Molton wrote:
> On 19/10/10 11:39, Avi Kivity wrote:
>> On 10/19/2010 12:31 PM, Ian Molton wrote:
>
>>>> 2. should start with a patch to the virtio-pci spec to document what
>>>> you're doing
>>>
>>> Where can I find that spec?
>>
>> http://ozlabs.org/~rusty/virtio-spec/
>
> Ok, but I'm not patching that until theres been some review.

Well, I like to review an implementation against a spec.

>
> There are links to the associated qemu and guest OS changes in my 
> original email.
>
>>> It doesnt, at present... It could be changed fairly easily ithout
>>> breaking anything if that happens though.
>>
>> The hypervisor and the guest can be changed independently. The driver
>> should be coded so that it doesn't depend on hypervisor implementation
>> details.
>
> Fixed - updated patch tested and attached.
> +
> +	/* Transfer data */
> +	if (virtqueue_add_buf(vq, sg_list, o_page, i_page, gldata)>= 0) {
> +		virtqueue_kick(vq);
> +		/* Chill out until it's done with the buffer. */
> +		wait_for_completion(&gldata->done);
> +	}
> +

Better, but still unsatisfying.  If the server is busy, the caller would 
block.  I guess it's expected since it's called from ->fsync().  I'm not 
sure whether that's the best interface, perhaps aio_writev is better.

-- 
error compiling committee.c: too many arguments to function
