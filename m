From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [RFC 0/3]: hvc_console rework for platform without hard irqs
Date: Tue, 3 Jun 2008 14:44:21 +0200
Message-ID: <200806031444.21945.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756238AbYFCMoi@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PPC devel <linuxppc-dev@ozlabs.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch set if my first attempt to make virtio_console usable on s390.
To do so, I had to change hvc_console, because s390 has no request_irq and
no free_irq.
I want to get feedback from the main users of hvc_console before I proceed.

The basic idea of this patch set is to remove the calls to request_irq and
free_irq and replace them with backend specific callbacks.

Please see the descriptions of the patches for further details:

1/3: hvc_console: rework setup to replace irq functions with callbacks
2/3: virtio_console: use virtqueue notification for hvc_console
3/3: s390: use virtio_console for KVM on s390
