From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 30 (vhost)
Date: Mon, 30 Mar 2020 10:22:22 -0700
Message-ID: <347c851a-b9f6-0046-f6c8-1db0b42be213@infradead.org>
References: <20200330204307.669bbb4d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200330204307.669bbb4d@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 3/30/20 2:43 AM, Stephen Rothwell wrote:
> Hi all,
> 
> The merge window has opened, so please do not add any material for the
> next release into your linux-next included trees/branches until after
> the merge window closes.
> 
> Changes since 20200327:
> 
> The vhost tree gained a conflict against the kvm-arm tree.
> 

(note: today's linux-next is on 5.6-rc7.)

on x86_64:

# CONFIG_EVENTFD is not set

../drivers/vhost/vhost.c: In function 'vhost_vring_ioctl':
../drivers/vhost/vhost.c:1577:33: error: implicit declaration of function 'eventfd_fget'; did you mean 'eventfd_signal'? [-Werror=implicit-function-declaration]
   eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
                                 ^~~~~~~~~~~~
                                 eventfd_signal
../drivers/vhost/vhost.c:1577:31: warning: pointer/integer type mismatch in conditional expression
   eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
                               ^

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
