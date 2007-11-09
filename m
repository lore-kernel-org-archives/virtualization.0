From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Lguest] [PATCH] virtio config_ops refactoring
Date: Thu, 08 Nov 2007 21:17:14 -0600
Message-ID: <4733D13A.6010305__34580.7076235816$1194578329$gmane$org@codemonkey.ws>
References: <4730A8F3.6020008@us.ibm.com><200711081320.35844.rusty__6233.15023626692$1194488552$gmane$org@rustcorp.com.au><4732774C.6020903@codemonkey.ws><200711090924.28659.rusty@rustcorp.com.au><47338EA0.6050100@codemonkey.ws>
	<13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com>
	<4733A6F5.3040202@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4733A6F5.3040202@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: ron minnich <rminnich@gmail.com>, lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> ron minnich wrote:
>>
>> Hi, I'm sorry, I've been stuck on other things (NFS RDMA anyone?) and
>> missed part of this discussion.
>>
>> Is it really the case that operations on virtio devices will involve
>> outl/inl etc.?
>>
> What's the problem with them?
> Except for the kick event it's not performance critical and the 
> difference between pio vmexit
> and hypercall exit is very small.

If you're a nutty guy who's interesting in creating the most absolute 
minimal VMM to run exotic paravirtual guests on massive clusters, then 
requiring PIO implies that you have to have an instruction decoder which 
is goes against the earlier goal ;-)

Regards,

Anthony Liguori

> I don't know about problems in other architectures, maybe mmio is better?
> Dor.
>>
>>
>> Apologies in advance for my failure to pay attention.
>>
>> thanks
>>
>> ron
>> _______________________________________________
>> Lguest mailing list
>> Lguest@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/lguest
>>
>
