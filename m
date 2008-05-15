From: Jeff Garzik <jeff@garzik.org>
Subject: Virt RNG?
Date: Thu, 15 May 2008 14:48:53 -0400
Message-ID: <482C8595.5030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760071AbYEOStT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, jeremy@xensource.com, Herbert Xu <herbert@gondor.apana.org.au>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Has anyone yet written a "hw" RNG module for virt, that reads the host's 
random number pool?

All this talk[1] about IRQF_SAMPLE_RANDOM in network drivers reminds me 
that virt guest instances should be grabbing random numbers from the 
host, especially if the host has a hardware RNG.

	Jeff



[1] lkml&netdev thread: "[PATCH] drivers/net: remove network drivers' 
last few uses of IRQF_SAMPLE_RANDOM"
