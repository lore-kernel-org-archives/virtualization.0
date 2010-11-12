From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Fri, 12 Nov 2010 12:14:18 +0000
Message-ID: <4CDD2F9A.7000702@collabora.co.uk>
References: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>	<4CCEC090.3050009@codemonkey.ws>	<4CD1A406.3090909@collabora.co.uk> <4CD1A73B.2010406@codemonkey.ws> <4CD44759.5020500@collabora.co.uk> <4CDAD4D4.3070009@collabora.co.uk> <4CDADACC.4070405@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CDADACC.4070405@codemonkey.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, virtualization@lists.osdl.org, Alon Levy <alevy@redhat.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/11/10 17:47, Anthony Liguori wrote:
> On 11/10/2010 11:22 AM, Ian Molton wrote:
>> Ping ?
>
> I think the best way forward is to post patches.

I posted links to the git trees. I can post patches, but they are 
*large*. Do you really want me to post them?

> To summarize what I was trying to express in the thread, I think this is
> not the right long term architecture but am not opposed to it as a short
> term solution. I think having a new virtio device is a bad design choice
> but am not totally opposed to it.

Ok! (I agree (that this should be a short term solution) :) )

> you want to go for the path of integration, you're going to have to fix
> all of the coding style issues and make the code fit into QEMU. Dropping
> a bunch of junk into target-i386/ is not making the code fit into QEMU.

I agree. how about hw/gl for the renderer and hw/ for the virtio module?

> If you post just what you have now in patch form, I can try to provide
> more concrete advice ignoring the coding style problems.

I can post patches, although I dont think LKML would appreciate the 
volume! I can post them to the qemu list if you do.

-Ian
