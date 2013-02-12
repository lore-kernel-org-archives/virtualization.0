From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/9] virtio: add functions for piecewise addition of
	buffers
Date: Tue, 12 Feb 2013 16:48:39 +0100
Message-ID: <511A6457.80609@redhat.com>
References: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
	<1360671815-2135-2-git-send-email-pbonzini@redhat.com>
	<20130212145620.GA3392@redhat.com> <511A608B.5080007@redhat.com>
	<20130212154338.GA4083@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130212154338.GA4083@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 12/02/2013 16:43, Michael S. Tsirkin ha scritto:
> On Tue, Feb 12, 2013 at 04:32:27PM +0100, Paolo Bonzini wrote:
>> Il 12/02/2013 15:56, Michael S. Tsirkin ha scritto:
>>>>> +/**
>>>>> + * virtqueue_start_buf - start building buffer for the other end
>>>>> + * @vq: the struct virtqueue we're talking about.
>>>>> + * @data: the token identifying the buffer.
>>>>> + * @nents: the number of buffers that will be added
>>> This function starts building one buffer, number of buffers
>>> is a bit weird here.
>>
>> Ok.
>>
>>>>> + * @nsg: the number of sg lists that will be added
>>> This means number of calls to add_sg ? Not sure why this matters.
>>> How about we pass in in_num/out_num - that is total # of sg,
>>> same as add_buf?
>>
>> It is used to choose between direct and indirect.
> 
> total number of in and out should be enough for this, no?

Originally, I used nsg/nents because I wanted to use mixed direct and
indirect buffers.  nsg/nents let me choose between full direct (nsg ==
nents), mixed (num_free >= nsg), full indirect (num_free < nsg).  Then I
had to give up because QEMU does not support it, but I still would like
to keep that open in the API.

In this series, however, I am still using nsg to choose between direct
and indirect.  I would like to use dirtect for small scatterlists, even
if they are surrounded by a request/response headers/footers.

>>>>> +/**
>>>>> + * virtqueue_add_sg - add sglist to buffer being built
>>>>> + * @_vq: the virtqueue for which the buffer is being built
>>>>> + * @sgl: the description of the buffer(s).
>>>>> + * @nents: the number of items to process in sgl
>>>>> + * @dir: whether the sgl is read or written (DMA_TO_DEVICE/DMA_FROM_DEVICE only)
>>>>> + *
>>>>> + * Note that, unlike virtqueue_add_buf, this function follows chained
>>>>> + * scatterlists, and stops before the @nents-th item if a scatterlist item
>>>>> + * has a marker.
>>>>> + *
>>>>> + * Caller must ensure we don't call this with other virtqueue operations
>>>>> + * at the same time (except where noted).
>>> Hmm so if you want to add in and out, need separate calls?
>>> in_num/out_num would be nicer?
>>
>> If you want to add in and out just use virtqueue_add_buf...
> 
> I thought the point of this one is maximum flexibility.

Maximum flexibility does not include doing everything in one call (the
other way round in fact: you already need to wrap with start/end, hence
doing one or two extra add_sg calls is not important).

Paolo
