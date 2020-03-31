From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: linux-next: Tree for Mar 30 (vhost)
Date: Tue, 31 Mar 2020 09:13:01 -0400
Message-ID: <20200331091138-mutt-send-email-mst@kernel.org>
References: <20200330204307.669bbb4d@canb.auug.org.au>
 <347c851a-b9f6-0046-f6c8-1db0b42be213@infradead.org>
 <649927d4-9851-c369-2ad2-bf25527b057a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <649927d4-9851-c369-2ad2-bf25527b057a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 31, 2020 at 10:27:48AM +0800, Jason Wang wrote:
> 
> On 2020/3/31 上午1:22, Randy Dunlap wrote:
> > On 3/30/20 2:43 AM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The merge window has opened, so please do not add any material for the
> > > next release into your linux-next included trees/branches until after
> > > the merge window closes.
> > > 
> > > Changes since 20200327:
> > > 
> > > The vhost tree gained a conflict against the kvm-arm tree.
> > > 
> > (note: today's linux-next is on 5.6-rc7.)
> > 
> > on x86_64:
> > 
> > # CONFIG_EVENTFD is not set
> > 
> > ../drivers/vhost/vhost.c: In function 'vhost_vring_ioctl':
> > ../drivers/vhost/vhost.c:1577:33: error: implicit declaration of function 'eventfd_fget'; did you mean 'eventfd_signal'? [-Werror=implicit-function-declaration]
> >     eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
> >                                   ^~~~~~~~~~~~
> >                                   eventfd_signal
> > ../drivers/vhost/vhost.c:1577:31: warning: pointer/integer type mismatch in conditional expression
> >     eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
> 
> 
> Will fix.
> 
> VHOST should depend on EVENTFD now.
> 
> Thanks


I did that and pushed. Pls take a look.

> 
> >                                 ^
> > 
