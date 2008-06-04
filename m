From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/3]  hvc_console: rework setup to replace irq functions with callbacks
Date: Wed, 4 Jun 2008 10:13:40 +1000
Message-ID: <200806041013.40692.rusty@rustcorp.com.au>
References: <200806031444.21945.borntraeger@de.ibm.com> <200806031445.22561.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758154AbYFDAOG@vger.kernel.org>
In-Reply-To: <200806031445.22561.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 June 2008 22:45:22 Christian Borntraeger wrote:
> This patch tries to change hvc_console to not use request_irq/free_irq if
> the backend does not use irqs. This allows virtio_console to use
> hvc_console without having a linker reference to request_irq/free_irq.

Two questions.  Is it possible to make the timer backoff a third kind of 
notifier?  And is it possible to make the dependency static, rather than 
dynamic, or does someone need two options at runtime?

Thanks,
Rusty.
