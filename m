From: Satyam Sharma <satyam@infradead.org>
Subject: Re: How to enable XEN in 2.6.23-rcS kernel?
Date: Tue, 31 Jul 2007 21:42:02 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0707312140220.28746@enigma.security.iitk.ac.in>
References: <39811185887611@webmail12.yandex.ru>
 <9a8748490707310652i27406292yf3e93ca78ef3bf32@mail.gmail.com>
 <p731weor0ee.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764998AbXGaP74@vger.kernel.org>
In-Reply-To: <p731weor0ee.fsf@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, 2004 ruffneck <ruffneck2004@yandex.ru>, linux-kernel@vger.kernel.org, virtualization@osdl.org
List-Id: virtualization@lists.linuxfoundation.org



On Tue, 31 Jul 2007, Andi Kleen wrote:

> "Jesper Juhl" <jesper.juhl@gmail.com> writes:
> 
> > [...]
> > Go to "Processor type and features" - then enable "Paravirtualization
> > support (EXPERIMENTAL)", you'll get a new option called "Enable
> > support for Xen hypervisor".
> 
> Perhaps it would be clearer to make CONFIG_PARAVIRT implicit.
> As in Xen/vmi/lguest being one level higher and selecting paravirt 
> implicitely. Unless someone has a good reason against that i'll
> do that.

Sounds good, just ensure you carry PARAVIRT's dependencies to those who
"select" it too, somehow, otherwise invalid .config's could result.


Satyam
