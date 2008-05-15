From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Virt RNG?
Date: Thu, 15 May 2008 22:31:56 +0200
Message-ID: <200805152231.56967.borntraeger@de.ibm.com>
References: <482C8595.5030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762832AbYEOUcb@vger.kernel.org>
In-Reply-To: <482C8595.5030509@garzik.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, jeremy@xensource.com, Herbert Xu <herbert@gondor.apana.org.au>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 15. Mai 2008 schrieb Jeff Garzik:
> Has anyone yet written a "hw" RNG module for virt, that reads the host's 
> random number pool?
> 
> All this talk[1] about IRQF_SAMPLE_RANDOM in network drivers reminds me 
> that virt guest instances should be grabbing random numbers from the 
> host, especially if the host has a hardware RNG.

Yes, there was a drivers/char/hw_random/virtio-rng.c in Rusty's lguest 
repository. 
http://www.mail-archive.com/virtualization%40lists.linux-foundation.org/msg02902.html

I have tested this driver with this fix
https://lists.linux-foundation.org/pipermail/virtualization/2008-January/009737.html
and it worked.
As it transfers only 4 byte per hypercall it is not mindblowingly fast, but I 
guess it is fast enough.

Dont know why it never hit mainline.

Christian
