From: Dor Laor <dor.laor@qumranet.com>
Subject: Re: Virt RNG?
Date: Thu, 15 May 2008 23:26:18 +0300
Message-ID: <1210883178.24261.914.camel@localhost.localdomain>
References: <482C8595.5030509@garzik.org>  <482C94AF.2010202@goop.org>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762370AbYEOUa1@vger.kernel.org>
In-Reply-To: <482C94AF.2010202@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeff Garzik <jeff@garzik.org>, virtualization@lists.osdl.org, LKML <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2008-05-15 at 20:53 +0100, Jeremy Fitzhardinge wrote:
> Jeff Garzik wrote:
> > Has anyone yet written a "hw" RNG module for virt, that reads the host's 
> > random number pool?
> >
> > All this talk[1] about IRQF_SAMPLE_RANDOM in network drivers reminds me 
> > that virt guest instances should be grabbing random numbers from the 
> > host, especially if the host has a hardware RNG.
> 
> It was actually one of the first device types proposed for what would 
> become virtio, but as far as I know there has been no work on such a 
> device.  It certainly makes lots of sense.
> 

There was a virtio-rng device:
http://www.mail-archive.com/virtualization@lists.linux-foundation.org/msg02902.html

Need to search what happened to it in Rusty's queues.
>     J
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
