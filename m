From: Andi Kleen <andi@firstfloor.org>
Subject: Re: How to enable XEN in 2.6.23-rcS kernel?
Date: 31 Jul 2007 18:41:29 +0200
Message-ID: <p731weor0ee.fsf@bingen.suse.de>
References: <39811185887611@webmail12.yandex.ru>
	<9a8748490707310652i27406292yf3e93ca78ef3bf32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764117AbXGaPrN@vger.kernel.org>
In-Reply-To: <9a8748490707310652i27406292yf3e93ca78ef3bf32@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: 2004 ruffneck <ruffneck2004@yandex.ru>, linux-kernel@vger.kernel.org, virtualization@osdl.org
List-Id: virtualization@lists.linuxfoundation.org

"Jesper Juhl" <jesper.juhl@gmail.com> writes:

> On 31/07/07, 2004 ruffneck <ruffneck2004@yandex.ru> wrote:
> > Hello to everybody!
> >
> > I did read, that Lguest and Xen was merged to upstream and must be in 2.6.23-rc1 kernel, but I can't see it in "make menuconfig". So, what's the deal? Can anybody explain me, how to enable XEN support? Thanks.
> 
> Go to "Processor type and features" - then enable "Paravirtualization
> support (EXPERIMENTAL)", you'll get a new option called "Enable
> support for Xen hypervisor".

Perhaps it would be clearer to make CONFIG_PARAVIRT implicit.
As in Xen/vmi/lguest being one level higher and selecting paravirt 
implicitely. Unless someone has a good reason against that i'll
do that.

-Andi
