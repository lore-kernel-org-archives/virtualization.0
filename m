From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Sun, 18 May 2008 09:40:05 +0300
Message-ID: <482FCF45.1050307__5304.3321393945$1211092917$gmane$org@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<1210865380.16012.15.camel@muff> <482C579F.4030509@qumranet.com>
	<200805160925.18087.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805160925.18087.rusty@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Friday 16 May 2008 01:32:47 Avi Kivity wrote:
>   
>> Mark McLoughlin wrote:
>>     
>>> I think Rusty is speaking from the POV of the guest driver - i.e. that
>>> virtio_net should never disable notifications on the xmit queue using
>>> disable_cb()?
>>>
>>> Sounds like you think agree, but that the host side should throttle the
>>> rate of xmit notifications?
>>>       
>> Yes.
>>     
>
> But performance is going to suck in the meantime, as currently our host 
> doesn't do this.
>   

That's what the feature bits are for.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
