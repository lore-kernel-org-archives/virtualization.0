From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest over qemu
Date: Thu, 12 Jul 2007 13:19:00 +1000
Message-ID: <1184210340.6005.723.camel@localhost.localdomain>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matias Zabaljauregui <matias.zabaljauregui@cern.ch>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-11 at 11:51 +0200, Matias Zabaljauregui wrote:
> Hi, 
> 
> I'm setting my lguest playing environment with qemu, but didn't have a
> good start... maybe because my modest laptop only has 512Mb of RAM.
> 
> This is my qemu  command:
> 
>                          qemu -s -no-kqemu -m 400 -hda linux26.img
> -net nic,model=rtl8139 -net tap
> 
> 
> ( linux26.img  includes  a  2.6.21.5 kernel with the lguest-2.6.21-307
> patch  )
> 
> 
> This is my lguest command (executed within the qemu VM): 
> 
>                           ./lguest 64m /boot/kernel-2.6.21.5
> --block=initrd-1.1-i386.img root=/dev/lbga
> 
> always get this message (I have insisted with different virtual ram
> amounts): 
> 
>                     lguest: failed to get page 167304

I did most of my development under qemu, so I don't think that's the
issue.  Can you send me your .config?

Thanks,
Rusty.
