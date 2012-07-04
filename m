From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio-blk spec: document topology info
Date: Wed, 4 Jul 2012 18:49:07 +0300
Message-ID: <20120704154907.GA27167@redhat.com>
References: <1341321412-24214-1-git-send-email-pbonzini@redhat.com>
 <1341321412-24214-2-git-send-email-pbonzini@redhat.com>
 <87d34cvzrv.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d34cvzrv.fsf@rustcorp.com.au>
Sender: kvm-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.osdl.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 04, 2012 at 03:22:36PM +0930, Rusty Russell wrote:
> On Tue,  3 Jul 2012 15:16:51 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Current QEMU and Linux drivers can export queue parameters via the
> > virtio-blk configuration space.  Document this, since the next patch
> > will have to add another configuration field after these.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Applied, thanks for the grammar fix, too!
> 
> > +        u8 physical_block_exp;
> > +        u8 alignment_offset;
> > +        u16 min_io_size;
> > +        u32 opt_io_size;
> 
> These aren't entirely self-evident though :(
> 
> I've put the latest on github (your changes included!), so please patch
> against that:
> 
> https://github.com/rustyrussell/virtio-spec
> 
> Thanks,
> Rusty.

Cool!
Could you please add tags that refer to various point releases
v0.8.9 to 0.9.5?

> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
