From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Virt RNG?
Date: Thu, 15 May 2008 16:44:56 -0400
Message-ID: <482CA0C8.7020808@garzik.org>
References: <482C8595.5030509@garzik.org> <200805152231.56967.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757372AbYEOUp0@vger.kernel.org>
In-Reply-To: <200805152231.56967.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, jeremy@xensource.com, Herbert Xu <herbert@gondor.apana.org.au>, Avi Kivity <avi@qumranet.com>, dor.laor@qumranet.com
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am Donnerstag, 15. Mai 2008 schrieb Jeff Garzik:
>> Has anyone yet written a "hw" RNG module for virt, that reads the host's 
>> random number pool?
>>
>> All this talk[1] about IRQF_SAMPLE_RANDOM in network drivers reminds me 
>> that virt guest instances should be grabbing random numbers from the 
>> host, especially if the host has a hardware RNG.
> 
> Yes, there was a drivers/char/hw_random/virtio-rng.c in Rusty's lguest 
> repository. 
> http://www.mail-archive.com/virtualization%40lists.linux-foundation.org/msg02902.html
> 
> I have tested this driver with this fix
> https://lists.linux-foundation.org/pipermail/virtualization/2008-January/009737.html
> and it worked.

Nice!



> As it transfers only 4 byte per hypercall it is not mindblowingly fast, but I 
> guess it is fast enough.

A limitation of the hw-random API.  However, I'd say the virtio rng 
driver could (and should) buffer bigger chunks, say at least a 
cacheline's worth of data, to return via hw-random's 32-bit data request 
API.

	Jeff
