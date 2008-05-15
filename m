From: Jeff Dike <jdike@addtoit.com>
Subject: Re: Virt RNG?
Date: Thu, 15 May 2008 16:43:18 -0400
Message-ID: <20080515204318.GA14008@c2.user-mode-linux.org>
References: <482C8595.5030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756065AbYEOUou@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <482C8595.5030509@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, jeremy@xensource.com, Herbert Xu <herbert@gondor.apana.org.au>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 15, 2008 at 02:48:53PM -0400, Jeff Garzik wrote:
> Has anyone yet written a "hw" RNG module for virt, that reads the host's 
> random number pool?

UML has one, probably not usable as-is by anyone else right now...

    	     	      Jeff

-- 
Work email - jdike at linux dot intel dot com
