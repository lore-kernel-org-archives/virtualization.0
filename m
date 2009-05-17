From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Sun, 17 May 2009 18:05:39 +0300
Message-ID: <4A1027C3.3080109__14822.036753367$1242572782$gmane$org@redhat.com>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<200905171134.31285.rusty@rustcorp.com.au>
	<4A0FAE35.3040608@redhat.com>
	<200905172346.14498.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905172346.14498.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mark McLoughlin <markmc@redhat.com>, Dor Laor <dor@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Sun, 17 May 2009 03:57:01 pm Avi Kivity wrote:
>   
>> Rusty Russell wrote:
>>     
>>> +static void adjust_threshold(struct vring_virtqueue *vq,
>>> +			     unsigned int out, unsigned int in)
>>> +{
>>> +	/* There are really two species of virtqueue, and it matters here.
>>> +	 * If there are no output parts, it's a "normally full" receive queue,
>>> +	 * otherwise it's a "normally empty" send queue. */
>>>       
>> This comment is true for networking, but not for block. ++overkill with
>> a ->adjust_threshold op.
>>     
>
> No, it's true for block.  It has output parts, so we should reduce threshold 
> when it's full.  Network recvq is an example which should reduce threshold 
> when it's empty.
>   

You mean the header that contains the sector number?  It's a little 
incidental, but I guess it works.

-- 
error compiling committee.c: too many arguments to function
