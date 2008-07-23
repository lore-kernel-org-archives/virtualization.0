From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH] tun: Fix/rewrite packet filtering logic
Date: Tue, 22 Jul 2008 21:45:30 -0700
Message-ID: <4886B76A.6000907__37469.371132511$1216788486$gmane$org@qualcomm.com>
References: <1215852774-23974-1-git-send-email-maxk@qualcomm.com>	<4886703B.5090609@garzik.org>
	<20080722.171111.267353608.davem@davemloft.net>
	<48867BC3.3070506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48867BC3.3070506@garzik.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, linuxkernel@bristyle.com, David Miller <davem@davemloft.net>, sjackman@gmail.com
List-Id: virtualization@lists.linuxfoundation.org



Jeff Garzik wrote:
> David Miller wrote:
>> From: Jeff Garzik <jeff@garzik.org>
>> Date: Tue, 22 Jul 2008 19:41:47 -0400
>>
>>> looks mostly OK, but stuff like the above should be
>>>
>>>     (void __user *) arg
>>>
>>> Did you check this with sparse (Documentation/sparse.txt)?

Ah. No I did not check it with sparse.

>>
>> Jeff, I already added this particular patch to the tree
>> a week or so ago.
> 
> Yeah, later on in my queue were the fixes.

I'm not sure I'm following. What fixes ? Are you talking about fixing sparse
warnings or something else ?

Max
