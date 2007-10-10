From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Wed, 10 Oct 2007 10:43:16 -0300
Message-ID: <5d6222a80710100643w7b02b3a7oa24a076b2bad4f52@mail.gmail.com>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063650.895058914@rustcorp.com.au>
	<200710101050.49012.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710101050.49012.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/10/07, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Hi Rusty,
>
> I have a late question :-)
>
> > There is also a generic implementation of config space which drivers can query
> > to get setup information from the host.
>
> After thinking about that for a while, is there a special reason the config
> field is defined as little endian? The only reason I can come up with, is to
> use virtio for cross platform emulators, lets say a ppc emulates an x86 system
> with virtio devices instead of real ones.
Not really.

Some platforms have multi-endianess capabilities. So you may want a
virtual machine running in a different endianess than the host
machine.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
