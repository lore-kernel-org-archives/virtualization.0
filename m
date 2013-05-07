From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH] KVM: Fix kvm_irqfd_init initialization
Date: Tue, 7 May 2013 18:16:09 +0300
Message-ID: <20130507151609.GD7899@redhat.com>
References: <1367938456-21005-1-git-send-email-asias@redhat.com>
	<20130507145937.GA23273@redhat.com>
	<20130507150512.GA21464@hj.localdomain>
	<20130507151133.GB23608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130507151133.GB23608@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 07, 2013 at 06:11:33PM +0300, Michael S. Tsirkin wrote:
> On Tue, May 07, 2013 at 11:05:12PM +0800, Asias He wrote:
> > On Tue, May 07, 2013 at 05:59:38PM +0300, Michael S. Tsirkin wrote:
> > > On Tue, May 07, 2013 at 10:54:16PM +0800, Asias He wrote:
> > > > In commit a0f155e96 'KVM: Initialize irqfd from kvm_init()', when
> > > > kvm_init() is called the second time (e.g kvm-amd.ko and kvm-intel.ko),
> > > > kvm_arch_init() will fail with -EEXIST,
> > > 
> > > Wow. Is this intentional?
> > 
> > I think it is. You can not be amd and intel at the same time ;-)
> > 
> > kvm_arch_init
> > 
> >     if (kvm_x86_ops) {
> >             printk(KERN_ERR "kvm: already loaded the other module\n");
> >             r = -EEXIST;
> >             goto out;
> >     }       
> > 
> 
> Interesting. So we check it with
> 	if (kvm_x86_ops)
>  and later we do
>         kvm_x86_ops = ops;
> 
> 
> This looks racy - or is something serializing
> module loading?
> 
I think module loading is serialized.

--
			Gleb.
