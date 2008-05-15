From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Virt RNG?
Date: Fri, 16 May 2008 09:43:08 +1000
Message-ID: <200805160943.08788.rusty@rustcorp.com.au>
References: <482C8595.5030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762044AbYEOXng@vger.kernel.org>
In-Reply-To: <482C8595.5030509@garzik.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, jeremy@xensource.com, Herbert Xu <herbert@gondor.apana.org.au>, Avi Kivity <avi@qumranet.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 16 May 2008 04:48:53 Jeff Garzik wrote:
> Has anyone yet written a "hw" RNG module for virt, that reads the host's
> random number pool?
>
> All this talk[1] about IRQF_SAMPLE_RANDOM in network drivers reminds me
> that virt guest instances should be grabbing random numbers from the
> host, especially if the host has a hardware RNG.

Yes, I prepared one earlier.  I was a little surprised to see that hwrng 
drivers don't contribute in any way to the entropy pool though, but now
reading the thread I find out about rngd (not installed on my Ubuntu system, 
but available at least).

One could argue that virtual rng should try to feed the kernel rng directly, 
with or without entropy credit.

Anyway, since there's interest, I'll drag virtio_rng from the bottom of the 
queue, apply Christian's fix (which I somehow missed before, sorry 
Christian), and re-post.

Thanks,
Rusty.
