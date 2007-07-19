From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Paravirt ops 64 bit git tree
Date: Thu, 19 Jul 2007 17:45:30 -0300
Message-ID: <1184877930.16311.14.camel@t60>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762344AbXGSUpB@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, rusty@rustycorp.com.au, jeremy@goop.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Folks,

After a long while, I'm giving the pvops64 tree the attention it
deserves again. It's been a long time, so it diverged a lot from the
rest of the work being done, and it is quite unusable as it is nowadays.
But at least now, it'll get it's own git tree, which you can clone at
git://git.et.redhat.com/kernel-pvops-64.git

Chris Wright and I decided that it might be better to rewrite at least
large chunks of it, so the code that is there, outdated as it is, is
more a reference than anything else. I'll be starting it mostly from
scratch, but it'll live in the same place.

Hope you enjoy!
